Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA54AEB64D8
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 17:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjFMRkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbjFMRkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 13:40:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922692
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:40:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd69ee0edacso382167276.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686678010; x=1689270010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7KQnfd1RrJljfgV3vlc4SkWbQ9MGK7nBO1blgrMwQU=;
        b=vtNoLPljHlPLaAGR0omf7PBhig7+ZwiOxgGFRpuQamNqHhyhAGc/cOq24sC71dKBNm
         arl1E5XbXKAZBSrPE86xn+Rc5dK/f4KrLhSfZ3c20aA5TPzX6uMEb+pn3oC8YtQEXhgs
         TsTL0bqeIikBT1K9PPEIVX/SkBAbV809kXPTyz1UvoEKR4SS1QdNlFkrRA4/VRmn8nDJ
         cGY4RzdMgs6QQD+MqIroLktwd8O5UChQp3l/ZdIjK3v0hYAp1pkMLj7NAuerVBdVWwnM
         Vcf8G7TJ57osavqTqWAg4WQrQSZbPpAwmxksjeAOVBw+a4k7x4pzFotZadJzejV1SroL
         EURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678010; x=1689270010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7KQnfd1RrJljfgV3vlc4SkWbQ9MGK7nBO1blgrMwQU=;
        b=DMWIRDDxlIanZ9VTPOTAbbOCUIGJFqqCPc2kkYphXzwqTK0l6pwMjqFSyMUMtnVUwW
         8dpMwN8CchLTwPNtMPvtYpUBtEx5a0nY2xb3FpnPKprw6v3+kT3jNEd2dXDSv2rsNFcR
         fLyblPbNKtYT+Jqb9aZOH2aPG33StTKMU/vScooUdxKBZbz4hFVMpG5tPXno+V+1IsBL
         K2oAwKPG5WjsBLmmMnOx9YLNx/uXvU9Z8De5JQGb1XQXrXNlsB4JJKJ+yWtWg89BwYm9
         Tpx/eYAMPfdiEdtUpv6Esm3VB16JxcBIkZsMVayryjJ/sqU+S15ZdXMc0jcIyGPkX7g9
         7nmg==
X-Gm-Message-State: AC+VfDwQRE1gwd1+SVzDm1FxyJ1siWJX/w68hiwdDfwtBhyAloksh7Jh
        5vCZTTwRXoscXp1+myU0+6YzTmkNkr49yCRqXC57LXFD0NtblAAFSozRjDC5rGQMvoD4UiwPlhv
        v7rRowcgXejhalq08MRG4wAsBo3jgG3G8BVdkaVU8HZpLtwbnLv34A0vRm9xyMJrPsjPc0GZP26
        Au
X-Google-Smtp-Source: ACHHUZ6YPN0GSBqL4iX7i2OHdLctm28TVfndK0Vx9+7eFtstlbil2JAGSnwpvZV4juHpipnpbsW3xB0XdqWqWMPxZuq/
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:5e39:4d58:c992:1db0])
 (user=jonathantanmy job=sendgmr) by 2002:a25:4487:0:b0:bad:4bb:c440 with SMTP
 id r129-20020a254487000000b00bad04bbc440mr1051892yba.10.1686678010094; Tue,
 13 Jun 2023 10:40:10 -0700 (PDT)
Date:   Tue, 13 Jun 2023 10:39:55 -0700
In-Reply-To: <cover.1686677910.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1686677910.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <a3b52af4c96db9a8164119e8ace0541db47b6815.1686677910.git.jonathantanmy@google.com>
Subject: [PATCH v4 1/4] gitformat-commit-graph: describe version 2 of BDAT
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code change to Git to support version 2 will be done in subsequent
commits.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/gitformat-commit-graph.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e2..112e6d36a6 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
 
 ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
     * It starts with header consisting of three unsigned 32-bit integers:
-      - Version of the hash algorithm being used. We currently only support
-	value 1 which corresponds to the 32-bit version of the murmur3 hash
+      - Version of the hash algorithm being used. We currently support
+	value 2 which corresponds to the 32-bit version of the murmur3 hash
 	implemented exactly as described in
 	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
 	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
 	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
-	in Probabilistic Verification"
+	in Probabilistic Verification". Version 1 bloom filters have a bug that appears
+	when char is signed and the repository has path names that have characters >=
+	0x80; Git supports reading and writing them, but this ability will be removed
+	in a future version of Git.
       - The number of times a path is hashed and hence the number of bit positions
 	      that cumulatively determine whether a file is present in the commit.
       - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
-- 
2.41.0.162.gfafddb0af9-goog

