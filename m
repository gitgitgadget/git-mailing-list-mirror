Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2311C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 22:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BBF2070A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 22:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUzwwHhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCYWQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:16:19 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:51233 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 18:16:19 -0400
Received: by mail-wm1-f52.google.com with SMTP id c187so4544375wme.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhlEh+kfkSdrcOvtM4ES54YzML5GWa8WcABe9Xi/pgA=;
        b=PUzwwHhKloeb6pek1KtW2UzCvbkCNaYAppZIyzqVmesvgj1vUVIC1QBKMEWVomD2gP
         MqSK1HePp+ZOcE2RDpPTu1T0oyq+QxJgz56kzbQnkqjvflYw5jKWBHPo7wZMjoUXFYDQ
         YyiRYmLrAm1Um7WP36r0FnBGtwtYniXUbn8aIcM1Z4g08FD3EO6dTGAyf0nK2h1dl+/k
         4Q4VnqMMIsV/xgddI1QJPo4MaIups0CB5KN+CQtKXPUeDJJ5Vg0E4lCnVu6qtJfzflWe
         NFjS63AtCu8YtR60IayQYznzcvlB9LirdFxJSRisu9Lm7SJCvml8fCtyj1Cx/Cmh0p26
         5WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhlEh+kfkSdrcOvtM4ES54YzML5GWa8WcABe9Xi/pgA=;
        b=SQVaUgU9tpP0MkW+bx+1sjl02SuQgUVcs767zhCyEF5jCG+tb/JWIwAJ1zzSDNIwuP
         sDh3/0QssPAqG1fnYO9KHrF/9rl7Lj4A/HMgFUi7p6pmBjoJA0BkIe+u5xyD1TElLy16
         9p5v3xro+cbsPFRvZ/fewa5NCGOxVL1u/M7Iw5+jAVsKQXlYMdERIcQyG0bCh9U/vG/q
         sHYXSQBYfIOpYAU25AkdY7gaf5akHtfo1E0HFXbgt5uy4AarzG0IVHsCX3eFV3xYhAEo
         d6ibFGylbPDbhc28Vq531aE7BwRXhDEi8fFQEnIVDKlm7WdkFRlIs+kDT5Xw5ediWXzr
         8BmA==
X-Gm-Message-State: ANhLgQ0sbZtp7+Mi2mdooA3H4US0zfMLKNMUvyunjk5e5kGi5OOwliIh
        PYbo09GYAhD2cu/oj2rsO2zRbkR8wPo=
X-Google-Smtp-Source: ADFU+vsanj59iFejz3+iRjNoXkLUTiZZwsPHxGcay5QYWGbOufqjtAFvQMtHxg/3KtdrXhP88h+S6w==
X-Received: by 2002:a1c:740f:: with SMTP id p15mr5579918wmc.98.1585174577257;
        Wed, 25 Mar 2020 15:16:17 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id k126sm653741wme.4.2020.03.25.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:16:16 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date:   Wed, 25 Mar 2020 23:16:14 +0100
To:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200325221614.ekn56wamfgs4bwmq@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Wed, 25 Mar 2020 23:15:44 +0100
References: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
 <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

IMHO this patch should be good to cook.

Thanks!
