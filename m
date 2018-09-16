Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF901F404
	for <e@80x24.org>; Sun, 16 Sep 2018 07:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeIPNMN (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 09:12:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:46535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbeIPNMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 09:12:13 -0400
Received: from p2520la.lan ([79.218.121.221]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQiVh-1gOv2c1G4z-00U579; Sun, 16
 Sep 2018 09:50:03 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        pclouds@gmail.com
Subject: [PATCH v5 2/3] Show the call history when an alias is looping
Date:   Sun, 16 Sep 2018 09:50:01 +0200
Message-Id: <20180916075002.3303-2-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc2.1.g4c98b8d69.dirty
In-Reply-To: <20180916075002.3303-1-timschumi@gmx.de>
References: <20180907224430.23859-1-timschumi@gmx.de>
 <20180916075002.3303-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PKAturQgPOTMKcv1qC3hMF2mrjOa0tdaT+9Xn1j4y+VgU640EtG
 Kf//45CMgVFyvtBmLemu9hvffsQCYdwMagH02xPolKIDSDw+dqMQcIDOWXZe6kqCF4mBRp0
 qlQj1hEd4JqbvqQUkhTTQm7SMOCHrRemkIUkEK3MyULgFwjgNLX+MbSNCqp4iIvzwyA7NGj
 IbC3UIQr67IpP9dtyc4GQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gFYw5JgGfLg=:e+PHXh8pSBc1pQfvpszLXg
 3GwcaQeSVTtoNPGkS6VjoFOsVt5MvGAYmTLVBte/Q5ltstXia+EobHoSz8aTCR04IzkM9C5Jj
 cR5H3OfFSLBUxYDMQRyUSORa1SLAmxAtwlo168lkteXB1QuRRgeg/gU1UsgFE+7D8NT+aPATd
 zLAfiP7cLk50b9Xy4LbbJ5pRJUi1GDKRNK8gsrXueZEUXdylYjmSyJyB5O0UdD8ttXjSr4Zvc
 c5tm31yhxtGy1J/I5ycjsDY6K+7IUlusOA/qDX6pwbH5hbFGQ8x1t+vVxlkEKIszrgv5Z1vb6
 prlvGIWDK8/pKEUW5HCihwpvHwvvfGQx0f+PUFKrODTUahWRHHuCWEXYx/LyKXfXpePCzKrQv
 g1MU838i9KQpsHP4uvD2BlwKBuK6rCpvhBR0F2IKo66Fv+dtIevGzpG5JcHXYV/MgTMSI9WRQ
 VeH7yBd78lWfS2X2oIbj7+k3HsUT9louQIeLoYRM1+leUax8fLxvTbUGaqOF3NXviOfjC9Vd2
 3Y7y2umTXBwoovA5kiUsE8ui55tk7+Cpj3FkV7FmUadbvAWJMPltYVSvm7CJSFgeRvr/B5Nud
 NcvT2VBkXtJJGOC6RtFZTUxscoIYMJSkQj/0aIBqiyq1al0l1RGuL/zoJa29G8N09+uKlFfqR
 aIWDcZFheZPXxVZNseG4goyLe1zMHDS95ArGOjFXknUYjJoGWygVqFRZViGMFvNjZ+fVRQ2d/
 rCuaNWLE4AeB9Ki++bkYi1R4C+OJXrDfMQPr+vsjtWGWvMZBQOOdW1X6PPk0MjK9TpSrCLWhH
 IHLH9cIBkd+GbtyfvNGCef7+L0NSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just printing the command that the user entered is not particularly
helpful when trying to find the alias that causes the loop.

Print the history of substituted commands to help the user find the
offending alias. Mark the entrypoint of the loop with "<==" and the
last command (which looped back to the entrypoint) with "==>".

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
---
No changes since v4.

 git.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 15727c17f..a20eb4fa1 100644
--- a/git.c
+++ b/git.c
@@ -675,6 +675,7 @@ static int run_argv(int *argcp, const char ***argv)
 {
 	int done_alias = 0;
 	struct string_list cmd_list = STRING_LIST_INIT_NODUP;
+	struct string_list_item *seen;
 
 	while (1) {
 		/*
@@ -692,9 +693,21 @@ static int run_argv(int *argcp, const char ***argv)
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
 
-		if (unsorted_string_list_has_string(&cmd_list, *argv[0])) {
+		seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
+		if (seen) {
+			int i;
+			struct strbuf sb = STRBUF_INIT;
+			for (i = 0; i < cmd_list.nr; i++) {
+				struct string_list_item *item = &cmd_list.items[i];
+
+				strbuf_addf(&sb, "\n  %s", item->string);
+				if (item == seen)
+					strbuf_addstr(&sb, " <==");
+				else if (i == cmd_list.nr - 1)
+					strbuf_addstr(&sb, " ==>");
+			}
 			die(_("alias loop detected: expansion of '%s' does"
-			      " not terminate"), cmd_list.items[0].string);
+			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
 		}
 
 		string_list_append(&cmd_list, *argv[0]);
-- 
2.19.0.rc2.1.g4c98b8d69.dirty

