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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC7C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C0320855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7F4RYTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKUAqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34241 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKUAqG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:06 -0500
Received: by mail-pj1-f68.google.com with SMTP id bo14so634912pjb.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=usYyzmvF1o2T3T0ZUlzmeeZUtmv5A+AZJd7/dTPgxZU=;
        b=j7F4RYTSDhPS8e/zVh00RpYJq9LDTG92yAId5+Qq9uimg4rTTxS3gl5GNOPG73qZmd
         NVSXkCzl7odp2H+oBo7h3ZtbzczNr8IgzcqWc+ex0OhAkYEozAMb+pHd3q/6ppVv58qM
         HYBse116ZUEejXk78Tdfb5y4rKrGimK1CRBOXD5OXa7KkogvRJGENsUS150hY8yeO7+E
         zTRgtWj5axkCPxn8dcUnNogmghrGRS/o69W+43fTfOkVVHRkeS3zcO5SR//qZCrZ62oc
         rBzNJWGmjWZyzd4OsM4MwqhFZNZSEIbXwmhB0Wt5ZKdLsD8P7i1oi8QqzQcsjb2C4e/w
         StKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=usYyzmvF1o2T3T0ZUlzmeeZUtmv5A+AZJd7/dTPgxZU=;
        b=ry/Nv88DJ0C7mc6u32Kh7942bFw30apcsIVSbYO4OwlgYLtufvWtZ9b5t6cXs1M22J
         KEe7j0lxlI3N5GffjeQhSZIjkdXK8D6eNPVcxUDt/iY5mh2M7ebf+XV3SgAslnFLShc3
         mHEjsfjvcJ5BfU+MJaj756QJt7ANe06gur4AbRxUBznsOy5FE7lwAfzw9xjqWUIeRDHL
         ID/1L1enQ9AI5tw41CesAzZkp2SKWMhMJ8JKY4tOPTsCl9U7WjSBbjQkc40/5awRz6V3
         2s7g/KTS61v+USaRI0Ux9KUQq/FKYGYyPw2Rcip5ymSOuu3/mD9DMtDUTaUlPcOgpJ9X
         3PQQ==
X-Gm-Message-State: APjAAAWIr4deM31dVgPZXc5PndHbLzoC2bVGKm7tSEG+/qyHPig+hvjC
        VfbdGTASqoPV5S4UJukPyjna1zsT
X-Google-Smtp-Source: APXvYqw2f4FFTWCf7LYo5wj6wI+ucZwwwyqGDudKf0189ymZi4iZ7JDW3c2J1ZK2lGq+ylYetnv2Gw==
X-Received: by 2002:a17:90b:3007:: with SMTP id hg7mr7870317pjb.73.1574297165221;
        Wed, 20 Nov 2019 16:46:05 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y12sm445694pjy.0.2019.11.20.16.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:04 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 07/21] t3600: comment on inducing SIGPIPE in `git rm`
Message-ID: <54e9e78e0323c7fad8ced40fbc7ba4236dd61056.1574296987.git.liu.denton@gmail.com>
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

Add a comment about intentionally inducing SIGPIPE since this is unusual
and future developers should be aware. Also, even though we are trying
to refactor git commands out of the upstream of pipes, we cannot do it
here since we rely on it being upstream to induce SIGPIPE. Comment on
that as well so that future developers do not try to change it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0c3bf10edd..0ea858d652 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -251,6 +251,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 		echo "100644 $hash 0	some-file-$i"
 		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
+	# git command is intentionally placed upstream of pipe to induce SIGPIPE
 	git rm -n "some-file-*" | : &&
 	test_path_is_missing .git/index.lock
 '
-- 
2.24.0.450.g7a9a4598a9

