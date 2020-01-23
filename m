Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22822C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 22:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB3020718
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 22:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LYAtTOmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgAWWy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:54:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54527 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgAWWy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 17:54:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42862443A0;
        Thu, 23 Jan 2020 17:54:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9pBXMOxn0bOQcU/QiiPAtVHcrGk=; b=LYAtTO
        mFE0XiXNV9LWrbUqopIzZQ/gfta4sdL7DarXghZCI9cgP1vb/Xsrz6KzvJBc+Rn3
        3VIotAoMxV1E7bX2cD5ZeL7qaY1qEJQepdJoRVDV57dulXB+Vvnnu5N/YGGuVZdA
        yHRJMISyqblTSxtXYCSEzaAVtub3pXinrJ2tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AlfMuqz3/6Uy2WzMddYH9WYnx4IS8jNg
        xBQnPPWkgB12Pcl2Pj3p/yMS6Sc3dkavT4yph7sUM6v8CuwG41CD6+wmcL1YH1YN
        /oFIVnX6OHdJOa3qbSIUl6Lly9OqoY9osvftbrym7ETc8QK1kVbYhxurqh0XcWQm
        Bsu4g/HIF2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39BB34439F;
        Thu, 23 Jan 2020 17:54:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 940B04439B;
        Thu, 23 Jan 2020 17:54:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH 2/3] color.c: support bright aixterm colors
References: <CANsz78+-Z89d8E=n3cjfnXaGVFXpchdG7EjtdQuFjzo-=2aPeA@mail.gmail.com>
        <20200121165623.151880-1-shawarmakarma@gmail.com>
        <20200121165623.151880-2-shawarmakarma@gmail.com>
Date:   Thu, 23 Jan 2020 14:54:25 -0800
In-Reply-To: <20200121165623.151880-2-shawarmakarma@gmail.com> (Eyal Soha's
        message of "Tue, 21 Jan 2020 08:56:22 -0800")
Message-ID: <xmqqo8ut3hsu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E4E37CE-3E33-11EA-80C5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eyal Soha <shawarmakarma@gmail.com> writes:

> +static int parse_ansi_color(struct color *out, const char *name, int len)
>  {
>  	/* Positions in array must match ANSI color codes */
>  	static const char * const color_names[] = {
>  		"black", "red", "green", "yellow",
>  		"blue", "magenta", "cyan", "white"
>  	};
> +
> +	int color_offset = COLOR_FOREGROUND_ANSI;

No need for the blank line before this line, but a blank line after
the last decl/defn is a good idea.  You'd need to define "int i"
here, too, as...

> +	if (strncasecmp(name, "bright", 6) == 0) {
> +		color_offset = COLOR_FOREGROUND_BRIGHT_ANSI;
> +		name += 6;
> +		len -= 6;
> +	}
> +	for (int i = 0; i < ARRAY_SIZE(color_names); i++) {

... we do not (unfortunately) allow declaring a variable in the
set-up part of a for loop yet (see Documentation/CodingGuidelines).

> +static int parse_color(struct color *out, const char *name, int len)
> +{
>  	char *end;
>  	int i;
>  	long val;

With the removal of the loop, "int i" no longer is used in this
function.  Remove its defn here.

> @@ -96,12 +120,8 @@ static int parse_color(struct color *out, const char *name, int len)
>  	}
>  
>  	/* Then pick from our human-readable color names... */
> -	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
> -		if (match_word(name, len, color_names[i])) {
> -			out->type = COLOR_ANSI;
> -			out->value = i + COLOR_FOREGROUND_ANSI;
> -			return 0;
> -		}
> +	if (parse_ansi_color(out, name, len) == 0) {
> +		return 0;
>  	}

Thanks.
