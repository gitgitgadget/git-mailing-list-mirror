Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD9EC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiCUXK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiCUXIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB734362D28
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so369080wmb.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mu/Th0tGJOW1Vp1fsRYv6sLwO9GVl//Pif1H+pKAEMQ=;
        b=MlUTeCKXSNfYWp/hlYJYnOD5AqJ1r7S/AWpidk8az35BFUkgSwGR0TPrBITEwAz2Ki
         CRi5F/2zO7ctrpdSWI11soM9JOpQzhYgx5WZCUq16M3qlsHzWqftcQ96xI3AlV9xmiCw
         9d8QGK+fRhAnDKtP71ihX7XCn42ZxfgjuN2W+izhUMhCkdXWWhxzerlQ6PL8cWq1w+ph
         YIh6gTAPGZQanvp7Ycr82KQJUN3NdosPGpxXbY+3FQXbEsBgrRDGRmPd5gcbJhHLgQl3
         6xZzLS9uiby62b9fo8oyQs+CqAQoVuwUUUUuVtbmADpRRti0Wj5NYl3UzcWczTw+Y1t3
         wxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mu/Th0tGJOW1Vp1fsRYv6sLwO9GVl//Pif1H+pKAEMQ=;
        b=EKFhoZa8eGkO1NY7BtOuR8xBRE/UrInIrLccxBR4TEOiPIhGPFayCVrBen6XmftbyA
         GdTw4ryARi1EwQyQ5eEklj1i2hI0W1Qdw2u/CRGlGJ8p//ANQxkVUuM1yA6oPc1fTixJ
         62q3fdtK73Rd9GCK5M4Px4zcAZC6tKRIiBLtZeK+wHAN3NuJRaoBYkrEZHJCBkjDp7rH
         8qknfuLELmv2RNXJ0PTvRlKoW7V3And6ZWpgzwoDPtfACHSfTwYqLSqe7AdJjuYaAcqW
         s182WcFL+unHo4aCpQ/tj74ZJORvBJbZiPN/JWBEXu+Law7+lQvuR6pbssEaYEht0KC1
         hIYg==
X-Gm-Message-State: AOAM533EaJhMeIA+czwe9Sxn4Pt/AMsb+TBE8eKep5hoV7KAgFBg7QQd
        oVN4a3w9CZiAo1N3FYRFXDj1jQDavcg=
X-Google-Smtp-Source: ABdhPJwByFocfBpa3uE43ULnAsKk5eNqox+XFJ1RQmAXpOOtoKgbSq8mEikocaUjur7YwJDDDPW1xw==
X-Received: by 2002:a7b:c350:0:b0:38c:6d3c:6c8 with SMTP id l16-20020a7bc350000000b0038c6d3c06c8mr1094761wmj.45.1647903350968;
        Mon, 21 Mar 2022 15:55:50 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:50 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 11/41] merge.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:53 +0000
Message-Id: <20220321225523.724509-12-gitter.spiros@gmail.com>
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
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f178f5a3ee..3bb6f902f0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -209,7 +209,7 @@ static struct strategy *get_strategy(const char *name)
 				fprintf(stderr, " %s", other_cmds.names[i]->name);
 			fprintf(stderr, ".\n");
 		}
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 
 	CALLOC_ARRAY(ret, 1);
@@ -824,7 +824,7 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
 	fprintf(stderr,
 		_("Not committing merge; use 'git commit' to complete the merge.\n"));
 	write_merge_state(remoteheads);
-	exit(1);
+	exit(EXIT_FAILURE);
 }
 
 static const char merge_editor_comment[] =
-- 
2.35.1

