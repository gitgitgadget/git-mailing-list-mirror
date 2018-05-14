Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518181F406
	for <e@80x24.org>; Mon, 14 May 2018 21:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeENV6t (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:58:49 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:43254 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeENV5w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:52 -0400
Received: by mail-ua0-f201.google.com with SMTP id i14-v6so17887584uan.10
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=aI4FONbBG1MR1inMetWSYORy2rhOpwe9yT6KqdjMR1Y=;
        b=mP8bCJ6UwxVIZ9gwWOZsLW4O4UhB1UgMq7nUChvAWhRaAr8RogoBrGl0lwuwUMeK8M
         8eJILeLjDjxJjFkYXM5/fIbFBlJQmuWTvu0kGXQCDGfN9SfRKfY1bnjTIY0+7tFVcyll
         Nx35qy1CqZcqs9a4Gn7ikR6Wt+JyCN4X65m1SytVBwXdhDPqw1RW+XnAKp1EtutlIFoy
         x0l5NxB7AsFrwpD5PZDj9XtAwdYsxWL/YjPDxOagnl/6Y4ax/MwT6xnSwRlbVv/USm1Z
         i6TA7OPldFGm4r1TfBQFT2MyDmm5RmFCHgInofP84hT17VMOkWzX99cfyvYBSc1w9lMe
         HvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=aI4FONbBG1MR1inMetWSYORy2rhOpwe9yT6KqdjMR1Y=;
        b=aypgTth6guMxGwcXrKN44tnlhMulLuw+Iy6jI5CIVQP4dzxpxWrSIKUrVdXzq/HHFU
         ojXPGVWiXFgHkDxoZ3OisTDq33HIcTDId7hL8X90M3Ce3pKtFzWPxJnRM5VKAQi8AB9I
         h6pwpRGSNcj49Ca8Vu3eF/GpoO+I2ZkwgdoohVBcbIE5u5RmnbqipXKwTvGHXV0RtRkz
         2OnBomFP274+/pHx82CrnE557O0zFP0jN6tMUOFWp+a7VMZ+CubyGQ1ul7k7cVopfCth
         zTEKSrd0mWbg7JCW67FWgqZfi1YQVqmqhSTT+1uLxJ9J0l1/dmtfz1fz4RlfklEiACaW
         QbHg==
X-Gm-Message-State: ALKqPwc6ovtrE6Nn539gNtexQO0JAIqUfdtUDHuRWFobT3B6aFYIrCBK
        O8844mjBj9/vecPdBkY10T5I6fVSMsH3+gjOUO92b4bvNFXKmQbLXNW/BSWcmeAoIx6V11fLWRK
        m4rNmPsxwfRrzfwPFLNVZHSeCxh1L/nPKFrRW0CnUXWxnUYiiI6MgfKmWUQ==
X-Google-Smtp-Source: AB8JxZqFZhhcTXg6mkgh4ZTNOI/A5SNaKBRtFQiGRSMahQE5BU8pgg1e4OrDB64uI/tZ97qn8ydyP28NbpM=
MIME-Version: 1.0
X-Received: by 2002:ab0:53c8:: with SMTP id l8-v6mr13078340uaa.55.1526335072324;
 Mon, 14 May 2018 14:57:52 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:21 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-31-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 30/35] send-pack: store refspecs in a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert send-pack.c to store refspecs in a 'struct refspec' instead of
as an array of 'const char *'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/send-pack.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index b5427f75e..ef512616f 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -126,8 +126,7 @@ static int send_pack_config(const char *k, const char *v, void *cb)
 
 int cmd_send_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, nr_refspecs = 0;
-	const char **refspecs = NULL;
+	struct refspec rs = REFSPEC_INIT_PUSH;
 	const char *remote_name = NULL;
 	struct remote *remote = NULL;
 	const char *dest = NULL;
@@ -189,8 +188,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
 	if (argc > 0) {
 		dest = argv[0];
-		refspecs = (const char **)(argv + 1);
-		nr_refspecs = argc - 1;
+		refspec_appendn(&rs, argv + 1, argc - 1);
 	}
 
 	if (!dest)
@@ -209,31 +207,23 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	args.push_options = push_options.nr ? &push_options : NULL;
 
 	if (from_stdin) {
-		struct argv_array all_refspecs = ARGV_ARRAY_INIT;
-
-		for (i = 0; i < nr_refspecs; i++)
-			argv_array_push(&all_refspecs, refspecs[i]);
-
 		if (args.stateless_rpc) {
 			const char *buf;
 			while ((buf = packet_read_line(0, NULL)))
-				argv_array_push(&all_refspecs, buf);
+				refspec_append(&rs, buf);
 		} else {
 			struct strbuf line = STRBUF_INIT;
 			while (strbuf_getline(&line, stdin) != EOF)
-				argv_array_push(&all_refspecs, line.buf);
+				refspec_append(&rs, line.buf);
 			strbuf_release(&line);
 		}
-
-		refspecs = all_refspecs.argv;
-		nr_refspecs = all_refspecs.argc;
 	}
 
 	/*
 	 * --all and --mirror are incompatible; neither makes sense
 	 * with any refspecs.
 	 */
-	if ((nr_refspecs > 0 && (send_all || args.send_mirror)) ||
+	if ((rs.nr > 0 && (send_all || args.send_mirror)) ||
 	    (send_all && args.send_mirror))
 		usage_with_options(send_pack_usage, options);
 
@@ -275,7 +265,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		BUG("unknown protocol version");
 	}
 
-	transport_verify_remote_names(nr_refspecs, refspecs);
+	transport_verify_remote_names(rs.raw_nr, rs.raw);
 
 	local_refs = get_local_heads();
 
@@ -287,7 +277,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		flags |= MATCH_REFS_MIRROR;
 
 	/* match them up */
-	if (match_push_refs(local_refs, &remote_refs, nr_refspecs, refspecs, flags))
+	if (match_push_refs(local_refs, &remote_refs, rs.raw_nr, rs.raw, flags))
 		return -1;
 
 	if (!is_empty_cas(&cas))
-- 
2.17.0.441.gb46fe60e1d-goog

