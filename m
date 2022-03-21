Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8384FC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiCUXKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiCUXIm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1550B0F
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h23so22040376wrb.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QY3RPZnbq3SHnb31nrheJajcr08F9gHfIHpZoxfsMTI=;
        b=dMB219Hvf+CW1mso8K16QMxeRbzvGfvB4pzprijA9ADBXg/Arnr+9M696ok/KLP7Yx
         Vklhw2NMpxBWwNJAmS7jZ2ZlcAUSKgVHDRsZCHIcpb6isr95c1Gg8evmj76Mgrf/oCop
         hjBZ+9WdvmG+dbGa877uyJw7viMKQxz8U3azjJIie6lazOBQcIdSIuV19Q+f4TJr57AW
         ImV02hx6QwDyiBFNKa71XVkND+5TDl9AC1iVlnRog6hFKQbacvjjeqwDvAsTCtcoGizN
         2Wf/yCa15yOaWavGpHqjKGofT3Dabg/CDb2Fv3x74VA0Pbt6BylgK960gIn3c3YVP+Rw
         H5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QY3RPZnbq3SHnb31nrheJajcr08F9gHfIHpZoxfsMTI=;
        b=k6aFCRNxUYinqYzQY0fbEdEHspFNRWgp75EK3JhzIjuwnlTQs/5hECo62pr8SjgDsY
         9DO+KWATgOvteWnWIiRLy+1fvARs4TC1nPvhgldaAyTy28nY7Qi7NLDiew4A1Zoqn+Cv
         L6eSoxE67hWma17b8MDfmDC3K2oi4BQ7YFDXsaK5MjIyFrmnnqONL5Ukp/qHypZP+VSS
         wGGsWnl1cXZNwnqa1+xJ6KeHcEhwaIxM9T/gi+mCXe/0kIuYjon+uWTodkQcW8jr3kGc
         YOp5vTPBpmv+k5FfXNm619Yxfip0npgIAhYozQs5eJr2blVVw0RLAhgg0A23+t7Nj5KO
         XYcQ==
X-Gm-Message-State: AOAM533oqsj+aW+FG45v4PJ+M5c4NW0QSRpLlouufooqkGIyk/4nzJ6C
        391fPcOzXTRdRucpkQEO48HbEtUU8fo=
X-Google-Smtp-Source: ABdhPJwQgW9pyCe7V4ICWyelfzwCzQvn0WP6wkazYB5KdY6zlfFX7CltUBiPpHovyDirbVHwvzsV9Q==
X-Received: by 2002:adf:ebc7:0:b0:1ee:945a:ffb4 with SMTP id v7-20020adfebc7000000b001ee945affb4mr20346143wrn.641.1647903366522;
        Mon, 21 Mar 2022 15:56:06 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:05 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 27/41] git.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:09 +0000
Message-Id: <20220321225523.724509-28-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git.c b/git.c
index a25940d72e..7b75e6e720 100644
--- a/git.c
+++ b/git.c
@@ -158,20 +158,20 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			else {
 				puts(git_exec_path());
 				trace2_cmd_name("_query_");
-				exit(0);
+				exit(EXIT_SUCCESS);
 			}
 		} else if (!strcmp(cmd, "--html-path")) {
 			puts(system_path(GIT_HTML_PATH));
 			trace2_cmd_name("_query_");
-			exit(0);
+			exit(EXIT_SUCCESS);
 		} else if (!strcmp(cmd, "--man-path")) {
 			puts(system_path(GIT_MAN_PATH));
 			trace2_cmd_name("_query_");
-			exit(0);
+			exit(EXIT_SUCCESS);
 		} else if (!strcmp(cmd, "--info-path")) {
 			puts(system_path(GIT_INFO_PATH));
 			trace2_cmd_name("_query_");
-			exit(0);
+			exit(EXIT_SUCCESS);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
 		} else if (!strcmp(cmd, "-P") || !strcmp(cmd, "--no-pager")) {
@@ -318,7 +318,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				for (i = 0; i < list.nr; i++)
 					printf("%s ", list.items[i].string);
 				string_list_clear(&list, 0);
-				exit(0);
+				exit(EXIT_SUCCESS);
 			} else {
 				exit(list_cmds(cmd));
 			}
@@ -900,7 +900,7 @@ int cmd_main(int argc, const char **argv)
 		printf(_("usage: %s\n\n"), git_usage_string);
 		list_common_cmds_help();
 		printf("\n%s\n", _(git_more_info_string));
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 	cmd = argv[0];
 
@@ -920,7 +920,7 @@ int cmd_main(int argc, const char **argv)
 			fprintf(stderr, _("expansion of alias '%s' failed; "
 					  "'%s' is not a git command\n"),
 				cmd, argv[0]);
-			exit(1);
+			exit(EXIT_FAILURE);
 		}
 		if (!done_help) {
 			cmd = argv[0] = help_unknown_cmd(cmd);
-- 
2.35.1

