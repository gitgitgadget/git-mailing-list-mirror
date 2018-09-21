Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5581B1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 18:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391238AbeIVAhx (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 20:37:53 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:33993 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeIVAhx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 20:37:53 -0400
Received: by mail-io1-f54.google.com with SMTP id h16-v6so2862954ioj.1
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EWXslfzsnnkgUJ8j3E31KFzjrP+4XmJGMGdcLdnXBxo=;
        b=ZqkYvDfIQhon1UdX6PiypF3Xfzx+CgooKPPasOiG3Hkegd1uicXglldrv/U8LUP02C
         PiW833aBdzWkmpfxPdwsdudEHKP8vjAS+fap48zNcCTkSzjJmt9vD8RHJNaJCU4MvGqn
         8Q9b03NIPXxm0bFgbICtRGuPpqx1jeLY8PaHKvLHGU26yrdDjjPF/9rbPq17rB48sq7U
         aWRY65RIj+GYAQdo5renEU35BFcGOYvwLd9Zu2J8YgLVcbcWrcuEy6go+UnNCFfKfC10
         i7TsFxuU1ZN7a+R6xhxuxx9mUvEtSc7J9KIN5+PBi9ADS83Em7ht0D3ZWbuYIsJKdrFi
         bDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EWXslfzsnnkgUJ8j3E31KFzjrP+4XmJGMGdcLdnXBxo=;
        b=rHrFN8UGQm2KR82V0yp4QACq72u/DXZagAwz2NvkiFe8pP6j6ARYEbsUkIXRbbntca
         LZFhMcrW/cwusQChNF+JDhCUs5iVKFRAlJqzJU03gLwWjQRP6sAWvgZbVZ0Sv6uzMP15
         BKgDtDKJpjYPaw5Nqpb3gJGABsp07aZuDoftn69YdLYBDIrbTN3z+CDsaBm1dW6+FGMj
         WKc//rz5z8IrUR3T4JAket3JqSPwiUUwO9VLvI737IDMUr5ZBN9U2g+5O7+chx8Eb7C0
         +moluv+D+I+eMjRVR7JIi8PRQLe4gQivqMGd18LuGeLyoZwImgxANMT2TPPHeVdCXIEt
         38qg==
X-Gm-Message-State: ABuFfohaqjxxVKEwKmvrydpqZyeZxM8RavKrge3VGOPG4akLtjN2Cu6j
        OTNTGwo2UfQdIYsGcmUp+pyiSvVinG4=
X-Google-Smtp-Source: ACcGV60NrTBJTfdFWEFxf69tIzRLXOU53GJmvvBezUabq01ysS72jv0PNY0CvrOS6q9a3jHQ04RBdw==
X-Received: by 2002:a6b:9b42:: with SMTP id d63-v6mr6006298ioe.183.1537555662422;
        Fri, 21 Sep 2018 11:47:42 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id v3-v6sm2833692ita.6.2018.09.21.11.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 11:47:41 -0700 (PDT)
Date:   Fri, 21 Sep 2018 14:47:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v2 1/3] transport.c: extract 'fill_alternate_refs_command'
Message-ID: <6e3a58afe7cd18d663f481cdc9eb65cc941765b1.1537555544.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537555544.git.me@ttaylorr.com>
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
2.19.0.221.g150f307af

