Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F66C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C9A20658
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dd0EogsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbgHQTtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732754AbgHQTsb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:48:31 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78BEC061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 12:48:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id d1so10707087pgn.11
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YK3x/89KAQUsGvZ3S7h62zS02azwWOQh6bgv+943HtI=;
        b=Dd0EogsF1JjZEmiyHUIDgwuFcYPnjXoFg/hD19coAuzuyHm5z8WH4u+9yixkQrSucK
         z8m3g4/hIk5zazYtX2cKMkuXe9W201AZS6B53/Z5pjavLOkMcroEPLKc7rvt5xmwhz6b
         HNjdSDF2sF8sTTD8ytRO4g/rjQ51Q4hKqD3wYfJGayTN0f8N8P66z5ymQUv23eo+o0tu
         YaKyQ8J0aIf+v2U9C/MIxwt9QdY5OZJ1wMdpDdljRPqieB9lyuhdEjDS+gzy/cAHjcTS
         tIRhEe3f8pmZUpeo2Umx6W7dGaGSlI2nymSP9aAqrxCGsZ7dgT/PCbXa3vgz9XO+zque
         YVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YK3x/89KAQUsGvZ3S7h62zS02azwWOQh6bgv+943HtI=;
        b=Gx4SWvyv8QI8INQ1YCHeI2WriZLxAunMIEVttZ2dlIutLDI8+wdW9s9nLvY7EDldSD
         psMEhjeI0F7cEhtYhGWeU7DASGEsYmHTiprbQtPAtud+wTFNSc4zD07gsMEryPGqY1T2
         gXjjVSS+vaiCRcFo4fMDXyrN6DBXCa1oH3GPlrAKWURQueRnFJkgNTvTP1swJPwqz0UB
         /Fiza2Utzl6kcBslHv+mcvCwv+juyGV6CwS3ymAjaIj7hxaMFQS4UKxGULl941HlDCNk
         6TPxe7IsV/dgPUromnS5nMxoDG7J/ZARH0J935hXHOA+3xQjA8US810wGf38FFygM5rX
         Bebw==
X-Gm-Message-State: AOAM533nVB+t52urm/+/nD2Qxu/rDllRg+2GsNSFJXccRrqs2SzRITb0
        i/WgIayufDdo+JPrnxmwZcbVHJUdH3qA01pbXp2CJGFU4GhiYXcB877CniNutbkyjW7Pbs/J2N0
        w+jn2nRpU/qCZkqaboaRlWBhx/pmzjnsvk4+YmK4uYIHymd4Gn9GLrLAfJ4foCyQVJw6LW9UGa3
        Mr
X-Google-Smtp-Source: ABdhPJxM6uWD7rETNbglp2FQJKa0dnaNpdvvA+T40TbxYwxX3xR7ApLRPrYoF5u5vJvZeKhlnyB6iAjvCLJQVoH7L0UQ
X-Received: by 2002:a17:90a:8909:: with SMTP id u9mr14024002pjn.119.1597693710728;
 Mon, 17 Aug 2020 12:48:30 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:48:18 -0700
In-Reply-To: <cover.1597693540.git.jonathantanmy@google.com>
Message-Id: <5120753ef9b67b9ef62f14f5d938b05afff87ec0.1597693540.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200814193234.3072139-1-jonathantanmy@google.com> <cover.1597693540.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 1/3] (various): document from_promisor parameter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

88e2f9ed8e ("introduce fetch-object: fetch one promisor object",
2017-12-05) plumbed through the from_promisor parameter but did
not document it everywhere it appeared. Add the documentation.

(It also plumbed through the no_dependents parameter, but I have left
that alone because it is being removed in a commit under review [1].)

[1] https://lore.kernel.org/git/e8f16d69089a5011c355d5939c56fa53b7a1eb2d.1597184949.git.jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.h  | 8 ++++++++
 remote-curl.c | 3 +++
 transport.h   | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/fetch-pack.h b/fetch-pack.h
index 85d1e39fe7..5e747daea8 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -40,6 +40,14 @@ struct fetch_pack_args {
 	unsigned cloning:1;
 	unsigned update_shallow:1;
 	unsigned deepen:1;
+
+	/*
+	 * Indicate that the remote of this request is a promisor remote. The
+	 * pack received does not need all referred-to objects to be present in
+	 * the local object store, and fetch-pack will store the pack received
+	 * together with a ".promisor" file indicating that the aforementioned
+	 * pack is a promisor pack.
+	 */
 	unsigned from_promisor:1;
 
 	/*
diff --git a/remote-curl.c b/remote-curl.c
index 62b3a45cde..0c1833dcb6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -39,7 +39,10 @@ struct options {
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
 		push_cert : 2,
 		deepen_relative : 1,
+
+		/* see documentation of corresponding flag in fetch-pack.h */
 		from_promisor : 1,
+
 		no_dependents : 1,
 		atomic : 1,
 		object_format : 1;
diff --git a/transport.h b/transport.h
index 1be4013dec..298d9eedc9 100644
--- a/transport.h
+++ b/transport.h
@@ -15,7 +15,10 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	unsigned deepen_relative : 1;
+
+	/* see documentation of corresponding flag in fetch-pack.h */
 	unsigned from_promisor : 1;
+
 	unsigned no_dependents : 1;
 
 	/*
-- 
2.28.0.220.ged08abb693-goog

