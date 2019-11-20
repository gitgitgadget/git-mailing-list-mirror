Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD92EC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8432D208A1
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV81E/DJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKTVSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38695 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVSj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id q18so395016pls.5
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ur6KdM4pG0VbrIOUonCcng9RoCMhYGLp0D5rysZWvIo=;
        b=eV81E/DJfrSWa2lQOrCumBPy255YW8GfuCapYw06pm3Ja6u10HTHb//gNtX7Z1wS+o
         OcnYr064R2rTSGPdvo8XjL+TGVX86nTedwSCiNjcNBz4iVJAO7VZUKivarrSWEFoEBDQ
         mHCttphS9bKA7tnaK9bs8WAKQwDkH2ooJgOq4KSm3rheVFRa0/cgng7fSdemc62/fMli
         0V5oLtznlFrEv5QHV0TQAu/Bx15h0WH8I+NtK4YM8cY21UAVpAzhF4EgSep/kVkWxbwo
         sFobioh3uB5A+Dkgb9HkCwqtMEltQWhF0T5bYhaTsQZqk1KpRZx4KCPSajQl0enco06e
         QBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ur6KdM4pG0VbrIOUonCcng9RoCMhYGLp0D5rysZWvIo=;
        b=E+Y4vu3ZCyHtak/ERL95TQTpy4MmEcQzgNWtv0P7UOR8Ar4PY4lCXBU0WOolxrL4ug
         hK9Se78VjCcqCrsu+YlpfkZ7wLva7IOEQ8wARVP+LEHKXJctWKRjmoJ5S5VvRVBxuMtI
         KA1pOnhc7ulIOe++Co+TKl29il6mD2d4JdigYbfZ3rwx56wVHIACStCcbDUFz+0FLVcH
         zrnScgENWs6EnLQbR3tNd5d1QpFoEjQOLvu+t6N6CkAcPFfBITiV8l/50kVQZLumgzml
         eYbLGbPTusB8kXZgZhrQzF618ef9OFWhXePwyCV4NwQjm8RnhzjIJd2QlRQ/oLornDym
         +SJg==
X-Gm-Message-State: APjAAAXHNrOcFF8pIXZdzkuvUyOYQMNmdwxSnPgdtipuTuRYQvO0n8+y
        o2xEdm7p9ZnFwL7Q+36FfyKOwQe2
X-Google-Smtp-Source: APXvYqykN200GrgCsbD3zSf0fO4hWqx0TDcchDlds0GUk0P5TiORc2xJ7m6vgrOy6ym47wbjwSyBJg==
X-Received: by 2002:a17:90a:f496:: with SMTP id bx22mr6747156pjb.101.1574284718281;
        Wed, 20 Nov 2019 13:18:38 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id a26sm299865pff.155.2019.11.20.13.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:37 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 05/10] t3206: disable parameter substitution in heredoc
Message-ID: <855a3df542a63ff77bd7164a4a7aab6d3b0fa447.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
 <cover.1574284470.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574284470.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the first heredoc, parameter substitution is not used so prevent it
from happening in the future (perhaps by accident) by escaping the limit
EOF.

The remaining heredocs use parameter substitution so they cannot be
changed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3206-range-diff.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 87c6c029db..41606775d4 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -9,7 +9,7 @@ test_description='range-diff tests'
 
 test_expect_success 'setup' '
 	git fast-import <"$TEST_DIRECTORY"/t3206/history.export &&
-	test_oid_cache <<-EOF
+	test_oid_cache <<-\EOF
 	# topic
 	t1 sha1:4de457d
 	t2 sha1:fccce22
-- 
2.24.0.450.g7a9a4598a9

