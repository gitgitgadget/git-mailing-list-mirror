Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B00C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A958120789
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj0fFwYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgCYPHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:07:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43026 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgCYPHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:07:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id f206so1155039pfa.10
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+z6BdC5bveeBZcRo7RMZhSYRMUrKbaLzmtDUtbC3KI=;
        b=hj0fFwYJidADOddLh8ben8pn/iMbp2vEUmENXM5lSewAoDA6tvms25ePM2xf3HkflN
         QgYrCwUjRwtGbSWyCluVbh1Uo7OkvDXEXtot6wxFXRmXrFDN7vj8NRZz4yGpldMu13KD
         Ido7k4g/2VfHw0ROSZhFlnaYpn6SGoBdd5YDKCQPhaNte1qTFQTVHyhmNdw+yjdjaALo
         ZUtYs50hNdfRoNfLH4hqD6QBl+hineBTXm4yZadFT6Iqjj515825vQSCSwXMWBcDxFFQ
         6D92nJ24O5ZxxPeTcpwwfBaR3/M2QwL3Rcg9mxQ98JSmMLNcPP25UsTp/eYCZQ8UhZdZ
         H/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+z6BdC5bveeBZcRo7RMZhSYRMUrKbaLzmtDUtbC3KI=;
        b=HCA5u/KEwlRtGWq8jBRKzLeviPjQ22ozXVNHO7yxs+R69RA66x5otk/qsmUzB7SNcq
         mfwEj6ZCs3MwdrfmOCFFPyxbS4FSNxbZDgOrlzS6uXPMHgNi8+FIPYY+CreDMz1r4unM
         r7NWx8qfk+wZ1eZSn+GXxLVEBylt+OMKcziy2+Z8rkBCXLhbPVCN2kgyhm8YLHWRcH7s
         sjAvTyORP4wBOK5IiQ6xsVRfuu3nV5ecBIdmWKjgHHAFXLWaJLXksikJw/tOJLlC9zBk
         zTa9AhDKO5TbrPip0MIV39s4ZJ7lDC6jHm+qQeA+baXer3PW1PTKiQoPeoyuFP4Tq0Nn
         4Rfw==
X-Gm-Message-State: ANhLgQ09MLIV4clgbnAONSfPF1AJMCHAFDtq6cD0Gi1f2fekVzCsZ1My
        smzLL1GrKNCWQ0KnhrOyrN/ruw8t
X-Google-Smtp-Source: ADFU+vs6lprhKQBJKamomdysQlhsp5xu7YQi0zHshb0qxreKOjO1WbagfkTTvVv+8ckebfHVRmq37w==
X-Received: by 2002:a63:de53:: with SMTP id y19mr3509066pgi.445.1585148823540;
        Wed, 25 Mar 2020 08:07:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id f127sm18232538pfa.112.2020.03.25.08.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:07:02 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 6/8] t7063: drop non-POSIX argument "-ls" from find(1)
Date:   Wed, 25 Mar 2020 22:06:19 +0700
Message-Id: <abb21b9e518079f8d5ee98e9e6d3bc2b1bae64a4.1585148327.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585148327.git.congdanhqx@gmail.com>
References: <cover.1585148327.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
update feature, 2016-08-03), we started to use ls as a trick to update
directory's mtime.

However, `-ls` flag isn't required by POSIX's find(1), and
busybox(1) doesn't implement it.

Use "-exec ls -ld {} +" instead.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t7063-status-untracked-cache.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 190ae149cf..6738497ea7 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -18,7 +18,7 @@ GIT_FORCE_UNTRACKED_CACHE=true
 export GIT_FORCE_UNTRACKED_CACHE
 
 sync_mtime () {
-	find . -type d -ls >/dev/null
+	find . -type d -exec ls -ld {} + >/dev/null
 }
 
 avoid_racy() {
-- 
2.26.0.rc2.357.g1e1ba0441d

