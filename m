Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935C2C2BA2B
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6E520753
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 13:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAjbgpXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDKNk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 09:40:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34826 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDKNk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 09:40:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id c7so5787028edl.2
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tKTWcCplTNAF3PNrp7ggBvUgGskP70k0vbuWEtBEo+Y=;
        b=gAjbgpXD23qGiMLZkUVMSZ/73gzjJLoIlO3loJGOLihY2C5TBzq+zB20RQ2wuAGTQg
         Iy80f9wRtH8N9RZkYHgQsy3O6I9A9YEbymjM+8m5SPYpvP3H4jBAXqnw0JTTcElBDY6a
         34ioIJ8JPoMfiMxbyTqk8gY8MeiddRPjfmmHOqYPgNatEhfzprtbDSH0Ry6quWigWaQI
         wzg4j6b2dT19GKPzm4E2pXMHvhB0FFmQE4dquLVQNQwHg6c44qp0HTVjD0w8tMbmvd7U
         rME3FAp6y/tLraEcw/ZxHQogtej4Ywln6WWbNroDQPT35nLhqOLadK86TYuU/8JeJBLK
         qmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tKTWcCplTNAF3PNrp7ggBvUgGskP70k0vbuWEtBEo+Y=;
        b=dHj+ZcJrq99kPFxkpFMEzcPfmnhm3vH5KQofzig1ksSMxMidaHQ2dvmW5FFVEx+EEp
         IerrWgH1e73jygh/YyVGKcCwU5NZBZ3mlH6uEBMMKbVriUB6Ip/OIFjpdryBjWGmDZFM
         Uu9sVuMNhY+UfsNnt5ggBGAYAD+hvLsmeZW9Wt49gosGkLLeYcsFLB5yNYrTuuz/BcHJ
         TOmfvgJQzM9mdTpWj59pArSp6HPkvASFaSPeFlQlt3WRgSSmGewCbN35z2wtL5AZB5GZ
         cfxHAKwUIq+Y64maDXmfkYdGRLCC9s0ldWVIGKdQ6o6e362q7t5BwvCfbowPBfZ/DsBH
         49Mw==
X-Gm-Message-State: AGi0PuZKPjv7OK64eIEaxCgwbHK2jEcy7yicEaCAf0BZBxVAZMwHdjba
        5AdoIrA3fo3bGuPi8mQZBSbK1qUU
X-Google-Smtp-Source: APiQypI/R1Vg03PpEj5frL9HgQhkamW58+M3Ze5EotXWalC2B7lW1nCLfQGIDDI4OGke1D2+BqhjBg==
X-Received: by 2002:a05:6402:17ee:: with SMTP id t14mr9580752edy.141.1586612426452;
        Sat, 11 Apr 2020 06:40:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm608807ejt.1.2020.04.11.06.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 06:40:26 -0700 (PDT)
Message-Id: <8650936b8d4e975cd5260cfe312cf79b36c2dcc5.1586612423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.603.v3.git.1586612422.gitgitgadget@gmail.com>
References: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
        <pull.603.v3.git.1586612422.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 13:40:21 +0000
Subject: [PATCH v3 2/3] mingw: make test_path_is_hidden more robust
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function uses Windows' system tool `attrib` to determine the state
of the hidden flag of a file or directory.

We should not actually expect the first `attrib.exe` in the PATH to
be the one we are looking for. Or that it is in the PATH, for that
matter.

Let's use the full path to the tool instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 7a7e7a38312..2f81463a240 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1547,6 +1547,6 @@ test_bitmap_traversal () {
 # Tests for the hidden file attribute on windows
 is_hidden () {
 	# Use the output of `attrib`, ignore the absolute path
-	case "$(attrib "$1")" in *H*?:*) return 0;; esac
+	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
 	return 1
 }
-- 
gitgitgadget

