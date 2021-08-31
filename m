Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A195C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F1C561026
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbhHaUxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241339AbhHaUxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:32 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660EFC0612E7
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:35 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id j18so766973ioj.8
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZEa3Fi1uZnCurzx/46RtiTv/7nsRoAGFEHKRIkqUa1Q=;
        b=W5VNYn0L7Gh1dw2HKV1i3MB82PQ6ch/PLFyRJByLXrpmIVFmfbxXDkoHBUnEM8Scqj
         HnYUkTrQfhU3QeUKbrehKQoOHizvryl/AlyyqPH6bbYUDPqZRxC4BGIbwG+vX3EC7WGv
         Yw5g4qzgotAfl27iHc1dsCaoqBdAvZKNerDt1A7Ad8BJ/qJ9wNM1/bDlMCf0q9RKSu23
         DLHbDT2n/qDegx8vhV+mku+hiYk6zbhVkIK8mYBI9oqExlMBmWJTv5Iz3KOM3hKozOek
         kctUZhJx+YJYBSjxCb0GUbo3wlADcoITa/CrnmPo4oiK8IcP/XGs94uasaQPV7/2DbE6
         OB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZEa3Fi1uZnCurzx/46RtiTv/7nsRoAGFEHKRIkqUa1Q=;
        b=EcBLIyvjiliSkstu4mJclLyGDPiBN+yj1RRU1UGAACN6+VqC04Xa5PQo0QTyd4YI8T
         6z80cEshVZBL3w8cl4SYDj+S8ySXtMqvhFdiD0Pdo80pqUtaCwm3Jz3Cv2NeO4PhQLti
         GqbWtfjdS/F8ocPNRJMu62gsSNYBEyxMTS8o2zqNVAKfI7knFJ3SZjH1jXmC74XXo5WW
         Lh5H35kPzuiJ9gTrcObxoXzwrlTkRP9bUXfwfo7lMhbc02EAtwa1q897hgjDiZSOxqYP
         un1rYEG08yQBjlFxca6B8srOOdEsxFd+nKRtEbLQOxdUH8gbtUbVA7jFHVaTLAxzFW57
         TOcQ==
X-Gm-Message-State: AOAM532fWCrIipTLYG5HQmSRk8J1W2ntCE0gOOzgWndZAw+iIwcrctdA
        ofuorI8FDQBSOUQGIgPMvem6QkGOL5hmHBnJ
X-Google-Smtp-Source: ABdhPJzSoqr3whXloFwfjTQKr23vw4YPEkOXAx1wgc6k3crKDjG29BJUyI4GFFakcFRAuf0JgFDGrQ==
X-Received: by 2002:a02:cf05:: with SMTP id q5mr4586794jar.132.1630443154715;
        Tue, 31 Aug 2021 13:52:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4sm10484075ioe.19.2021.08.31.13.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:34 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 21/27] t0410: disable
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
Message-ID: <94b1317e0c42bf5fd7492eb6e51e8ff6079595cc.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Generating a MIDX bitmap causes tests which repack in a partial clone to
fail because they are missing objects. Missing objects is an expected
component of tests in t0410, so disable this knob altogether. Graceful
degradation when writing a bitmap with missing objects is tested in
t5326.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t0410-partial-clone.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index bbcc51ee8e..bba679685f 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -4,6 +4,9 @@ test_description='partial clone'
 
 . ./test-lib.sh
 
+# missing promisor objects cause repacks which write bitmaps to fail
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
 delete_object () {
 	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
 }
-- 
2.33.0.96.g73915697e6

