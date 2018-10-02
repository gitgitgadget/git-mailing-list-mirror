Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360B31F453
	for <e@80x24.org>; Tue,  2 Oct 2018 02:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeJBJEt (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 05:04:49 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:42508 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBJEt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 05:04:49 -0400
Received: by mail-io1-f51.google.com with SMTP id n18-v6so538482ioa.9
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 19:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DV7GU0hije/3MRO0t6GQNPK1JremetfuPFkNeZT3Y/E=;
        b=xOQSed5pj6xZnl+rsGV7ltkyqzLk5qNuxeaUFJh/Q1Vtid1inRil0Hg0vfkxaZaGkL
         vndDh4ew8fc33BsgmT9mbigPH3WIpEje48xHPH3QX4tH0eK/GeXGCWQwFQj3u2KM+iCq
         sK0Y4jkgKfah8tx1HJNq00Qdz2/phkVaCbaJrAE44bX0m6JhWtdpxYCt278OSaSYIRvE
         c44hqS+fgXJAGFQrTvZ2IvfhoYqZ0GC3mCszLIZYNULMLiWu7TuoxdO5pb7NK8+D0SfJ
         VIO9O8Ed6QXFln04EAX4vv3N7WWbtO3q7vRHGb5oZ9Y4kkmVe9pI1MIfr2e0NK/NUDW4
         pU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DV7GU0hije/3MRO0t6GQNPK1JremetfuPFkNeZT3Y/E=;
        b=DkrOCafH3fBTJaQY+/Npc/3F1zldCadLmQgDO2/UlpYTFjewld06+t76dilzOQrlrR
         6DkP/Ha+IyOJKPdA+asmpq71gIw2tKNB44mi/2yTHLkQ3elXTtMqva3NN6c1OEAU5xyv
         F8ywldGvXHpi1Dazafaxg04oDmqWwfZAdenNVkm6v6UImNjZShTK10WPUa1UcWvcth/L
         cCxevUNION4vbNSzBOkc18R7po3cP4/OJ/UGI0lexCMHB5DWtnkCZbZ25dHiEmIDc+h0
         kMvO4UBPHDPrAxDoBVWV8zh+4M2roTZQ5cIwCdIm7aHmv9uPflCfk666znuYm756e0PL
         lJnw==
X-Gm-Message-State: ABuFfojv7GjDunybYQ2xtIIIgiIM4PU6g/rrBIfhmIuGwU30G7UCSAlL
        TaqjFDIk0FX/RPNUM4H3G1uKqO3bQQQbqQ==
X-Google-Smtp-Source: ACcGV62xnrhi3kDfvMWhgmMtvJhjeesQV1LP/cn+5kPbbH9JRBEuIwr52MLIANmw2vv5oz1rgN3rEQ==
X-Received: by 2002:a62:6cc4:: with SMTP id h187-v6mr14409783pfc.158.1538447038237;
        Mon, 01 Oct 2018 19:23:58 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id l16-v6sm27830301pfj.179.2018.10.01.19.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 19:23:57 -0700 (PDT)
Date:   Mon, 1 Oct 2018 19:23:56 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v4 2/4] transport.c: extract 'fill_alternate_refs_command'
Message-ID: <6119de15f2ba56e093c60a41990db740f3904d54.1538446827.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538446826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538446826.git.me@ttaylorr.com>
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

