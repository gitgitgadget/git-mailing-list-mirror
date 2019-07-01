Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A341F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfGAOq1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:46:27 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35225 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfGAOq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:46:26 -0400
Received: by mail-pl1-f201.google.com with SMTP id bb9so7410046plb.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bspsNAjXAX8xQZooyKU2OPmxbmU3vPrBvNkTDWda4Bk=;
        b=pgJ0Fi5uVpMgC5YrFEcVXOFLEH24OXtdowOkCYH23V1R4o3m3aKxhcfpJEYmVUtFLe
         rFxHDKTRKNIJv6GE7AZEAViNazRTGcPL7vwK/2ZE5SLi/Th75DpWg9rALCByWLIc1BSy
         tTfoYHPzHGVihLRat5TKXRIkWNWWyD8KBZaAcN+9WBDRnoRQpPRgoX4adE6Iz4kvARni
         j49zQVUVgQhv8sG2WR5xElJRynuSHF9lySRZJyBww0JzHwmnNk69p6KJ59n292IXyR0A
         ZQO1fumRCCX96Y8Xs5eJgtk0VDXE//l/AQy6c3u/jIsb4O8G2e6Je5qzanbhE04q4StK
         0qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bspsNAjXAX8xQZooyKU2OPmxbmU3vPrBvNkTDWda4Bk=;
        b=Lv4udX5V7WOuvxrWrXwqfXtwX+i9yUoUyyq1jm/V4Wh7DiOvg020d7bVy7AbM5xdb6
         GkkWB4XuQWU2nK+ZSSWlRvs96FPc1g3qcYXuwyj/71O4dIkjW1H8gG1GVYYTpDExvtSc
         oo4+ilj5BUWK8swk+aIJb+fymgV1NdcQa/JNj34gTWStc79tuJPm1WKpnMtQSowNrZNa
         Gk4gyN8cIzcaobbqqwbT03HSaBwz60RMGGErI9vrRus69XXtx9kNIgU46Psw1tyD0P6k
         tnRMJ4nLF+LGvFx6W8c2+etiNsXRUEJwHNtysvKIBP5s1EYdO3Cj74WlqNXeHryt+/qM
         zr1A==
X-Gm-Message-State: APjAAAUUvELm8QpOYBWYvR2+QTBPS572gcAscpWN2qb4B8fRD3wK1YYW
        5Cjt2zgAESonWD3AYHCkwe4s5vTsKh+16J+ujvsNCAX7XX12fEbUpo/LqLUOU3n2Q7Ns2bLWeUb
        wHSJ6P4QJpP5BMcPtWi3hZ1g6qWFVeVWHOKhwJPHhdzOnxwVgaV4X
X-Google-Smtp-Source: APXvYqyknvXQcaBaNyDJW4d2m8JXyRNoqBoKH8+8vlqFAHX8LjHyhYzD9gV5TVujuIc6cQtsFdlJdLIX
X-Received: by 2002:a63:2a0f:: with SMTP id q15mr25804948pgq.163.1561992385511;
 Mon, 01 Jul 2019 07:46:25 -0700 (PDT)
Date:   Mon,  1 Jul 2019 10:45:48 -0400
In-Reply-To: <20190701144548.129635-1-brho@google.com>
Message-Id: <20190701144548.129635-10-brho@google.com>
Mime-Version: 1.0
References: <20190701144548.129635-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v10 9/9] blame: add a test to cover blame_coalesce()
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
2.22.0.410.gd8fdbe21b5-goog

