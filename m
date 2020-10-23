Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E560C5517A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 19:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3BC20882
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 19:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MPjNvz0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755261AbgJWT5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755258AbgJWT5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 15:57:25 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D80C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 12:57:25 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s17so1316051qvr.11
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Prn4IxmR5/a7ANV2hiON5gJt4UdKCDfiG4ADxY1Dxp0=;
        b=MPjNvz0sQqszcRyz9aFfAh4Ag3OYRC2D7ZpbGOFv0iYtre6zE+vS07oYmc5mqm5dqW
         +uuDyGhJY3Gx3yDUzg29YxJQQ86AN2/lO7lJmqTFstqEvrff5ZwnCYhDQOaBJtspq4Xp
         UyF41bSKWTgc3uIs9fsnLYWZFeo/MZMyDzGk8fzH7XWiSiZIO/6TeW398g8+MfgLlZi2
         DSDkYStBb7UXBX69QoLUjm/hlrPv+PXvWIzhh/QKna8S1Rd+v5FJN8HvvXYN0LUYykBl
         hZ3NsjsijaPnuv+ItgcdrVs7BtlktIKf0Bl5pfWM7gup5/l9r6siN077CoFkkKHGhlJv
         qtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Prn4IxmR5/a7ANV2hiON5gJt4UdKCDfiG4ADxY1Dxp0=;
        b=t8hCCVbPLbqNPHeN/Wbk+zSHsUL/DwfzgdH7Y+BnSbb9FZjdfjKxi8q0hWs8LfM714
         k8TSclMxcPDMFdxeGqLtABA6RT+fJv0NT4hJWEagg7gftv6yxX+qNj76LGkJgq3ktHG9
         1MH2i8lRYyO3A5jCwCrnG7JqFfx/fSLFrH/ZWDIjZhJGQY7I7VvffKN1gmm3Vqde6UaB
         yYw/RwC3Z+ZqK1Ji6JaytNG1UFSefGbJ04OFmx6zHNg6AbHPDMQeANxa1vVFJjH/IlAy
         YWYitt2wXjRHbSuY6wDLO5GBvnMMC8Es6V9uGs5qG+ScLTHaJxzhDgCeF4SLSjcSM6J8
         VIzw==
X-Gm-Message-State: AOAM530Brudh/wOJiwn7EPC6cvry13r/vfgj00/QImmfUAws9TWyRX3n
        hPxXwZS2avxzTrCBPuutYHBsBPsckKQXnrRE
X-Google-Smtp-Source: ABdhPJzNzK7NEvIcs94DsCEObHCfBE6gfVBiuXwMkw5xOHnakbSbLJ64Q4x0Fg63hhR6aBSBOy08xA==
X-Received: by 2002:a05:6214:1351:: with SMTP id b17mr524933qvw.11.1603483044500;
        Fri, 23 Oct 2020 12:57:24 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:eda0:8d26:51d2:6e87])
        by smtp.gmail.com with ESMTPSA id k16sm1622386qtu.45.2020.10.23.12.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 12:57:23 -0700 (PDT)
Date:   Fri, 23 Oct 2020 15:57:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] refs: implement reference transaction hook
Message-ID: <X5M1oe4lfkUy9lAh@nand.local>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
 <20201023010315.GA1542721@coredump.intra.peff.net>
 <xmqqpn59k2xw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn59k2xw.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 22, 2020 at 08:59:23PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> [...]
> I think that makes a lot of sense.  In addition,
>
> > ...  But we'd possibly want to actually change the behavior
> > to always send the actual ref value to the hook.
>
> I offhand do not see a reason why we shouldn't do that.

I can't see a reason either, but teaching the new ref transaction hook
about these updates gets a little tricky. In particular, we update the
old_oid for ref updates that were split off with something like:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 04e85e7002..9c105a376b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2484,9 +2484,20 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		     parent_update = parent_update->parent_update) {
 			struct ref_lock *parent_lock = parent_update->backend_data;
 			oidcpy(&parent_lock->old_oid, &lock->old_oid);
+			/*
+			 * Now the parent knows its old OID too;
+			 * record that fact for logging.
+			 */
+			parent_update->flags |= REF_HAVE_OLD;
 		}
 	}

+	/* Now we know the old value. Record that fact for logging. */
+	if (!(update->flags & REF_HAVE_OLD)) {
+		oidcpy(&update->old_oid, &lock->old_oid);
+		update->flags |= REF_HAVE_OLD;
+	}
+
 	if ((update->flags & REF_HAVE_NEW) &&
 	    !(update->flags & REF_DELETING) &&
 	    !(update->flags & REF_LOG_ONLY)) {

...but by that time we have already recorded via an oidcpy the old and
new state of HEAD. So, Peff's patch passes in isolation, but applying
this on top produces failures in t1416 like:

--- expect	2020-10-23 19:56:15.649101024 +0000
+++ actual	2020-10-23 19:56:15.657100941 +0000
@@ -1,2 +1,2 @@
-63ac8e7bcdb882293465435909f54a96de17d4f7 99d53161c3a0a903b6561b9f6c0c665b3a476401 HEAD
+0000000000000000000000000000000000000000 99d53161c3a0a903b6561b9f6c0c665b3a476401 HEAD
 63ac8e7bcdb882293465435909f54a96de17d4f7 99d53161c3a0a903b6561b9f6c0c665b3a476401 refs/heads/master

It should be possible to keep track of the old and new OIDs via a
non-copied pointer, but I have to untangle this code a little bit more
before I can be sure.

> Thanks for carefully thinking things through.

Thanks,
Taylor
