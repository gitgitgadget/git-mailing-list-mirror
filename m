Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ADDC433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 08:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbiF1Ixy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiF1Ixu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 04:53:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B7D2CE3D
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:53:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n8so2587854eda.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=j9ZkHFXlNzh+u8yXW+/eM2FDW+qLC8cD2QRsQmiBsm0=;
        b=ZpfIEwJmvM+ClmR7ShHYMn3oGQPSy+9vGln24gafZJJdhL/K7BekkHQ0kNxq1hfx45
         zj03wAIOJiveffRmoqlCLuKi8AMSosIUIaLm5T6Cpnknv1yOCzWiQLkbML3Sdvic5J37
         vDdkAKw3T4s0MIf+WSK1AkPQe18j5eL22+AuDDU/Jlxj0AVgGz2tid5DLpuhyvzUKeBv
         hPZp08XHgiCCTkAJqgn/0st8egAxlP65R0chTvi9BgH5Q692xjGn8bT7ySh2Hrpd2Mvi
         jpckDS1P7fCvVoLdtfLMVM3majDMQtrYVhddW6lmOn0DNIIqT4MN5eblul56swEmsSOl
         Qsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=j9ZkHFXlNzh+u8yXW+/eM2FDW+qLC8cD2QRsQmiBsm0=;
        b=O+S8UNfmnqc7as8gOLnu8QL+ykAd8PKAnznELzYJb9aabedz0K7wntO6mXsDVag8e9
         faTjwhKsmA+EDwMIFFDxJLJ5JzG+DI0goocn5UEXQMbO713PA0ooFPGPR9Z4RejJiREf
         YNlPAe1wL+jmZV0EIUYJnihJmYU9uagusqx6+vwDo+ZJqK3WuQo3I3EqQtDvE66OMHxo
         KvrLGqSs/k85WeVBWGvATHshZ1VlT6Q27m7u6zYymOud4J2KC2U17R3riFzhSa/yJBEw
         GVTNDm1CMzjgtQEtJs9jNQBYLShDRUSB8Fn5+Mv7fpnoj6fQell73zfKx/hurj67NtN9
         ha3g==
X-Gm-Message-State: AJIora/qml9Cjct7UzoR9meBTTwzATIpWWI9i7K6mBmuTQ8aHx0RjF05
        3EA0WgoHUmU/qSUz46BMl6cU0we8MfE=
X-Google-Smtp-Source: AGRyM1tqSfCweMzjTe3VGRWMFHiam67pY3cRgu33MiBpmETwwen1siWGzwUC326HRHkICgGq9Puq+w==
X-Received: by 2002:a05:6402:3708:b0:433:2d3b:ed5 with SMTP id ek8-20020a056402370800b004332d3b0ed5mr21906642edb.246.1656406427704;
        Tue, 28 Jun 2022 01:53:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m7-20020a056402050700b004356c0d7436sm9220413edv.42.2022.06.28.01.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:53:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o66yg-001lmS-HB;
        Tue, 28 Jun 2022 10:53:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 4/5] submodule--helper update: use --super-prefix
Date:   Tue, 28 Jun 2022 10:47:21 +0200
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
 <57988287fc01a8baf5c4fd7326772c80bc015f3c.1656372017.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <57988287fc01a8baf5c4fd7326772c80bc015f3c.1656372017.git.gitgitgadget@gmail.com>
Message-ID: <220628.86wnd1f9t1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 27 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> Unlike the other subcommands, "git submodule--helper update" uses the
> "--recursive-prefix" flag instead of "--super-prefix". The two flags are
> otherwise identical (they only serve to compute the 'display path' of a
> submodule), except that there is a dedicated helper function to get the
> value of "--super-prefix".

This is a good change, it was slightly confusing that --recursive-prefix
is left in git-submodule.sh after this, but then I remembered that I
removed it in my ab/submodule-cleanup, and you were presumably trying to
avoid the conflict.

Still, I think it's probably better to either base this on my series
(re-roll incoming), or take make this truly stand-alone, and have Junio
sort out the minor conflict.

>  static void update_data_to_args(struct update_data *update_data, struct strvec *args)
>  {
> -	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
> -	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
>  	if (update_data->displaypath)
> -		strvec_pushf(args, "--recursive-prefix=%s/",
> +		strvec_pushf(args, "--super-prefix=%s/",
>  			     update_data->displaypath);
> +	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
> +	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);

I did a double-take at this, but it's just one of these cases where
"diff" is being overly helpful in trying to find us the most minimal
diff possible :)

> @@ -3352,9 +3342,9 @@ struct cmd_struct {
>  static struct cmd_struct commands[] = {
>  	{"list", module_list, 0},
>  	{"name", module_name, 0},
> -	{"clone", module_clone, 0},
> +	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
>  	{"add", module_add, SUPPORT_SUPER_PREFIX},
> -	{"update", module_update, 0},
> +	{"update", module_update, SUPPORT_SUPER_PREFIX},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
>  	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
>  	{"init", module_init, SUPPORT_SUPER_PREFIX},

I did my own spelunking into --super-prefix recently, and went a bit
overboard, I don't think I'll ever submit all of these, but they're in
my avar/git github fork:

	f445c57490d (submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags, 2022-06-27)
	bac3def78e9 (submodule--helper.c: remove unnecessary ", 0" in init, 2022-06-27)
	af03aa2ad40 (submodule--helper.c: create a command dispatch helper, 2022-06-27)
	952fdec4cc0 (submodule--helper.c: make "support super prefix" a bitfield, not a flag, 2022-06-09)
	2d30186e633 (cocci: don't use strvec_pushl() if strvec_push() will do, 2022-06-27)
	8aa7e049360 (git.c: die earlier on bad "--super-prefix" combined with "-h", 2022-06-27)
	b0d324e9ad2 (git: make --super-prefix truly internal-only, BUG() on misuse, 2022-06-27)

So, this is a digressio, but after doing those I figured we could
eventually get rid of --super-prefix, but it'll require some more
make-things-a-built-in, or make-things-a-library.

But I think out of those perhaps you'd be interested in cherry-picking
f445c57490d (submodule--helper: remove unused SUPPORT_SUPER_PREFIX
flags, 2022-06-27) before this 4/5? I.e. before adding a new
SUPPORT_SUPER_PREFIX flag we can remove it from those commands that
don't use it, which clears things up a bit.

The others are all mostly unrelated cleanup, and I'm only noting them in
case you're overly curious. A web view for f445c57490d is at:
https://github.com/avar/git/commit/f445c57490d
