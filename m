Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3FD2018E
	for <e@80x24.org>; Tue, 23 Aug 2016 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbcHWQHZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:07:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:56487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753542AbcHWQHT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:07:19 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MPUZ7-1bY5Ug23P7-004k7Y; Tue, 23 Aug 2016 18:07:15
 +0200
Date:   Tue, 23 Aug 2016 18:07:15 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/15] sequencer: lib'ify read_populate_opts()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <85a8ec8273994c599402c380abd383ad2f539777.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M9THPmp4gKmHjOlOftN1tpPuqTPx0KiCMSrDF7SHStnZZt100y7
 A10rmPqQlLYtxqrXwv5LS7wNVsPn6WZTlQoq1rp1ZaUD7AfAqyMU9v8tr8iwCaBhMNG/gzX
 vxiA1CQDocKav6bocq93CxjUTGcy58qI9CZ0UepdcP2Xd7kj2qHLH9P6v83UsnHySYt69hY
 9b+4PsT6su8WcE8vv7M/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p4hi2ZIGjrs=:xBrSNeaDgNPdQGgQqd4MBH
 op4mu+NBMV02/nLR/SDEcaFyNaJ4xzf48aMVJ9jIFBWb8jxwPO+zT06kBW+2KGqtxKQOkgxUQ
 L3XbXqP+lGRdHQmq8hIXL/wLUKMxRRV9KUkEIcWHHO8174WGVAqZPAj+yNtAZPaJpzV58EQoT
 AOrkGOzTOkWMf9fXvLkmfml43TxGTvp6CFs1/3o8o4FOD1StY+QiQCaW2cmboZffYLoqI4hHG
 C7X8HkSG7iNTzXF3lJe4Azq0BtnrBBx+2/xxzkk1OUvE/lfWjhO0vJg0dYPX+HeU9LGlhkB9p
 xVWXNavZrvo591zQl3Y+JAWu2rxGtaJhrRZStoVobxNUdLtcnqhIO0gAyQjueksISX63j6Drf
 cilJdI3uW7heObSvRvK8f7jxbQEJHwCGiphkPbZZXwhAwlNvS+rnbgZ++/O6oh4S40x5NKHum
 1Oqc6EIn2j6pKuJFhtC2qqgLonX45PUwQ96F9JqYzP+fuWv9DyLx7WfqZH1mUnKhDrslv+m+k
 +L35YYBpsTN5L/swS+C/4LmyyEYu5erJRShM3UdjxqkAs0f8fRbzTagz9K3JN7IfOKrTmjPYk
 S2B5KBaHvNME68EU4pjP59jH12v9Y4/guD1QykwR7m6tNz3qddKuT75xn6dNB87GiA0l8Yns5
 p83TWexQNv0vxeJiLukODkhJ+tM0yXRn316f1AeAL5P6i7bfopt8w7Rgr6FWOhlfCJAq3tTYM
 +QzVjf+p71B2hsw4Dt/uiqUoo7pyQLzSwzNy+vXc4a6B1M3Ei5uSNkX3Tz8RVwhbguRrUvf8P
 4n0JTID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5f6b020..808cd53 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -806,12 +806,14 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
-static void read_populate_opts(struct replay_opts **opts_ptr)
+static int read_populate_opts(struct replay_opts **opts)
 {
 	if (!file_exists(git_path_opts_file()))
-		return;
-	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts_ptr) < 0)
-		die(_("Malformed options sheet: %s"), git_path_opts_file());
+		return 0;
+	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
+		return error(_("Malformed options sheet: %s"),
+			git_path_opts_file());
+	return 0;
 }
 
 static void walk_revs_populate_todo(struct commit_list **todo_list,
@@ -1017,8 +1019,8 @@ static int sequencer_continue(struct replay_opts *opts)
 
 	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
-	read_populate_opts(&opts);
-	if (read_populate_todo(&todo_list, opts))
+	if (read_populate_opts(&opts) ||
+			read_populate_todo(&todo_list, opts))
 		return -1;
 
 	/* Verify that the conflict has been resolved */
-- 
2.10.0.rc1.99.gcd66998


