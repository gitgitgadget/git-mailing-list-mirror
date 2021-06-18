Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C73C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC1361261
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhFRVGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhFRVGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:06:09 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2D0C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:03:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so4396233ote.11
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4m17VSsGW0HO9uj4oysb97HEpGCZgUD68XvQrdwsRwI=;
        b=N9oWhubD9ezPtVJvWrCJFiPOcWLt+UiWTT3fWpVQW58WVMsA72Mg9cg+Auekzzd5wd
         13NVNgcDKAVcITsKdyIdCyp3tMn6B67T5yURj/8FdTykkbQdFoYa0jGvsEeSljfRXLLe
         Lw5MLG/9bzrFCMC0oLw0l/vv7Tuw01P595Ln58xTz9bjXWGd6qQto+lvCtn5H9C7yORj
         FkhAgFHCuUFJgQ3/hsSFJOF9R46kg9Nud1OeSWSmCRVbsMjV3HnGGOiovPZn/O/YJ9GI
         dzfncHVol5n4N48y4RLjCs1CTmen4CKF+AIO2ylcD0Sh9RRtNEukfDXdkVCZnnflaLfg
         z2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4m17VSsGW0HO9uj4oysb97HEpGCZgUD68XvQrdwsRwI=;
        b=kla4tbl4oNzzBsqgfhT8gjdSqFauBBnfkmOAmBcA5y96Oc1S8/aPebOYntm7ZInjs+
         u3H2bsy0RGpgZy48X/xRzPNQ+AERVK0vpWIHp5BvJPeQzno7U5PtkLcLqeHN4HcKV3lM
         RjRctSCe+dmMBcHkYVLzNBnue4TjoiMn/WgCBA29FP3tB9zRbl3s/wjmaGTu/X6O+d8p
         Iw7H0QWP70JCDeDwU9uLZPJ5KbCJhZ7/vB720wZK1ow0WaMQG1rNUzsWIWW6AO4QCmSt
         7Bd+71iH1IOk3DdIfS9IMBk+yuaEZxOXZAthwfCYTmM8Fg/VNzR3h8Rg0DAbw/+z2vdU
         BTIA==
X-Gm-Message-State: AOAM531KaJr/AydDWlhqfvGyt9mHiBEnv7rvyj7IGHsdCUmB4Aj9Cp4K
        0RC9LM+u6n5juakHW09CgnA=
X-Google-Smtp-Source: ABdhPJzKwXi/cg/y1icVjD+18OJxeuhhcKdIJeaF3NERdcf7bBXibfxO9V4sEp0XMvaI4uzyCPALUg==
X-Received: by 2002:a9d:2034:: with SMTP id n49mr11729139ota.231.1624050238221;
        Fri, 18 Jun 2021 14:03:58 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o6sm1274424ote.81.2021.06.18.14.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:03:57 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:03:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Message-ID: <60cd0a3cb4058_c0ff920813@natae.notmuch>
In-Reply-To: <20210618203057.790320-3-felipe.contreras@gmail.com>
References: <20210618203057.790320-1-felipe.contreras@gmail.com>
 <20210618203057.790320-3-felipe.contreras@gmail.com>
Subject: RE: [RFC/NOPATCHv3 2/4] doc: add linkgit macros for asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> From: "brian m. carlson" <sandals@crustytoothpaste.net>

> --- a/Documentation/asciidoctor-extensions.rb
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -15,6 +15,8 @@ module Git
>            "#{target}(#{attrs[1]})</ulink>"
>          elsif parent.document.basebackend? 'html'
>            %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
> +        elsif parent.document.basebackend? 'manpage'
> +          %(\e\\fB#{target}\e\\fP\e\\fR(#{attrs[1]})\e\\fP)

This is the same as my version [1]:

  format = "\e\\fB%s\e\\fP(%s)"

Except my version is cleaner, I don't see the point in doing \fR \fP.
What do we gain by that?

[1] https://lore.kernel.org/git/20210521224452.530852-6-felipe.contreras@gmail.com/

-- 
Felipe Contreras
