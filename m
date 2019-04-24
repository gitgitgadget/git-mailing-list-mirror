Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030781F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfDXWrG (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:47:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40414 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfDXWrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 18:47:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so10036450plr.7
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 15:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J2vuqzzG3upXc10i7/iQLq6AzRVhy83EjkO8wxrcPVs=;
        b=DoKBDLrMlbb6DVutmN5/ybw3Mhsl2XlPU6CvHuMfHrzSZH4MjdWGif6zJO7LkYTBhe
         tq1SM0ekWv/jOpyxXrXl/vekCaVPUIcbx5SzSQZ4x7YUJHT67F3VjHZ+wT8a96HlnBaV
         cTf5HFv9C2bkIZJFntS47e0Fr2dxoLM/gMJ8FEBgAFPDh3dIoRibZgOLUJmyXTCWETWU
         Qv6svWkP8JlV+GN3YCYNfvDQnXxeJG7/R8hcOPVaG6xJwsToeOOug4E6QEnWPqvTNM4o
         xDmX5HYyeSOyo8AHdz7rcalIyTbJ6GJdNgRekSHIfys/8zVaSz2Ug5BDofDdn62bQE3m
         OkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J2vuqzzG3upXc10i7/iQLq6AzRVhy83EjkO8wxrcPVs=;
        b=PvlDT1VP7gO/Kf8+/5xnmHGZ6XIEyxvP5xJTIJhGnTS5Ojo2GcUVCdamrYUf+lx/r0
         zmVYq7DWthukbr7iEqk5MrJn6dV71RUuIT449eaGyi941NkeESxheI0Nb5c2uI28p+H4
         AI8FLdCkh4hYgF53985OiyW0emgcqZe6558wSqiO9ZfIxYVM4Xq0RXAuyCZEP3c8A4X9
         4wa2wvS1JUjMRkhLmUnq+4gX9Rq4IAhsgUJ0Z5hNV/XKoDeg8OXz5fYgTDR8e5HQFfH+
         6UX0HpsavGydqqMQ+se0VjPJ3LKOrp8tAk1SSof6+ueKWS1I/jaLZ4QjQXiPeGQ2d6Z1
         9HEQ==
X-Gm-Message-State: APjAAAVUNAJRubLHyHfFCWZkUgethlwXD5iyNjPzVEvShWlIKKWFvjie
        G3b0OKZhODFPXvsIW3r+EjokbGqy
X-Google-Smtp-Source: APXvYqz0Ra2kza6ZAPDdpc7O0HidbRDVyxBZ2uiei7hHGxUQAFPTMA6DjNcXDv99nhXgdYOxxrU+Vw==
X-Received: by 2002:a17:902:20c9:: with SMTP id v9mr35145690plg.239.1556146024828;
        Wed, 24 Apr 2019 15:47:04 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id p128sm37453968pfp.30.2019.04.24.15.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:47:03 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:47:03 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/6] difftool: make --gui, --tool and --extcmd mutually
 exclusive
Message-ID: <bc3e2291714d48d0fc8c420c7cb54219c251887d.1556142510.git.liu.denton@gmail.com>
References: <cover.1556009181.git.liu.denton@gmail.com>
 <cover.1556142510.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556142510.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-difftool, these options specify which tool to ultimately run. As
a result, they are logically conflicting. Explicitly disallow these
options from being used together.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/difftool.c  | 3 +++
 t/t7800-difftool.sh | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a3ea60ea71..65bba90338 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -731,6 +731,9 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
 	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
 
+	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
+		die(_("--gui, --tool and --extcmd are mutually exclusive"));
+
 	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
 		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
 	else if (difftool_cmd) {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index bb9a7f4ff9..107f31213d 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -705,4 +705,12 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'difftool --gui, --tool and --extcmd are exclusive' '
+	difftool_test_setup &&
+	test_must_fail git difftool --gui --tool=test-tool &&
+	test_must_fail git difftool --gui --extcmd=cat &&
+	test_must_fail git difftool --tool=test-tool --extcmd=cat &&
+	test_must_fail git difftool --gui --tool=test-tool --extcmd=cat
+'
+
 test_done
-- 
2.21.0.1000.g7817e26e80

