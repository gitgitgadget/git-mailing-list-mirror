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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2705C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF98611B0
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhDIIH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhDIIHy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:07:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6222EC061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:07:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e12so4674503wro.11
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VegrmzRhNKZVzzE17SXW49GEV7SvxJWKbFVl2j5qUVI=;
        b=b4re/scsS2JSqMAwpbONssyMkoLpxmCKsLon3218CUP4AE4vtzxohK0pXdPqEW1AQB
         EXHXEAY9mijETG3dpguv8DlJ+cafeaFd3oNrs+Ti2MmLEyWJebklAMjR8HPgUW0X9AEa
         qbUpsWdhcnh8dmecu7kGLIoHu/hpHWDz9Yk+0hJe5D51n3001kNTpdEJuF9l6Y/8Weuk
         GOqxZPvvpu1y1tJulx5v7htCDGYvkBZnPhdPWyXS8FRbtyk9EGtSUzHtKp4qzJGO1et+
         UioBcXnYKMPtsLRQ8+M9/rARcr3D37SbiQsVQAzMQinOFu4qH5QSFYykbdWSF/TJ/gRc
         391w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VegrmzRhNKZVzzE17SXW49GEV7SvxJWKbFVl2j5qUVI=;
        b=QkqQQXGRY5WJtRLfp9p+2Xm4RMVMZTyKBt+NCLZEYVRY1seW4aK0pwiAkl8EOYwNd5
         TioFbB3Zv22mA5UCRVMCAc78JeydDcV2YRok2HCQzkyq/mKXwGlI7A+32PHsvojpygBq
         caTpFhLmfQuT/9DGQZdjNxAzxt6N3VThxbg+yZrJe3D7i1GW7mkpg1aq91zGvIs5TXk8
         BhmWE8Z4EaUKv9oY26yDwOu7gAMuTYpLpabwURV+/purAtBWBRKYc8pqTZfuNnDPDJ3g
         CW330Jhhf7QjWjMRYpJEHMhP3Lzdqm9Ptlin+n+GpaUQZLdutNC3iWorjeF4cxwbVI1E
         iacw==
X-Gm-Message-State: AOAM532EDHYimpjojEy+BUg53r+bzruvB2urMSRrgPzIaOrRPTUS/kuF
        D7vsJ10CsiENkpVpDtYyiVM88B95/tT/qw==
X-Google-Smtp-Source: ABdhPJzqbyPp4Mr+hzLqMy6WwgHgG7MFqxul38OyOOjDqlAKqoIP+CFHOdcKvA3mv7gYQB1zkIwbPA==
X-Received: by 2002:adf:c641:: with SMTP id u1mr16485650wrg.332.1617955660003;
        Fri, 09 Apr 2021 01:07:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15sm3105988wrx.73.2021.04.09.01.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:07:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] object.c: initialize automatic variable in lookup_object()
Date:   Fri,  9 Apr 2021 10:07:28 +0200
Message-Id: <patch-2.3-f1fcc31717-20210409T080534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.584.gf4baedee75
In-Reply-To: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com> <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Initialize a "struct object obj*" variable to NULL explicitly and
return it instead of leaving it uninitialized until the "while"
loop.

There was no bug here, it's just less confusing when debugging if the
"obj" is either NULL or a valid object, not some random invalid
pointer.

See 0556a11a0df (git object hash cleanups, 2006-06-30) for the initial
implementation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 63896abf01..7fdca3ed1e 100644
--- a/object.c
+++ b/object.c
@@ -87,10 +87,10 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
 struct object *lookup_object(struct repository *r, const struct object_id *oid)
 {
 	unsigned int i, first;
-	struct object *obj;
+	struct object *obj = NULL;
 
 	if (!r->parsed_objects->obj_hash)
-		return NULL;
+		return obj;
 
 	first = i = hash_obj(oid, r->parsed_objects->obj_hash_size);
 	while ((obj = r->parsed_objects->obj_hash[i]) != NULL) {
-- 
2.31.1.584.gf4baedee75

