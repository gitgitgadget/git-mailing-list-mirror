Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 986A51F576
	for <e@80x24.org>; Sun,  4 Mar 2018 11:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeCDL1O (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 06:27:14 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37828 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeCDL1N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 06:27:13 -0500
Received: by mail-wr0-f196.google.com with SMTP id z12so14393120wrg.4
        for <git@vger.kernel.org>; Sun, 04 Mar 2018 03:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BV6UpNWUKGKJt+XZOGep1BVKr68pU971OKvSe0n+ebM=;
        b=WaaeXH76zKT/V9o7qNnXxCnEB3AQq+JyXAHOWB7Xnuf7io9HawlV5AUVHQSjjaR30b
         NlybSOYT6kWtkWmhWTxLFIaEU/cawCRI0PvBY5cv0uOFRs0qo+zwBFtcq5FP+g35pNZs
         5ZKsC3AkLLIzLyA79V9CYfP1ct5g3MZWvOkZztcMF1eMw4QZQ2h38TFPHuBUUumk9zsr
         dYMc2RwmqD79M6KVbT3KnH1OtuVp44fHnrHChnpS96VvEjAaAyDMDFMfHdJo/ZjMjLmN
         XMeRClod5DmuwEtjUnZ/1cgcUUoYnE1WgL2l1wjVngvbfbfTMfpRWwUe2nLSrCNqQfvk
         EBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BV6UpNWUKGKJt+XZOGep1BVKr68pU971OKvSe0n+ebM=;
        b=htls9Yjuv+PQHhjZz3jkPY/cprWmpENAKDB+NFChRwZoVoe7LvpkJlarviwl/jxi53
         F7VjKKEjm7tf1z5NnkHw9Bu7gPUueCPDccjO8mskiPbmdSaibG6nAhVNlbT9SSEIMRqx
         oc9RF5tGbqrN7hNqw00w0/TNmauqiSJKQqHeO8b/HImNBM+H9CPhKIxVf9uTt21iskM2
         e935zlEmeiKNwjPiqIPZb0Eq6fqdnOejv6YfUxTy+vOhnx1Lb2vZ/Q5RddfNlipGbM4r
         A3b/DdaPLxXP5Qwq/RZFz8Jh9lm/Jm3R8JCc+VSllI5On3fV3jFpYRyAdAWHdUGFXeLo
         h5UA==
X-Gm-Message-State: APf1xPBM6J0no58NOzzQWxqxe4EX0i4ZaAgD/SBwmiILeSC3i2BmVQu2
        NQur4gSt4s4hrl5xeaQXsLWo8A==
X-Google-Smtp-Source: AG47ELtSvZfZwmjbhZabwaRDVOM0n/Y2LXLM0mwq2FQXryFp/dBX7F9wlr4RtkmRGV1x3eOtlH2eSg==
X-Received: by 10.223.192.76 with SMTP id c12mr9312743wrf.177.1520162831479;
        Sun, 04 Mar 2018 03:27:11 -0800 (PST)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:5fe:bb85:ada6:d63b])
        by smtp.gmail.com with ESMTPSA id o94sm16684005wrc.7.2018.03.04.03.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Mar 2018 03:27:10 -0800 (PST)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Wong <e@80x24.org>, Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 1/2] git-svn: search --authors-prog in PATH too
Date:   Sun,  4 Mar 2018 12:22:36 +0100
Message-Id: <20180304112237.19254-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 36db1eddf9 ("git-svn: add --authors-prog option", 2009-05-14) the path
to authors-prog was made absolute because git-svn changes the current
directoy in some situations. This makes sense if the program is part of
the repository but prevents searching via $PATH.

The old behaviour is still retained, but if the file does not exists, then
authors-prog is search in $PATH as any other command.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-svn.txt | 5 +++++
 git-svn.perl              | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 636e09048e..b858374649 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -657,6 +657,11 @@ config key: svn.authorsfile
 	expected to return a single line of the form "Name <email>",
 	which will be treated as if included in the authors file.
 +
+Due to historical reasons a relative 'filename' is first searched
+relative to the current directory for 'init' and 'clone' and relative
+to the root of the working tree for 'fetch'. If 'filename' is
+not found, it is searched like any other command in '$PATH'.
++
 [verse]
 config key: svn.authorsProg
 
diff --git a/git-svn.perl b/git-svn.perl
index a6b6c3e40c..050f2a36f4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -374,7 +374,8 @@ version() if $_version;
 usage(1) unless defined $cmd;
 load_authors() if $_authors;
 if (defined $_authors_prog) {
-	$_authors_prog = "'" . File::Spec->rel2abs($_authors_prog) . "'";
+	my $abs_file = File::Spec->rel2abs($_authors_prog);
+	$_authors_prog = "'" . $abs_file . "'" if -x $abs_file;
 }
 
 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
-- 
2.16.2

