Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48597205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755884AbdABP2C (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:57773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755917AbdABP2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:00 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKpvc-1cO4Wb414a-0001LA; Mon, 02
 Jan 2017 16:27:50 +0100
Date:   Mon, 2 Jan 2017 16:27:34 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 16/38] sequencer (rebase -i): the todo can be empty when
 continuing
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <f7a123fa9fed3d157011ac6a42123742eec67298.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2sG8zFfdG0035z6xgPCMDLXdXHzMwhfGOnFGLcqU1gn35kxPand
 LjN5exNp6z32T7iVkVnlJuGeLlBdnUStpOEKG9tq5XjbvUC6cXTZLfrPK1ZBjPk2pxeaGsp
 A+vtiQ4tH7p1fRCXNd/ao0rT6QgH8DA9agYlyNAXBYBoddKzE4/bcEGYFk2FB9k0/BY44IP
 kTE7UrB9eLX8r5Buu1Uvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0dvYfo85wug=:2TrOuHJBKV0DEVim3YQ1+M
 WZK+Fervii8NuVnwTSINkxy3k4Brvaq2YTeFvCqxF1H0zfYzLFo+1VOZu5PW0MV8qDWpSJrpm
 47kCj8TkZRomoftQbstcdFVu9fYX1cC1J466b3bGQG37OkosjvcBxYeSgYCaFE4NakzthkER+
 KZHP3QF1/8/OvMpAD+5QSH/7lDmvAPp8nKI+GOjG541TXoj5l1HlEbSl00XFxM5zAbcYNiaj5
 12Za38FvflYU89vt9E/9HEMVWXSHkBNzL+dZWTMEU1LKLf0GK7HB4APBHWHdO2CsHSHT6kcLG
 h1BEseNcpljLqEjQPYSk/rHCbrL4rhCAJkIaGJqXZAsa0VFdTUn9EzhEmFu6yp0jPVwY2uVoc
 2Q1oBot46xC/440HbrzD4Y5HrFBIJ4DTq/gyvKpvwTXgV5GCAwegwhp2w7dKggCsSFtEFTMu0
 dneQeYpCfchs0HTfjZTRUrirh7xt1ngbfgeEGtoTD2vVhTAEBtkR7MOjHVeYOmGQOnNq3elu/
 /LKgFcdeJVwphlVbEE0Uq/imdkuzMrsRjylAbBnqE5SbEWk3fLfc2LgIcq8yEOnZGTF4WjsBs
 WG1YKfpLwCNKuMV6jwrQdDn1dwJGawWLm00FBQ8gUw43fuER9hF63CZhpeVWJx6ex211mQT1n
 gq6KUeax7LWPtNqAepYDjYkDfTr71yYL+ShM3y1Ey3PEvtC5LaJe3OlBsazGHEi4LXls4SElB
 qiAYGHa8bfIBRhS/EaDQ67tVGM9FAGTVJuSYr9+IQN/hAn5TcNZzYK3fHRGAuACS8F4KKA0T4
 j7CiZx0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the last command of an interactive rebase fails, the user needs to
resolve the problem and then continue the interactive rebase. Naturally,
the todo script is empty by then. So let's not complain about that!

To that end, let's move that test out of the function that parses the
todo script, and into the more high-level function read_populate_todo().
This is also necessary by now because the lower-level parse_insn_buffer()
has no idea whether we are performing an interactive rebase or not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a7b9ee0d04..6a840216b1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1215,8 +1215,7 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 		else if (!is_noop(item->command))
 			fixup_okay = 1;
 	}
-	if (!todo_list->nr)
-		return error(_("no commits parsed."));
+
 	return res;
 }
 
@@ -1240,6 +1239,10 @@ static int read_populate_todo(struct todo_list *todo_list,
 	if (res)
 		return error(_("unusable instruction sheet: '%s'"), todo_file);
 
+	if (!todo_list->nr &&
+	    (!is_rebase_i(opts) || !file_exists(rebase_path_done())))
+		return error(_("no commits parsed."));
+
 	if (!is_rebase_i(opts)) {
 		enum todo_command valid =
 			opts->action == REPLAY_PICK ? TODO_PICK : TODO_REVERT;
-- 
2.11.0.rc3.windows.1


