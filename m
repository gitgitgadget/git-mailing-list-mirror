Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98E2C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A000020855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMzJzSCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKUAqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45380 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKUAqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so660358plz.12
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gUuf5We69nsFsCt6sK/t0U/hn0TpTVvp9LecOjw11LE=;
        b=vMzJzSCf/aCT2868Gwj5UkarjhGk1ZwX337Th5AkXBZrK8UQj9a5pUqOOe/eDAzc/u
         R4M8sJIEbh7dqV8i9EVpcYBNiEkkQyVPfx0ChZbaA2jOJUwRn3vMPkio5O4CNb+RrOoP
         9D1MRhoiZzVMG5f7SUJN7Nf6Y8J37r7NO0U2QhJWkydJnpJFZ8bDVLJEux0VeaYRqc1g
         sVSNlNg8+9CmtijX5TBaciOZxlbKTwjJf5vdJgrzMQbyeGP7+hFfhHoRhNPMJDsXCStX
         sdOF5SRTzFEXgboSRJPY0YQikGEy55//rCX/eJfV3yrm6bSLiUCtsw1VbXX2o17uquaX
         vKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gUuf5We69nsFsCt6sK/t0U/hn0TpTVvp9LecOjw11LE=;
        b=BHcdiF8Hjtg6KC11XJLa6mwhQozw3r3b9FuLjrVCIiy/0/omZztap/uRgzZKdEJJvZ
         CVxuypjdgKmVzcQizPorX5BvtdILGR5EQYbX/XcFGjnpJE3gQ+B61bRdQaExeSXmL2ak
         CufJ6dJpBGjLOmPRv6BuO37YV9vvcJwThBTVXEIzfPRDeo4gE6qQlwmpj3UEWKCnja29
         U2bm/HZfZXNMXXYrygqT981HFZovOk3CdHGC4lpLVKXCHdwxCfehMIRKI7zq0dX8Ywek
         6FkL3/3ZIG98auCK1gsar1FBQHLoV864nra/T5X3SF2O2IURCtHAM8vIL2m9xTaXtVCh
         bikA==
X-Gm-Message-State: APjAAAVan+zkX2rz/3r/yOIOvWknDZuu2LvCYjVnrWNlIaAWnqr5QQLb
        HblFKrvLaCg51vP1EyM68YTQkVZp
X-Google-Smtp-Source: APXvYqzLWFrPA3/APQwHvRuC4hz1XX3hkkng6XAauRKLLYB1bsRTDbFPe8Mgp5FK0OTNNrj0GGMPJQ==
X-Received: by 2002:a17:90b:4386:: with SMTP id in6mr7705759pjb.33.1574297176881;
        Wed, 20 Nov 2019 16:46:16 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y16sm606667pfo.62.2019.11.20.16.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:16 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:14 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 12/21] t5317: use ! grep to check for no matching lines
Message-ID: <b24745bd6059017358bf47e96ad9ce33481f440f.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several times in t5317, we would use `wc -l` to ensure that a grep
result is empty. However, grep already has a way to do that... Its
return code! Use `! grep` in the cases where we are ensuring that there
are no matching lines.

It turns out that these tests were simply born this way[1], doing all
this unnecessary work for no reason, probably due to copy/paste
programming, and it seems no reviewer caught it. Likewise, the
unnecessary work wasn't noticed even when the code was later touched
for various cleanups[2,3].

[1]: 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
[2]: bdbc17e86a (tests: standardize pipe placement, 2018-10-05)
[3]: 61de0ff695 (tests: don't swallow Git errors upstream of pipes, 2018-10-05)

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    Thanks for your help, Eric. I shamelessly stole your message text for
    the commit message.

 t/t5317-pack-objects-filter-objects.sh | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index a8bbad74e2..dc0446574b 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -45,12 +45,7 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 	git -C r1 index-pack ../filter.pack &&
 
 	git -C r1 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
@@ -149,12 +144,7 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify blob:limit=1000' '
@@ -164,12 +154,7 @@ test_expect_success 'verify blob:limit=1000' '
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify blob:limit=1001' '
-- 
2.24.0.450.g7a9a4598a9

