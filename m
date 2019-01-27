Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73791F453
	for <e@80x24.org>; Sun, 27 Jan 2019 19:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfA0T2E (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 14:28:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39857 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfA0T2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 14:28:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so15659182wra.6
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 11:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xWGdzopbWRAUZivCaHnF9StHMlgmBndHa05ufYNtX4w=;
        b=NMOWJ8ptCJAOfHS8rGq6Bpso1GQ8HyKHKpdf9/Oyd2Xoiud6Yv1LFr+Y8jRgeDCkjN
         kDiougW4RpXldTS2WKkB2YgS1e59VY4bHYoJkh3457jlnUcP5KpcQ4zV9y3WGWKp/HhO
         L6WFUSDBLeMf7jvvhpdO3aIbBrP0ZKkebJ8r0lyc/BgiGvDPdDcIsmQwzM2BZBoNMkr9
         92D+b0lfBWdZ/WJanDE+UfZCS7hm8j6bHD4LMl8wadAxkuh/zayUCdXrtIAJNkUocwxS
         jjEoQOr88nGJinsAqZnJc5E0AcLljvCWbVg76gnjTXYT5HFUbIrcK/gBhUzv/rr7yskp
         Hnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xWGdzopbWRAUZivCaHnF9StHMlgmBndHa05ufYNtX4w=;
        b=thtKYadRNgIZQQ1NlEl62KOGztqkiisRyX9j3cvSiqwwcAJ6G1kwWmkhlAG6cSS0T4
         dGkkwFDTktpfl45UO5WmW96wiqiZw0/s0Y5WuDIDQKdkRhlQPoXQ4iGbjG+iGNpThG6T
         3duzy4v7Xm2sXH5HKegIQ/t9puTQlM+T/DCXOKg0gmTublhdttRBHbttlJH8W94V7lBV
         iQ6AXDzkTiIs1LYqbgmqk5n8fVE1WX0/gDHc/QTA/1BQqiCCh5W5f5++t9iav9dsK0M5
         eB20Dx7vCN6bW/Ub8C8IPpiTa/CPeiM/Yyq+wUufv0AToR3BGUdsToISThZWPmNfdek3
         t7Jg==
X-Gm-Message-State: AJcUukcBICyn1QpDDTGDDmtmzTU8aDClqDRhdaa/zOehw+wIpOMKKp7l
        xcFDh5Cin9y0Jzop/3k8+Jyx8Vts
X-Google-Smtp-Source: ALg8bN7+kojadr0a6mOnZfDRve3jLkCoO9BZ+53hqSBhrbBfRcPyj6sxA9GodKEHIQRQcLHTIJjNYw==
X-Received: by 2002:adf:93e2:: with SMTP id 89mr19759843wrp.129.1548617281558;
        Sun, 27 Jan 2019 11:28:01 -0800 (PST)
Received: from t500.lan (13.162.125.91.dyn.plus.net. [91.125.162.13])
        by smtp.gmail.com with ESMTPSA id a187sm63894262wmf.33.2019.01.27.11.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 27 Jan 2019 11:28:00 -0800 (PST)
From:   Sven van Haastregt <svenvh@gmail.com>
To:     git@vger.kernel.org
Cc:     Sven van Haastregt <svenvh@gmail.com>
Subject: [PATCH v2] git-submodule.sh: shorten submodule SHA-1s using rev-parse
Date:   Sun, 27 Jan 2019 19:27:40 +0000
Message-Id: <20190127192740.8678-1-svenvh@gmail.com>
X-Mailer: git-send-email 2.12.2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Until now, `git submodule summary` was always emitting 7-character
SHA-1s that have a higher chance of being ambiguous for larger
repositories.  Use `git rev-parse --short` instead, which will
determine suitable short SHA-1 lengths.

We cannot rely on always successfully invoking `git rev-parse` in the
submodule directory.  Keep the old method using `cut` as a fallback.

Signed-off-by: Sven van Haastregt <svenvh@gmail.com>
---

Differences since v1: Keep the old method using `cut` as a fallback.

 git-submodule.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad..5bd724e63b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -850,8 +850,16 @@ cmd_summary() {
 			;;
 		esac
 
+		# Ensure we have crudely abbreviated SHA-1s as fallback in case
+		# rev-parse fails to shorten the SHA-1s.
 		sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
 		sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
+
+		sha1_abbrev=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src) &&
+		sha1_abbr_src=$sha1_abbrev
+		sha1_abbrev=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst) &&
+		sha1_abbr_dst=$sha1_abbrev
+
 		if test $status = T
 		then
 			blob="$(gettext "blob")"
-- 
2.20.1.dirty

