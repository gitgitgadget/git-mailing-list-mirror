Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7138C001B2
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 19:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiLPTuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 14:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiLPTue (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 14:50:34 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46987509A
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 11:50:29 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id b2so8561316eja.7
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 11:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6uGiNytu9huDA3M+FXeVeBi4wMLf6GgptkhoF7K0SwI=;
        b=DZaZ/bZLa+n+EP2DKvEPjjvLkK54XJkrw8fSUf1FpHvWrKmsDUbWWuehCCKECh/5Ko
         En9sEI9DE0zSMo7fKvCIpYFs36InGI2AISUnkpUzXkXXee5zQOYI+2nThlm2GYfF/GHR
         PG5+n2Su6iGDJJnO0dV354e5BK4L3+HH/+2OEHJCvGZy7uMhkht15KI1jmbFsjHMtU47
         llh/Dz2aXkrPtMRN/v2X+nDkuwh59bcPEhUbHBZyVtg8fyVpuWfz9SwosXlSWXsgfUdJ
         RjH3SZpYuesIDfIjxbAp8c9DQ1YXFbhvf+T9GnKmcDK7QslPWTYfO8PNK/3ENVbbFXvE
         zXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6uGiNytu9huDA3M+FXeVeBi4wMLf6GgptkhoF7K0SwI=;
        b=Pkh5MQ2xyo29qqwn/d06b/0ibqWkr8t8g9WjpY/1Zfk7jWxmw0vKrUrOLxsQ8Ihcq5
         tRy46gCp9AmdAK3AlHStSKVZQlK8l7+aFQv6E+7SaBgYXqqU8sXNcBX4vnGa98wTAjUI
         iWFAuIDCk6xXGVNMr/N8COMcSBoKP3h9BIgizJ/jFfa3F1dhr/zH1wR2p0boutVY4tMl
         6f1usY+l8Vo6s57q3JOmQzA3q40XZSeYoxUNDKnpCCrg2r4MKk9GsCkQABXDzsAQR3mL
         gw3yChp5bC8/nydvkRaBH+UPL6dxE1a3/wlz/Q2ee3GPmpq6rSuh0AYmc7DdowNnTtb9
         evbA==
X-Gm-Message-State: ANoB5plM6sC4N72XodH+lyfK90mBaBSf1KisCXbNJD+RjWHQlWqKXGNO
        wepgLRQS2f3kP8GgPKGHs1ORsKSuNH8pDUaWMZapSIfnZek=
X-Google-Smtp-Source: AA0mqf5W0O1SlE6pLZTt8lrBIUpLlUQpxa+NhTOs9Q5mtyoHbBdtAzJ6BVldSwgDvr7mlFfGJ/PDMZL98C+jtDx02Wc=
X-Received: by 2002:a17:906:7816:b0:7c4:72d9:acdb with SMTP id
 u22-20020a170906781600b007c472d9acdbmr848475ejm.110.1671220228288; Fri, 16
 Dec 2022 11:50:28 -0800 (PST)
MIME-Version: 1.0
From:   Prajwal S N <prajwalnadig21@gmail.com>
Date:   Sat, 17 Dec 2022 01:20:17 +0530
Message-ID: <CAC5-4e-hViTA36gg=ui5=kUsSswVe+XhRmBz56H-4PkuhYLrrQ@mail.gmail.com>
Subject: Add git config variable for signoff
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I noticed that git provides the config variable `gpgsign` to enable
GPG signing of commits by default (akin to the `-S` flag). But there
isn't a variable yet for signing off commits by default (akin to the
`-s` flag). I feel this would be a convenient feature to have, since a
large number of projects today require every commit to be signed off
for DCO[1]. I am willing to take this up, and would like to know if a
patch would be welcomed.
Thank you!

Best regards,
Prajwal S N

[1]: https://developercertificate.org/
