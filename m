Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF0E1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 18:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfJGSSa (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 14:18:30 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44084 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGSSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 14:18:30 -0400
Received: by mail-pf1-f202.google.com with SMTP id b204so11671466pfb.11
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 11:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZOC7/JSp3X4bWCvPK2kIvVcXvfmtecDnh2mxoIfVNCU=;
        b=IDbrzI/pk7GfiyoVRdTp3nv1LKYazgXws4ih3rMk1FetWwkSB8yBHdylXnB32vODdZ
         Xxg7CUz1X1MsdF3oT6eITTZ5PyOdjTvh3jrYlpawVn+nIicFr3KElv/MNDXeIWJrk59K
         8gC9VPtEoE1vJwDgC61TW9/Jz7Gr3HC7SlUll6qDx7FTuWZxMwvhceE0HEVuP2A3YQGC
         4r0rqBw9pFUzj1qqoaCzcLSKm0Perqn9PiR6u8Ru6CDg/EMkP/IyOQKROGw3IfTi76W/
         JsdysU/roY5nppulmZupphLNOVEpZ2rHK5pV9H0rzOhz6vsoIJBVpFrhE9AxJUHRJOEL
         +7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZOC7/JSp3X4bWCvPK2kIvVcXvfmtecDnh2mxoIfVNCU=;
        b=Ne6PN+2tyEOBS4ZCa4UgAwbwLoGb8/HyhVqGhbaXJNyBHkiNA1NDaoQoVm/DIv0TT/
         DE0ZrE7pp2WB/hZ45JGVHjKlUrBg6jo3Wg1Nv2EKFsykkZAHaYTSp86OoFfJxw2GjZXC
         59VVG3r7RFd3h7oLOIruHV01NhgdW+5bx25shrjKuLj7I8WudfbqOqykOueMXlE8fjps
         aI+Xhn8wRN9Q1LOy+Pf8Q7+5doGbhgw5YWIIPFmCnObW4fadSkqgIJ0Kxj6Hz2m+mJ75
         KCVY7dVW8gqFu0SFfrQe2eYRtPO8UW58FILLNXV7NLlOXzeJgV206dZCFQBVEgGhAX7P
         +uTQ==
X-Gm-Message-State: APjAAAXfUsPJawF7VzUb1s3xHxa8h89hm3nb03piQ3QzxVpNYhWWhlZK
        X4d1jyxrNBG6VN+bTCPP8T5WgHqU3tFQ/PEKtXsx/+wPiAyvg6b/PDuHybcQ248AiAlDuRxDTmk
        TlEb9OJQjx/uJZ5GrhemIE/GUThgDh076VdeKqR1fFySGWMD80bhm+/rRIGJ3cS/6di3xQ35Efe
        ab
X-Google-Smtp-Source: APXvYqxsaq1c7ZvBTXr1r7wYgrMEF9h4UxcE7L7m3wSVaTbXyBjj9JiMenGG41cGxJN72bA395WA09pGxXX5qUszEgje
X-Received: by 2002:a63:f14c:: with SMTP id o12mr32065956pgk.386.1570472309144;
 Mon, 07 Oct 2019 11:18:29 -0700 (PDT)
Date:   Mon,  7 Oct 2019 11:18:25 -0700
Message-Id: <20191007181825.13463-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] fetch: delay fetch_if_missing=0 until after config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running "git fetch" in a partial clone with no blobs, for example,
by:

  git clone --filter=blob:none --no-checkout \
    https://kernel.googlesource.com/pub/scm/git/git
  git -C git fetch

"git fetch" will fail to load the config blob object, printing "unable
to load config blob object".

This is because fetch_if_missing is set to 0 before the config is
processed. Git must set fetch_if_missing to 0 before the fetch because
as part of the fetch, packfile negotiation happens (and we do not want
to fetch any missing objects when checking existence of objects), but we
do not need to set it so early. Move the setting of fetch_if_missing to
the earliest possible point in cmd_fetch(), right before any fetching
happens.
---
This is not a full solution, but this helps in the use case described in
the commit message. The full solution probably will involve teaching the
fetch mechanism to support arbitrary struct repository objects, and by
moving fetch_if_missing into the repository object. (Alternatively, we
could add the equivalent of OBJECT_INFO_SKIP_FETCH_OBJECT to functions
like parse_commit() that are used by files like negotiator/default.c, or
split up commit parsing into object reading - which already has that
flag - and commit parsing.)
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 24d382b2fb..865ae6677d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1666,8 +1666,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("fetch");
 
-	fetch_if_missing = 0;
-
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i = 1; i < argc; i++)
@@ -1734,6 +1732,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	fetch_if_missing = 0;
+
 	if (remote) {
 		if (filter_options.choice || has_promisor_remote())
 			fetch_one_setup_partial(remote);
-- 
2.23.0.581.g78d2f28ef7-goog

