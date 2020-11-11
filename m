Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8276DC5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0A220829
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlGeh3z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgKKM2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKKM2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:30 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86451C0617A6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:29 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so2306062wrr.13
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I45Wez2549eUcVcvjzTBIh58pyxNIL9ydV8QhHpZrSs=;
        b=NlGeh3z8EQcJvNhAz4Xik48igb/CiGEubywqovfn38xD+2x+pw/KuY3F376fhVGJDH
         gJMsFgTIoIcn87BkETkKGtTZaRBC6P1OvIR33t37zrwT2uEHGQ+x6dDOz/hI3jJVhaKX
         A0QN0YMAz8YyWz16lWxQ0IUiFjFyKO5FDyHUYbe2YQDtoASGCKJyFGEjWJ198FnDhsk/
         JrdQAXvQC2Qun9+7Eqq/g6J30VGlTeauGIhQgM7HrYcgEDBuMHnvqGzg7VtXrWuo2c4u
         ShmdH2QYgDgRp9QIERbeBW/+ACxdFSOa2j69tiLEjztwmc4PuB7MLgYmXwv/F5TSAL1l
         lj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I45Wez2549eUcVcvjzTBIh58pyxNIL9ydV8QhHpZrSs=;
        b=ehf9Ppujv/itDGzbysudcE3ex6vLuNeu7cqFcuvtB/LFHbHHadsP6nRE9SN7tMdvmm
         HFllfsimJHmAWzosUhwWv8d957WGz51uTUeSWMMfMEherd5WaGV7REYknSsV7euPHrCd
         oOSNmZvDxqNLGQDEGnfaxVolF/2UxOhZP6tFKGHjHWz+whpG5Q2kyGYqL7UfF8YthRcT
         d0QmdoXHiE1hPzuuu0OL+GC1ioL7nkeZbcdoZAmvyadb7NZL55yw8yW4CN/kvDupTC1G
         ASYmcoyGJy5PQiqxVpbicIYS1sN9WSJQSSSy2I6qWVlxzmejoWMR6wU0wua7BWnLE4V4
         V16g==
X-Gm-Message-State: AOAM533nnfa7FC1q1A1f6sg4Xv11HjQSIkEE4Q3fFn7wITeQwoAPZgLh
        rq2JmzZbNADrARyFwx7ztcf7LwNGK6U=
X-Google-Smtp-Source: ABdhPJwQnV6r8kKonI7gFv89ovFGL8F+MvYWjIVDvG0Ra4zwWRNtMkDe8acN5V4N8wSpPcTzJOhcSQ==
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr26246001wrp.142.1605097708170;
        Wed, 11 Nov 2020 04:28:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm2536656wrg.95.2020.11.11.04.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:27 -0800 (PST)
Message-Id: <98deb538d91ba0ab485fa8d97cc6062bcc680938.1605097704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
        <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:16 +0000
Subject: [PATCH v2 03/11] add -p (built-in): imitate `xdl_format_hunk_hdr()`
 generating hunk headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In libxdiff, imitating GNU diff, the hunk headers only show the line
count if it is different from 1. When splitting hunks, the Perl version
of `git add -p` already imitates this. Let's do the same in the built-in
version of said command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index be4cf6e9e5..b6d53229bb 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -661,9 +661,14 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		else
 			new_offset += delta;
 
-		strbuf_addf(out, "@@ -%lu,%lu +%lu,%lu @@",
-			    old_offset, header->old_count,
-			    new_offset, header->new_count);
+		strbuf_addf(out, "@@ -%lu", old_offset);
+		if (header->old_count != 1)
+			strbuf_addf(out, ",%lu", header->old_count);
+		strbuf_addf(out, " +%lu", new_offset);
+		if (header->new_count != 1)
+			strbuf_addf(out, ",%lu", header->new_count);
+		strbuf_addstr(out, " @@");
+
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
-- 
gitgitgadget

