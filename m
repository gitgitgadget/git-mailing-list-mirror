Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15281C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED27C6109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbhHMJPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 05:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbhHMJPy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 05:15:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F150C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:15:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a8so14350348pjk.4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lEn4oeBK8CxlcAsOA0DPqcVBzgH8Xm3ZiDrENDy2Yj8=;
        b=jOmGI9w70ydIMl+XmmKMrePPgcczufzF/19xluFHgaBBgRzD7Zga5apjq6o6TmvRHX
         fsipNN4eJDthA0OmLXi1D/OSOljKylCuH2/moUJUWwnN36MnvUezKu+eF1LVgmlfXuzE
         ++6CYVhlqAXoILYPiV8vAw/nDl+sCpzg+FfxQFMDXjejgfI2KUwOEU/+GefL300IFFPM
         grXxMXqIZkNiOmsYgGQpPoDDVZZ9O2IICLGB92lb00Z+QNVJiSetXKRCApU6nmCha1oo
         crpBh9IIO+MtkTH2EmBKxEU5ke0j8rViIhKXRQp4fzA0GAdm7yti02fty4+ITO69VulS
         QPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lEn4oeBK8CxlcAsOA0DPqcVBzgH8Xm3ZiDrENDy2Yj8=;
        b=PoqZggLPNBOUznrymqvvVBDgbxJPXq9cm2gqhSeIc28gVtxyaD+dvj2QGaSHvhoSce
         Iqu5ThKh0c1GSuZtFibe8Cd7q3+E8vvltjeBR3fO4b1JNUqCYX1ER5sd3BiKClZz2oNw
         pRnV3zv+yHNkRLFxLmI+UZREE1MCf1wyqfrAYdw1blgI8L9P/xsX9+oOwaLIf24t7J9n
         fH8QlEOLx8JbhW4lfwPEpZTt9tGHh/GkEbibRCzTiHhV0zJD//RBp3MzAVwHSbQeqOwZ
         XSgHa3PfLzknoMWtKrZRqv7DjloBEJ9ElF2MBDiedxXi3ITgIsdE0MiG1xRsLanIX+wG
         NDPg==
X-Gm-Message-State: AOAM530ggsMk4GXPR+4CVvrK7e5YA5f9D7U7HIc68fE8LQPkG0ZaUHbn
        3sGsHbREi14XFmuve42032w=
X-Google-Smtp-Source: ABdhPJzK65XOnUUaAcRz2rfS2xWKOCcZmoWoFaS4NI/60QxZ3cta1yJs+P9LCvFnADjA9KtoJ/hJ2A==
X-Received: by 2002:a17:90a:fb81:: with SMTP id cp1mr1727611pjb.52.1628846128149;
        Fri, 13 Aug 2021 02:15:28 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.158])
        by smtp.gmail.com with ESMTPSA id p17sm1286968pjg.54.2021.08.13.02.15.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 02:15:27 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org, avarab@gmail.com, jonathantanmy@google.com
Subject: [PATCH v1 3/3] t5702: `fetch.uriprotocols` is configured without value
Date:   Fri, 13 Aug 2021 17:14:56 +0800
Message-Id: <3ee54255440fcc5cf549ab5e98fa51bbcd5df2e1.1628845748.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.1.g0de8fe24d1.dirty
In-Reply-To: <cover.1628845748.git.dyroneteng@gmail.com>
References: <cover.1628845748.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t5702-protocol-v2.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 66af411057..cf3bc89775 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -945,6 +945,29 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 		fetch "$HTTPD_URL/smart/http_parent"
 '
 
+test_expect_success 'packfile URIs with fetch by default `fetch.uriprotocols` config' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+
+	git init http_child &&
+
+	GIT_TEST_SIDEBAND_ALL=1 GIT_TRACE_PACKET=`pwd`/log \
+	git -C http_child \
+		-c protocol.version=2 \
+		-c fetch.uriprotocols \
+		fetch "$HTTPD_URL/smart/http_parent" &&
+	grep "git< packfile-uris http,https" log
+'
+
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	rm -rf "$P" http_child log &&
-- 
2.32.0.1.g0de8fe24d1.dirty

