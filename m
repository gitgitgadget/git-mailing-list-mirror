Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D2F1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 18:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbeITXsw (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 19:48:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:47032 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbeITXsw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 19:48:52 -0400
Received: by mail-io1-f65.google.com with SMTP id y12-v6so8650309ioj.13
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gzNArQoQm45WYjNXbVponfKrICgMkHCFqCa42GW4UMw=;
        b=WpSIIXzzavElwcTfqouC+O7B0/ltJqqXWf8E/ykJP/kUlFmJsOKSDUkVZBKBawWmms
         Xid6a8CG/VZLMNqdOpf5dL+/yYjw+xBOHkrdUDKWWwehhAY7tcDUNp91uPdgYUPdSD10
         lYz3hEUGqViQAyCHc+f4DEvBNYjSKjUzpiXBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzNArQoQm45WYjNXbVponfKrICgMkHCFqCa42GW4UMw=;
        b=LcsWhfH1YJKNRUDuzBSHSc58juyb1MuRj5tl4slfLnjbpT31ZbmEkOwifRXr4ahgyC
         EaqTH7jZdrI6cJQXg/ALK5T2OEZjo//hCakhxZSKGaZbbO0tkVPDl+KazSbprpQziQvX
         v7vWAZkdfeRPZ38NnFWsHVaajAPBkDbVK+1drG7BONcf2+/JXUPBOB1ccqd3a+qsQ/yp
         OUFaeql3E0rMVgJefV/a6hWSjuoRntJPfoTtBo2TKyl/Yr7bKEx7p563KVC7NcWyxKED
         ci5YypLK1t+bhPds5o1wvsieIJxG4L5bJp6D4F9aiEZJPWA/bb2qW6eQBqERkUMOcdOA
         dHkA==
X-Gm-Message-State: APzg51CJ9vc4LKmOB8Lr+7fH2gpSsSX8dkY5WsXBUSYlkqngw3N1Ok3e
        rX70onIGVUtxmAvJU1xUgF/Z/1uLAvUbwfqiL9CRPkoGiEC7q0Th2NReVjwn6MXJskyPAy123aP
        xNGkVH4OLppeeaK+3zyl9IWBmUTdZjMqtzXBHaK38AwBBqHIowCgv/ND+Y7KeZw==
X-Google-Smtp-Source: ANB0VdZyB+dgBH5I3P4Uie+C6zailZEO84DPHdsULbK4C1wMPQWR+93QHiav2zitIXWipLBeAS7hWw==
X-Received: by 2002:a02:1643:: with SMTP id a64-v6mr36772203jaa.133.1537466650573;
        Thu, 20 Sep 2018 11:04:10 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id a64-v6sm1048709itg.40.2018.09.20.11.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:04:09 -0700 (PDT)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Thu, 20 Sep 2018 14:04:08 -0400
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 1/3] transport.c: extract 'fill_alternate_refs_command'
Message-ID: <6e3a58afe7cd18d663f481cdc9eb65cc941765b1.1537466087.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537466087.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To list alternate references, 'read_alternate_refs' creates a child
process running 'git for-each-ref' in the alternate's Git directory.

Prepare to run other commands besides 'git for-each-ref' by introducing
and moving the relevant code from 'read_alternate_refs' to
'fill_alternate_refs_command'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 transport.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/transport.c b/transport.c
index 1c76d64aba..24ae3f375d 100644
--- a/transport.c
+++ b/transport.c
@@ -1325,6 +1325,17 @@ char *transport_anonymize_url(const char *url)
 	return xstrdup(url);
 }
 
+static void fill_alternate_refs_command(struct child_process *cmd,
+					const char *repo_path)
+{
+	cmd->git_cmd = 1;
+	argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
+	argv_array_push(&cmd->args, "for-each-ref");
+	argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
+	cmd->env = local_repo_env;
+	cmd->out = -1;
+}
+
 static void read_alternate_refs(const char *path,
 				alternate_ref_fn *cb,
 				void *data)
@@ -1333,12 +1344,7 @@ static void read_alternate_refs(const char *path,
 	struct strbuf line = STRBUF_INIT;
 	FILE *fh;
 
-	cmd.git_cmd = 1;
-	argv_array_pushf(&cmd.args, "--git-dir=%s", path);
-	argv_array_push(&cmd.args, "for-each-ref");
-	argv_array_push(&cmd.args, "--format=%(objectname) %(refname)");
-	cmd.env = local_repo_env;
-	cmd.out = -1;
+	fill_alternate_refs_command(&cmd, path);
 
 	if (start_command(&cmd))
 		return;
-- 
2.19.0

