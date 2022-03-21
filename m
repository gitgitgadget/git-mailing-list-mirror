Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C394C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiCUXKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiCUXJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B460450051
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m30so12816598wrb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2p6bfiW5VuLcAUsQl7oKZ4SFXFoVeZ7t5xiC+0hs1s=;
        b=CF39FG3Rcu+68ymLSsHICiBOSbqziCoo/tidIjOtzJTehztHEnEmB4J7Dyyklwj+tb
         CsKmiRNMfkGZTIfMk1pTEzeSZk7UwOo5QkPiOrX7KeBSoEi1v1wcxa7tJUgZG1NOr+Rh
         +h83dx77eb8mTaSgnc3QISxGFwJtiATo5vtfFLCfgQizBfYVo1BG8Ba8BEOIegQ6gXGK
         ZrcZc9XY7wdPi9eBahpZbXziQkZbuYfmwcHtQAmDiEL3Q0/P8tcfJUaWFtuMLGCPSbSq
         HaClXCwYd7T+iELbo9GMfEjCI/eL1oo6F2bO23/bQub34G00dPNL3kdaJz30fEcMYXFM
         WxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2p6bfiW5VuLcAUsQl7oKZ4SFXFoVeZ7t5xiC+0hs1s=;
        b=UsCqlzHbDhbHiUN1BEMNTJZpQ9Scq3LeMbPLNE+mkV0Z0qEgf7r5A8zfqnLIewQSq/
         /6sx82ySY+Kk00pvS2ldyv7DCyXQ+XBD7plzP0uPgRkyHeVv5Xl6RykvmkODqPvqG6iP
         EwrySjgT/d0Hlq9aNeEcVOfl7DYb6Fx2OKqz7/9cJ/5OfNx0+SGtTwkUW5utIrReGI3i
         NJRfXpCZnEOBneDhQzFkXWRUpzryjfYiimMcfACN/tYwGWSIDVmq96uOP8H55ebrdsrc
         DjE8Mpg1UMEYvrJk6HxbeI917+ensdkG/IM1BjxR3sLuuNNVN3LeEULiQ4sFoirgrXnl
         nvhw==
X-Gm-Message-State: AOAM5308p0u3s6nL0pE5V0yU1e5q166TCPYW/8XZPbzs4sZOb6v8ywOU
        hi6BGFwVYOsvEzDJ0Aznn9EF+kVHaZY=
X-Google-Smtp-Source: ABdhPJy/PnrCy6uuetKp/3Fgit0G8KiSHKJ7OpC4bvnWKoJZDSsG9AT+keilsIVLiH+l+srn0HSJAg==
X-Received: by 2002:a05:6000:1685:b0:204:483:77ab with SMTP id y5-20020a056000168500b00204048377abmr9674197wrd.295.1647903345735;
        Mon, 21 Mar 2022 15:55:45 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:45 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 05/41] commit.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:47 +0000
Message-Id: <20220321225523.724509-6-gitter.spiros@gmail.com>
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
 builtin/commit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 009a1de0a3..13af49fdd2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -496,7 +496,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	}
 
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
-		exit(1);
+		exit(EXIT_FAILURE);
 
 	discard_cache();
 	if (read_cache() < 0)
@@ -1081,7 +1081,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (launch_editor(git_path_commit_editmsg(), NULL, env.v)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
-			exit(1);
+			exit(EXIT_FAILURE);
 		}
 		strvec_clear(&env);
 	}
@@ -1785,12 +1785,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 	if (template_untouched(&sb, template_file, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 
 	if (fixup_message && starts_with(sb.buf, "amend! ") &&
@@ -1801,7 +1801,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (message_is_empty(&body, cleanup_mode)) {
 			rollback_index_files();
 			fprintf(stderr, _("Aborting commit due to empty commit message body.\n"));
-			exit(1);
+			exit(EXIT_FAILURE);
 		}
 		strbuf_release(&body);
 	}
-- 
2.35.1

