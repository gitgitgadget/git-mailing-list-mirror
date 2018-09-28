Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B571F453
	for <e@80x24.org>; Fri, 28 Sep 2018 04:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeI1Kr2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 06:47:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42751 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1Kr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 06:47:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so3374959pff.9
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 21:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DV7GU0hije/3MRO0t6GQNPK1JremetfuPFkNeZT3Y/E=;
        b=JRCuS1tj3yFkanc6JGOvVQPceRk3Miie0TOocCxMPKHJEvCJkj5BOgfJLafiK2j4VK
         crJZ+LgMNc/5lp0wgLUA4GQnHx8+9fUpxUy+NPPKfM8qUJqPEVlYengT7Uz39FvgNZsd
         mn1XOJIXBlAt94WkcDIv+Gpdw/oWWitfEASCgXes5Ho8E7fUWQZ1UhZaKgNji1ApjP9w
         HssVPGbRgJzs33FKF+hHYtizWSjYEBsvjg1dbCHBS7ad4sIQ1eIf7z+PvfHpEv9S1qLt
         3ROPoeUyW77TuvsZGSK2h27+LX/wnmulh91H121c9BBCketjcE5/1Fucw2n9Xcc9q0fO
         GZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DV7GU0hije/3MRO0t6GQNPK1JremetfuPFkNeZT3Y/E=;
        b=RJp+jdfOTVd4SM/s7IwF2R9VV4f2mMb7ae9RL+YYWfxg6Bz1epp6mKu0cHd/YlIART
         3tkb7O1AIeG2vGOEnrFYUeQfY57ABNpCW+Sn9PrjHDn0ZACYijnl3Id8sdPxlKTv9SKy
         H99eOjaf4XZkxg7+KP9w8/xUEPVjp+to/MKe0IM5+jhtFxfGU5THP2IVVjBDfMHCL2wp
         BzZ9LfyTJ2AQJojBlaOtVefC1b3mDFfjcAqNuaa8K0iLEgEUpZr7DMs0eRPOL275VAuY
         kaPrcSGVJn1iFxns5qmI1xK0FmRGOtIM1VbzAit8xcXA7QTWTxhbzeID/UDU91VJI1Qa
         Sg8w==
X-Gm-Message-State: ABuFfogahS5kJUJ24fDF3koSEtUOMh4/QGxqJMsx6bpOWTMzZ6xFJ3af
        K6f4lYevBm1q+ID+K9KYYzTpxrvb8tdV7w==
X-Google-Smtp-Source: ACcGV63CIDbYun7rcZ6JRjlT2wbGGCujtldVlaO5C8WOx8ZqFl9E6PYIKqr4WSAYzWa4hnTFeGHevw==
X-Received: by 2002:a63:225a:: with SMTP id t26-v6mr3873946pgm.275.1538108741794;
        Thu, 27 Sep 2018 21:25:41 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1924:afac:8279:2210])
        by smtp.gmail.com with ESMTPSA id p11-v6sm6117296pfj.72.2018.09.27.21.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 21:25:40 -0700 (PDT)
Date:   Thu, 27 Sep 2018 21:25:39 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v3 2/4] transport.c: extract 'fill_alternate_refs_command'
Message-ID: <9479470cb1d5bdf8ee140d723fb913b9a95d3a32.1538108385.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538108385.git.me@ttaylorr.com>
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

