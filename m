Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A0720A40
	for <e@80x24.org>; Mon, 27 Nov 2017 03:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbdK0Dkb (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 22:40:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53254 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751107AbdK0Dkb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 22:40:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C4BABB6FD;
        Sun, 26 Nov 2017 22:40:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zfn6dyzB5HdSfuIhE8bixyLzWls=; b=nP3REi
        hoaAE+Q1xOg27mi7IVoOjQvnZNzxbhJmszL3WnNUpIYbZAeaAvxvFHIc85tQtHQq
        +8wC/wIVygHjApuqTEKZCE2gM5I+84SO9OYzxgW7aWin+zqyD/X/K/R2QPGldYv9
        COew3Cn71sNfZh2T1ma98j9vY4eahYeEVqDrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XYwjXqE6Tcn+9on3RDnQvGRseSI6uSee
        qpCl59TxMgRnkQhsPwVnEOGOKArx3AMZwwuQFXiZ09EIHfkaJWK4qOrLVQG6y8v7
        2GneCiHktjYGot015/fL6WrTV/FhL7mnkBcb8SKvxjsYV4DNGnyC7B91Hdl77loN
        CevhM5wizOA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55633BB6FC;
        Sun, 26 Nov 2017 22:40:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D12EBBB6FB;
        Sun, 26 Nov 2017 22:40:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        David Turner <dturner@twitter.com>,
        David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
References: <20171124195901.2581-1-newren@gmail.com>
Date:   Mon, 27 Nov 2017 12:40:28 +0900
In-Reply-To: <20171124195901.2581-1-newren@gmail.com> (Elijah Newren's message
        of "Fri, 24 Nov 2017 11:59:01 -0800")
Message-ID: <xmqq4lpgfkyb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6E35CDC-D324-11E7-9D66-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> In commit ae352c7f3 (merge-recursive.c: fix case-changing merge bug,
> 2014-05-01), it was observed that removing files could be problematic on
> case insensitive file systems, because we could end up removing files
> that differed in case only rather than deleting the intended file --
> something that happened when files were renamed on one branch in a way
> that differed only in case.  To avoid that problem, that commit added
> logic to avoid removing files other than the one intended, rejecting the
> removal if the files differed only in case.
>
> Unfortunately, the logic it used didn't fully implement that condition as
> stated above...
>
> If that description leaves more questions than answers, we may need to
> augment the above commit message with the following explanation...
> ...
>  merge-recursive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

As a fix, this sorely wants something new in t/ directory.
