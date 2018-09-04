Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD08A1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIED33 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:29 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38785 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIED33 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:29 -0400
Received: by mail-qk1-f202.google.com with SMTP id 77-v6so3717232qkz.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MpCLxiXXBghFmwJoodVIDFlFq9F4uakR7UWHwlxu3Pk=;
        b=RtxZLIDH/sEM6DHxmNNqs5ehBYlIJZKZSiD32AvtL6cd5e/hur4mlK/zrrR/swWBWM
         th+Bb7hRECCs/dJDmVb+b0d4DpWimSIb6vZBygRKJG7GlQ/DG9Rtp43DvGUC+4QljB+Z
         qnPFIx6ju/9u3FfIAZjC+UvYMooV56J1GV3YSQtvhU8IMUnk4/njvPZ+d/A450O6K4/X
         jAZuvJaVqHKhOzdhPloqAlFrrJBkPqu96CaoGSIMdPKvIZ1LiyNvw25y1qvJUiyoYObr
         0FtlbAgt/gcCUiDYoczhsbx93RPadUKHv1gI0F8otJ6yhdFYfdC21xqmRp0v0XdtkPnS
         MnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MpCLxiXXBghFmwJoodVIDFlFq9F4uakR7UWHwlxu3Pk=;
        b=sY0TwDoXtUQE0vkw4WYVWOiM+wfdk52P5ZaJw2nChbmcHRYaeOLo1NKZgF9zDphzr/
         63RXb6Lj0ADb9Y7Lmcqlo8ueY65rGjbTPOZ0PppyI1ZYZEC7RwLbK7Z7NIgXEHACJ8WI
         9gQeR2uWLx+T0YkUwMVJCkxiLgue9AQl79WotIhQKrhwjyrJZR7mKDfwdvv4O/rXdAcT
         MoMRYZjWZJNi546zZrsNs5y1VSFpy7MntzjuyQHRArhUXG7ygbq3jaJHYUehyies50Hi
         rOyUhnBalQeOIil09D7tJ9S75e1Kz+Nea6MHhrFKsDez5H7bf2mDpYj3Ysk556mg127J
         xq8A==
X-Gm-Message-State: APzg51B9izE56nUhY5pmQjkjdxz1e8PlzGlFKCv0xqJiBPK05SpJDjOY
        hWaxfoNkZReDXnR2cIfMbHHr4AoEuHPSSTFJxHI6ci5mMDrTpxWc1jesJYAZZDWV7b81Vf8T6/b
        UANaGL/tCsQ7iGPr3pYFPysN82Rkr+AQZ73tD4MvPQah4VZACa+OlV4738GZS
X-Google-Smtp-Source: ANB0VdYRYoQYa0oBCC1y/3vSGY0I0MrvzeGuJetOeHnfeD/yh28Wi73T3PiIjMlACEj5APyUlUjQxsGG1IQe
X-Received: by 2002:a0c:d254:: with SMTP id o20-v6mr18326151qvh.35.1536102131645;
 Tue, 04 Sep 2018 16:02:11 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:44 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 06/11] submodule.c: sort changed_submodule_names before
 searching it
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
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
index 8345d423fda..8bee455137a 100644
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
2.19.0.rc1.350.ge57e33dbd1-goog

