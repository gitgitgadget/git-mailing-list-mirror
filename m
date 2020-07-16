Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7CEC433E3
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C64A20739
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsVWOiWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGPMT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgGPMT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 08:19:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526CC061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 05:19:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so10099651wmg.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69Bh3UP7bjekPz5dao8yczDgOXMyxuhA/pe6g5dmdOA=;
        b=lsVWOiWXiRrLQduR6Y/ly2iUCqqAcrV6UfujrZ4Ghyx5RaAfQ/WPZY4jacS4R4Fg15
         BG5O5kmq/X61luIs2RPly/WP/XhDxKa0DJdIL43Zey6yGhJFxAwV0yFfpRX1UMBsEzm1
         HuBwN/tmfYzleFhSSQDRVuMhHpsR67U4+vWf0sWGkJVTuhpZNHvvMg13SOdZ7NQMGrM3
         uktzsy9BV0M74czi+UZ4a9nwMtEXlJ3TuOOBxbOX1THMg3cOMYywlla8qhCpWNtbuBLb
         YmMP2dmdUxQixLN7GGd7rdXkyuVIw0Od48R7Lhloe5vAc1f30T4tsvq8CIlQTvglggsZ
         iebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69Bh3UP7bjekPz5dao8yczDgOXMyxuhA/pe6g5dmdOA=;
        b=Yws6gdZjGECx+PI8Qve3JFdlHAtl0NehGWzdQ9Hg5K2l2aAEzvB/3N14RHkrTQNbNR
         /GT8LWC3kOJ2NzCfxnUBGcYl7F5U2xIpvoxfTP9kmcMKyZmlRkMKYYPkjb6QPDNBDusp
         Q+uxwRTu+107+0cOgC36wrAXwsq3TN6snHVGkv3pUVvesJgGsJTaDSHRfSmg/4VcDe7T
         F4CyVcGeu9cB9NApUk2rkq6U4R5dzwpprpFLUg0TdvBrJp3//xUfa/wcERjiljKRI/Le
         9T8dyaNL/wE96cDRTdGVnZnwvuI5X5L8NatycAcOgWgey4Z08OGp1V50pZlWpXnSktj/
         Ez5Q==
X-Gm-Message-State: AOAM533nKHSMGyD+4rgW1O+lBvJ5XFjINsvMx7xS7c7EC/JMKSIVWCPB
        pT62xWB6ZK8Af5FrJi1S3pLXGZw0BfM=
X-Google-Smtp-Source: ABdhPJxfqlLxluUN1VZQBSPVC1WI7s4MLCvWrHWpyYOqYgaiJAaNPtg/p8EXgnPqTjXpm2vOlywNRQ==
X-Received: by 2002:a7b:c921:: with SMTP id h1mr3885167wml.29.1594901995852;
        Thu, 16 Jul 2020 05:19:55 -0700 (PDT)
Received: from localhost.localdomain ([193.56.245.81])
        by smtp.gmail.com with ESMTPSA id p4sm8725714wrx.63.2020.07.16.05.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 05:19:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 2/3] t6300: test refs pointing to tree and blob
Date:   Thu, 16 Jul 2020 14:19:39 +0200
Message-Id: <20200716121940.21041-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.227.g757ac19d14.dirty
In-Reply-To: <20200716121940.21041-1-chriscool@tuxfamily.org>
References: <20200710164739.6616-1-chriscool@tuxfamily.org>
 <20200716121940.21041-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding tests for refs pointing to tree and blob shows that
we care about testing both positive ("see, my shiny new toy
does work") and negative ("and it won't do nonsensical
things when given an input it is not designed to work with")
cases.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6300-for-each-ref.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index da59fadc5d..e9f468d360 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -650,6 +650,25 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
+test_expect_success 'set up refs pointing to tree and blob' '
+	git update-ref refs/mytrees/first refs/heads/master^{tree} &&
+	git update-ref refs/myblobs/first refs/heads/master:one
+'
+
+test_atom refs/mytrees/first subject ""
+test_atom refs/mytrees/first contents:subject ""
+test_atom refs/mytrees/first body ""
+test_atom refs/mytrees/first contents:body ""
+test_atom refs/mytrees/first contents:signature ""
+test_atom refs/mytrees/first contents ""
+
+test_atom refs/myblobs/first subject ""
+test_atom refs/myblobs/first contents:subject ""
+test_atom refs/myblobs/first body ""
+test_atom refs/myblobs/first contents:body ""
+test_atom refs/myblobs/first contents:signature ""
+test_atom refs/myblobs/first contents ""
+
 test_expect_success 'set up multiple-sort tags' '
 	for when in 100000 200000
 	do
-- 
2.27.0.227.g757ac19d14.dirty

