Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC44C33CA6
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A602075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8/2yFxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgAGExi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45942 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgAGExf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so41566916qkl.12
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5XsKrkMwUUFBH1wMuXh1KUK9uMITCm65kS4SjYFPEM=;
        b=d8/2yFxa6GlY+vpHgvHQz/whfKslA5VE1Zs235omyGTQH8Swij9oCumsjuIX8S3NZP
         2r762a5K6uBmtY89XP4geFQq0b6qcnklBQZoccPaTCj6hJGhXMq5BmuAKsXHgYEi+8zs
         n0IlNxiG82SYsh3KVG63qYwoPWng2UrOIkVB8gT01gDmTu6Oi7gz513HTt3bK49l2pax
         QLOuSd/WA2PSKRpso7FFjqakqS16Sp3ULXFcjMKWCip/Rw5pfF6lA6AKnEzXdf1X29xn
         tX32Jwz5H7pl2JQ/q9+3JJgxXFsAV+8p7G/EFQyb0z4+6G71NO5+++AHHkL2Fe1/8gVs
         1Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5XsKrkMwUUFBH1wMuXh1KUK9uMITCm65kS4SjYFPEM=;
        b=B2xp25M1CfV0hbCZDnsRCl5vBuasNzngMFQF3cd84zf6AmaVQSiAuuO4Kn4MLahkcd
         YYKJ6YfQazKLC3R7i3iU1qit8CFQasCmQo6mZRwk2BiWX+Kag+VKYLA/mKH3VZY5mx1N
         xqIP4oym2fCx1GD9ZQapYLiAJy5j+5B8QjAswOJszP851Kw+nUITMozQcJKyouKqlJQ8
         mgQ3OWAEMZrT6PXCeJtscSnhKTLRihUNpyrSWGmf6KuT+dfKfjLlzYxSqrSs1dwxZRe2
         6DWLiQapMRF8AK5MABKGQKzMGaP1A6Yf0sgh3kv2lo+u7HTfmxDggbeFQq0BoEfZthC7
         CC0w==
X-Gm-Message-State: APjAAAWwXsiENAVap05jGNTfCI9orOg3MXOJ04Si3Q/+WqbqIX8at+5S
        gnub7F/3i2vdJv57iq8ELk5nHlrn
X-Google-Smtp-Source: APXvYqzGr4fR986WmxfH3W5EiXxHf70ONq3zV+Fnn1rKIx4//uO5mFdCOd4Tsct6uEouoh7AifG1XA==
X-Received: by 2002:a37:ba03:: with SMTP id k3mr83941897qkf.127.1578372814246;
        Mon, 06 Jan 2020 20:53:34 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:33 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/16] t3030: use test_path_is_missing()
Date:   Mon,  6 Jan 2020 23:53:05 -0500
Message-Id: <f0da1d63500ad8b3e3ee4c1ccb3bde2342a9ec42.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use `test_must_fail test -d` to ensure that the directory is removed.
However, test_must_fail() should only be used for git commands. Use
test_path_is_missing() instead to check that the directory has been
removed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3030-merge-recursive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 2170758e38..d48d211a95 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -604,7 +604,7 @@ test_expect_success 'merge removes empty directories' '
 	git commit -mremoved-d/e &&
 	git checkout master &&
 	git merge -s recursive rm &&
-	test_must_fail test -d d
+	test_path_is_missing d
 '
 
 test_expect_success 'merge-recursive simple w/submodule' '
-- 
2.25.0.rc1.180.g49a268d3eb

