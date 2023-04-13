Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789BAC77B6F
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjDML6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjDML6C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:58:02 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12E419B
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:58 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id bx42so26155397oib.6
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387077; x=1683979077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iG05m1s5ONOnlMKFDVhfBZ1jYfEbz+GcmYbgSyKXBtw=;
        b=NcH85y4WgyUnVlzwRAXofG++Lu9OmLeeNdyK5ErrsWJBn8IRkODkiDtjHLrEm44JV7
         p19Tl4UwU5u3NTrfZkA1rCYTxupB6JhvXe+0zejHBTdH8CVNp3B3hi9wMmW/FsAi4Ek9
         vwWX0tXYPJjOVoNWfZ0nZUGFfLia2f0dkW0S5Yk36tN0GEbSKfi7EaL+mJ1GmUfLv9Bh
         1Qa67gKQAjRe2osD9ieGM7TyATup+D7vGSH6y1EULb2z1h+iiXvgVpVYU6Z7gqRDjL7p
         sfqBaRv0DRD8ssQUE3Wza5S3bcjyhwpg/OBE5SRGUGxT/gkQ0p06QSmh9gaRTIe32qvI
         fDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387077; x=1683979077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iG05m1s5ONOnlMKFDVhfBZ1jYfEbz+GcmYbgSyKXBtw=;
        b=eGkKercC9XHMJIgUdjBR+vmv+N8OSOyIstHwvp++WRAkyaz4NfJG5KCfbcfRpOJJ12
         yDDO/OG9xcr+tu8KSKadKTFD2RRZeY78qx6mkss1pll7pfqKK0gk/eFlRJBL5AJnr3DB
         Wy7i6j4gUsH4m/c0eFG0b29iuzjzSrIfJdcn/ZVbUXV1VvyTmAET9yeJd9U92f2pbtah
         Aqy4YCMrH/IHoMSI5SsQ+DCdYcNc3wjnz1Bw84gAtYMxFlsylmH66pYDC4gauf2cfYdu
         MqFgREjjxBD+vaAHJkVm9Du563VcsLa8Z7mSr35OraEDj8C4WlScf+LrnVLs/0I+auHP
         qEoA==
X-Gm-Message-State: AAQBX9ebNmzo/KxzrL0LnAjlbrZUA4NzEryMbNR8sEzSil46P61CPga+
        5jMqaCn3ePL3EY0pVcrVHVu5xJkg5BU=
X-Google-Smtp-Source: AKy350Z9H60RGwAT6VcjIPQ1kGUazutsjJD/xYwbfPq6Yb6bMYeIlyMaZLGrrNZP8qcsueyM730GBA==
X-Received: by 2002:aca:1709:0:b0:387:38f:9cf0 with SMTP id j9-20020aca1709000000b00387038f9cf0mr996638oii.33.1681387077785;
        Thu, 13 Apr 2023 04:57:57 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bi9-20020a056808188900b00387160bcd46sm527770oib.46.2023.04.13.04.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 08/12] test: doc: use temporary stylesheet
Date:   Thu, 13 Apr 2023 05:57:41 -0600
Message-Id: <20230413115745.116063-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

xsltproc doesn't have a problem with a our trash directory.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t0600-doc-tools.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0600-doc-tools.sh b/t/t0600-doc-tools.sh
index 0af431941d..cd88027514 100755
--- a/t/t0600-doc-tools.sh
+++ b/t/t0600-doc-tools.sh
@@ -54,10 +54,10 @@ description
 Part of the \fBgit\fR(1) suite
 EOF
 
-"$doc_dir"/gen-stylesheet >"$doc_dir"/manpage.xsl
+"$doc_dir"/gen-stylesheet >manpage.xsl
 
 xmltoman() {
-	xsltproc --nonet -o "$1.1" "$doc_dir/manpage.xsl" "$1.xml"
+	xsltproc --nonet -o "$1.1" manpage.xsl "$1.xml"
 }
 
 build_asciidoc_py() {
-- 
2.40.0+fc1

