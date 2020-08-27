Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3095AC433E6
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 22:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF1D20848
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 22:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC0ccZt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgH0WCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0WCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 18:02:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFACC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 15:02:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k18so4551567pfp.7
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=koDvtHGxJ0kmpDucXO+mtDtum+st/ZNnUNrtMbbiQdQ=;
        b=SC0ccZt2qkv35M5oK2sfIPKdsC/RuTXgge63AI0X4ywrO362thSq8IpOC7ALnlqKZK
         OBBorE+93WUtQK780l1Rq1pA+kWghKivOR9yTxDUaTkIhlBzvEIXCUmgktYZHydRPMxs
         AvwqvxkQV4QqOTGqU8fx0eD5AXVEEAg6tA1wusj2sBMSjSGFGooG4xYve2mlf+RZja7H
         J9avrVhvcq4CjEXc4luEDUs3SA1UiKtNucNskVHWZvMXr0olVsT+tRuKzDIIyKWDfVgo
         AUVKioFRJihgaG9e7RhtQf0TxnDNA4xX9/DfEmmun4XqeauAruWpLByEmGn5R34xz1pn
         mPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=koDvtHGxJ0kmpDucXO+mtDtum+st/ZNnUNrtMbbiQdQ=;
        b=uLv9Rfi1eljfaF6E20zec6SWm0Q+KgW4V0l3jSun5myzAz3kszZDyqWr1ldSsg4aja
         OFL/4WaZe6kmKhXJ02GXR1p2qSW9QUecxqfj/dKOUA1EcNdsyq0NGcK132APwZnMm7jU
         t7GeLxr/IUNN4040UQmqH4FPjXyJInQtrZD6mKN/5mew4RNP+ur8tGmGpwYksZwd9buM
         /UNXkPNnHOTicvXFlOnqfueCOQpejuEAeHekWFEkrkhtvPBxGk25iV03p3lv7958L/QL
         plRkHNUy6kImS1HQ/9fjU6vPRVpDR07bizqTb35wPxUUBP1UDm9SHpRrEXB1xE8RnTYm
         X77A==
X-Gm-Message-State: AOAM533Xs7PKV/b5UVuip6sBd6dMSHtHfSopadKgUFXPus71eOH/Mfwt
        BHoklmakv6GMP38ZDiE9YceDeqe3uVDgkg==
X-Google-Smtp-Source: ABdhPJx+VqSPc57toWu5ldDHYvswquxw1bevWV7jbmjC7I1r1eqYjnDBtlVo3+zzoB9v9r8mXD9IZg==
X-Received: by 2002:a63:5721:: with SMTP id l33mr15810610pgb.100.1598565771846;
        Thu, 27 Aug 2020 15:02:51 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id s10sm3225439pjl.37.2020.08.27.15.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 15:02:51 -0700 (PDT)
Date:   Thu, 27 Aug 2020 15:02:49 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
Message-ID: <20200827220249.GA71190@Carlos-MBP>
References: <xmqq3647rjnt.fsf@gitster.c.googlers.com>
 <C580P9BS4VYA.15I6SHXQQ35HF@homura>
 <20200827192029.GA63138@Carlos-MBP>
 <xmqqtuwnq3x1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtuwnq3x1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 12:34:02PM -0700, Junio C Hamano wrote:
> 
> That feels both understandable and bogus at the same time.  To:
> is pretty much required (yes, you can use cc: and bcc: without any
> address on To:, but that is not something you'd usually do to send
> patches to mailing lists), so lack of it means either asking
> interactively or aborting.  But other things like in-reply-to are
> optional, and tying the decision to prompt for them or not does not
> feel OK.

but trying to "fix" this breaks 10 year old tests, so it is obvious
that everyone already expects it to work this way (probably hidden
by the fact most people don't let git-send-email prompt for "To:")

the patch after the scissors attempts to document the current "Legacy"
behaviour which should be worth doing regardless of what is done with
this patch.

but I suspect it might be worth adding a new configuration flag like
the one that was propossed so that the prompting could be set per
repository to either "Always" (for when forgetting it will break the
threads in lists that care, like this one) and "Never" (for when the
lists explicitally ask mails to be send without one, because they
use patchew or equivalent (ex: qemu-devel[1])).

Carlo

[1] https://wiki.qemu.org/Contribute/SubmitAPatch
--- >8 ---
Subject: [PATCH] send-email: document logic for In-Reply-To prompting

Eventhough there doesn't seem to be a good reason for it, it is
the way it has been implemented for the last 10 years.

Document the current behaviour (which the tests also depend on)
before it can be tweaked by a future per repository setting.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/git-send-email.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0a69810147..8e9ebb3fac 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -108,8 +108,7 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
       [PATCH v2 2/3] New tests
       [PATCH v2 3/3] Implementation
 +
-Only necessary if --compose is also set.  If --compose
-is not set, this will be prompted for.
+If --compose is not set, and there is no known "To:" this will be prompted for.
 
 --subject=<string>::
 	Specify the initial subject of the email thread.
-- 
2.28.0.424.gade71fd49b

