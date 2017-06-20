Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1F820D18
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbdFTH4y (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34987 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbdFTH4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id d64so21286045wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=da2WIjwlSTlPrh+uyiJcIzabqukcQ6E7h7BrvzifZQE=;
        b=EhRpqg/c606t81CQjrbB9h+Ls2cKK5oD4LhMJXUek79i4CGLdfi4dtpPnFApFM3Mma
         o2yO3LC4jRiT5S0HJ8jJbXx4fIdicr8ggmw0nWlx1VVHU+nu6iff2+6Lx5DplWZ+0kNE
         7pRoj3Jchs1y2gAOgHFWC9tGyMe+zqSQT/b3Bv6D4Xdj6ddbwE9OLPAJWFMSWRg64h91
         ftvclheSDRJVFZTfJ/EDRDNtkXy7Ls+qcw/Up3Wst8EOkqLBNNQKi+fcuDWSKjfIqlm7
         WwiBFLqDEEnc5c/R/LYy1gkjV3NGAbx0B9BLsgn8o9AXCzWBIQ02k1/oH+HTqXQXv/zx
         0gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=da2WIjwlSTlPrh+uyiJcIzabqukcQ6E7h7BrvzifZQE=;
        b=eDI+NjmM7OVlQm+faOUmt9cdPHJfeRVoWuMZmhVn3mhdMy/yFMRBCrr6roe1CDpkO4
         xTfmQ4JAGXK2LXig5xRDZRjI6Rwzf78lrNbJWMxM9fZyqWyh0L4YfdTyi8KLIEJPnEto
         7Ft++2aues0w+IU94OwmcLgpfkNGUTeGH6966p/wfccMKyuXYq3bKzEHfVLrtAYGMTov
         BvCKSl946QuxsolXtnyh0KU92UiiDuzxjmhDb45OSbiPEKSfDevCD22b5RD1mR585sEf
         l3tRqMJstSSSGdIdNZG3cz+Zpp/7KYFU/gA3X5TrroFNuhw7G4q8WoZdiFahmDsdvwx9
         DLAw==
X-Gm-Message-State: AKS2vOwKJEPT6yLFzU+XYiDB09mNMPe7lK9YpCPG9A7o19dMTglmCMlY
        RJRAM5iOo6eWKSL7
X-Received: by 10.28.35.196 with SMTP id j187mr1673324wmj.26.1497945387225;
        Tue, 20 Jun 2017 00:56:27 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:26 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: [RFC/PATCH v4 29/49] Add t0410 to test read object mechanism
Date:   Tue, 20 Jun 2017 09:55:03 +0200
Message-Id: <20170620075523.26961-30-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0450-read-object.sh | 30 +++++++++++++++++++++++++++
 t/t0450/read-object    | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100755 t/t0450-read-object.sh
 create mode 100755 t/t0450/read-object

diff --git a/t/t0450-read-object.sh b/t/t0450-read-object.sh
new file mode 100755
index 0000000000..18d726fe28
--- /dev/null
+++ b/t/t0450-read-object.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='tests for long running read-object process'
+
+. ./test-lib.sh
+
+PATH="$PATH:$TEST_DIRECTORY/t0450"
+
+test_expect_success 'setup host repo with a root commit' '
+	test_commit zero &&
+	hash1=$(git ls-tree HEAD | grep zero.t | cut -f1 | cut -d\  -f3)
+'
+
+HELPER="read-object"
+
+test_expect_success 'blobs can be retrieved from the host repo' '
+	git init guest-repo &&
+	(cd guest-repo &&
+	 git config odb.magic.command "$HELPER" &&
+	 git config odb.magic.fetchKind "faultin" &&
+	 git cat-file blob "$hash1")
+'
+
+test_expect_success 'invalid blobs generate errors' '
+	cd guest-repo &&
+	test_must_fail git cat-file blob "invalid"
+'
+
+
+test_done
diff --git a/t/t0450/read-object b/t/t0450/read-object
new file mode 100755
index 0000000000..bf5fa2652b
--- /dev/null
+++ b/t/t0450/read-object
@@ -0,0 +1,56 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git read-object protocol version 1
+# See Documentation/technical/read-object-protocol.txt
+#
+# Allows you to test the ability for blobs to be pulled from a host git repo
+# "on demand."  Called when git needs a blob it couldn't find locally due to
+# a lazy clone that only cloned the commits and trees.
+#
+# A lazy clone can be simulated via the following commands from the host repo
+# you wish to create a lazy clone of:
+#
+# cd /host_repo
+# git rev-parse HEAD
+# git init /guest_repo
+# git cat-file --batch-check --batch-all-objects | grep -v 'blob' |
+#	cut -d' ' -f1 | git pack-objects /e/guest_repo/.git/objects/pack/noblobs
+# cd /guest_repo
+# git config core.virtualizeobjects true
+# git reset --hard <sha from rev-parse call above>
+#
+# Please note, this sample is a minimal skeleton. No proper error handling 
+# was implemented.
+#
+
+use 5.008;
+use lib (split(/:/, $ENV{GITPERLLIB}));
+use strict;
+use warnings;
+use Git::Packet;
+
+#
+# Point $DIR to the folder where your host git repo is located so we can pull
+# missing objects from it
+#
+my $DIR = "../.git/";
+
+packet_initialize("git-read-object", 1);
+
+packet_read_and_check_capabilities("get");
+packet_write_capabilities("get");
+
+while (1) {
+	my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
+
+	if ( $command eq "get" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		system ('git --git-dir="' . $DIR . '" cat-file blob ' . $sha1 . ' | GIT_NO_EXTERNAL_ODB=1 git hash-object -w --stdin >/dev/null 2>&1');
+		packet_txt_write(($?) ? "status=error" : "status=success");
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
-- 
2.13.1.565.gbfcd7a9048

