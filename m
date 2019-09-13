Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C345F1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfIMNCx (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:02:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38787 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbfIMNCx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id a23so24753698edv.5
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FE65YJQO7zrKfVbH++0ZWusJuB9EyAxSzwJdZ0cmVTI=;
        b=AbBjAGncAOgboC7D3yPlYZ2UHWUKvADVG5m+LlAGGTTJ+hiAVLdDLmqIPYbLixY3/r
         ub6gWc/GJhjkyT5bWacsJrPBcfySZXpJq49O1HbAGceEgxjGFUJeRpM1ijlftJmG1YUt
         1KXBlmuPX72nFczsWh3mSXe+4w7z3xafUmcNIBD8fqEAyeQhSy71XO/U4EJccM78Iadu
         sY854heiFWgCJjXopRtmvjozxcPf++l+FuXU6SpTUI7LsIILVgi6k4ZOUTxNthhkQybp
         eWq6X0Vcm8/930NMpEiOL2ckzWmkgJIJ1DQb33ICK/ALrYLpmesxZl4DLTCxlQ/qnA42
         v82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FE65YJQO7zrKfVbH++0ZWusJuB9EyAxSzwJdZ0cmVTI=;
        b=pFSjZczAGXFvSzcAdLXGytiAaNgHdaeeBbxcL8bByddvZfmYMItP6Wd+rFVqGdn8jb
         Z3PGrDwf7JvJQR8bVjNXiVpfDV5b4nmCxuR+ND2kEmIQdJ0EOn713ia7Gelk+Xax90y2
         i4xJEICwx+Xh+qXlzAd71Wd8FQ7dCXohGhw3RiRj6j+dI2GddYm7kNxqQCBo+PA4OdyW
         ao+Y+KDZz1o89B6MO531uRZ82DloCboWlw/0t82a+Eb87VTE387uOPHLGEI8nRu0bNHQ
         cj70LLSJnDkBvF7S17wNIjgCjFvEdQhmJZjzr9diPBOKcBxjS6yhEdKP+1z5Z08dPv1V
         bcYQ==
X-Gm-Message-State: APjAAAVKCPggnjYohlNTDN3e3hJjfFW8Oy2Dd17m/7dS9tUdam/jS0AU
        G4la7axAHTiqYhFzkjv9pWhnHJBd
X-Google-Smtp-Source: APXvYqzWhXxFL/ELy/3lw9Te3kLPS3FRY0bBMQ4tJiwuQiY8X3w/pCp/Umll/EzU1HfCG2c/RAwfsw==
X-Received: by 2002:a17:906:76c2:: with SMTP id q2mr26568554ejn.202.1568379770792;
        Fri, 13 Sep 2019 06:02:50 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 02/10] packfile: expose get_delta_base()
Date:   Fri, 13 Sep 2019 15:02:18 +0200
Message-Id: <20190913130226.7449-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.46.gd213b4aca1.dirty
In-Reply-To: <20190913130226.7449-1-chriscool@tuxfamily.org>
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In a following commit get_delta_base() will be used outside
packfile.c, so let's make it non static and declare it in
packfile.h.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 packfile.c | 10 +++++-----
 packfile.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index fc43a6c52c..5a6e8d54f1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1191,11 +1191,11 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 	return NULL;
 }
 
-static off_t get_delta_base(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t *curpos,
-				    enum object_type type,
-				    off_t delta_obj_offset)
+off_t get_delta_base(struct packed_git *p,
+		     struct pack_window **w_curs,
+		     off_t *curpos,
+		     enum object_type type,
+		     off_t delta_obj_offset)
 {
 	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
 	off_t base_offset;
diff --git a/packfile.h b/packfile.h
index 3e98910bdd..8049202f4c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -151,6 +151,9 @@ void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
+		     off_t *curpos, enum object_type type,
+		     off_t delta_obj_offset);
 
 void release_pack_memory(size_t);
 
-- 
2.23.0.46.gd213b4aca1.dirty

