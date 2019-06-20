Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6EA1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 16:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbfFTQjx (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 12:39:53 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53291 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbfFTQi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 12:38:56 -0400
Received: by mail-pg1-f201.google.com with SMTP id j36so2096337pgb.20
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bspsNAjXAX8xQZooyKU2OPmxbmU3vPrBvNkTDWda4Bk=;
        b=rmpXWiruWC8XLfRoeRhEpnkYEST40axHm45tfpsuoIUySrW4USfeL9Y82EZVDV/kq8
         vgZbtPSbUC4L7GP1023l4IVQDdNq1yLDwzDWwcwXBeMNneeRy2QypArHMlhImcO1VCqd
         vy6Bub9aAG/6C4D/+/HP0cbZS6IHr5uZYvDA3bwtHNOLSD518Mq73scUkEnfAVkNTqtH
         cCrqI/ILMmuu/Zdkl/hm/ibIevtduTgRRIvk4z4P65jUmk9DDGTbhJ1VbDDCmCQ+1wVS
         bGHz2dlXBlUfoT5zncPXcdAnuA1KfDziUk3aZLgHhx0tg4E7pmVTgdjBd5cdWljZvCZ+
         Q1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bspsNAjXAX8xQZooyKU2OPmxbmU3vPrBvNkTDWda4Bk=;
        b=pksS02XWy0bh4bCl7j6SXa2m6nZnQ65JIXxF59LjMiGJZchX5DdknoZuV0yONskXaI
         ga99zrwZMXuSci2lcfmI/yV3SjlvjsvylW3lDLDQsZ8zgjBcOM/KjfqF5ZUquS8oA+EI
         fwQ8Uchp7GtHARj78EHTLIgkfn7zF7mw0aDYipYydp5a9754BQ1NYE8rooeQmP7Q/D84
         0xRK0AwdPMdW7DU5dRsetOfFDg2ZPhHpP0YFasDxKF7VU6YI8cjwybF4PvYazUvgaa4s
         vz0zwhNdLNL9hFnEkA0BUVl4o9efhvTI4C7qIOwq+I4BGbN6CNDpiliPZuwvVtoCEnVZ
         wkWg==
X-Gm-Message-State: APjAAAXWRN9zSRuazfF5ceqGwpzogVjgNl5iFYSokKb6H7HOCGwwmWC6
        DXk4POcI3ol+xHAz/m020vl/q9vLkpOPX17ry/cvaHDYP9fxZ8VDwM2Y2CU7755fHi2XevrFJGa
        tz6rpD5ULKlAzsxSzG8pENz0Y5uiVmRNzVhS9RIPkg+TOjQIYhKYd
X-Google-Smtp-Source: APXvYqwBSo9EVcoG5YEWoaYHd42bwSIpU/TMfSDmSpNg+X/FMYCvMA6QWvfH6wzydi8cTN3SdULv0iba
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr13585339pgd.259.1561048735136;
 Thu, 20 Jun 2019 09:38:55 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:38:20 -0400
In-Reply-To: <20190620163820.231316-1-brho@google.com>
Message-Id: <20190620163820.231316-10-brho@google.com>
Mime-Version: 1.0
References: <20190620163820.231316-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 9/9] blame: add a test to cover blame_coalesce()
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

