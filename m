Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B2E20285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdH3SUQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:20:16 -0400
Received: from mout.web.de ([212.227.15.4]:59967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752069AbdH3SUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:20:15 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKwFs-1dn7b32BzU-0005Qh for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:20:13 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 21/34] refs: release strbuf on error return in write_pseudoref()
Date:   Wed, 30 Aug 2017 20:20:12 +0200
Message-Id: <20170830182012.21066-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:g3aVB9KGxtZja6muKc1u/Qp2HMRMNz4BW5i8ef3lqLBcBM9VvGN
 IvkcJjBNtff8oRIJtfF1ljKcL6h4w3qq6fkHGFPXYWC87jFlHRTKuAS6xp3Q5QjUP8BKfXC
 C7yNxgNtzgOJ5886R7IvC4YIsRoGktzdb0dVFWBxzUO7JJ9VEAeoQfNVbU5wJ88yM/GATwp
 F1p2pZHF97eUUyk5fpeWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XTa0RdDqXSY=:XorRIWGYtq4yz4+MhvJw1p
 F6k0gJ6KQhGVqU4M9KCyZBGNGohzQrd3nBXckWnpz/i4FPzode5cgtCCDEvl7/D6ya09o/C3W
 sKuQ8XB6ZgSkmfEfqHEzNoIC7ldFLWHa0KUqKMcaUGADq7B/f5aL9J9NzN3AiemnPQC1Ac1Qy
 848IXbyrGA2gk8pFGQV1JHpdIh0rgKtSTFQ9j/3UHUAOQjSyooHFXDb+ewHo2F5S1U+ZvseZp
 /bcySSzqUvg+ck48Q/AgmkeNZnYfQJRB9bTkOFVt8JaF2pLNVPbve4/HYZsVQjaKMg45OsfhD
 nikkh01U8iI2Re5xNPGq0tITuMvjQQOTDap4U/qTtOHPpQ8Q+yXMqb2mbbCwTSKSjA2kYHojn
 HvpBOEHqZ9GwmYfe7YSitVvOQmERnSsiLACxNwlTvSF9LqtYuSZGvICQ0OjOjMt3VVbtYAZFd
 jY1yo92ZCHhBhlEohR3btYYnadj1zWP5FUqCY7odRhaQKaUvOstpq7P2R6moYwkyJGo0p5aPy
 N5OIq9wQXwolEtTWklQdHe4WfCAiVMSloYps8vyrrQOYZmxRqC0kG8Gu1mwGE8lt7ZghgQKWG
 RmFJWXf1ok/BX+3HEV/+XU+swSvstk6D+b+njGYCYo3ZVKXHqreObztWYcbNItUW5ojHe1XPb
 ekHhXmTvyyIU5ckzkwaGM/Dk/p0MvV9YaUh0F2VmMm1RyNPbzAQFZQ97U0g/4FcgnKlrwsY77
 x2tXMFRJG49XPXKlewXQ/7ylQLiRSaC2l9amjZmVhSNbula+2PkWRsly0U300HDTAO0pIJvkY
 LQb5mw8v8HMbOkowtJGO4dmknEWOw==
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

