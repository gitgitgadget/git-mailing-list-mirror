Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EDEC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79B5221F0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loPuz3JO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbgFRBvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733080AbgFRBvh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 21:51:37 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB87C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:51:37 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k15so3287757otp.8
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=loPuz3JOsGmAPN7fnCpS3h4SpHsI4I5IDs5lUcBX6xwBEhzztURZYOCK5rrs4vLnMi
         OVcwSxOAyZ5GzqRDbA1sdZHo9vFQE0XSrVTa/+lpYseUPXjZcI6c9QsW7/f/LA9hbV1P
         ej/WbPTAjSAi3mpsa3+ygs1bzMJs5hZ07F2+f5Q4Q1F7g0VFQ/mkUXrcOLKQkCAPwQ6h
         o1HBODvNqpMrIX8+EsFS9OSFrG8iNhQnarwyjozWLLM6wNPyywcnDVNR84XNATBNeNy6
         lmFdUEsUG9vFI2/d+USnfusUC+Ils/8a+5qqcItNqaezIaKCDiJyjrMA1Y7F7mjrdBik
         vGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=Cn/LOCXK8K4Zz3mkTfex49Hq7zvHFXOEygH460Hi5EpFUBzR/EmFQmKk9/sBCCMNaa
         3Zfzih+qxHecfTudKdTQFCTtIc2DdjsE9AbRAvp7aesJKIbn490wLBLvJvpn7plwV1bL
         nKnwL7uZpJn2V/YyPkkDvIEhg7M8mvcfzbL0DlC4iWoTnlsBT/LxTMchhq2JS69r5FVH
         FCSaoU7H9tzFNNUVNWhVSkV7INWHTUH7B24j+LqGn9IV8b6EKmIptfjwv9Vi5KkNxd00
         o0XHt6aggXqbEFidBc9AKeKYarfEylNKOT4MftxpX1oLVgYDA5d0VSOXGUQ0nQXXxf6s
         ewGw==
X-Gm-Message-State: AOAM532mEsUGjFWnh894xX4bMuOV5Vsa+nBKyjUs3a1WWgWCKEg2R0Z7
        NW+wJOFSndvMX0uaApJaBLgPPx0u+0neYQ==
X-Google-Smtp-Source: ABdhPJwtBIEwJbFRI3Wk5bBc42Xrg+jKZvWJkCxgsogMOZcb2aF2LN/wHTtJMSGOi/xSZvJwsUZd4Q==
X-Received: by 2002:a05:6830:2089:: with SMTP id y9mr1664561otq.308.1592445096807;
        Wed, 17 Jun 2020 18:51:36 -0700 (PDT)
Received: from [172.20.159.42] ([162.251.232.105])
        by smtp.gmail.com with ESMTPSA id v2sm356604oib.26.2020.06.17.18.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 18:51:36 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   How soon <tecksoonhow@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Thu, 18 Jun 2020 09:51:25 +0800
Subject: Re: [PATCH] unpack-trees: do not set SKIP_WORKTREE on submodules
Message-Id: <4A18C201-4D57-4BFB-99EC-168C4430107A@gmail.com>
Cc:     dstolee@microsoft.com, git@vger.kernel.org, gitgitgadget@gmail.com,
        newren@gmail.com
To:     matheus.bernardino@usp.br
X-Mailer: iPhone Mail (17D50)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
