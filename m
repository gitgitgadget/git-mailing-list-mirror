Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2524C433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 05:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B244F610CF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 05:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhISFFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 01:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhISFFd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 01:05:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A051DC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 22:04:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y8so13068832pfa.7
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 22:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=MuYZ/h8jbuCPhgZv0HuTDBzYyLkr1RZpYcz9G1bggwY=;
        b=QjJOliifIgymX9bY98vLK9HLHG0W2VJUkpbW9ZptFY8DwsF6jN7MA2N5w0R4QWGz2c
         bMeoH1Yfv0mBnpFukCiZiyeVaCzpXsZTc+vdaN7w9LF05ratf737jVW0E6vVAHp8GDE2
         8hNMHwaOdN1Oeir1gmT3W9sZRewkL/FTsbFcTiXCnVXY8h2IbPcOYgLD8CvRPpKIasmZ
         L6RMCreMgkVyekIsNYI7QPMs9SV3naFBxOdX9jHhARH3NEjXjPAXij4fmHtclDgzBooo
         aDp/y9sYnIMoA3d1x+Ykc8TNZojZRi07RVMVwU6bA/UtMThoPM81rEdhwIZQoSK2c5jE
         msvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=MuYZ/h8jbuCPhgZv0HuTDBzYyLkr1RZpYcz9G1bggwY=;
        b=cl+IxUDS7jne/Zwr4sCWOO3gEA9jofH1iCW9za9sOxmfRzx+FWvuVz6XMLayacaNKg
         LYFgy/83BABGmn1ugcGk70WZ0d+FA08VTR+2modVIXP8b2Bh5eWoTG19l+RzTz6MDEbf
         BwMQS75G97BYYVZa0rLkHh1CVJUiaFxw1yOC6z4tlAyjCdY/wQbElFbTbesfoTB0B+Ne
         PMPMegPnL6vYbGquAdrQCi7q7qy3ibLqus+AO4I+oazq8YzDV1tw0wLrvZSbAiMYK2fC
         E1EJuW6hY138UyWefQ26doYKjKm0lfseQv1eMhy71vkrfFVQMeHkKlRoDhQRheqM8i/W
         eHKA==
X-Gm-Message-State: AOAM530il7A2jzrfUuIYdy7ahHfuflewIYk69mfj6GLgwNpHtgMfLqto
        4Uwk0mlYRixM9SxU46xwzvqaRBGRluGrJQ==
X-Google-Smtp-Source: ABdhPJxQ/Z+GECHLHRgS9aZpXIvkqy4cnLK0gKqrhO6cdCaVYP7BLI2C+bMdgRyFF1K1QSFFjvfuEw==
X-Received: by 2002:a63:ec06:: with SMTP id j6mr17655272pgh.259.1632027847907;
        Sat, 18 Sep 2021 22:04:07 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-85.three.co.id. [180.214.233.85])
        by smtp.gmail.com with ESMTPSA id z62sm14815038pjj.53.2021.09.18.22.04.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 22:04:07 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: LANGUAGE instead of LANG respected in git?
Message-ID: <8ed06f91-2efc-1816-aa82-beac8e174549@gmail.com>
Date:   Sun, 19 Sep 2021 12:04:04 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Supposed that I would like to display `git help` in French 
(`fr_FR.UTF-8`) language. I ran `LANGUAGE="fr_FR.UTF-8" git help`, and 
indeed the help is displayed in French. But when I instead ran 
`LANG="fr_FR.UTF-8" git help`, the help is in English instead of French.

It seems like Git use LANGUAGE to display localized messages instead of 
LANG (like many other tools do). Why?

-- 
An old man doll... just what I always wanted! - Clara
