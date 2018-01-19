Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40A21F404
	for <e@80x24.org>; Fri, 19 Jan 2018 19:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbeASTY2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 14:24:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64534 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756019AbeASTY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 14:24:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E134DC911E;
        Fri, 19 Jan 2018 14:24:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uU13qSG8254nW4S5hKl7gq77uG4=; b=CHMF3Q
        L9Zuz8AB86Wk0Hmzxt8w7+yi1tdH16GTxP2yzNlDdZAbj1HbFqYTNLayehb937ku
        Cf/N7IiY7sbi1m9jT8VplNIosevB4kwINGmcDoSbLbTlsqfiQrJgbrl0Mvewl9Ut
        Kx/EULxR9sZ2Fre/dOy0phn7gP2r7YHhYkErs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qpOD2GVRora0Otp2avkWPLiA9MVLTg9Y
        pNnyYBzi/K2+Zpxw3Vc/Z739rVGFZQA+Nb39zKhm6Rm8g/Zi6iTP51bN2BPgMhUv
        6qvWQJV7jYhaL9FB6GiDhRzfDxnA82ghm9oPgUiRuTOunWJ1HapszNqxPs1sL9XW
        nFi9qKrmyLA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D78ADC911D;
        Fri, 19 Jan 2018 14:24:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F320C911A;
        Fri, 19 Jan 2018 14:24:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Subject: Re: [PATCH] repository: pre-initialize hash algo pointer
References: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
        <20180119041825.727904-1-sandals@crustytoothpaste.net>
        <CAPig+cTOw5NsSmLHYcBEidDzNyiidJ0Dw1dF227KWDL9JrASvw@mail.gmail.com>
Date:   Fri, 19 Jan 2018 11:24:24 -0800
In-Reply-To: <CAPig+cTOw5NsSmLHYcBEidDzNyiidJ0Dw1dF227KWDL9JrASvw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 19 Jan 2018 02:54:26 -0500")
Message-ID: <xmqqr2qlps7r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C26537C-FD4E-11E7-997D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I'm still quite mystified as to why this is working on Linux and not
>> macOS, but I can only guess that compilers are just very advanced and
>> have somehow concluded that we would clearly never dereference a NULL
>> pointer, so they picked the only non-NULL value.
>
> Now that we know (due to Duy's excellent detective work[1]) that the
> trigger is files with names differing only in case on case-insensitive
> filesystems, the commit message can be updated appropriately.

Thanks.  Let me apply the following and do a 2.16.1, hopefully by
the end of day or mid tomorrow at the latest.  Test to protect the
fix can come as a separate follow-up patch.

-- >8 --
Subject: [PATCH] repository: pre-initialize hash algo pointer

There are various git subcommands (among them, clone) which don't set up
the repository (that is, they lack RUN_SETUP or RUN_SETUP_GENTLY) but
end up needing to have information about the hash algorithm in use.
Because the hash algorithm is part of struct repository and it's only
initialized in repository setup, we can end up dereferencing a NULL
pointer in some cases if we call one of these subcommands and look up
the empty blob or empty tree values.

A "git clone" of a project that has two paths that differ only in
case suffers from this if it is run on a case insensitive platform.
When the command attempts to check out one of these two paths after
checking out the other one, the checkout codepath needs to see if
the version that is already on the filesystem (which should not
happen if the FS were case sensitive), and it needs to exercise the
hashing code.

In the future, we can add a command line option for this or read it
from the configuration, but until we're ready to expose that
functionality to the user, simply initialize the repository
structure to use the current hash algorithm, SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 repository.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index 998413b8bb..f66fcb1342 100644
--- a/repository.c
+++ b/repository.c
@@ -5,7 +5,7 @@
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
 };
 struct repository *the_repository = &the_repo;
 
-- 
2.16.0-204-gc262421c89

