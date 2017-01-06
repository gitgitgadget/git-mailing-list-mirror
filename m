Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F289D1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 21:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755328AbdAFVDg (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 16:03:36 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34632 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753468AbdAFVDe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 16:03:34 -0500
Received: by mail-pf0-f181.google.com with SMTP id 127so16206418pfg.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 13:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uz1QstpuVZAIaPw5qCTPAxo33VmxmEj/gGzU4r6HlNs=;
        b=rDQpPsCuajyeho3lABMNQwzVw2JZ/ZlEeIP/Q/R32zwn/OuyCdr9MZOXpjP7dToatt
         cdul/PaekmozgDan9ry4z4SEkvl36dJBuZnHwYr/6JaYfIunsy+AzJeEIlNVoawvU4Wp
         8zb02EzpP1I3xUSGy7YBO0G2XRRsEzA51sOdedkS5CO7MjqF7nVz8mx4w5+kVQtaBe2V
         mLiI8tqzxSBSItzYCm4SV2OIeIVB0r/lc+lR4k+//1htIvTWzY/nh8F2kUlZWQZXzgnx
         NjwW5AkAVtV5m2NwQMNYNiE0RDLyG99mFHuUIKc/LX0SBiK3VU8khu3Ky+/j+Hw3MstB
         XpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uz1QstpuVZAIaPw5qCTPAxo33VmxmEj/gGzU4r6HlNs=;
        b=jnArkEpnwsBLByI+LZ1oN5iEIqCytwrArOfN6vwhGY/JcAnwjidlvq9Nz79tZOQRLX
         od0+Ug4yVFpHsCffnIbDL+TYxPngcXVUI5h8DM1MkdxLEzRIUQKt7GrO01zoGhQ9b3pc
         IJx1rrmTYtP4Xutl/FQ6F4SbHuY1F09X09zAW6WLH+sLCIf8otKzNYKmTLP28J78Qivx
         EeT+IZvumGb2Wtq/pNjnFzW6ToRJpmqRHi5QFwiAQ/DOMCKxPb8cEGzOMrXumjurp3gW
         wRwblovxKBSZdVcY62Gd6paLOnuSe2cO26IFeoOC9ok2MnO0ndC15WQ+UjTFWloNo/El
         rSyQ==
X-Gm-Message-State: AIkVDXIDDeobtrFqOuO9Gg7rlQRS4vwDH6oTb4c+9c9itDZJWJow0NW2W331pTFCT3MhMxfd
X-Received: by 10.84.238.133 with SMTP id v5mr26983260plk.143.1483736612850;
        Fri, 06 Jan 2017 13:03:32 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:b5c6:5d9b:cb8b:89ed])
        by smtp.gmail.com with ESMTPSA id i86sm3263811pfj.87.2017.01.06.13.03.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Jan 2017 13:03:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/5] refactor unpack-trees
Date:   Fri,  6 Jan 2017 13:03:25 -0800
Message-Id: <20170106210330.31761-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.31.g919a8d0.dirty
In-Reply-To: <CAGZ79kaM=Uosm7KAvAP-8w59Tyfc7LZiV3ZOr=PZnBgMCzr2AA@mail.gmail.com>
References: <CAGZ79kaM=Uosm7KAvAP-8w59Tyfc7LZiV3ZOr=PZnBgMCzr2AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unpack-trees is a central file needed for the understanding
of working tree manipulation. To help with the understanding
refactor the code to be more readable.

The first patch was a standalone patch 8 days ago;
now incorporated into this series as a v3,
reducing the scope of the checkout state.

The second patch removes a single continue statement;
it needed some digging to explain, but looks trivial.

The last 3 patches shorten the check_updates function by adding more
functions. If we ever want to parallelize file IO then these smaller
functions would be the scope to do it, keeping the check_updates as
a high level function guiding through the steps what is happening during
a working tree update.

Thanks,
Stefan

Stefan Beller (5):
  unpack-trees: move checkout state into check_updates
  unpack-trees: remove unneeded continue
  unpack-trees: factor progress setup out of check_updates
  unpack-trees: factor file removal out of check_updates
  unpack-trees: factor working tree update out of check_updates

 unpack-trees.c | 96 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 32 deletions(-)

-- 
2.11.0.31.g919a8d0.dirty

