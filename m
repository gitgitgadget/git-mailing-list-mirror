Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA2E203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757070AbcGZQHB (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:07:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:50635 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731AbcGZQG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:06:59 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MFdDB-1bV9x80pUb-00Ebp1; Tue, 26 Jul 2016 18:06:51
 +0200
Date:	Tue, 26 Jul 2016 18:06:38 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 13/16] merge-recursive: write the commit title in one go
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <882273dd0067de30fe4b672050457708d56f317e.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0ZQ4BPMr4X6QbCPMtw3tgwIx+qqToaRKTNmvAlhYsFjzqPRGISp
 u8g+Rh2Q7fFMtwmVPRu4JbKyEkoMVdZ31S0cjMb1ngp65O4qWXH2gUSUakf81/20VoU2/hQ
 zmymb9vf/EcHB82JJocXhuwjrHyr5jlIwSvDvg0f0WJMOqw7H1d8pDqz5iDKLT7+zMiY+h3
 MEURuPf6OTPWl47CCN9iQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:s5JbB8wU+34=:l+0iUqCtamScwP1xKDrRcX
 oPlv32tAY7pKL7DzLupd5z5Xmfrd+3O4XUewajMkIS2/DySvzPwzg0yQqpSbXoXyxhernL8TP
 itqoW+C27XPacFPyuQ+z+1WwU6IOrl8EwUAE90OWKu3IUvezRgrvbsGTfLeSl0x0NozujYTkV
 4icf3fdq+MEWs9OFtcV9xtYci5ez6mrRuhqUTRPj+LyojkaUape3DMgwUOwpA7AHw2XZbKKUo
 ufD9cGEHHLrms+KSvrBvYzW0EcT54kqnq+x5vEreXJhvZRKaeFl65g/fIwS0du4bn0xUGc1t5
 GVoko6Bj1Cj461ulXXcFxz4sjTn+fvcPOUvHWZ3ZiKLKQ6GFPjuKPS/HI0mLxjegeTGQhrXzj
 7wyxHRcU6KcTQWHhNxpLwJUsVr8t9VzxQW76i3G56rXSAduso4SJVPq/0tTkO4cro+6C9quab
 ZiOfJsJJewdZJCsNOTnFySTzYqClF7TsfDIy4YzO7hV2kGHP2NFzhTFOXllAWKl8qM66dm/2u
 SnYtNq0guEDcyGLUjHWKiXxKrss/NbF6hOi/9JMj8V16kx12wDkOMP7E1AGdeQbLphAY7vcUX
 EMJx9VpvhG4XK5zz0y/8kAEjaS9K+S0KwFjh9jT+fKEJa/taoqu5G94qt5M9UmV0EydfZVMww
 /DeBgV6mJmuPlpOHnPsEDTYXDtPx4Ncdt66pph95B38Az76RulaJgauKpKK+8WPmb6L7FviS3
 yigsuPyjNyqwqynU6MqDgdxzyPHys10cjLPSMUk1HqUTkDCWNSDVOkgAQOpRjXDeNsksjmI/Y
 ekvZCli
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In 66a155b (Enable output buffering in merge-recursive., 2007-01-14), we
changed the code such that it prints the output in one go, to avoid
interfering with the progress output.

Let's make sure that the same holds true when outputting the commit
title: previously, we used several printf() statements to stdout and
speculated that stdout's buffer is large enough to hold the entire
commit title.

Apart from making that speculation unnecessary, we change the code to
add the message to the output buffer before flushing for another reason:
the next commit will introduce a new level of output buffering, where
the caller can request the output not to be flushed, but to be retained
for further processing.

This latter feature will be needed when teaching the sequencer to do
rebase -i's brunt work: it wants to control the output of the
cherry-picks (i.e. recursive merges).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 71a0aa0..723b8d0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -191,25 +191,26 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 
 static void output_commit_title(struct merge_options *o, struct commit *commit)
 {
-	int i;
-	flush_output(o);
-	for (i = o->call_depth; i--;)
-		fputs("  ", stdout);
+	strbuf_addchars(&o->obuf, ' ', o->call_depth * 2);
 	if (commit->util)
-		printf("virtual %s\n", merge_remote_util(commit)->name);
+		strbuf_addf(&o->obuf, "virtual %s\n",
+			merge_remote_util(commit)->name);
 	else {
-		printf("%s ", find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+		strbuf_addf(&o->obuf, "%s ",
+			find_unique_abbrev(commit->object.oid.hash,
+				DEFAULT_ABBREV));
 		if (parse_commit(commit) != 0)
-			printf(_("(bad commit)\n"));
+			strbuf_addf(&o->obuf, _("(bad commit)\n"));
 		else {
 			const char *title;
 			const char *msg = get_commit_buffer(commit, NULL);
 			int len = find_commit_subject(msg, &title);
 			if (len)
-				printf("%.*s\n", len, title);
+				strbuf_addf(&o->obuf, "%.*s\n", len, title);
 			unuse_commit_buffer(commit, msg);
 		}
 	}
+	flush_output(o);
 }
 
 static int add_cacheinfo(struct merge_options *o,
-- 
2.9.0.281.g286a8d9


