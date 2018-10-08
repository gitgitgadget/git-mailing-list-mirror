Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C611F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 18:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJIBWY (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 21:22:24 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:44675 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIBWY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 21:22:24 -0400
Received: by mail-pf1-f174.google.com with SMTP id r9-v6so8580610pff.11
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DV7GU0hije/3MRO0t6GQNPK1JremetfuPFkNeZT3Y/E=;
        b=Jy1RPBBihw5XXUgVlfNcjZX8/sfeWQUHGaFyS8izvgIGybMyJ2mbgQaV8U5BTWbJzc
         MLIjsWh2xycFyxQM88Aosb/akzVzWQwx6/sa4BFuMnVF0XBfDX4ZyiGNh+D/ya2Lnv7H
         kf2ghFrVLC7BIaGcZTdSuhaiT3qGWqvGwpZhArVPzhCBf7QjnUxboK5dzIOL0X5ABQZH
         duDagpdU79BGJDQCEudr5I9LrnoHO6xphRuVIBdgzjy4l5Q7Gs3WAQ6lTt8VATufxIyr
         1mLAHJf8/IT9RtHDnSE1GYUK8ZKZO98SsumHV7ZCIp8/3iCNji4+MUNfjEOZ8o3hYNZP
         GUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DV7GU0hije/3MRO0t6GQNPK1JremetfuPFkNeZT3Y/E=;
        b=P2S713UTyvDJ97bGWGA6bjsmHLLUofuY29K57+/J5tkmxBnhJ6dYhrhtYLzGeNBlDI
         nxIH4Jo9sFJ1iyXtmqOB4uXoPN9acMVUCPNk6RKBFTwHbz3ElGCz+aOggaM2ZWb21mxn
         pMGjBUDrV2f4tPeec1GwtMbcqcmIFqHSoJUU4FZHAejlrcb1x/WANGgaAit2231aoNWd
         yiH843Gvpmxf4oWsVnfs95Swd4aXYnSskec61SH+FUrRNFty8HmZI3FhYHZXcpMP6iZe
         Bao+bEZ4W4zk28Q6HIEbVoeDRqFtbZ37FZrRq5tsxcpnAj6/QSYibKibyG2OiogYl9vh
         W+cw==
X-Gm-Message-State: ABuFfojBJF+SxOXiLFe/gozDmEdPR8KmIJ2wuL7Ni4A8bLvQx2OfyR/X
        TctAZqWq3IpTdhCUv6+AiRuT/fiD1O4=
X-Google-Smtp-Source: ACcGV61VZNE0lNK7jKOZcOA+1LqE5TpPNEbtf8xY87knGVSkS5PmHgp++M2EpZmmNWIIQ5fVN+yk5g==
X-Received: by 2002:a63:e00d:: with SMTP id e13-v6mr21878474pgh.114.1539022167349;
        Mon, 08 Oct 2018 11:09:27 -0700 (PDT)
Received: from localhost ([205.175.107.112])
        by smtp.gmail.com with ESMTPSA id n63-v6sm15396056pfn.9.2018.10.08.11.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 11:09:26 -0700 (PDT)
Date:   Mon, 8 Oct 2018 11:09:26 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v5 2/4] transport.c: extract 'fill_alternate_refs_command'
Message-ID: <3d77a46c613c1c3d7f1cf161ac12ff6477430958.1539021825.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1539021825.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539021825.git.me@ttaylorr.com>
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
index 2e0bc414d0..2825debac5 100644
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
+	argv_array_push(&cmd->args, "--format=%(objectname)");
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
-	argv_array_push(&cmd.args, "--format=%(objectname)");
-	cmd.env = local_repo_env;
-	cmd.out = -1;
+	fill_alternate_refs_command(&cmd, path);
 
 	if (start_command(&cmd))
 		return;
-- 
2.19.0.221.g150f307af

