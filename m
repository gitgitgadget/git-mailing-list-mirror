Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C213EC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9B360F6D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbhIGK7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343844AbhIGK7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DEBC0612E7
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so1560672wmh.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5P3kh/X9HhslBfcGEKe9JwBUL1cFukw7pG36VBtTsBo=;
        b=S4d2CcMdhGf/NE7TCAl8da06FOuTNZgDRe5AgM0iUtkZAS20BzazvbFdepCYYr2sVT
         NsDUegI7xfvs1BON4nyB49WjK6JtFLDDxI5ikiYM6Z8JFJDJJAy1jrBFsowfmdbs5HbO
         QkkFS7tO7RoTSVuKTZueW+FFvuDe30Nu6n3BuyyTFSv6q9TPQcb6QtWIP7DCqGNOw+CC
         ZWS6Z8OmH2LUYIKsQbUtXsy1YAbwmfHony+j82USRgFPkbmkXMrIvu8OX0TYJf/+UBr8
         yzUeU2p/VzRtcy6Oi9PKQ9iRwT1qMLvMs1ptP2gQDGoyLzvl45X/G0eAlM9BqviZJdV2
         lFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5P3kh/X9HhslBfcGEKe9JwBUL1cFukw7pG36VBtTsBo=;
        b=DIoaHNAN/w3wVSK15PMBCMhG3ShCkuJiaFzDeksdktKFvb8tZxTugosP4PZLhdvH4i
         V8tHPOXMWxJoZuMpwq8Chxsfvvv/nhSij751ZefglIEW0f3KSP9XLLY+v3JRPBry3zA0
         j8BY9oWAQFs00toDpQPa8Xmy2Tp+4XEpF39KxPnPFQBkfSmJvBzTs5tcw26fkMuazUsG
         TVZfBFq0LNfYNMOgPBYPvCpX4lZhPsL76Fr3Rkn59bM4STMRuFxXlE/N7f5l9voBE5tB
         A30c/6XMcrQUDad8SRUWl7WlQnQ394hhWlWdt+2wmr0crcZ4UV1TXufCNfHhyL9/lVsg
         BDcA==
X-Gm-Message-State: AOAM533gXLKUVhbo9Pc+E5om7dQVXAWOut0krXFz29/on6Zz29Vban5w
        XnyQ2Euc+XJkJWGA/kgzgzLSU0LwDTVYjA==
X-Google-Smtp-Source: ABdhPJylC07Tvya4jc/Vdaq0RPMerdoPY79wUbtYoeT8dwGVnl1/+B2pCpwLL15yQZfHDS0ptOI2fQ==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr3266276wmb.190.1631012314325;
        Tue, 07 Sep 2021 03:58:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 11/22] object-file.c: add missing braces to loose_object_info()
Date:   Tue,  7 Sep 2021 12:58:06 +0200
Message-Id: <patch-v6-11.22-326eb74545d-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the formatting in loose_object_info() to conform with our usual
coding style:

    When there are multiple arms to a conditional and some of them
    require braces, enclose even a single line block in braces for
    consistency -- Documentation/CodingGuidelines

This formatting-only change makes a subsequent commit easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7a47af68bd8..878a4298c9b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1473,17 +1473,20 @@ static int loose_object_info(struct repository *r,
 		if (unpack_loose_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
 			status = error(_("unable to unpack %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
-	if (status < 0)
-		; /* Do nothing */
-	else if (hdrbuf.len) {
+	}
+
+	if (status < 0) {
+		/* Do nothing */
+	} else if (hdrbuf.len) {
 		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
 			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0)
+	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
+	}
 
 	if (status >= 0 && oi->contentp) {
 		*oi->contentp = unpack_loose_rest(&stream, hdr,
@@ -1492,8 +1495,9 @@ static int loose_object_info(struct repository *r,
 			git_inflate_end(&stream);
 			status = -1;
 		}
-	} else
+	} else {
 		git_inflate_end(&stream);
+	}
 
 	munmap(map, mapsize);
 	if (oi->sizep == &size_scratch)
-- 
2.33.0.815.g21c7aaf6073

