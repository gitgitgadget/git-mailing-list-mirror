Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F391F406
	for <e@80x24.org>; Wed, 16 May 2018 23:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeEPXAK (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:00:10 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:33305 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeEPW75 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:57 -0400
Received: by mail-yw0-f202.google.com with SMTP id z195-v6so1091658ywa.0
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=33VkkJwRWAm8LuFVGGjNvQUAcJ+fvOZ+y86AxgwRoTQ=;
        b=dhq8wj2OwEcVw8wQz92hPFEKI8VUaYKEoYUkz3JKjVLu3TcXcJWNTJq77A5uuxAzCW
         jHyqUNcYn4Y1g1iINnXnEUtRw4BzxuHGAAT0O907sSflPLHyO/0/GqZ8lJzwiAJcbm3P
         qUE/Y9mFOjAJIMOrUu5IUtfL4mlxQ3sF0Hc5WD6PmyxjRM1GTXcERJhAObPtXkVipBUZ
         c4Mo+4co+Ks/SM96VTLO9Vpo/Z9dUcja1uD8KvAbuJcnfw6/7YhCC9EK5ZckK21j9P0O
         getzsRzMfWZLb2nYHpcrDlZDstBr27dQ1X7phdOvSBWaUXjy/xR4EHMP5ns/VEl+zvhq
         /+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=33VkkJwRWAm8LuFVGGjNvQUAcJ+fvOZ+y86AxgwRoTQ=;
        b=i3pmPRIyQnGaWYkcoAI78jodf1/w61fRUbC0zEXiOFbS6DmNYTfbsJqSo15C1QIiKh
         KFw86IVT3XWJBSnFYuJD7NrJ6mQd9N/vvKoENhmqPgnhmSUXWr5EOapPpVr96AaxbR55
         hAW6D9jYwV0N5ppcmGkl2R58ZCSjrcCULfAJUIByGzl+5dvyS/MXoglY8wWU50GErqQa
         FLRPjY9vWCtwalq8KH1ZotOXIu+PEIJUFIB9jmKWU7jbI3FmfhQVLZsxMelcVLsxU82M
         QjEtAr4IWkc9E47BT8aYbOpxe12ELQndi3jm3m6Skh25YcB8TJPNnAT5ifgikFDYe8q0
         B3RQ==
X-Gm-Message-State: ALKqPweghGTfHRMKt0nbTbO+Ud42moh6jTCjDvKWgKoXnog9tWw53AuH
        PEl0DakO5RfRBIshQvjIW1iq+FlzesySYG7k7BoyofUb1oWrSgcabkLL0SGhlzIBT94MfIhYDV6
        m0UTvjH7ZReR/Qt4WxZuuzg+uTd8kqoylzd5X976uAVQ5OxtDFR5S79FxeQ==
X-Google-Smtp-Source: AB8JxZpM9V2uTqRQSGMQeY89GTVHHN9bksWw++3bfaatIwZ+WMG3NSpYEbWfjKxFbRwUfx0+82iyTO6j6Z0=
MIME-Version: 1.0
X-Received: by 2002:a25:9b42:: with SMTP id u2-v6mr955393ybo.62.1526511596476;
 Wed, 16 May 2018 15:59:56 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:20 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-34-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 33/36] http-push: store refspecs in a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert http-push.c to store refspecs in a 'struct refspec' instead of
in an array of 'const char *'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http-push.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/http-push.c b/http-push.c
index f308ce019..a724ef03f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1692,8 +1692,7 @@ int cmd_main(int argc, const char **argv)
 {
 	struct transfer_request *request;
 	struct transfer_request *next_request;
-	int nr_refspec = 0;
-	const char **refspec = NULL;
+	struct refspec rs = REFSPEC_INIT_PUSH;
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
 	struct rev_info revs;
@@ -1756,8 +1755,7 @@ int cmd_main(int argc, const char **argv)
 			}
 			continue;
 		}
-		refspec = argv;
-		nr_refspec = argc - i;
+		refspec_appendn(&rs, argv, argc - i);
 		break;
 	}
 
@@ -1768,7 +1766,7 @@ int cmd_main(int argc, const char **argv)
 	if (!repo->url)
 		usage(http_push_usage);
 
-	if (delete_branch && nr_refspec != 1)
+	if (delete_branch && rs.nr != 1)
 		die("You must specify only one branch name when deleting a remote branch");
 
 	setup_git_directory();
@@ -1814,18 +1812,19 @@ int cmd_main(int argc, const char **argv)
 
 	/* Remove a remote branch if -d or -D was specified */
 	if (delete_branch) {
-		if (delete_remote_branch(refspec[0], force_delete) == -1) {
+		const char *branch = rs.items[i].src;
+		if (delete_remote_branch(branch, force_delete) == -1) {
 			fprintf(stderr, "Unable to delete remote branch %s\n",
-				refspec[0]);
+				branch);
 			if (helper_status)
-				printf("error %s cannot remove\n", refspec[0]);
+				printf("error %s cannot remove\n", branch);
 		}
 		goto cleanup;
 	}
 
 	/* match them up */
 	if (match_push_refs(local_refs, &remote_refs,
-			    nr_refspec, (const char **) refspec, push_all)) {
+			    rs.raw_nr, rs.raw, push_all)) {
 		rc = -1;
 		goto cleanup;
 	}
-- 
2.17.0.441.gb46fe60e1d-goog

