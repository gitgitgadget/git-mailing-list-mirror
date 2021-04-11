Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D0CC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE67561025
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhDKOnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbhDKOns (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:43:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3704C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:43:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so5407717wmi.3
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSwQKFZvEOCZoDTisdb0QCutW0A8I1jF7P2J6UgPmg8=;
        b=EtB/Jf4Qm+ovDS8lvU2lVXw3jSBxnuTDGfN1EYtKjN48Q0sVkWFPihm+bQlAe5lSUs
         vxsPDKUNX54drSD/RVG7H5C3UsmAQexvnPxUs6M/XoWw3q3HlRLCfpOeLpvkNnNIlpv2
         Pn0R9I+ZPaNjDMZzcTxKlRvoiPkfFutpUfFsaNd1EjMefrwcDTa3YYduYwfwQbe/7sza
         q3klTBGVU397RHnTOSalnOnaQTw/YyOomO/E28ZJC28mWCQC5nPrKuZMNoJv2Vz8bRXm
         9C9osCqT2r7ffjhuANa1d+QcVSNLPsOfPAG7NKHnSR6RZpkn+wh/I7ytM8yzBbVpipXP
         8TSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSwQKFZvEOCZoDTisdb0QCutW0A8I1jF7P2J6UgPmg8=;
        b=IsnwzL1UKI4pWv8eUYw0U21R41Z0mC8uKYUllk0LRYEVWlOM06kukAikjrt5PCRkAB
         Ii4RAuF8Gp5VTUFq417Q/YcNMRdOs8e55AJLoJrcByI3bNn5j/HSf9xYJYac/wCH9hMg
         wMxhRk+dYpeLeVDlN6cOJQ2omPqFVPOEIuw6f8HMzP2KOs7709QRv54ClJfuwd9C/d2T
         6Qeuv3REuYnnR86DYAJjeQUJgfu4mfNz3NbgEmBzJDNRs+C/LUfSKEsqgrTqvptc2b5c
         i/CRxHGd3f5kqDnWApJm3mscryqG50VU3gqKjszKcALCOycCydftbPgZFJxBDBR64oE8
         9x6g==
X-Gm-Message-State: AOAM533C6QWcaVyfkviYlE7lgE4etahSzeqguae11kE5F/IstbXwgTYG
        6/GAlZLnwdvWT6n49XR8dr0g49He0D0=
X-Google-Smtp-Source: ABdhPJxB0PVRJaMjJt1tVAyKG+QvRHwd+9lIBeAL3Qh1suAUuBnyMs3T6S8mok5BIhw+OkM3D0/F1w==
X-Received: by 2002:a05:600c:1994:: with SMTP id t20mr22316233wmq.41.1618152209425;
        Sun, 11 Apr 2021 07:43:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e33sm2105343wmp.43.2021.04.11.07.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 07:43:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Drew DeVault <sir@cmpwn.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] send-email: simplify smtp.{smtpssl,smtpencryption} parsing
Date:   Sun, 11 Apr 2021 16:43:18 +0200
Message-Id: <cover-0.2-00000000000-20210411T144128Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.623.g88b15a793d
In-Reply-To: <20210411125431.28971-1-sir@cmpwn.com>
References: <20210411125431.28971-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 1/2 I unintentionally broke the deprecated
sendemail.smtpssl configuration parsing a while ago. Since nothing
actually uses it let's remove it.

This doesn't conflict with Drew's
http://lore.kernel.org/git/20210411125431.28971-1-sir@cmpwn.com
series, but as I'll reply to there knowing that we can do this might
simplify some things for it, if it were to be based on top of this.

Ævar Arnfjörð Bjarmason (2):
  send-email: remove non-working support for "sendemail.smtpssl"
  send-email: refactor sendemail.smtpencryption config parsing

 Documentation/config/sendemail.txt |  3 ---
 git-send-email.perl                | 13 +------------
 2 files changed, 1 insertion(+), 15 deletions(-)

-- 
2.31.1.623.g88b15a793d

