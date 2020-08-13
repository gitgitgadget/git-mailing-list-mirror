Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB6FC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9E020774
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd3vM+hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMSIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSIr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 14:08:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC49AC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 11:08:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j187so5969101qke.11
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oV8stU7hGwtsJlM2Xecy1EMsFNKqssrVXT/QfwNnRh4=;
        b=kd3vM+hRWgqTmEf9Fyng+8XzOwpNkwWu9hPSl8b2lzNEhtKlsKrWxbPrzlvrYXdL2i
         38apPLHrFpQrhr2j8PvKG/5ZBiyv4/JbUHC7fZMdFqEi02Wf/7NaePgODoXiNDdCoiI4
         joFjykjMGn2e9oPYScFSyey7fYa+5Tip2/VNi/eM5879Q14Os2XjQHteHiiKC5g0aQSE
         o5suZ7R8bwXBWn/8pJVSBkybADcaUvJadoiCLdQFSY76Rqo88N8Ao8+PWoFmNK23FY77
         WwjSOMX4XDqxr84izIhrnkYXK0plAHWc4jaCMn+LlVstAvlgODJqhoJRM/ud9MG22L2q
         Dn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oV8stU7hGwtsJlM2Xecy1EMsFNKqssrVXT/QfwNnRh4=;
        b=aD2TFhC87ny1eMZhbqn/UgPn3UN+652A9yWRh7ifK4RTvI8lqYzKKzEHsIEircmd/b
         bIjYaekdqSwtjpzlhpsvxcg7PD6Mvo1zUVlNSOd+DhB1eCv5Q4xKeYVw87AakBAibaNY
         67+Oner315pEkChiI1BIPMeiyzN7Su+TakBydKl1djJmbLGJRZqwo1dx96hMSYBeR45w
         IylcqBZQj2lS1GA0v5PEF4wuMb+Xqdk8QrWoYbzdvoFPVz0KTqZLKQQqSjpUM+fEdV5y
         xDCQgsg+7QXoPiiT1hoVv96Eegx1iMbuCRF5cQnLDLa09Ch1Rg6CVrZidDGAdITGpsiM
         9rRg==
X-Gm-Message-State: AOAM530IiOtS9l6mlwNuSqzd+iQU+Ub0PH4i16NAAQfXojwiXP/rWD2F
        fMGXh2MWqBx8a0Xorm2GchRKJnQ5Ngs=
X-Google-Smtp-Source: ABdhPJyuYbM7Qts+PtkkQsPYMykrBvOd5XUMlUt4S4+WRO8S2Jyr/k+/LA6/590z7KzwPsmq69OTTw==
X-Received: by 2002:a37:a7cc:: with SMTP id q195mr5843773qke.110.1597342126462;
        Thu, 13 Aug 2020 11:08:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id l1sm7061540qtp.96.2020.08.13.11.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 11:08:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] stop calling UNLEAK() before die()
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200813155426.GA896769@coredump.intra.peff.net>
 <20200813155500.GA897132@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <275f3f6c-77ed-fddd-8f79-28f25b257362@gmail.com>
Date:   Thu, 13 Aug 2020 14:08:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200813155500.GA897132@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2020 11:55 AM, Jeff King wrote:
> The point of UNLEAK() is to make a reference to a variable that is about
> to go out of scope so that leak-checkers will consider it to be
> not-leaked. Doing so right before die() is therefore pointless; even
> though we are about to exit the program, the variable will still be on
> the stack and accessible to leak-checkers.
> 
> These annotations aren't really hurting anything, but they clutter the
> code and set a bad example of how to use UNLEAK().

Good justification. I'll stop being a bad example ;)

Thanks,
-Stolee

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  bugreport.c | 4 +---
>  midx.c      | 8 ++------
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/bugreport.c b/bugreport.c
> index 09579e268d..7ca0fba1b8 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -175,10 +175,8 @@ int cmd_main(int argc, const char **argv)
>  	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
>  	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
>  
> -	if (report < 0) {
> -		UNLEAK(report_path);
> +	if (report < 0)
>  		die(_("couldn't create a new file at '%s'"), report_path.buf);
> -	}
>  
>  	if (write_in_full(report, buffer.buf, buffer.len) < 0)
>  		die_errno(_("unable to write to %s"), report_path.buf);
> diff --git a/midx.c b/midx.c
> index a5fb797ede..737420f157 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -807,11 +807,9 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	int result = 0;
>  
>  	midx_name = get_midx_filename(object_dir);
> -	if (safe_create_leading_directories(midx_name)) {
> -		UNLEAK(midx_name);
> +	if (safe_create_leading_directories(midx_name))
>  		die_errno(_("unable to create leading directories of %s"),
>  			  midx_name);
> -	}
>  
>  	if (m)
>  		packs.m = m;
> @@ -1051,10 +1049,8 @@ void clear_midx_file(struct repository *r)
>  		r->objects->multi_pack_index = NULL;
>  	}
>  
> -	if (remove_path(midx)) {
> -		UNLEAK(midx);
> +	if (remove_path(midx))
>  		die(_("failed to clear multi-pack-index at %s"), midx);
> -	}
>  
>  	free(midx);
>  }
> 

