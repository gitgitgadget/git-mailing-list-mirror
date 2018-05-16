Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC59B1F406
	for <e@80x24.org>; Wed, 16 May 2018 23:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeEPXAa (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:00:30 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:54166 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeEPW7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:52 -0400
Received: by mail-yw0-f201.google.com with SMTP id w4-v6so1083130ywg.20
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=aI4FONbBG1MR1inMetWSYORy2rhOpwe9yT6KqdjMR1Y=;
        b=sWFItARInN30AW6zj3mCPSQwIqAhGQeCXMNOf+VAb2JMMTaz9sUWLejR1gKv9FMGU8
         RAl1f+kyoslC8H24abyRKSdElMq5dmfPXHora+oIIoFjcwImtQP/QYFZeOG/OXi2BcAp
         pYuqSiW8BSOPE65hWTUSHV3sZVnPXgSejKaxEL/HygtITfAInKlQyeVa7+fYgh0lYVWK
         F+RQ1ekKTk47I6aazEKR7PqWqdBC3GPf5njmD0z36DtRVNrY0ZF/Of3X4IXZlwc4UJpR
         slKPZTdq2pSxj+z6Sf1Gn9VYTvuFgH/YAU3Xf0Wty8OGSgICH6XT3SlS9SZSkzFKedU6
         /rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=aI4FONbBG1MR1inMetWSYORy2rhOpwe9yT6KqdjMR1Y=;
        b=LQIhXkN0vjaIJso34v4YqRzZJGPF0MWc32w3FIcyF6Ttu+dtYXXwAmG5HHakI8h7Bp
         sU6IV8/qM61lgQs3BH6oqA8cHZ5pEekELpZW24Gb3U/c6fg/Xs4Rk9/IYaCfTUDX8i22
         vTbK3wu4uUeGmK2+jpEJuFz3O8iksdFhGz7dLOy7NAmWOxREtj/eOnzEqTwhZKT0NSZV
         I1ncrBASOu1ihuDYZ/D9K0OdYMXvE5L+j6IfYO021zc3zgPUfw/0UyiDZfwDcb8zVf2O
         1raCeFoq7ALEo62uQj33TG2pi00/1gBy4lDQE+ku3b/rjd/wyRj2/IDM4R98OTpEnWg5
         FeGQ==
X-Gm-Message-State: ALKqPwfkn/CmkBRmscxH0K6an1yRXjxS3aWfIrrT6X6jSFgy97gUU6sA
        zlJC7hjZjSmD3ddccPfvSWHS1TMr/ueemcCwV1z9ZClLoDJuyF5BQllPIV98qDmyXDboJXNgPEu
        qKUKAC8JXWswJTND2kn7PjS8xmrvJQw5LTRbOMRgIl8SSyzlvRrrB5JaFIQ==
X-Google-Smtp-Source: AB8JxZoroXALhdZ92JupJLCTnw7i69s7lmQQyFMxHxAa/cI9Y3re6U3iViaN3NnZL06/78gvkWxXsa/rSrw=
MIME-Version: 1.0
X-Received: by 2002:a81:6644:: with SMTP id a65-v6mr922135ywc.200.1526511591723;
 Wed, 16 May 2018 15:59:51 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:18 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-32-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 31/36] send-pack: store refspecs in a struct refspec
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

