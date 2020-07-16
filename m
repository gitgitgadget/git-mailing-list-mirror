Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C21C433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 06:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA7392067D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 06:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M87IRwC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGPGU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPGU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 02:20:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC64C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 23:20:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so4345896pgh.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 23:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1WtpCGSy4lUXf9fdsi8LmkiDtble3Az2HuAHzOntMjo=;
        b=M87IRwC3BAdvCEQR+yeO7VcCFPNSG3oMGC2IKKBWWMxLs8wXm88F8zsBf1f9UKLQie
         lF14PLb1AwJdsOxYG9Z4pCgodVM9nbR8L6m8Rpd0RBTwhPeMH4V6sQKXgwxLiACA3U3F
         JA2UtzEM2zicY9Yf3u4dF3KtvGhh+O1buCGoO6wvp0d9OcGkQXam11cs1xFqnOFDpbyW
         L5zXdcqxI/5d9Mse3j7SOBxJyE8exGFeckvT2gxVtXWsxLuvxp+8d0k+qU1y6mt3AyvD
         c6xfhlq7ZCX/bptKyV+RPT3iS3tbkTnfCwg6knkYIZtnE6GHkfGB4J3t/UxJex33je5n
         tefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1WtpCGSy4lUXf9fdsi8LmkiDtble3Az2HuAHzOntMjo=;
        b=izcQ9rvdncVIrkoF/ZuDi72aK/2PnZm5v8NrUwTp85DGRT8aC+9b+Re4Sd6D/CGcje
         uNLcmrz0j7KPCU3ZEA8C+w84y78loPkdlhaz+FVb3gPNmPmgXqi62h9NK9FBU35aroZ+
         ryN+dXI9UFGy843Y1NveFxZxBQyw02tNkDYbcTLGvjTd+lbgHOSbckGpAmZxVUvtlCE5
         GTch3V2G++Ymtem9ble25dg9xFUKOdsnYLPCEiNJhNhnhBmD3zu1Y/gNUoOQ8Kp/pLrs
         CrlHKVrtk8csJuD99P0LeifFZG+DeF1Prv+InYMtGnShvHaYo/oE4tpABoNfRGoTkcOe
         6R6g==
X-Gm-Message-State: AOAM530m9ZS4Tb7LtP2yxTSYB/MAVMQantWw7fvmsYx7zoXFUuLvz/rA
        93R0OzvMpEsKwBt7Rwe6U0Pjwpj4
X-Google-Smtp-Source: ABdhPJzaL61UvOoqstBFZF5yqZfvo4faAMyBg/+cp9FTso9YfKnpnzV5gj0ezY//H0nsuV1DoJLKJg==
X-Received: by 2002:a63:778c:: with SMTP id s134mr2827517pgc.273.1594880456863;
        Wed, 15 Jul 2020 23:20:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id r204sm3882869pfc.134.2020.07.15.23.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:20:56 -0700 (PDT)
Date:   Wed, 15 Jul 2020 23:20:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>
Subject: [PATCH 0/2] extensions.* fixes for 2.28 (Re: [PATCH] setup: warn
 about un-enabled extensions)
Message-ID: <20200716062054.GA3242764@google.com>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpn8wkben.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Here is my quick attempt to see how far we can go with the
> "different endgame" approach, to be applied on top of those two
> patches.

Apologies again for the delay.

Here are patches implementing the minimal fix that I'd recommend.
These apply against "master" without requiring any other patches
as prerequisites.  Thoughts?

Jonathan Nieder (2):
  Revert "check_repository_format_gently(): refuse extensions for old
    repositories"
  repository: allow repository format upgrade with extensions

 cache.h                  |  1 -
 setup.c                  | 24 ++++++++++--------------
 t/t0410-partial-clone.sh | 15 +++++++++++++--
 3 files changed, 23 insertions(+), 17 deletions(-)
