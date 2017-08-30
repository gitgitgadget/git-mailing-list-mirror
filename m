Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F009208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbdH3HAd (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:00:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33538 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbdH3HAc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:00:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id r62so1050959pfj.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gwo+96eA3JpMRa168pj/T80ZWzZ8DsJxvAZ2tUlfyeU=;
        b=uuTIaErh2u8ik3WDkO8PKjCo5Xj9PpnIHpGzToDCUGeI48zS9Q2YD3iqk2DBe+O+gs
         mPbP8RlEBTYriJyatsvzsPAJgLtdTgBZjx+vuWWFC7VCZvDsODGKptqTRFzF6xuCzEAS
         SpHrqOYDRQLpId3+yeZnN+OPPzuZ4zYKJqFbNMZYpbqQzn5cFRNodXiId4smrjbHQ6Ci
         0fE+Gq3B4GVyV3JCKtcyaYbUCe8ka1QEjJykkgzXoL7Jln8P67hsps7peap0mVeJmUSa
         M9z85cWlhpGeNDNR5512oU6rp2UkFyWBSBBqtGj0+qf1zmDSJfVMRBe4+XqWra+yqVJv
         bS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gwo+96eA3JpMRa168pj/T80ZWzZ8DsJxvAZ2tUlfyeU=;
        b=VrGEEQLZphdWjJxasBm5k1eD5DUFxIwcOQMI8z8AGmigUahvuVTSQBLDTHepg0RVbG
         zmonOTSp93vABT5rjQHe6VhOJGAEVc4bilylhGxN9BPwfbo+GXkvUvI1qEPc/+c+fJ3T
         FFKhtiYPWKQXAfAt+Fgsn9hRk4DwTpcpkBtr5IJKri46srb/SdeDwH+VnvmObRHFBs/5
         9eDCPmDWCR6x2B4oJrlWAiSUUq7IP34FipV9s5RjG5nUKLyDENBmYMXVgzk8M0UUKGzd
         +9mGycCgQlWjcwgNp8IWteEUnTYfyNGNS+gLLAoUuVpEXPkYn2Pmk8GqnIoai0ulRmHC
         uVrg==
X-Gm-Message-State: AHYfb5jBui0THG4VLQXtEnzuizPZFvSAK0D82iLxfVBz3P6Qr0uadnWo
        b7hf/rnUfNigDnksZI8=
X-Received: by 10.98.202.91 with SMTP id n88mr611039pfg.73.1504076431640;
        Wed, 30 Aug 2017 00:00:31 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id r86sm7443941pfi.161.2017.08.30.00.00.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:00:31 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:00:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 13/39] sha1_file: add repository argument to map_sha1_file_1
Message-ID: <20170830070029.GN153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow the map_sha1_file_1 caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 893e37afec..3adae104c6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -871,9 +871,10 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-static void *map_sha1_file_1(const char *path,
-			     const unsigned char *sha1,
-			     unsigned long *size)
+#define map_sha1_file_1(r, p, s, si) map_sha1_file_1_##r(p, s, si)
+static void *map_sha1_file_1_the_repository(const char *path,
+					    const unsigned char *sha1,
+					    unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -902,7 +903,7 @@ static void *map_sha1_file_1(const char *path,
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(NULL, sha1, size);
+	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
@@ -2102,7 +2103,7 @@ int read_loose_object(const char *path,
 
 	*contents = NULL;
 
-	map = map_sha1_file_1(path, NULL, &mapsize);
+	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno("unable to mmap %s", path);
 		goto out;
-- 
2.14.1.581.gf28d330327

