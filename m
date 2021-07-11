Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D17C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 11:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C8661209
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 11:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhGKLVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 07:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKLVi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 07:21:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8469C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 04:18:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so10967439pjs.2
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 04:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=ZGaCnEV6c+5PVDoWK/2QFU1gUxxidVUF9yT/UpkWkuU=;
        b=k+tbIjDAB8ckn0syts/YeTVj7Q8OgpFLCEc8FNIF8lvUQDukY0s8ZfG+si8twZYzPi
         UOj0L4DJwR8Ls46BOfbxWIBMMTK8mZz7yG+LAdubK4uHo7V+9o6373dNVzPwkg4V3Az2
         hTtBWaUDYj3eBIMI6JNcs6240k2hKAPtYS17p7GdhtyqYGFwhQH+9nLvLTOXDfKX7mVU
         w/xgKZ2mklEeUB53P0hf++xtD9I7Ar4mRswHAA4ClEjUgS4VwKoh4+H0Hj996WJvCg2U
         o1fcogRViEphW92VwFJ8ejT3Igo0wkBqttj9aflVxBBoKdhPxwV9f+2oG/cneeYdBghX
         K2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=ZGaCnEV6c+5PVDoWK/2QFU1gUxxidVUF9yT/UpkWkuU=;
        b=qYd/vV+eOAfDLrWplJ11qtFZF+VZ+UnTaBdzsPJrZJjP9tmU3AvsjCOjzdMPxSsCdt
         ljMGgXnC7Gvgi0BsWMRbg3OlCMDUxfDEFSCWpG7WbKn2o4oHMy/6KST3AI5IjiWnRB5o
         zvdbfHQ8AWzx1oM5x2ajKB8cuTCqUdnHkneUwKZSPuGnl0TKPHLJNSL1yQr/o6+ZNWMo
         id7A3+UjDIWNbw3Dotvjgud6ojz30o6P3Zo6MTVA4yss0DjG61Wzaa090FkDb7UVZLfX
         0hgTKQZBKGF2iiAxQZxDwOcWkvCyJUc+0Sz1jBOc2vxb+/9Ft/GnxoLkivWS06Gx1oHT
         h4nA==
X-Gm-Message-State: AOAM531bK0rtZnx3fLqJ9uxCZK5wNlKXhxUw8YkKuF/xPw0t/bQr9R+I
        x5Su/rTrWQVvSUpNIQcOiVg5Qb/duxAoCw==
X-Google-Smtp-Source: ABdhPJxXIj7mL3c0s1MAinj9kSTeSmx4ZOkiUtx8WCUCsbjq96tmixAD1VJjLPmm9GcigrfgtEPv6Q==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr8787752pjs.64.1626002324628;
        Sun, 11 Jul 2021 04:18:44 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id x6sm14518552pgq.67.2021.07.11.04.18.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jul 2021 04:18:44 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: =?utf-8?Q?=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=93_Week_8?=
Message-Id: <CD6968A1-179D-4B77-91C1-4EECB1B69951@gmail.com>
Date:   Sun, 11 Jul 2021 16:48:41 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's my weekly update:
https://atharvaraykar.me/gitnotes/week8

I am currently blocked by trying to pass a super-prefix parameter
to another command, when calling it from within C.

If you are interested in helping with that, this will take you to
right to it:
https://atharvaraykar.me/gitnotes/week8#path-pains

Have a nice day.

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

