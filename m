Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87EFC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 07:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DDD61183
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 07:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhHXHtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbhHXHtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 03:49:39 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8530DC061575
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 00:48:55 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id a5so3092480qvq.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 00:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y2zVweKFHDbFqGrt9wmohzxMmjOvn3fNR3V0ciKIS9o=;
        b=qBqxubr4bm07UsIqdz/2pN1gpE4DRNrUbNgYULAfrtMvhjlirfCqsg1hVbaF1zxTZi
         O9vKQOAeJl6RUqW3zFiHT3eZHBX3M9BT1RtudFK0JxiRf3JrLd9ROHg9QjEPHepIBzco
         pEmrMjD82HR3UBpkw/lLiK9SFEwpZhWQwzweYrGkyRm1sf+ggDDvoXwHK9+2RQZr1aq2
         dlji9AlZR4VN8ulpGQX2DxIfMBHmgMTW7I+ziDAb7cL9jx/n/IW+yW3a3ZCIKbZhG6WA
         v/KlcglUodWCSJznRFKLJlu3kstfVLN0zisizjU3j+SYrAFcVNotF9eElJsrDUrjAPXF
         9y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y2zVweKFHDbFqGrt9wmohzxMmjOvn3fNR3V0ciKIS9o=;
        b=o+oSuWX8rrATZ72G7Fu/JXJaMa79jFHnCU8LRytuzj7b2D5zs5LN871sTe3vmD14gy
         ainBbIQIcE9ywwe743PEKbMqllMCwkYr7SG4hgwrMW40hhM+bZsJZlKNwF00s20bpgwN
         48gDeMy/3ILXTdlTpjT3Zt/+jOzDfP/BVF5Kp4oZeRem2+dLeK72q1jyZXhKYDK260Mt
         PmcjAZ1rz15Bw4mc3wLt9LCM1evBGTnOO/OiDxWYZ9Ad/3BxNkYvvSwDSD8uBtc+4Rig
         WiHE9pb+Z3jEC0Zc1ub5TOIWod+b/WbnAJNKk0zOdwTs4XPcIDKKR+6aAzfJ8fHYnDU8
         bsaA==
X-Gm-Message-State: AOAM532ot8EFjrKmM12yHyZJHAg5rpoxD3PzrwofrItyimBOL5vhuhjZ
        /ibEuIX/Y5yXr/MqZB0LAEc=
X-Google-Smtp-Source: ABdhPJxjt3KLIXUNDOIk44HJTAnmJY1RoeRHDQU9t+fEBCRnWhCe1EdsNntKhZ3HtEYSRo5iBFCwWg==
X-Received: by 2002:a05:6214:18f0:: with SMTP id ep16mr10624065qvb.25.1629791334598;
        Tue, 24 Aug 2021 00:48:54 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id d20sm10226518qkl.13.2021.08.24.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:48:54 -0700 (PDT)
Date:   Tue, 24 Aug 2021 00:48:52 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Marvin =?utf-8?Q?H=C3=A4user?= <mhaeuser@posteo.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [BUG] send-email propagates "In-Reply-To"
Message-ID: <YSSkZIFaiDyELMJP@carlos-mbp.lan>
References: <4db7759c-2123-533b-9f89-954c07f5832a@posteo.de>
 <YSPOOGxTMEgStdjJ@coredump.intra.peff.net>
 <5cd5a58b-ac9e-4628-a8d3-836b1f795732@posteo.de>
 <YSPomC95hxZZTHRe@coredump.intra.peff.net>
 <2412df60-f8ee-ab0f-08b2-20a0b6b641fa@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2412df60-f8ee-ab0f-08b2-20a0b6b641fa@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 09:47:28PM +0000, Marvin Häuser wrote:
> On 23/08/2021 20:27, Jeff King wrote:
> > But either that should go into its own patch, or the commit message
> > should be modified to explain that it is covering not just
> > in-reply-to/references, but we think this fixes all similar variables.
> 
> Fixed, opted for latter [1].

Left a comment in github; dropping the "Subject" move would be also
needed to fully do that (the fix doesn't need it)

> >    - note the weird behavior I found with --in-reply-to; this is
> >      something we might want to address at the same time
> 
> I think this case must error? The definition of the "--in-reply-to" does not
> declare it as a default, so it must be enforced (and it is), but it's also
> very unintuitive the file value is discarded. Who would decide the behaviour
> spec?

AFAIK, this is what the cryptic warning in the documentation[1] talks about.

the "argument" being that most of the times that header is incorrect
(because it was incorrectly set by format-patch) or it is meant to be wiped out
to keep this patch together with the rest in the reroll.

the warning was added with f693b7e9a5 (Improve doc for format-patch threading
options., 2009-07-22), so throwing an error now might not be wise, but maybe
a documentation update.

Carlo

[1] https://git-scm.com/docs/git-send-email#Documentation/git-send-email.txt---no-thread

-------- >8 ----------
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..76687d0574 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -385,10 +385,10 @@ default to --thread.
 It is up to the user to ensure that no In-Reply-To header already
 exists when 'git send-email' is asked to add it (especially note that
 'git format-patch' can be configured to do the threading itself).
-Failure to do so may not produce the expected result in the
+Failure to do so will result in that header being reset, accordingly
+to the options used and may not produce the expected result in the
 recipient's MUA.
 
-
 Administering
 ~~~~~~~~~~~~~
 
