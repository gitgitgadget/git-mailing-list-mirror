Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA02AC77B77
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDNMTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjDNMTV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:21 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA64B767
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:11 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-187878a90e6so7696384fac.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474750; x=1684066750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH+efnO59F69GecAfIBijjIg7HeqCeBMZ/U56GD+3oQ=;
        b=GcFOz2vCz5GZKy9ibn+EAKv0+FkcUzvjAZjiqNf71n9gz8UKycxIjYrdIuH0QvGyke
         Q/vFeg7C0gVLf58ip7iPX8Z47F10NCmEssFRJ3WGaMVNchxUNa3UCbsWMYtehgezBMKQ
         C6MmpkQyx4PxbZdWr1PmpJ8m4X0H6hoEcgC8xMaDXH35hHBlybAw/PjkNR7UIMZI0Img
         CagSaBJfKmYEsKSd22H1tXi4TARTnslA2PzMeLf5cgzqC/ZCL1f9Z5tU9V8KcPLQEQPc
         TZWC7e6mtt5QdzNU/ERGkpDwVjbvvVcvA6SmCLTVDcCe40kwFK25z9j+IIgdAmzoiP4K
         hsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474750; x=1684066750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nH+efnO59F69GecAfIBijjIg7HeqCeBMZ/U56GD+3oQ=;
        b=MfhfhwRA8+1tKELkZcRdrmtp8xjQbcjVJ23BcfMYaQwAgXgds00K8z6tGDhY6/VuJs
         j1U7l3nm2lkg8+SCOKSHpmENihnarN6H8inXGCR2YVFwovNDVvGP0xzH+h45GduzUM5f
         z1JzOLN2CCi6Lh8QQhmZW5BmhmdGEmvIOwy1u4XHp94E7leQUzBrNBKrfRMeOrHeLhwy
         /VLDw1ONApTf67waatjDWkOk28AtNHTKxOzXEFvmGp2ye2TuVmu4j5ifCaQ5TiLaEhl9
         zVJd6TPSxRIE8x6qPY/H8aoRFkAxiT3MoK+eXXKlWZPhwOT7uSUK7xFeFue4I6iKjl4M
         1+WA==
X-Gm-Message-State: AAQBX9d8gTZfUEGKfYCCCRvziP2pHKEMiRqnVKPPSt+LC3IGwvyv8rp/
        ZSwFsUMvwK+SXOHtjUIc07eMBhkXi8g=
X-Google-Smtp-Source: AKy350bkNsSxNy2L6xPsqgEmftryqOF2rplXkAetMDlbwssD2UaeBIVgp2tjky3hOlxoVvT3neHDmw==
X-Received: by 2002:a05:6870:831b:b0:177:8c47:c6bc with SMTP id p27-20020a056870831b00b001778c47c6bcmr3434646oae.50.1681474750693;
        Fri, 14 Apr 2023 05:19:10 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bf27-20020a0568700a1b00b0017703b8a5f8sm1676755oac.49.2023.04.14.05.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:19:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 17/18] version-gen: get rid of GVF variable
Date:   Fri, 14 Apr 2023 06:18:40 -0600
Message-Id: <20230414121841.373980-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's not much point in a variable which is never going to change and
doesn't really add any readability.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 8f2250bb1b..161fcdf1ab 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,7 +1,5 @@
 #!/bin/sh
 
-GVF=GIT-VERSION-FILE
-
 get_version () {
 	test -f version && cat version && return
 	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g' -e 's/^v//'
@@ -9,5 +7,5 @@ get_version () {
 
 NEW="GIT_VERSION = $(get_version)"
 
-test -r $GVF && test "$NEW" = "$(cat $GVF)" && exit
-echo "$NEW" | tee $GVF >&2
+test -r GIT-VERSION-FILE && test "$NEW" = "$(cat GIT-VERSION-FILE)" && exit
+echo "$NEW" | tee GIT-VERSION-FILE >&2
-- 
2.40.0+fc1

