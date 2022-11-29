Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32999C433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 23:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiK2XaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 18:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiK2X3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 18:29:49 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06BE716CE
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 15:29:41 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o15-20020a17090aac0f00b00212e93524c0so244027pjq.2
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 15:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CE3o35DP0AJ+KfPbrRnkPbkZdA+gzedIiONUZ2R1Bec=;
        b=KX6CQYBzdGoHHYZHaHCTEr9X3Mec3DDsB6lqG3xZs558+H4nxWE6C95V7yTjESaMj4
         VGtFKErty3ZeugqYnC0LXGrBZITgK67gAFChpIcB+w00iS9u3B3sGN4e/jcSalZzdeV4
         sHokjIkcZDgKpMdQtyLWUg3bzB45azLWVZKwhfhHjPvH2nlepOmZS4dRAIwGfhY5UlSX
         E08zNET4NCeRDNt9CHmKzyEaVSwhytLa/QCwebk4xHDQjYtkS3oukyiMJX+QaeEY5WCf
         0R09LT0Z0nzYP8zgogVMJWX9f/fy0B7a9/krAiMkbEggVXsiWrdMuIPK2XpuRJaRPMvO
         dh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CE3o35DP0AJ+KfPbrRnkPbkZdA+gzedIiONUZ2R1Bec=;
        b=5Mpsqwgjt1InPXYFzCParVP3KTo5uwzcFHH+JoScGubV25B1ZAAjlrEdFgC/VmPXfU
         m5a97MvfJFhjy7kc4GLS3mgt+jX20oh1H4848nT+WA5HqJegd40mrot0WeR1D2emiZBP
         y5jQIoOhvaCWOpwOH6RxnjXnDTbAU7PzuN5zCoknq1yoBao1ESkp0Vo3AGRMSBvtO2HM
         oclLxGnDXrU35DceBd5i3rR08gYH3klpFtsQe8VR64WnFTgVWQfbdmn+/WsMp11P/4By
         gNGyanX1i0A1FvIDjzpJjwv4R/GzwgiWEF3FhlBJro/DZ782GC7reHpQzLS/gp9RuVoe
         C3+Q==
X-Gm-Message-State: ANoB5plZp9tV/Rm/sutkiR7ovo29PGVtrhgBmkCu7RwzgMLaw0mW2TM5
        CaHNpaYs2cFJE2XH30BOWOjoHqW1dp4+sw==
X-Google-Smtp-Source: AA0mqf4Gua7GykE6LKwosgs3chnsuyUT8GJ9OXjUHYMyXXFA6UKE4qxQYYiBvbCBdVCOQPnWxm2aJ0BSVbETpQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1303:b0:561:7dc7:510b with SMTP
 id j3-20020a056a00130300b005617dc7510bmr60818201pfu.3.1669764581436; Tue, 29
 Nov 2022 15:29:41 -0800 (PST)
Date:   Tue, 29 Nov 2022 15:29:39 -0800
In-Reply-To: <20221108184200.2813458-2-calvinwan@google.com>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
 <20221108184200.2813458-2-calvinwan@google.com>
Message-ID: <kl6lo7spqqzg.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 1/5] run-command: add duplicate_output_fn to run_processes_parallel_opts
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> @@ -1680,8 +1683,14 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
>  	for (size_t i = 0; i < opts->processes; i++) {
>  		if (pp->children[i].state == GIT_CP_WORKING &&
>  		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
> -			int n = strbuf_read_once(&pp->children[i].err,
> -						 pp->children[i].process.err, 0);
> +			struct strbuf buf = STRBUF_INIT;
> +			int n = strbuf_read_once(&buf, pp->children[i].process.err, 0);
> +			strbuf_addbuf(&pp->children[i].err, &buf);
> +			if (opts->duplicate_output)
> +				opts->duplicate_output(&buf, &pp->children[i].err,
> +					  opts->data,
> +					  pp->children[i].data);
> +			strbuf_release(&buf);
>  			if (n == 0) {
>  				close(pp->children[i].process.err);
>  				pp->children[i].state = GIT_CP_WAIT_CLEANUP;

A common pattern is that optional behavior does not impose additional
costs on the non-optional part. Here, we unconditionally do a
strbuf_addbuf() even though we don't use the result in the "else" case.

So this might be more idiomatically written as:

        int n = strbuf_read_once(&pp->children[i].err,
        			 pp->children[i].process.err, 0);
 +      if (opts->duplicate_output) {
 +          struct strbuf buf = STRBUF_INIT;
 +          strbuf_addbuf(&buf, &pp->children[i].err);
 +        	opts->duplicate_output(&buf, &pp->children[i].err,
 +        		  opts->data,
 +        		  pp->children[i].data);
 +          strbuf_release(&buf);
 +      }

which also has the nice benefit of not touching the strbuf_read_once()
line.
