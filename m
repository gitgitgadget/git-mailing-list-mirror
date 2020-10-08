Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510AEC4363D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 01:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E3C2145D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 01:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiUrQjW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgJHBpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 21:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJHBpR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 21:45:17 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1044BC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 18:45:16 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y10so2385769plp.14
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 18:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6VZZwGF2omuGDgpE05vww6q2MgMDCRje+LnZOV83vvU=;
        b=fiUrQjW6IOTTciSMF+BWOxjbD5/rJVlcmpp2d3igwx8wIzOCGVaaAKF/P9TA3NiHq9
         /wrHQMmGhsZoMii/G+QHKRSoe0F7s01JWVZC9P7/UbUFyXkev9oTbcyxUDnlUNQFGZo3
         vprybGwpgU7XpHzeRIE5/djmIU/Hvkmxrn6mNkcZsRsZOAbXZSuK83UF2sphX6AvO0rC
         DECBUPZsFknrs1+N6FTDGlKvL6XV/NEjgDgiFgmIsiMmruWrfkTSzVFfo1bmPXhvX6Yb
         tX9UghL0K0eD7+7sU3x/ovANwU3M5avQegOYVQWufXSE9LbD0G8xIjVW9S5Y0AuTOAi3
         bEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6VZZwGF2omuGDgpE05vww6q2MgMDCRje+LnZOV83vvU=;
        b=WiHYzunxTclHWGqriNnhYYZ5O79UC/zkpjsk3mM5XsiadsEfYlamwLnSa0/zi+lBGL
         ZieHh3EDbKNtxw44rz4xRs7MHjEwSL6vXl13Jo/Nv7uRQG+LCPX868KPB9znFlprpIZX
         e6+mPA6J3/tT6llWHYqEVQ8ZiSyh7LeqH+Llj/v/o3OSZdDILC9UVGB/ZxoVGnraXqc2
         cXq7zyezEry1v+WiagNmca4UjZirJRPo637x1KdCLZ8Vcp0YJNtc20u7kb9RsWV01WU9
         r2Y5GXYc58Ju0vC0cilLa1JRlBYkOc+tSKpUe+PakVeNcZ9fVZgc3oVSK8nV7j01QG+Z
         ESOw==
X-Gm-Message-State: AOAM5316/AlUv0xgh2w3Z/HymXK8KKce3ohXecBzjXGz6bVI1pyR+tmp
        A/BJs/PYy9T4GyI3PJ/NwMK2LmA5o6fiS+NKsRZS
X-Google-Smtp-Source: ABdhPJxZOVBcBICvlIDjT3QRGs31nVyfFenZXANdq8D8vV2sHDTpLtzlwteboTN6n1xKzolXKCG2SD5NcU1qXC0eU0Us
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:1851:0:b029:154:8ed7:bf5d with
 SMTP id 78-20020a6218510000b02901548ed7bf5dmr5453344pfy.66.1602121514957;
 Wed, 07 Oct 2020 18:45:14 -0700 (PDT)
Date:   Wed,  7 Oct 2020 18:45:12 -0700
In-Reply-To: <b94c5f5c6120347fd97bcc2dcc187fc86a802dff.1601568663.git.gitgitgadget@gmail.com>
Message-Id: <20201008014512.1413826-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <b94c5f5c6120347fd97bcc2dcc187fc86a802dff.1601568663.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [PATCH v2 04/13] reftable: add a barebones unittest framework
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com, peff@peff.net,
        hanwenn@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/test_framework.c | 68 +++++++++++++++++++++++++++++++++++++++
>  reftable/test_framework.h | 59 +++++++++++++++++++++++++++++++++

Even if reftable will be a project maintained by the Git project but
independent enough to be used by other projects, I don't think it's
worth creating a separate test framework. E.g. as far as I can tell,
when we import sha1dc, we don't import any tests, so I don't think they
need to import tests either - they can run the tests in the Git repo
themselves if they need to.
