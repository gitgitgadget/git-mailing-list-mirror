Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8EBC432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6745B2240C
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH5X5iUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKSXzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:55:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44242 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKSXzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:55:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so13205841pfn.11
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hnwixFKlmn33rNHPEiOhaTj3B6JRS6BfgSY11clVH8c=;
        b=jH5X5iUG0p8LOH6ngrS/OnK5fOuFRg0MVzBWIBbduSNP9QtPYHBPzqkrZSRDJ22aVB
         SG2qORFEj34D4Y4Yu57PP8UBE2oP0MLlbEJgm+7AByQnMHUZHy8EDBDgVOeoZX6sWBeS
         d96WwPWE6x+50n0lGUvWf5Lf9+n87e4AteuLwMPr1iP672j84gRJlNgi/QhTk6HUKrJg
         DM1JueOgGZcyDoY5j/ZLM6zqTQoV5WRqzK1nNa+djmIKYiDctT5X+v1cZfng9skpW+52
         6PQGJpQmpnqhSgKVjskh92mSsN7vm71RiGTauu326QfVKWgyoBTIa0trKa0BYHePKgUG
         yjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hnwixFKlmn33rNHPEiOhaTj3B6JRS6BfgSY11clVH8c=;
        b=Wv6GbuSkOdNvijsfiFeaMQZn04A9Y7fPgev0vxZWm3HU8L7BpXe2npY+7nfrv6dbjH
         4e1p/zIN/EqEX7Louug+bxs3zBco7mRVGYpREFFKACRWnsrQXuWuxVo0ph8o7uuO7T8b
         i3my0+O4CMqUDxuCbA98m514GutLo4AuG7HjFzz6gNjYy1aCBc8vyYTMPAd8+G6SLmcH
         9mdEooqp0HVZzb2dguSYf21XgOCnRsKAOPRDjvWkiDgvU9Xxf8DyU8KCNMZyHR1NpHcq
         DW2Uv8w4ILnjZa3VkkucbZae/BQV+pVI1u+ADbISWV3sr13J3wnJZ+DNsIvRONUTXVtG
         e9Yg==
X-Gm-Message-State: APjAAAWLHQyuqd8NRxn/+JzjmJ1JzVW5kjogjppg3ke3nFhdZ3docwi1
        J4sJhiVvVxJDp7swlY2YUP0zWGpZ
X-Google-Smtp-Source: APXvYqzqsrAxHSR8ClNmQMzgtjYwqdHM3dZDeaD0sKFGGQWk7Ufg2wcrOIm1Hz9TGRkVrFg6GgNQow==
X-Received: by 2002:a62:7643:: with SMTP id r64mr313418pfc.191.1574207736951;
        Tue, 19 Nov 2019 15:55:36 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id z6sm4855546pjd.9.2019.11.19.15.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:55:36 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:55:34 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/8] t3206: remove spaces after redirect operators
Message-ID: <16a90b70638b100afe4b7d68c0db20ffae7ce964.1574207673.git.liu.denton@gmail.com>
References: <cover.1574125554.git.liu.denton@gmail.com>
 <cover.1574207673.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574207673.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For shell scripts, the usual convention is for there to be no space
after redirection operators, (e.g. `>file`, not `> file`). Remove the
one instance of this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3206-range-diff.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 0579cd9969..87c6c029db 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -8,7 +8,7 @@ test_description='range-diff tests'
 # harm than good.  We need some real history.
 
 test_expect_success 'setup' '
-	git fast-import < "$TEST_DIRECTORY"/t3206/history.export &&
+	git fast-import <"$TEST_DIRECTORY"/t3206/history.export &&
 	test_oid_cache <<-EOF
 	# topic
 	t1 sha1:4de457d
-- 
2.24.0.420.g9ac4901264

