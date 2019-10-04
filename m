Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 437E61F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 00:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbfJDAXQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 20:23:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44308 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbfJDAXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 20:23:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so2271687pll.11
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L5Veb6eK24CErOvl/SEjJY+U4Vv6sP9jwxQoS4Rlzb4=;
        b=rUuMNKyMMLhvUhkQJLvGUh4w8UB+ITr0BRdZsU8WR2kuITfdyXAmsl8wMxQU/sdh34
         mgvfZH0QHuBHl98shefawCNqNfahoWHMsn8K/M+Mbbg5+lYTqZsgAZZCSHM0pZU7AOgi
         GbNnBc4W+TXdaUP1ZJQFNMNiByCkzhdPG6xdKqJ6J8Apc4MKizz/sxKkjv9ox6804JIw
         eB05jTcWFcgkuV9PJB8o4TZj4NBjo6u/sP5Yd84HYkxJjtVAtJkBPzfc59VqQhJqKzc2
         t4spifgsJbPgwTkBVv2PFEzMmNUkBKDzXzyI0mkdtYe8RDDCDYd/GcsZNnoDglsg5W/N
         zXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L5Veb6eK24CErOvl/SEjJY+U4Vv6sP9jwxQoS4Rlzb4=;
        b=r7Mcu8DcSlED6+YQQIDrbRxpnwNYER+laoR5GLxhltZJg28sQ03xNHyzuJSUTIAudW
         RtC9e0MDPqe19NJ5m8yHHRVdFF40pB0CR0tiwR3eXxK2I6cyn9f8PWRmmtQLH0uvqZ6m
         1pw5owR+al0EdmcVePOiCpaPloFCiTkmFf6iRtMXr2tHsXsSNwrfUlVK92LDRdEhq4MY
         Kdf5MHK7gHSqR62r2FsrOHLrVrG94T3mXZFkMORvu79FD5wvx80b4483Te6LNy8JCXHN
         Uqa+NPRT4OCqz6aYsMyVoAEKo4ayweOFUkRtSK2etnJpmGFjxthNkkFSZGRVPeH4vvLi
         aLUg==
X-Gm-Message-State: APjAAAXaB3S0/B+8wihNvGvRk+l3yFRQNXEDbtVzCznO9KmXVWr8YemC
        s55WmSuavc9B/Uo5osyf0IJGEXRC
X-Google-Smtp-Source: APXvYqw0tAFuPdtym1M8fveOuTd9XstxpZzH9svqJCb+gP9qDNSzuBV5ZDzXSMWEPGfDOIUbcWlnaQ==
X-Received: by 2002:a17:902:7001:: with SMTP id y1mr12033934plk.49.1570148595199;
        Thu, 03 Oct 2019 17:23:15 -0700 (PDT)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id b22sm4770838pfo.85.2019.10.03.17.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 17:23:14 -0700 (PDT)
Date:   Thu, 3 Oct 2019 17:23:13 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] test-lib: let test_merge() perform octopus merges
Message-ID: <e77af8cde5380c3ba43f074232a50a262ef79791.1570148053.git.liu.denton@gmail.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
 <cover.1570148053.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570148053.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently test_merge() only allows developers to merge in one branch.
However, this restriction is artificial and there is no reason why it
needs to be this way.

Extend test_merge() to allow the specification of multiple branches so
that octopus merges can be performed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/test-lib-functions.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 87bf3a2287..b299ecc326 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -228,9 +228,11 @@ test_commit () {
 # can be a tag pointing to the commit-to-merge.
 
 test_merge () {
+	label="$1" &&
+	shift &&
 	test_tick &&
-	git merge -m "$1" "$2" &&
-	git tag "$1"
+	git merge -m "$label" "$@" &&
+	git tag "$label"
 }
 
 # Efficiently create <nr> commits, each with a unique number (from 1 to <nr>
-- 
2.23.0.565.g1cc52d20df

