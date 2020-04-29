Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8849DC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6157F20BED
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CBb7Drb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD2VmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:42:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58367 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2VmH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 17:42:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6204CA756;
        Wed, 29 Apr 2020 17:42:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rG2RAmGtVzAj86tk2/iiDkTZbiQ=; b=CBb7Dr
        b2DUOACnTK2VP2ct0WB52bjnJVJbOoLc1iTX3lx501vH9DYNvIqXKZRW4Nael/oa
        i0UDwnzvVE8wumV6KlRcglTUcrhkHKg/J3eQP0WZyyrDMZGbW8iJc2Jqad4Quq7o
        bFaL5BvW4MzzOHSzUPy0IYtzQBt0kfsmmqWYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eu9Rui1P8bbOPouMxPvZlAKDMSlc7+Rx
        J+IvL7Ca0rCC9Y5/IoCI3seDjFkDrrgUckEv/tXvHdrejZuE4miAXmQ8L7azhI5Z
        JUdXSJW8ZnGBcNszBMFDA7nnSWqRXa2R32v/d0dc/nBHWo6uH5ELOmWgU5V6jzxF
        k4O4MivbbTI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADF64CA755;
        Wed, 29 Apr 2020 17:42:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0067CCA753;
        Wed, 29 Apr 2020 17:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Taylor Blau <me@ttaylorr.com>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re* [PATCH 0/4] t: replace incorrect test_must_fail usage (part 5)
References: <cover.1588162842.git.liu.denton@gmail.com>
        <20200429195035.GB3920@syl.local>
        <90edb162-e035-bdb7-a2d2-ffc6bd075977@kdbg.org>
Date:   Wed, 29 Apr 2020 14:42:02 -0700
In-Reply-To: <90edb162-e035-bdb7-a2d2-ffc6bd075977@kdbg.org> (Johannes Sixt's
        message of "Wed, 29 Apr 2020 23:30:19 +0200")
Message-ID: <xmqqblnaufyt.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43FB0E70-8A62-11EA-81E4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 29.04.20 um 21:50 schrieb Taylor Blau:
>> This comment has nothing to do with your series, but I am curious if you
>> are planning on touching 'test_might_fail' at all. These can be useful
>> for non-Git commands, too, such as 'test_might_fail umask 022' on
>> systems that may or may not do something sensible with umask.
>
> When it's not a git command that might fail, the idiom is
>
> 	... &&
> 	{ umask 022 || :; } &&
> 	...
>
> -- Hannes

I hoped to find this documented in t/README, but ended up writing
this.  Overkill?  I dunno.

-- >8 --
Subject: [PATCH] t/README: document when not to use test_might_fail

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/README | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 13747f1344..870950c7d1 100644
--- a/t/README
+++ b/t/README
@@ -875,7 +875,9 @@ library for your script to use.
  - test_might_fail [<options>] <git-command>
 
    Similar to test_must_fail, but tolerate success, too.  Use this
-   instead of "<git-command> || :" to catch failures due to segv.
+   instead of "<git-command> || :" to catch failures due to segv,
+   but do use "{ <non-git-command> || :; }" to ignore a failure from
+   a command that is not git.
 
    Accepts the same options as test_must_fail.
 
