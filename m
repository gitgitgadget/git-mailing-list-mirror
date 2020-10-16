Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77701C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C2D2083B
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 15:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RMj9x+A+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408721AbgJPPt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:49:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61149 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406318AbgJPPt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 11:49:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B66938F7AB;
        Fri, 16 Oct 2020 11:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GEASPjitH+hnqeRInVEjDBIGzn4=; b=RMj9x+
        A+sYwO6gYCfSlFoOsqTgkBNPh95ROEOCXLWedBxoU+PqQaE9s5lnUtMZAeDClb9T
        mMwdKlRPLdZE1Zu9WS8vgFR1PdpJcO/03vJefSftUREivcDFIXLrrzDF2vtpStlj
        XbGRm7lfPUMHtT3+Tz8BknSpNyTj82V9+Xo+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ecoh6WalBIFI+jW930a3sPebeB4XssSN
        khBAH+ibROm7XEfkJi6xWggxlH3GTcDNsBSRP5abA9GjAOkk3uy2cwKXoJuPz+4/
        cevhlmz0THCwdEzO6vFwLPH7+DHZ9W+JXvTmwYgrOyYHFb2l2rquGwuXP2Qzv639
        p9+UQVXBM3w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEB828F7AA;
        Fri, 16 Oct 2020 11:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 410E28F7A9;
        Fri, 16 Oct 2020 11:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] fast-import: remove duplicated option-parsing line
References: <20201015193411.GA1130491@coredump.intra.peff.net>
Date:   Fri, 16 Oct 2020 08:49:54 -0700
In-Reply-To: <20201015193411.GA1130491@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Oct 2020 15:34:11 -0400")
Message-ID: <xmqqblh2dvbx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C7FB728-0FC7-11EB-95B6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit 1bdca81641 (fast-import: add options for rewriting submodules,
> 2020-02-22) accidentally added two lines parsing the option
> "rewrite-submodules-from". This didn't do anything in practice, because
> they're in an if/else chain and so the second one can never trigger.

Thanks; it is embarrassing of me that I didn't see it while
applying.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Another tidbit I noticed in my foray into fast-import earlier today.
>
>  builtin/fast-import.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 70d7d25eed..dd4d09cece 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -3399,7 +3399,6 @@ static int parse_one_feature(const char *feature, int from_stream)
>  		option_rewrite_submodules(arg, &sub_marks_to);
>  	} else if (skip_prefix(feature, "rewrite-submodules-from=", &arg)) {
>  		option_rewrite_submodules(arg, &sub_marks_from);
> -	} else if (skip_prefix(feature, "rewrite-submodules-from=", &arg)) {
>  	} else if (!strcmp(feature, "get-mark")) {
>  		; /* Don't die - this feature is supported */
>  	} else if (!strcmp(feature, "cat-blob")) {
