Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860E31F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeHIAkD (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:40:03 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:48940 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAkD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:40:03 -0400
Received: by mail-qt0-f201.google.com with SMTP id a15-v6so3007386qtj.15
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uYF8aNRKUBbAnZFfuL3+rHuuAFGVX/giushBKLq878w=;
        b=BcnaVDVhgVF9asobdbLPruqn/ork8uVA3BjjIp2GzztceqH/rcn6bnN9HN0T9VIA6C
         WOPsu5HAbGXEOz2YikJlixbf/bxl2GQRN12f0q8hYUG+JzgebM5RI0KcqUTYlNcKMzhm
         i5eBUKgEgU2HYKGQTBvsyWEhQiyOvGYWlDw7jMPG6RtWvE1MP+d93qFTqALXGFXbzJRE
         lC7yZehdOEWrBH6gtzagKlWIiKxxvbWBGkWdbVFzTEhCDBtQSS9eO8+cUNvv6vXFHiB8
         QLxKbKtm2m7bzgQN1P6AGkp+pQcyZDNrOKiJZWhi5npKPa2qBa07LMUyDakZ4BGQXtWn
         w0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uYF8aNRKUBbAnZFfuL3+rHuuAFGVX/giushBKLq878w=;
        b=ujoyUKuOKGAkWGKBBk2PKKxUlCQvAznxIQCtuEwdyQsIRTH9RRpHqe+sp4mdGv767s
         9ctXNtC6ksXai0pdF8cKIZMpeLuHRGopXFGLg9jWjKk3ANmpDDHqXgk50T63CfjBUghn
         EBMfSuGtd+jpmEDUyY3FWdWrMr3looPa8tYhJLNiIYzEUcpDA/XsaF8KykiALkxgXeZY
         Lkk5WzhCMP8SYF8Sph+A4RvT3U1NMNWYkWiOVM4u3zNS38R14ZFn8BOF7Y7l+TAeCRdG
         nkXFtEIrTn/RqvzgYO/wdscu3mdoPO8W1Opdkm65fMYlYct+MVhjSebdvX4hjCbLXGgX
         HBrg==
X-Gm-Message-State: AOUpUlE1IL58NpOnesx2C/A2FDiTI48xeZ0We0i1l1nf1bhFy3nFnAU8
        7a0evoSEH/q0nryFihupl2gSDn6Xyv26TAjLbHeVYm0MgMR1c/WEc7YsPJFRadtgTk3c88zBChT
        s9tseL/OgqvK2BB59hvio9jTQpPVPPHlyWPleSJqP2JchxfvqAoXAshlqY49s
X-Google-Smtp-Source: AA+uWPysWIXprYnI1wY1DjKluIF+8pL8cujKC77WVY2FLeKneLgi6WFL9lAEQAMJpU0vPMTVAktARiTWNpmH
X-Received: by 2002:ac8:1ab2:: with SMTP id x47-v6mr2403079qtj.43.1533766702584;
 Wed, 08 Aug 2018 15:18:22 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:48 -0700
In-Reply-To: <20180808221752.195419-1-sbeller@google.com>
Message-Id: <20180808221752.195419-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 06/10] submodule.c: sort changed_submodule_names before
 searching it
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of sorting it after we created an unsorted list, we could insert
correctly into the list.  As the unsorted append is in order of cache entry
names, this is already sorted if names were equal to paths for submodules.

As submodule names are often the same as their path, the input is sorted
pretty well already, so let's just do the sort afterwards.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index bceeba13217..89a46b8af50 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1255,7 +1255,7 @@ static int get_next_submodule(struct child_process *cp,
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule || !unsorted_string_list_lookup(
+			if (!submodule || !string_list_lookup(
 					&changed_submodule_names,
 					submodule->name))
 				continue;
@@ -1349,6 +1349,7 @@ int fetch_populated_submodules(struct repository *r,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths();
+	string_list_sort(&changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
-- 
2.18.0.597.ga71716f1ad-goog

