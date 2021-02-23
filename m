Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF50C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF68F64E31
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBWBLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 20:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBWBLY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 20:11:24 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5454C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 17:10:43 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id v206so14744467qkb.3
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 17:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKjdnQ3gSdFdx4CeoOLPmaJ7ny8BwD5wwIXTUT/b668=;
        b=tL5yQGthzl+4AfcJmuJ5HjfXG6/zvwUQvxC2bDZwl4a7J228FPUK/lF+PFVes1R87K
         jClgmmg8Z+vQeOxnbkialkHcWzrNSA/11c3LixE2WplBFeDjCQiX2ckNUwIKVxuQd2y8
         v9XJlxXkblst6eabnU2+PSQsFbqLAuQiSHelIef2z8d1Uf0DfT3A432A0VzUxftnuyHF
         QYxBXap3bRdh7x8Q6djq/F+08zJJMi2gUukUxA+Ms85XvxOVbDN++ckl0vLAMTxlyzfy
         hIP1FbGzsT0cxXqGxhpUs2KPerxtZqAqUZ2yj06Qdv3k1TJBoHcW/wneTzq6GycIu/lq
         NZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKjdnQ3gSdFdx4CeoOLPmaJ7ny8BwD5wwIXTUT/b668=;
        b=fwEotA0GioQ9Pya76sST4KnI/uj3G6A/zneBOorRLzjMvoEo3Rx/0oElWlymp+0K6p
         q5+QDv/DI56+fM6RkQS8IklENz7Ruxuyi3EkA4OQTIta8WAgWnuhayAdFkLorC9R6Myc
         xinBRGJTEdOP/dJlpXndHOO65uf+DiqecbdC0H59W/hzd0L6b9K9c0x/5LdArzK6AOKb
         5LmGyUmuInJfzBNI/Suwh3Rgv3WHxSle5Rn1nswkms1dWqBFi4YbHVU51QILOfWkYP9K
         eB5TGaTexxKYwS63bf21CBPwi+OIJnOLSqyNHjiKvFEcRDPV6UgMzA1iRLoOvMyR+0Lq
         wUoA==
X-Gm-Message-State: AOAM5310pz7dlYQ+pDXax4QKD/M+BAHSU0Vu8kZtxpnw8305rs3SCOYR
        aF2Kk4D5syKUGUgSPwm/eUwrC9g4LcmLTg==
X-Google-Smtp-Source: ABdhPJy7eBo7SBr5gzjLpWxAGzU2GGcfnixz+FdKvXuYk+1u0948+MJ5BnVMPir55ewnyRfcCN1jXQ==
X-Received: by 2002:a37:6cc6:: with SMTP id h189mr24707579qkc.195.1614042642695;
        Mon, 22 Feb 2021 17:10:42 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id v75sm13599070qkb.14.2021.02.22.17.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 17:10:41 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: [PATCH 0/3] add: minor --chmod fixes
Date:   Mon, 22 Feb 2021 22:10:32 -0300
Message-Id: <cover.1614037664.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch was broken out from [1], to avoid holding it off while
there is still work to do on that series. The other two are minor
related changes.

[1]: https://lore.kernel.org/git/cover.1613593946.git.matheus.bernardino@usp.br/

Matheus Tavares (3):
  add --chmod: don't update index when --dry-run is used
  add: mark --chmod error string for translation
  add: propagate --chmod errors to exit status

 builtin/add.c  | 18 +++++++++++++-----
 t/t3700-add.sh | 46 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 10 deletions(-)

-- 
2.30.1

