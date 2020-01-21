Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF2DC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8362465A
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r+OZk/2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAUWEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:04:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61988 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAUWEw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 17:04:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B61737A28;
        Tue, 21 Jan 2020 17:04:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FNcOQfTlLMGZRWqA17U+fGuO5UA=; b=r+OZk/
        2XiQU+38w7GZxslaM1f5qRBEcxx8yGrn/xcXh+4MxM+2E2Zy8Bff9dKOli+utQgL
        dJspYWJqccIH9lxUbAxc6dJG14qRs1MB5gvJwos5NMk4y2VbtuHLrTgPXuahpiap
        nqA4h+JMyvb7ae4MudN+m6OyvQ/amAf+CrTy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VNyJNnUDJL1nqCHYDOvhImP62CsigdCA
        dFa3ikNXbs8o0ucWdAn8+YmuchaGztdqqkcxdUfCKSN7VVU9qB91rdLro56mlanP
        YrUUiIvIff2Mjc6H5K2wBriuTIfJKxgdxG9fi/AcCMadahtJ+HawyyMdgvAdkaI6
        eJzfGr5BrM4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 416B437A26;
        Tue, 21 Jan 2020 17:04:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B205937A25;
        Tue, 21 Jan 2020 17:04:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] parse_insn_line(): improve error message when parsing failed
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
        <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
        <2ae2e435b0ef6888e72defc7abee1909b29aa914.1579304283.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 14:04:48 -0800
In-Reply-To: <2ae2e435b0ef6888e72defc7abee1909b29aa914.1579304283.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 17 Jan 2020
        23:38:01 +0000")
Message-ID: <xmqqlfq08nzz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B1F67F6-3C9A-11EA-81DF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the case that a `get_oid()` call failed, we showed some rather bogus
> part of the line instead of the precise string we sent to said function.
> That makes it rather hard for users to understand what is going wrong,
> so let's fix that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ...
> @@ -2125,11 +2127,10 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  	item->arg_len = (int)(eol - bol);
>  
>  	if (status < 0)
> -		return error(_("could not parse '%.*s'"),
> -			     (int)(end_of_object_name - bol), bol);
> +		return status;
>  
>  	item->commit = lookup_commit_reference(r, &commit_oid);
> -	return !item->commit;
> +	return item->commit ? 0 : -1;

This changes the polarity of the error exit from positive 1 to
negative 1.  The only caller of this function takes anything
non-zero as a failure so this would not cause behaviour change, but
returning negative is more in line with the practice so it is an
improvement.

It is unrelated to the theme of this patch, and the proposed log
message does not even mention it, though.
