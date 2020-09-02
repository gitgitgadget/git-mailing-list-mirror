Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D76C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 07:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8D22072A
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 07:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIBHSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:18:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46995 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgIBHSu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 03:18:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id a12so3872710eds.13
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 00:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7AyOxMp23tgN8Z/1vudItk+JzDFz/NYW9/dzZn5zhM=;
        b=clZrb/twfaYihiZtOU40SozIaPhmq0x9QkULKsAzUj9RnByF3wFfI0HgddTm1b0QzD
         zEPc62S7nxESrVldQQvRPbQAsS91DhXPqSIXGn8GqRgC9eP55hGCNrq/MpASXHaHTIEa
         e/eYAQTrDH08aoPqaYkwnhAoVCuJg0Dv1AbKN6+LmCDn93iRVMiO7Zd2wKJSkh8qq0yx
         KngrfJQq9yqf0O3xKWX1oCuhT+Rti/aZnhn9F/7NmlXsvmCuuOT5/e2bPl84Tj3CC/vX
         VPIoTmBEbzmyMmsDkEM9cVW7foFCNTQniCADfai7mCAcyrHG7Bst+idJnV5vrQid49/q
         gMkw==
X-Gm-Message-State: AOAM531jPhHF+dP30iWgGa7iSzwB9rY/idbgjMDUZAYTSlUhNf8+yVJz
        NYRgPRXncfCaRqieG4cujOceJB60f5mGIShY7ew=
X-Google-Smtp-Source: ABdhPJxOYrcuz42bboZstWm5PD/9zy6h0s1VfLKL1XVah7py8uPMsouhFJvw++j05ll+XgkUSfeuEk8PR1GXJoqcQWg=
X-Received: by 2002:a05:6402:17da:: with SMTP id s26mr36498edy.221.1599031128822;
 Wed, 02 Sep 2020 00:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599026986.git.matheus.bernardino@usp.br> <0750191342754bcca398c6fdad522616b0f3fbc3.1599026986.git.matheus.bernardino@usp.br>
In-Reply-To: <0750191342754bcca398c6fdad522616b0f3fbc3.1599026986.git.matheus.bernardino@usp.br>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Sep 2020 03:18:38 -0400
Message-ID: <CAPig+cT7bO97kWgQCftetR_4i_eTU4FsGejkdkY+cbd5K78oLA@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] t/helper/test-config: check argc before accessing argv
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 2, 2020 at 2:18 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
> Check that we have the expected argc in 'configset_get_value' and
> 'configset_get_value_multi' before trying to access argv elements.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> @@ -138,7 +138,7 @@ int cmd__config(int argc, const char **argv)
> -       } else if (!strcmp(argv[1], "configset_get_value")) {
> +       } else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
>                 for (i = 3; i < argc; i++) {
> @@ -156,7 +156,7 @@ int cmd__config(int argc, const char **argv)
>                         printf("Value not found for \"%s\"\n", argv[2]);

This is certainly a bug fix since it was accessing argv[2] without
checking that that element was even present, but the more significant
outcome of this change is that it now correctly diagnoses when these
two commands are called with the wrong number of arguments (just like
all the other commands -- except "iterate" -- diagnose incorrect
number of arguments). It might make sense, therefore, for the commit
message to focus on that improvement and mention the out-of-bounds
array access fix as a side-effect. However, that itself is not worth a
re-roll.
