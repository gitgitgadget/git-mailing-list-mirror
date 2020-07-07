Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B928DC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 18:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94064206E2
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 18:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rams-colostate-edu.20150623.gappssmtp.com header.i=@rams-colostate-edu.20150623.gappssmtp.com header.b="YGArh3DX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGGSCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGSCj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 14:02:39 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E1C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 11:02:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a12so44181214ion.13
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rams-colostate-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=mvOkShvig3k1YPYL+0S+4no09AkhXfvQNGk1HEk0wcE=;
        b=YGArh3DX8blDkzSIzaGRyc2GQEQ+WumuFysPNVwFfLq0CpwZo7SzgjvhqiN2KlOQI0
         eqm5tufgCa8nYWvLC9I7/nWW+R3RsUc7rtn6z1NPERbu5Q39S9qEcCluuKHrEl0dS0vL
         USm/SvF1qSfKDCwuhdgDLUOEMY6xtxAGEjNUXwjdZbjmiWs76105IzrQPwN6jyHkCPPZ
         RPnOPStqRSjg5eKv+Atnc9Jv6PPu24NgVtFNzfGVioVPt6DlULCJX6emEE53rBa70ki8
         Uce4CTIh+8k+9inNZG124aVD9Nt7K2SVujsJkMQKSDHPlZ6X8EgFnanP7AsN9+K/AbMi
         rBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=mvOkShvig3k1YPYL+0S+4no09AkhXfvQNGk1HEk0wcE=;
        b=HkouMAtgqjz8jirC8B12BFY+fNRhmmjVe0XfL2wxhEeKZgxc8HHtn2AtvFdSFzPoZC
         r2KczQTYrX61gkGzHYPvXH+RyWrRzHLGyZyR/v9n3my0NOs+GZzcH6ab1QGYb4opKotA
         nSPTCnNkdo5Wafo/qorPxyvyk1GL0LMSyQTHSfWb/ogG5+siAsemT0NIHwgZ+iNtea7n
         HXuHLJB/qIjgl35oM06Urkbk7BYgP/MfSwDk3qabV9GykxKuSsJoRuweWErHvo7zm6O/
         zfTUrcp1yBB04ELtjkMKoHA4msEyvyibceQdo0JrCycgaM2CAAHmJYoS6pvvt+5fKGgp
         ibug==
X-Gm-Message-State: AOAM531dLbce+0tQdE4IXTTdaheRSQrXJ/TaWdC4TQ498FMIfxP8oLSd
        Bc4zQzKzCQUjeAJhrlRlYA51Tw==
X-Google-Smtp-Source: ABdhPJxf1QXjeKtnQHkR8qmflEJjJGT3dCxLbtJtlJ1YXBCnaO2haNqR2i0s1LleM5rBbrMg85RPDw==
X-Received: by 2002:a02:cb92:: with SMTP id u18mr38935957jap.143.1594144958226;
        Tue, 07 Jul 2020 11:02:38 -0700 (PDT)
Received: from [10.180.88.240] (host-110-28.cofcdis.ftcollins.co.us.clients.pavlovmedia.net. [68.180.110.28])
        by smtp.gmail.com with ESMTPSA id 5sm9625151ion.7.2020.07.07.11.02.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 11:02:37 -0700 (PDT)
From:   Jimit Bhalavat <jimit@rams.colostate.edu>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: GPG Commit Signing Project
Message-Id: <3942AC4E-6798-442B-81E9-B3D9B10A4A56@rams.colostate.edu>
Date:   Tue, 7 Jul 2020 12:01:30 -0600
Cc:     git@vger.kernel.org, David Huseby <dhuseby@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

When we last spoke, David Huseby, my mentor for Hyperledger Git Commit =
Signing Project, proposed an outline of what we are trying to achieve. =
We have come to the conclusion that me and him are going to spend the =
rest of the summer analyzing the format signing infrastructure and will =
have proposals and questions as we go. I am also going to write a =
technical design document which will help us analyze the problem. I =
realize this is a larger long-term project that I think deserves a topic =
and how would I set a topic up?=20

I am also going to be thoroughly reading and understanding the patches =
from last summer which will help me guide through the format. If you are =
not the right person to be in contact with, please put me in touch with =
the right person, or if you don=E2=80=99t mind, please forward this =
email to them so that we can be in touch.=20

I really appreciate all your help, thank you once again, and I will have =
proposals and questions as we move forward.=20

Thank you.

Be well and stay safe,
Jimit Bhalavat=
