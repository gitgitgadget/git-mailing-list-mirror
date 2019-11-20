Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C92C43215
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 14:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE7224B1
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 14:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI87V25n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfKTOOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:14:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33120 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfKTOOB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 09:14:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so9708wrr.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 06:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wBrs9AUVUvw2+eglku+2XyzOL25PtNDbDwgVitPjhck=;
        b=nI87V25nJaqqfqttfBB7iqQ2jZ/8ehPZvCb8fIU50PsDKOMidlE6UhiUQS8j3HRpQr
         EDF1qd+TE79tFTezXtFVjBoSixOnYZGoUBDHbRGEkfPxtD7IrhSEX6DNfCZFYDFijG66
         ZM/m1P5i+ATQmKGeUDBDGHf2Svq3MgCqOozXl5KZI3WKVEhAdNpPE+XEIldMcVBJwvG0
         niiIs8g4K7KIkV/qrjKAvSobBU/zSN9ZIU1QTIiQmjGVRvy1YE6I3XKUTvP91j7W5cdt
         byEaoOh+dP3wcpEDFR1CmjAg4AaMjiY9R2LqLSxUe52RAXCnUqWibK93DkdEAl7IHMJi
         kZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wBrs9AUVUvw2+eglku+2XyzOL25PtNDbDwgVitPjhck=;
        b=iOr34BLlEsN92BcjWD7gLbmXu0U7Z5qfgyfRKNuJ4OseVI2fRZqM/5LvcbCDnzO8yV
         GgvJsS6wZJWU0nYKNYFIUVaAfMaNT6DkPlrcrlIfNHDc+pp+Xv8/oPMhOhrDeDMw9fFV
         MPos879Yl32IiMtSdAzL6f/3aampDqxs/eYse/7P2tS/HPs1Fts9lRMO5aUYwNr9K3Vt
         ko/ooe9yKOLeruGYuHSDtIR8tiR78v3vtzQs8FcroNeIc/At2/mxRs/U9LwTYfPLD2cK
         xFRm3mUxGZebfQquAzxIYpx2Gd8jafbM3pKK4Nna7F6GpF+TfQfMgVmxYY7dfJBBbZce
         Zt0g==
X-Gm-Message-State: APjAAAXZjqmhIoh0J7VRoesfJQwe1//s/P7qrUL1ak0kwrCPcqeC8Z2R
        0iYoX40LcyKmLag6rb5g0/ZJzwL1
X-Google-Smtp-Source: APXvYqzi7JL4hlcuUvJ7tjARwflE5/0TbuAjVg5TQwHzWfoqPFoVP58sCdJgQbqr6H0Ohl/A5Hla+Q==
X-Received: by 2002:a05:6000:1605:: with SMTP id u5mr3494538wrb.252.1574259239866;
        Wed, 20 Nov 2019 06:13:59 -0800 (PST)
Received: from szeder.dev (x4d0c5363.dyn.telefonica.de. [77.12.83.99])
        by smtp.gmail.com with ESMTPSA id g8sm6740385wmk.23.2019.11.20.06.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 06:13:59 -0800 (PST)
Date:   Wed, 20 Nov 2019 15:13:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
Message-ID: <20191120141353.GA30837@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
 <20191119143308.GF23183@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119143308.GF23183@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 03:33:08PM +0100, SZEDER Gábor wrote:
> > +	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
> > +
> > +	if (mode)
> > +		argv_array_pushl(&argv, "true", NULL);
> > +	else
> > +		argv_array_pushl(&argv, "false", NULL);
> > +
> > +	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> > +		error(_("failed to enable core.sparseCheckout"));
> > +		return 1;
> > +	}
> 
> Why the external 'git config' invocation?
> 
>   git_config_set_in_file_gently(git_path("config.worktree"),
>                                 "core.sparseCheckout",
>                                 mode ? "true" : "false")

Having slept on it, I think it would be even better to pass NULL
instead of "false".  "false", well, just sets the configuration
variable to false, but a NULL would properly unset it.

