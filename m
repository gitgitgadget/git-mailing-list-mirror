Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1801F462
	for <e@80x24.org>; Mon, 10 Jun 2019 15:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391231AbfFJPat (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 11:30:49 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:32771 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391204AbfFJPat (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 11:30:49 -0400
Received: by mail-qt1-f201.google.com with SMTP id r40so9359812qtk.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ww/wGlGsDKoClXh0wNKiSAYIihBJNwqHvabiMf2ua4o=;
        b=qWCvejDn1QMouqMivJrJyk8AyquI1wpknVfTbZqTXgihYUY4PVDUMr0GSl8KG9RzCu
         HasUaJkvZX0mvZKrEcDhgbaOXQMbvSb344pWkRoxOMLoypsq3C7+ORRNjqWc/Q0o41Sg
         qHYfgb02k+TWJAKZSwdUJTEeRakWqr/v873FmC45IulX41UD5K0ZK9urBSkkJp+/9PBu
         VI3wlvwvPwc0QZPjSzmcOApzdTx+I53GdJtP1R4LEhi19vmBBDhtfV0mt0yIEi0XVKDw
         lbljMnix1WgnhnCVPDG5VJ8V2KSAB+lHf3oYw7hGJQTCrJVJbzGLviuBvnOaEHdsOWnH
         PQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ww/wGlGsDKoClXh0wNKiSAYIihBJNwqHvabiMf2ua4o=;
        b=lmIDFyEKn6ujwb1MYmaGCINkxS8rd7DMiedLEsD9syET9NOwLLM/9tk6SUbYpuAcLG
         KSp1lPlJ2a9Zd9+U3NueOEjHBQ4JUYps7UljHJhado0cRppQ6oED1h1uooBkybCb3t8X
         w4DEpJq8qiPeq3TlEWbV+UsQO9AH0xq4OaNKqfw6Cmc8tm0hrIP6W0lPOT0d2zmhCAc6
         lmdBwu2QFoTMECU12pjqwxraLGSTWhrJPXWd+dEupktSFMgDFVizsa6uS7ISe/JEXblN
         vkocfnINALu/CKYqGm2oXfC86iy1x2QeF0usAR1ypvLyeI+c0bdR0BWM26p0fNlEnxw6
         R70g==
X-Gm-Message-State: APjAAAXy7//wYHvG8qZfZvy/QBm+eqllotZHwPPxHFXgIlM75IBLskJx
        JlXhJyF8FB6brv3yLdmAlEHDcf+jWaCBccQ4dffkRrzy0sQoKnoH/8ZphWSKDs2Jf2sCaN8Kht7
        cFLF+PEBN5ZtQZLHHBWPHGSu1fViDs751JqRgnmTakg7jJgDIbOkX
X-Google-Smtp-Source: APXvYqw/zjSSYgKGKUDj2UQtSdR009korW2RHvtw/OWnVl52wEGCSIwsHHiAQ9G5QukLWNwEccYnG5Dn
X-Received: by 2002:a0c:9332:: with SMTP id d47mr42152796qvd.222.1560180647898;
 Mon, 10 Jun 2019 08:30:47 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:30:14 -0400
In-Reply-To: <20190610153014.42055-1-brho@google.com>
Message-Id: <20190610153014.42055-10-brho@google.com>
Mime-Version: 1.0
References: <20190610153014.42055-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v8 9/9] blame: add a test to cover blame_coalesce()
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Barret Rhoden <brho@google.com>
---
 t/t8003-blame-corner-cases.sh | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index c92a47b6d5b1..1c5fb1d1f8c9 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -275,4 +275,40 @@ test_expect_success 'blame file with CRLF core.autocrlf=true' '
 	grep "A U Thor" actual
 '
 
+# Tests the splitting and merging of blame entries in blame_coalesce().
+# The output of blame is the same, regardless of whether blame_coalesce() runs
+# or not, so we'd likely only notice a problem if blame crashes or assigned
+# blame to the "splitting" commit ('SPLIT' below).
+test_expect_success 'blame coalesce' '
+	cat >giraffe <<-\EOF &&
+	ABC
+	DEF
+	EOF
+	git add giraffe &&
+	git commit -m "original file" &&
+	oid=$(git rev-parse HEAD) &&
+
+	cat >giraffe <<-\EOF &&
+	ABC
+	SPLIT
+	DEF
+	EOF
+	git add giraffe &&
+	git commit -m "interior SPLIT line" &&
+
+	cat >giraffe <<-\EOF &&
+	ABC
+	DEF
+	EOF
+	git add giraffe &&
+	git commit -m "same contents as original" &&
+
+	cat >expect <<-EOF &&
+	$oid 1) ABC
+	$oid 2) DEF
+	EOF
+	git -c core.abbrev=40 blame -s giraffe >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

