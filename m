Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F95C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 22:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A86F20897
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 22:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EKfgh+OR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757043AbgJWWHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757040AbgJWWHS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 18:07:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2432C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 15:07:17 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i7so1658287qti.6
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iGNR3ErNAbHa7apYpmmgs/7ebmIYnL4qDbxcYlx1sOo=;
        b=EKfgh+ORQ5QqqcIK8vnthoeaxEo+WjJcax2wbuWp567gsIY73sBAB6gdRZACfG57RZ
         4sjqcqahbDwPVqaaLkQFGJModio8+O66u9JzmjCSFhO5A3oPtZtNTm4qWt/ipMP0eRPA
         ZKoXan+P/0IiyScnrFIdEKDrKKVoxw1tls708NAnVjXuCYyGjmg5H+V8XBD2YRuUIDRM
         kq5V/IxnCV098PBNB+K8RYuPiesxelmjacd9fKkwLqhY9wzxp8ZKoMCicayUHPE+9gdk
         R2Tfl29fl0xRVwHdHsOM8fhll2GMR2PukBisPVQQQeJSfs1kkAj7CL3pMKXYurND211U
         imSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGNR3ErNAbHa7apYpmmgs/7ebmIYnL4qDbxcYlx1sOo=;
        b=V6o5f5BtXIw4RtN3kTxnYJZWNnzlyQPlSNK/NT4quCVsU6h1DMiXVRedxWMq9V4UlD
         PZTqzPWnDS7dIKDBQd49M6psOlPTk+WtRTkzce12S/XVDvplLHPu7L4kPmu5hyWZeBsl
         zfSHO+OrXCx3iso2F2/3bBLZ95Ye8KDW1to3hdrfYZVKDNVYNM+QXOqqiaq5GRm34fp+
         sh81q+301NVpJ8+DHm8seWW1MVt/XW6LiWca1cY77xubz6qrkS58M9JWrlfDK4jYKHiQ
         AHsdM40AP0VgcCyfukp6045h5xb8dD606WaBWmHOzuspnEvGfh6oGdOuoMEFnkhf2UcY
         9q0g==
X-Gm-Message-State: AOAM533Tzm9mPRpwzFW5DVCm1EUlk3aWElxzASZskSm8WhV613gK6Tbx
        xyqnY1OldeDnsG/sBF07tj9QFw==
X-Google-Smtp-Source: ABdhPJzjkgWmke+UOuM1kbhzTl9dQynfZhei7Opvu4RFqIPz4tvjbPBk/66WVDxAd9VxBcBwp9KhBA==
X-Received: by 2002:ac8:6047:: with SMTP id k7mr4431310qtm.60.1603490837020;
        Fri, 23 Oct 2020 15:07:17 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:bcba:b70c:690f:c45b])
        by smtp.gmail.com with ESMTPSA id y125sm1611337qkb.114.2020.10.23.15.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 15:07:16 -0700 (PDT)
Date:   Fri, 23 Oct 2020 18:07:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4] refs: implement reference transaction hook
Message-ID: <X5NUEtS0S30iZY0A@nand.local>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
 <20201023010315.GA1542721@coredump.intra.peff.net>
 <xmqqpn59k2xw.fsf@gitster.c.googlers.com>
 <X5M1oe4lfkUy9lAh@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X5M1oe4lfkUy9lAh@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 03:57:21PM -0400, Taylor Blau wrote:
> It should be possible to keep track of the old and new OIDs via a
> non-copied pointer, but I have to untangle this code a little bit more
> before I can be sure.

This may be both easier and harder than I was imagining ;-). In the
easier direction, the following patch is sufficient to get the tests
passing again:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 04e85e7002..744c93b7ff 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2311,12 +2311,11 @@ static int split_symref_update(struct ref_update *update,
 	new_update->parent_update = update;

 	/*
-	 * Change the symbolic ref update to log only. Also, it
-	 * doesn't need to check its old OID value, as that will be
-	 * done when new_update is processed.
+	 * Change the symbolic ref update to log only. Though we don't
+	 * need to check its old OID value, leave REF_HAVE_OLD alone so
+	 * we can propagate it to the ref transaction hook.
 	 */
 	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
-	update->flags &= ~REF_HAVE_OLD;

 	/*
 	 * Add the referent. This insertion is O(N) in the transaction

But, it also means that we're now needlessly re-verifying the before
state of symrefs (or so I think, I haven't yet proved it one way or the
other).

So, I need to look into that before deciding if this is a good direction
to go.

Thanks,
Taylor
