Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91371F404
	for <e@80x24.org>; Sun, 28 Jan 2018 17:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeA1RG6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 12:06:58 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58448 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752065AbeA1RG5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 12:06:57 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 51D9460FBD
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517159216;
        bh=Ya3UAOBOMDPBb7woQVMNfrBtAyc8z7UUVNxnjY9uK1w=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=t1jk23qGGAfYhEA8wZmmcPPvWqmcrKcGldJE5Ff7cZ2inKmD66TMSY37/sD9RgHo3
         8npwfcwFzrr5BorjQI60Qgk+iYnsHbf6PHoaS5ErB0fZ/QHXaEW8UL54lynDhiQqzK
         RuwP/sHsHw7BavLBdR6Y1251iQJMH1MDhYmhdNvlpJZH7cu2lAEqhwh9rkBxB6te9O
         Owfn+T6F8uyQUzfm0z4bMs7YhyDuz4llXJezFN5gztv7ltSSdxnKXSMkj5etK/TKoI
         MBuccRrzeM8ns1cf8vH0mJDWPOhhBDAbzQ+YnMRBOVV7HzP/4U60590JA60dt2eIjD
         ytD+x5MQrPMIU5VQpIHcXD/TAK1u9iITLk0Nb3b5gUkv2LanP1OIdVRiqnd/iQC5Nv
         c1fliGlGGAYdlNajA8+ywO2tGqoD0Is7RvLCDOcLKQA0ERlzWOJmF7thwwc2aFcVh7
         X+pSsyB3HEyTCOm7kmtekVjeNqclqUEMl6UlErpsan68TC77BEV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 2/2] Switch default hash algorithm to short BLAKE2b for testing
Date:   Sun, 28 Jan 2018 17:06:39 +0000
Message-Id: <20180128170639.216397-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180128170639.216397-1-sandals@crustytoothpaste.net>
References: <20180128170639.216397-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the default hash algorithm to short (160-bit) BLAKE2b so we can
identify tests that rely on a given hash algorithm.

This is a test commit and should not be used in production.  Widespread
test breakage occurs when using this commit.
---
 repository.c  | 2 +-
 setup.c       | 2 +-
 t/test-lib.sh | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/repository.c b/repository.c
index f66fcb1342..95c0ff74d6 100644
--- a/repository.c
+++ b/repository.c
@@ -5,7 +5,7 @@
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SBLAKE2], 0, 0
 };
 struct repository *the_repository = &the_repo;
 
diff --git a/setup.c b/setup.c
index 8cc34186ce..72eaee9c4e 100644
--- a/setup.c
+++ b/setup.c
@@ -488,7 +488,7 @@ int read_repository_format(struct repository_format *format, const char *path)
 	memset(format, 0, sizeof(*format));
 	format->version = -1;
 	format->is_bare = -1;
-	format->hash_algo = GIT_HASH_SHA1;
+	format->hash_algo = GIT_HASH_SBLAKE2;
 	string_list_init(&format->unknown_extensions, 1);
 	git_config_from_file(check_repo_format, path, format);
 	return format->version;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9a0a21f49a..cd257040ad 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -183,8 +183,8 @@ _x40="$_x35$_x05"
 # Zero SHA-1
 _z40=0000000000000000000000000000000000000000
 
-EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+EMPTY_TREE=f44422a644bfa5212387098f253a1e89eba94548
+EMPTY_BLOB=a706650a477f63b9b00eba41272bf36ef5a7dfa2
 
 # Line feed
 LF='
