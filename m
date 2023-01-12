Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CACC54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbjALJVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbjALJT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:19:58 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB65564D
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:59 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 7so12363640pga.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9VFD8Mq5DWbcibSMZCTlrnddSh63BJmMEBiiD3nANM=;
        b=XSbGIjTjAZdAbh65VcaubIc+DWnOmaaEYYTZggh42AzDw2X77r4LAMV54wTBREhuqT
         xjt07iG3SST77Hkd8dtb8RCET+VxdgxfM/sthFgh7wJXfjenvODjecnUUvey7HYxr+et
         qs++Yd0dWnfrE5HVlHtolza1nNwV/WvI9r+Tpnz3xl5UFHAxx5xlcRqAl36+ykO9Hq37
         UNzOE8ExKkP64Wkq5yZ352BFzFpqER8+bLEi6P72tuwHff6MO6ZTTezTmSR4cfL64sk6
         ilMgo2olHKAcEVAhCedOFHa0+V+ozybNIrlexDl6Ac9niSfYvT7xqxqmTt+Blg76T+kD
         9HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9VFD8Mq5DWbcibSMZCTlrnddSh63BJmMEBiiD3nANM=;
        b=yhoUjPaPNxTKS46MCHat8opUvinQfAiV5lvfyD8IIjfpg7Qq8xWrDvdnpJTIrMIW9v
         HdauC6nRNbmDpJlXEYentyC7IvJT8Ky23cBDV+hGEtVLNZS1qrmCnpxyrkSehIRqzL5k
         iWlCLwyvjbCl0TaJltlEiSxq+rOdSmS/FQ8jPOsQ0lWmDQ0il35Hx7d2hVMYkI8XdgRU
         6mXcsyT5ouofMEnlSxdtwKR8XDfN8DFH+lTbXfQ37w59IrxM0SUSFoy5hslMZn6mphhA
         vregGkUPRP27Hsu/RPoNdG7QfcXuqECzsOfTBeX5tZwaDcb1wn0KsQ0aEGxY3mee1VQD
         YCcA==
X-Gm-Message-State: AFqh2krtaFIkjmEkoQyVcBAsb96blVA7c3X/jpbN1GM9eXyIlZnrv/eT
        iibwm9iEHUDvbumZTe0Ostud12Y+8Vki6HKg
X-Google-Smtp-Source: AMrXdXuCqfkEdR8M2De4KW28irdXpMNKwLqa2kga0TG62ienZQmvHXWt03k4JC9iRPvcnwpZjncu/w==
X-Received: by 2002:a62:84c9:0:b0:581:1f4b:d1e5 with SMTP id k192-20020a6284c9000000b005811f4bd1e5mr60663724pfd.12.1673514719003;
        Thu, 12 Jan 2023 01:11:59 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id d126-20020a623684000000b0058426d9db66sm11257069pfa.218.2023.01.12.01.11.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:11:58 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dyroneteng@gmail.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 6/6] t3104: remove shift code in 'test_ls_tree_format'
Date:   Thu, 12 Jan 2023 17:11:35 +0800
Message-Id: <20230112091135.20050-7-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.98.g174eaa53973.dirty
In-Reply-To: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
References: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

In t3104-ls-tree-format.sh, There is a legacy 'shift 2' code
and the relevant code block no longer depends on it anymore,
so let's remove it for a small cleanup.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t3104-ls-tree-format.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index 383896667b6..74053978f49 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -20,7 +20,6 @@ test_ls_tree_format () {
 	format=$1 &&
 	opts=$2 &&
 	fmtopts=$3 &&
-	shift 2 &&
 
 	test_expect_success "ls-tree '--format=<$format>' is like options '$opts $fmtopts'" '
 		git ls-tree $opts -r HEAD >expect &&
-- 
2.39.0.98.g174eaa53973.dirty

