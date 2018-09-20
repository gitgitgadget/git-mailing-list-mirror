Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB101F453
	for <e@80x24.org>; Thu, 20 Sep 2018 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbeIUAdo (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 20:33:44 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:46696 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUAdo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 20:33:44 -0400
Received: by mail-ot1-f73.google.com with SMTP id s69-v6so9425886ota.13
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UUwfTv0lpeZOuBfD/Yn7O4ku3FXTlodMSIYRS4B+UhQ=;
        b=WhSbhCWFm6ru0NbUnC1vt5wz4BiMxuHaOk5BeHQU+VTRLbsqlZ1c+ufcxLKTUoFiXF
         sNBPev/LG5arnOcE5ahBReU475go7YV+lSjRdOvnNyH17dbv60Bfs/wP8PJ+gNLminYR
         h0iRQXL04KuW8ZUWj6vN0MBhjKOh96HlibCwgcJF1lrfXZcILqd6LtNmljiQvdgePL+x
         Ug2O1A2pD9gpzODmawRrJqvmwxvia0lnHNnHmBuZtqu4e2sRPcNdN5Yfd5gIrVBKRlI5
         H+CQd23g4SFDESqhwpmCbz4xc1/FtAok7R4Xhgmjyv7Bv8QyGm/orHCaHpW2lyDVbmMw
         0x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UUwfTv0lpeZOuBfD/Yn7O4ku3FXTlodMSIYRS4B+UhQ=;
        b=BO+W9GApaMWXSv5/y3TBPGzZ6kLugXowIdUZ9jwDT1CiChZhRXZKtst/i2kbqe8III
         dXffaj8npU7Zz7NQw0YsNfWxiUyDINJf7gESN5/aHUqcdkYQnAbw+hSTH8scbWZao/Bc
         AWi/oTL4uFElIzCRW7IT/JikwS5O17bPakV+HZ/a1Ks58axzHZlhUO+aFAYo8Gy7VgpN
         N4VjSJdkj0bqZs/TV3uRfgm7sfYryyVt/Yzn0JLgcC5L0k6cf6u/ydaCyIbJkAV65pxK
         YFu0NWEmThfBvwNfN3zGt8TdEdm/kMyV/nsyHaqUlhOMDFJ1LBpX+WFdG0K2qpBeNaqS
         bq1A==
X-Gm-Message-State: APzg51A0H6yiDyr5XZHz2ajYbl/wl2Dhd31pUR9uusPoKQK4fHd+omjQ
        dBpswig0W7bwj9HODefWLc9NNUzrC6zpPsbPtck5yZDMtrcSWPaHCDSsr1u32/W29BbaFuLtZIn
        fEZLBZM3EqzJjPNZciTfoTlw9QHSJ3fmgFcWJOJ8uflu3VpykTyxvI1WzPJKv7P+Fdj4wNXd6I2
        E9
X-Google-Smtp-Source: ANB0VdZHSL54fZvhLCulwrz9vidGwyx8MugLC7NV9kYWQrYZSTXrKjUYWHjz4lWfFWIOpVkqVoBNDsJRTxpOFHePO/6D
X-Received: by 2002:aca:e045:: with SMTP id x66-v6mr42994865oig.13.1537469332305;
 Thu, 20 Sep 2018 11:48:52 -0700 (PDT)
Date:   Thu, 20 Sep 2018 11:48:43 -0700
Message-Id: <20180920184843.20898-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH] fetch: in partial clone, check presence of targets
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matvore@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching an object that is known as a promisor object to the local
repository, the connectivity check in quickfetch() in builtin/fetch.c
succeeds, causing object transfer to be bypassed. However, this should
not happen if that object is merely promised and not actually present.

Because this happens, when a user invokes "git fetch origin <sha-1>" on
the command-line, the <sha-1> object may not actually be fetched even
though the command returns an exit code of 0. This is a similar issue
(but with a different cause) to the one fixed by a0c9016abd
("upload-pack: send refs' objects despite "filter"", 2018-07-09).

Therefore, update quickfetch() to also directly check for the presence
of all objects to be fetched.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
In this patch, I have striven to avoid piping from Git commands that may
fail, following the guidelines in [1].

[1] https://public-inbox.org/git/c625bfe2205d51b3158ef71e4bf472708642c146.1537223021.git.matvore@google.com/
---
 builtin/fetch.c          | 19 +++++++++++++++++++
 t/t5616-partial-clone.sh | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d21..e9640fe5a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -938,6 +938,25 @@ static int quickfetch(struct ref *ref_map)
 	 */
 	if (deepen)
 		return -1;
+
+	if (repository_format_partial_clone) {
+		/*
+		 * For the purposes of the connectivity check,
+		 * check_connected() considers all objects promised by
+		 * promisor objects as existing, which means that the
+		 * connectivity check would pass even if a target object
+		 * in rm is merely promised and not present. When
+		 * fetching objects, we need all of them to be present
+		 * (in addition to having correct connectivity), so
+		 * check them directly.
+		 */
+		struct ref *r;
+		for (r = rm; r; r = r->next) {
+			if (!has_object_file(&r->old_oid))
+				return -1;
+		}
+	}
+
 	opt.quiet = 1;
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index bbbe7537d..359d27d02 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -170,6 +170,23 @@ test_expect_success 'partial clone fetches blobs pointed to by refs even if norm
 	git -C dst fsck
 '
 
+test_expect_success 'fetch what is specified on CLI even if already promised' '
+	rm -rf src dst.git &&
+	git init src &&
+	test_commit -C src foo &&
+	test_config -C src uploadpack.allowfilter 1 &&
+	test_config -C src uploadpack.allowanysha1inwant 1 &&
+
+	git hash-object --stdin <src/foo.t >blob &&
+
+	git clone --bare --filter=blob:none "file://$(pwd)/src" dst.git &&
+	git -C dst.git rev-list --objects --quiet --missing=print HEAD >missing_before &&
+	grep "?$(cat blob)" missing_before &&
+	git -C dst.git fetch origin $(cat blob) &&
+	git -C dst.git rev-list --objects --quiet --missing=print HEAD >missing_after &&
+	! grep "?$(cat blob)" missing_after
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.19.0.444.g18242da7ef-goog

