Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64591C48BC2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 01:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A1E6138C
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 01:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFXBrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 21:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXBrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 21:47:19 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3C2C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 18:45:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso1989815otm.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 18:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=C9cfidRs8xQbjkHsKYMAFZIgrxxPWMXNvnmua2YyyaQ=;
        b=BRkyR8Z3dqAcAvHEqgGuA5peR1jfRYF5tTFLnosGk/2Hd72FsDwSF42Yuh4vIeuIpn
         LJIAJYxBH94NKEPG/U+5r8GzgxypLvUJP+AZFLlpuAaM6/RKDRL59mV30vp5sJEp9A/+
         bmVGNXgRysi4zNPLsYQhW2yKfOyTHvFBW3WGh3TZaiwITUmQMVnrNzUpocV1bOks2Ms/
         1fzRbR0t4THuKGDdZwtCVwDSMLVuO4S5ZBZJ+Vd8ulMdd84NOowi92ezrUafIKFSwA7b
         OemnaHM5tRH7+zYP9nRIghPMLzh21SfeTB193DCNU6mW8rzOWJWbxtsmjp08j5uvm+qh
         iqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=C9cfidRs8xQbjkHsKYMAFZIgrxxPWMXNvnmua2YyyaQ=;
        b=Sqy0pU/W5TW1Ew6NCAry4r5KW6CLqpdMmY/XVf4JX32RDfALebJmML/EZKW7BBnCpa
         wBj5UtfxO9SueJYGzHusFsZQuw5NCyDObC8gpNaoCwlBNlMG6qw5fUNjm+lqzbK3T1gF
         OL2g/cW6EAfBFLTkkZt5cxVb3BQGkC6vmh1YGqxT0/dtcc1R3+TBlpighrLJCuKmCKFE
         YGbwxgJzz5OW09npancIQtQFV9qzulVgVNj2J13Kox22rvqV9pNriqMIFmxOnBHK9NXE
         kWqhkk0tWWA1QZ7DbFH8jb39lJtKXimrsGhrXCDblblKy8gsyQkqlRkgHL+hJEQaQaLL
         Ctmw==
X-Gm-Message-State: AOAM532elkZt4IrL9jvHdiTqkCMPLrhVeRO3x37GJKxiQZw43X9kmThK
        VkdzTcxuwjGZAugLV9Rvi2A=
X-Google-Smtp-Source: ABdhPJz81SP+H8oURR3IvWb/6l52qp+/jTiPYSU+6jB6Wvzlo9uZvsfutVT7HihnY+Skwg65YoO3gA==
X-Received: by 2002:a05:6830:1309:: with SMTP id p9mr2433366otq.209.1624499099359;
        Wed, 23 Jun 2021 18:44:59 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id s15sm370004oih.15.2021.06.23.18.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 18:44:58 -0700 (PDT)
Date:   Wed, 23 Jun 2021 20:44:57 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60d3e399945d_2cc520855@natae.notmuch>
In-Reply-To: <20210523054454.1188757-1-felipe.contreras@gmail.com>
References: <20210523054454.1188757-1-felipe.contreras@gmail.com>
Subject: RE: [PATCH v6] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> --- a/builtin/help.c
> +++ b/builtin/help.c

> @@ -264,6 +289,7 @@ static void exec_man_man(const char *path, const char *page)
>  static void exec_man_cmd(const char *cmd, const char *page)
>  {
>  	struct strbuf shell_cmd = STRBUF_INIT;
> +	colorize_man();

On further reflection I don't think this colorize belongs here.
exec_man_cmd() is meant to execute any custom command, not necessarily
man.

-- 
Felipe Contreras
