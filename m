Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD8AC64ED6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 22:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBWWZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 17:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWWZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 17:25:09 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0112F31
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 14:25:08 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 130so4010924pgg.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 14:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzIrodTvYTaKloItAT9d3Z5p2WvABb8fMN8KmqonP7o=;
        b=pZ/6Pebat6oc1JFgUpwlN5F5YrYTaByCYZHLYNoQWOeSplZ3PeTUD89IQrCLQnNcdx
         ehp3pXtxSrjy0bDzmGAOhxHbaTYXTGRHBOkhs0scZcirnHRrgMgFkvM992jT0sjE3bq6
         Bf830PzzSMuANV8WiJYnIhtXmtmJm3RZ9yvZ2ukzHUxQDA4AwPqw70snKCXHYHspF7xS
         h7I1NyPUoU14MhARE1vgkvF8ZWX4iTXR8az8gVLh+WlUwvypRO1BOCqY38e8bqlm0UDr
         rzrsqasetmh5m52J8ExpqE6Mjtq2CZGZn8wdZlrTAOnWNpJuiujyt24iea4z1Am3Udpe
         PuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AzIrodTvYTaKloItAT9d3Z5p2WvABb8fMN8KmqonP7o=;
        b=vOqohf5TqjumsDxOLBhZ09PpkbNlPlT2URJlI3UYYb0mmJkMJEUIvD0yQ0mjNFuWe6
         u6qCRD4s6SpxpuDEzG0CiXq1Rq3WMWfQAx8aKHzr9ID3zdDT6ribCvc5tPVcpvYCDRex
         OTBRejNn5d32LhwZ+94w5reclTlPH5Wl3gNRg09HA7CnYOKBMfssQQmNZOQocwJ4MICB
         IWFPvJJxU6O3KBro52OGay4vBQ/wjx66V0QkhBIAn/UeTF1XSfFDccRsphXjuEER79S/
         YWvmC2R0DMO6DZXZDQ38KXLS78EEl3b0SmzGWBy1TRO+i64vXC9HyodEzzHqkCgtlTx8
         Z4Nw==
X-Gm-Message-State: AO0yUKXf07utjS5OR+rISiYvg0rm63v0+PG5+02Tej6PwoVh8pvxjfbp
        HkvVOeoc9rHyIG6mucLKeYc=
X-Google-Smtp-Source: AK7set/kjfc/QsPkQ2lAvQHM9txlaXw2MBMgFMfvVvDXlCF7Le13pe5lEeWWE33L/6BEld5+Kjxtaw==
X-Received: by 2002:a62:6306:0:b0:5cd:81a7:4094 with SMTP id x6-20020a626306000000b005cd81a74094mr9348145pfb.5.1677191108259;
        Thu, 23 Feb 2023 14:25:08 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7804b000000b005a909290425sm3366642pfm.172.2023.02.23.14.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 14:25:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] rebase -i: match whole word in is_command()
References: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
        <b050e7c1a4daf6c65aa9b2b6f44248d7b403918e.1677185702.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 14:25:07 -0800
In-Reply-To: <b050e7c1a4daf6c65aa9b2b6f44248d7b403918e.1677185702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Thu, 23 Feb 2023 20:55:00
        +0000")
Message-ID: <xmqq5ybs6mv0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	const char *str = todo_command_info[command].str;
>  	const char nick = todo_command_info[command].c;
> -	const char *p = *bol + 1;
> +	const char *p = *bol;
>  
> -	return skip_prefix(*bol, str, bol) ||
> -		((nick && **bol == nick) &&
> -		 (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
> -		 (*bol = p));
> +	return (skip_prefix(p, str, &p) || (nick && *p++ == nick)) &&
> +		(*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
> +		(*bol = p);

OK.  So we skip the command name string in the line given by the
end-user (or see if the first letter matches the single letter
command) and make sure it is followed by a whitespace or EOL in
either case.  The old code was not doing the "end of word" check
for the longhand at all, which was clearly wrong.

I too find "&& (*bol = p)" that pretends to be a Boolean condition
but is there only for its side effect distasteful, but I agree with
you that fixing it is outside the scope of this patch.

> @@ -2513,7 +2512,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  			break;
>  		}
>  	if (i >= TODO_COMMENT)
> -		return -1;
> +		return error(_("invalid command '%.*s'"),
> +			     (int)strcspn(bol, " \t\r\n"), bol);

Nice.

> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index b57541356bd..1d2f0429aea 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -60,7 +60,7 @@ set_fake_editor () {
>  		">")
>  			echo >> "$1";;
>  		bad)
> -			action="badcmd";;
> +			action="pickled";;

;-)
