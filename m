Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EFBD1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 15:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbeHISVb (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 14:21:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44674 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbeHISVa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 14:21:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so5553405wrt.11
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ves5Xj1yLmQVoogLlRyZBKVEzNjPRBastKnGzPJvjLc=;
        b=cxph+1GtiHjW38lGse5aKPWPWGL8RA8r9vtcCDzrnJei8ZUNVEvsVKih8UuHEsHnMl
         GUsT3Ay16Kh8SoXAGc+Esc7gdE5ebUlNbdy7Wifgcq1PkDqZxe0HZ07n0wa4oA5Qf0Qy
         np6S7N1xqJqxUNa5jzCGYT/q6CUNrNp/u/vIOFHTqtKmddejdFXabjl0IhPcNtw4YuXc
         HnNK9ijrqEbfizrcSyx7NEPeQ3iX9HtJdVPGjtDptsVHhbjjcZGai2PoZf0sK2VLG5Zc
         uk8hf0bbGLdx9dTkO3h3HDilx6AcJh6M0ZuEgMFx1VYZVAmrD6/kv+ho3Aj0uptliVM7
         ezbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ves5Xj1yLmQVoogLlRyZBKVEzNjPRBastKnGzPJvjLc=;
        b=QhymPDb0ID6e8cUyCbfG3G1lgvf4cAH2HQHUJZmsfoDcWtHC9WIGMPVEi21cXY0MWx
         XY7Jyk+AfoebiH6t6OneSTqyfjJ8gkAGsd9lLLylGGDXfwUE6ia6OXXwrG1nyH73ebJm
         5XeNCS+2H+EQKzyvvqtMBEBGTDO0cKcB52o/C2udv9MpihTi0HJizNMTiZ9obtrzxaD1
         lC6TqP5e1XsKBkj52XW38JLWQsSdC1Jo2wasS2z2+qzq1qdo46joR0edrkqSr6H5iFqa
         YRicJNYUnpFmjq1vWAfer0B8Ws2nqqen/rEkwpsea650wgyO91BeFyqy13ZBEhOwIjq4
         ohuA==
X-Gm-Message-State: AOUpUlEGx6Mm7nuTaBvJpAsnbCbTsgspKnQoCWbCIFI7atbFj18LF5rp
        vstyG/w4C6lrpf3o7GjTEHmPIGvO
X-Google-Smtp-Source: AA+uWPw6PeeGG0T4iDol3vr+SNa105NYpXvnrPSeQVFctYW+RbkUxftkk5l7NHgFXSYyManTWb1Tlg==
X-Received: by 2002:a5d:6103:: with SMTP id v3-v6mr1899035wrt.265.1533830158088;
        Thu, 09 Aug 2018 08:55:58 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t69-v6sm10913762wmt.40.2018.08.09.08.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 08:55:57 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/8] packfile: make get_delta_base() non static
Date:   Thu,  9 Aug 2018 17:55:25 +0200
Message-Id: <20180809155532.26151-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.555.g17f9c4abba
In-Reply-To: <20180809155532.26151-1-chriscool@tuxfamily.org>
References: <20180809155532.26151-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

As get_delta_base() will be used outside 'packfile.c' in
a following commit, let's make it non static and let's
declare it in 'packfile.h'.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 packfile.c | 10 +++++-----
 packfile.h |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 6974903e58..04d387f312 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1037,11 +1037,11 @@ const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
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
index cc7eaffe1b..1265fd9b06 100644
--- a/packfile.h
+++ b/packfile.h
@@ -126,6 +126,13 @@ extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsig
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
+/*
+ * Return the offset of the object that is the delta base of the object at curpos.
+ */
+extern off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
+			    off_t *curpos, enum object_type type,
+			    off_t delta_obj_offset);
+
 extern void release_pack_memory(size_t);
 
 /* global flag to enable extra checks when accessing packed objects */
-- 
2.18.0.555.g17f9c4abba

