Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDFDC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D712075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KbEX6GkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbgAXTJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:09:50 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57418 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbgAXTJu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 14:09:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BEC89D9F2;
        Fri, 24 Jan 2020 14:09:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KWBAareIH05TnPLy1nyzEddU88s=; b=KbEX6G
        kGInoNUuN0J/ur928cB1K2Fl5Vr3v4QMVsLXNpHvfIRIZXHrYZesPVJkRAWgeDcY
        2mcPaOiRADRs+1hwttZfOqFfEJ9LC9tezN2vyHqLcbSKQXhVwfYwHu9QV7TB4631
        NEu6SyuFjgMpYzVTG3/8vihj5zpt+B9sKSvUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uCVlaWYT+mB50qCd99Pgw1nq/Aq3VTmP
        mxaLFXbmSrNR/G8NKcf6oM8gQULaDv3SrOqS7Fcft7PUR3y4Wz4xeRktKr2WNiAw
        8bgXjbU7mCyc+cX/KvN/LRWJzydyd9HCCMdnfiLV2nDsQB95mCiYuj0zMHeTI/Ym
        xI8h2xnwVpc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94A539D9F1;
        Fri, 24 Jan 2020 14:09:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9D97A9D9EF;
        Fri, 24 Jan 2020 14:09:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v4 4/6] config: split repo scope to local and worktree
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <9f160e281a984ea7578f8fbe244adc77c6585e44.1579825267.git.gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 11:09:43 -0800
In-Reply-To: <9f160e281a984ea7578f8fbe244adc77c6585e44.1579825267.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Fri, 24 Jan 2020
        00:21:04 +0000")
Message-ID: <xmqqwo9gzn60.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1570AF90-3EDD-11EA-A10F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 214003d5b2..6695e463eb 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -44,8 +44,10 @@ static const char *scope_name(enum config_scope scope)
>  		return "system";
>  	case CONFIG_SCOPE_GLOBAL:
>  		return "global";
> -	case CONFIG_SCOPE_REPO:
> +	case CONFIG_SCOPE_LOCAL:
>  		return "repo";

This must be updated to "local", no, to match the change to t1308?

> +	case CONFIG_SCOPE_WORKTREE:
> +		return "worktree";
>  	case CONFIG_SCOPE_CMDLINE:
>  		return "cmdline";
>  	default:
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 7b4e1a63eb..90196e2862 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -259,7 +259,7 @@ test_expect_success 'iteration shows correct origins' '
>  	value=from-repo
>  	origin=file
>  	name=.git/config
> -	scope=repo
> +	scope=local

