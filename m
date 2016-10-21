Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49BE120229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755445AbcJUMYu (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:24:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:55368 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755429AbcJUMYq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:24:46 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LuxG5-1cxfmu3sCv-0108fs; Fri, 21 Oct 2016 14:24:38
 +0200
Date:   Fri, 21 Oct 2016 14:24:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 07/27] sequencer: refactor the code to obtain a short
 commit name
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <79f2fb5e2de8158db6516f4e9c8eb0f5cce6ddb6.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:z/F86sy1n/XCB3D2UMvfbARdQG81gFx9i2+dEOoU1q3lz8X29/U
 2NQBBGr+hynO64+4U9xM3tV+AtIjaRM+pxCYqLnXDU8EfiuG4Gg+b+W3bssxVCaD8BeONaG
 njMQTsq6CkbSk0Ko2Qr4aNoLWKFEEZK3qfVWaLHGG0B3k/Bf3JEo8xKNzLMDTj2pvEyWT5v
 pIEh7hvrCmyfWYHIGYtvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I0zJGoD8uOQ=:RBNl//CKYhGzrK2HwLS+rw
 MZdmnuGWKeFQQ9hl14DooJYHyFLhwtFfGWiNcWDBPE3ooO7iOtpnP44LJP3xYMg8WKvtIOyPa
 KqgFQEst9VadYx9SKY5E5C3DwDNFMlJn82WE+XGlPb6/mC18LHHYn1gBHUT1PszL95EEfH9NK
 0h5GHaBOcqDUvvIuQlSon054tXLVv9ajPC+BazvqSXTSyYimYfYtFbe6976hKH9465t1Gwn2Q
 Ow0R39G6b4CS2RP8wEmBkmrVg7W41LzI4nL6gPxnhi5Kjl3AuVSJL4h8E9qGR0HgVHikrLSBg
 sW47HW3Nodr0wYrtjDUIPCiRI3q77Z+baY/RBbaB4FsqsApqhc97O4g8hxv2VC0URgkjVsaZp
 zEs4WWE7BWlSYng+RBT8z9u4lgbLxZHHE7T4x/mxdf8+Cq5bSJ3mo9QvsDtkePSYnASzzuUW3
 2q0urpI2bkjVPgTuuQ4AkomdJLBRmXprxhX2AiG9RAunXZ6bhk+Tep7/H0LmCJBvQDXrg76or
 6kEbEHWePSTSlAJI2xDDzmAUj7vbtcG5M9DQSnnINLspzLeuwZcXuPrfRMGE/IfTk566EhvQw
 Wt8Vt6LD0pWv8mzDOYeXq6GQPJQCUHSwkD7ninzusV8qjjPa/o9sRyuoeBJjNfnNfjWjAKnMD
 c37OnsQ83ID1l1oe6eJkTVLdfez5x0PCY1Lb916BijxqvndEIhS/8M2g8IZQzyOLyNF9MciSp
 QRkihEaXeWGwxXDtAxArlJCJ7CZpuUqLpiFBC1TXBohAUI66sX9YE8D5tpNTAUwB4Z/709BNF
 gaDXd6I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not only does this DRY up the code (providing a better documentation what
the code is about, as well as allowing to change the behavior in a single
place), it also makes it substantially shorter to use the same
functionality in functions to be introduced when we teach the sequencer to
process interactive-rebase's git-rebase-todo file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fb0b94b..499f5ee 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -147,13 +147,18 @@ struct commit_message {
 	const char *message;
 };
 
+static const char *short_commit_name(struct commit *commit)
+{
+	return find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV);
+}
+
 static int get_message(struct commit *commit, struct commit_message *out)
 {
 	const char *abbrev, *subject;
 	int subject_len;
 
 	out->message = logmsg_reencode(commit, NULL, get_commit_output_encoding());
-	abbrev = find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV);
+	abbrev = short_commit_name(commit);
 
 	subject_len = find_commit_subject(out->message, &subject);
 
@@ -621,8 +626,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		error(opts->action == REPLAY_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
-		      find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV),
-		      msg.subject);
+		      short_commit_name(commit), msg.subject);
 		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
 		goto leave;
-- 
2.10.1.583.g721a9e0


