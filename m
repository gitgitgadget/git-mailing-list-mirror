Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C1920285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdH3R6b (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:58:31 -0400
Received: from mout.web.de ([217.72.192.78]:56967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbdH3R61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:58:27 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZvUH-1d6JGZ1xJl-00ljYr for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:58:26 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 21/34] refs: release strbuf on error return in write_pseudoref()
Date:   Wed, 30 Aug 2017 19:58:12 +0200
Message-Id: <20170830175825.20905-8-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175825.20905-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175825.20905-1-l.s.r@web.de>
X-Provags-ID: V03:K0:j6UIKbyEUiWPpnyTuhUi7U1qtCCUob3vR87WfBwnyEMjgwj1wmP
 Hw8ta2I3vGrSxfofOl8eMW8l113gDUE2gyrg1uUCP64VXf8agF1qd6gZ8oridRQAdWBsjuA
 BVp9n1sv52MVrc4JLv2w9PxVI6PPi9am1jorRr3F5uduNkuOyEi9UNZtKOBs4wN1esf0XcQ
 Gyw+G9TLlJUPMnR957+yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3PVHUlRiLuw=:cdzURX4hOJkNfAKTiTAKcx
 bkoUQXw2JMd9MBdBSG0mUcMWMTJtLENV+x5T2QKOuaMDA5uUos6mDrF4CE91ozooX481A3Ujk
 oiDwgyRlOIL3EEvAIK3TquLA4x2ICNxsvpeLKFz1Ye/4QdVelHPo+PHDIj4ppyWJfQm1lYCo0
 O+JZfbAdgEwEp/MDWAGLMgr41SKv6/mUBl5410jSVrA2g4xrfAhTMDOBIyhZo2TZVXD0jwDVP
 3diNS2RFejhCdfCWF7kncvMDO4L6zK+LFxb+JjOvheNaIXeBUgEO+h928k3UcVKJ0tjsjzh6+
 Z5BBBGVD3iCgYVezB+xi7Ls0QD0VDlmWcN9jS4zLRvcXmCW8Afr5J8+TilLQKrR2HtFZdkFOu
 ROzdPXeAoKoeR/yMmXg06v36Dt5LXmiLlxDdlMmm0CaU4tNgHdJ/vfWlr+3wbCV++xi/yhxv5
 HbNDdDIIxVs1m0UN1MVG/w2u24VeZPwtQulo+b1DGC+lHGIqsk6ADE6rldJ8a1WelQcH5GXwe
 gR34nXZyazkjOQ+x3kRb+pZFR6zGjVJNyDyjnP8ukdsvV96SseijSm0C/z5mpzgrPU1nwIGDu
 DfaczAGdkYyUoJL5flZnMYi5YHTybkaRJ8nPpb+vsPNj6YSRF78kQaQBbcjzl9HSjx19ja6WH
 GyIyarlfgJWY6hSKzRYlelt4eaVCkuGufifQzSz7JRPWmy+I+kI14oAL4pagvOmylVDN8qRTO
 ITzYv8EuJm+MN3EcK4pVfY3o7GPQ61uiBIYtZ2kTWQihALP6KnafKsUIqT+772X1iJ6khj4MA
 A1Qzq8T+UUIVK8w9Yotv8bRERQIDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index b0106b8162..d8dc86b1f5 100644
--- a/refs.c
+++ b/refs.c
@@ -597,45 +597,45 @@ long get_files_ref_lock_timeout_ms(void)
 static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 			   const unsigned char *old_sha1, struct strbuf *err)
 {
 	const char *filename;
 	int fd;
 	static struct lock_file lock;
 	struct strbuf buf = STRBUF_INIT;
 	int ret = -1;
 
 	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
 
 	filename = git_path("%s", pseudoref);
 	fd = hold_lock_file_for_update_timeout(&lock, filename,
 					       LOCK_DIE_ON_ERROR,
 					       get_files_ref_lock_timeout_ms());
 	if (fd < 0) {
 		strbuf_addf(err, "could not open '%s' for writing: %s",
 			    filename, strerror(errno));
-		return -1;
+		goto done;
 	}
 
 	if (old_sha1) {
 		unsigned char actual_old_sha1[20];
 
 		if (read_ref(pseudoref, actual_old_sha1))
 			die("could not read ref '%s'", pseudoref);
 		if (hashcmp(actual_old_sha1, old_sha1)) {
 			strbuf_addf(err, "unexpected sha1 when writing '%s'", pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
 		}
 	}
 
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
 		strbuf_addf(err, "could not write to '%s'", filename);
 		rollback_lock_file(&lock);
 		goto done;
 	}
 
 	commit_lock_file(&lock);
 	ret = 0;
 done:
 	strbuf_release(&buf);
 	return ret;
 }
-- 
2.14.1

