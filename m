Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678CC1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbcJNNUW (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:58066 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755618AbcJNNSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lm7MT-1cUNBa1hzN-00ZhTp; Fri, 14 Oct 2016 15:17:47
 +0200
Date:   Fri, 14 Oct 2016 15:17:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 07/25] sequencer: refactor the code to obtain a short
 commit name
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <da12dda5acf5ac3c1c1d08c1a941de0f193909ea.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RUaN7EReaIrwajJU+CSPleyMmz4FUZ01ijffy22FqK6EVG4aUHY
 pg7OzxHTolo3GliY4Thh3s5YvtnEnMUnbOf/LWRVlOA0Ast+PEDNnd1L9LmcYef9/162Eye
 14Z9pzpM1MwMZzTTuFyQPbhRui5Pw0w6llVjbz5LVmwvno1wJgiVBlj+xtDiQbkmIlCnS3v
 XeVCHaCG34RYF0E/M+0Eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5680Hp/36NM=:Xjbgkb2YqvcL9hhAus+Rms
 AGitpwNahwgB4boYi7krf2vWJgN+7L+IBh6OKRBJZ29XHQUyKqUW4ZHfBHnbgeyPzkACLjRNR
 LSnc1qxsh829Bsb2qDGAmuOFieJr60j7hc1pPwxJoNm7We7Jcj+NWv7feIOiEk11OvRHqfzgz
 MjeWqZzAIKGNh9rFbWv2oY3TZLSsn0G28AaLUeo9RvZ+AhdXQXikEexFQRqCVj2wrnwBiQWuz
 aUwfGhhNO0MdDUuIpAZtHZ39T0xgy+1sJYMRATvT4WnDnXiNLA+7kY1KVjiKIcQh9WF6nZXbL
 gGe2L50+SHKwGYj9MoEQIaFH401QLTOEoUjqJ8y7FSlJd15BNu3doLpX2049gLXcnaRhIHpl/
 AOlJgcjGVLpkI+sUXOahWm3WALOeSc8p9iQ4suXFzcE1g7NHYm9FynLsAvwdAL32GLsbg3OgW
 XgLMG7OY6CRS+kZEBb3PHoedh4wxBXVSVsdMeKzf+mksq5vOlXg6dAckgBHgviP/TCCnHQ9FE
 uRw/N4fGvID0u85Kach/FQAz7pPPjoPIPZkWi16oRHvcD70/CD5LToEHP+NxGhoGMG0C9ai0/
 Ag9y+hyTV0c60R8WlFZznBMfRf6NFaVICFidzSuDjg0ZRBwrvRdaf7bbpK+yN1abivd0ILFn1
 MibrO0KgoNGuqWHQOgv86Zgd8ATFZ5juYVEAcFobengg1DvLlZJQHLxjUQe63qZjl+1PwUbhW
 3KySWVZ4/icDFsuMQY/XsW194AatGuIKJgf4ApiDujIaVvJxISQnbTBuuoFwVgMamUTq+l7HS
 ne35u/e
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
2.10.1.513.g00ef6dd


