Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059CE1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756766AbcH2IGt (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:63209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932522AbcH2IF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:05:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lmr1w-1bCeO02lrQ-00h8Xk; Mon, 29 Aug 2016 10:05:48
 +0200
Date:   Mon, 29 Aug 2016 10:05:48 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/22] sequencer: refactor the code to obtain a short commit
 name
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <4b99922194d97f012459a473da48ec31d18c687f.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/nng7pB4Kul4bJNqUMWvPAVtvVcGvdZMZfVL69nt8mPbyGR5Ae6
 X3RIoAqxt01y3uCIgV+A/SpZ4cjbbQxdoOBgs2ZTU0OXe0o81qzpigDVQagDuyG8ILQoWtV
 M0NmCSQ0UFf56srDuhs5F616lSl2oTWnk+sjqieTuP+pZJCMr6WNs8QyKY3c4OWoYTSnlgw
 fPLTUFAC0bV02kCrj8VVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eO/D+RDp6l0=:yuxslsC05EUOPGgY3znCm4
 iC8EVos1bhWTKL68MDFtaCiIpmbzPNqKi6km2nDdgDcmdnEDiHwbdJwuRltiiqcFyYaG8dxai
 7W0pFWmdSwlxkTtyRmT0p8OshtawqGYE7CjA077QbAroccQz/yDg5mGr2zMffTnzfLNU6DRNm
 WU4KpNsEk0lG6HxusWMkddMCXn/+hjgDXDk9sYGyqZBP9ZkgqbnmXgOdTgh+uFdtDC2P9FDO0
 Yur8y+ClAw0xPbfIJW3RT6tpIj0059pTnsWSFNPPIZ2LVc0miNwcXZEFV0wHORI2L6cNY63jX
 VTvtQIAF5b54P0iIrfor0n0+qJoK2g00t2kGGN2zQHYEXpC1eLrN6ZzYcNxSggwCjqN8f211M
 2bqDaaeFHLkIeUbf0UI0iVuzs9TVMhOAGrUPezZ0dw8fa5Ev6WXRTSdCnLbclNjPaDq+gw4ee
 s2V9pY0hPNaZ2Oziph5Fv1gesG8NXT8ULso9IwsiN+qK3ay3nYYWAnj60ULlHRV91fqQLMDv9
 s9eUqlNPOF2D3guJJ9tYzrjF6SF9z4186Rb8HpAEJNdtiqBaI2MASshP+o8gW85LIcfPDo4WX
 gaWKQkU6aFSkmlDm63tiWLA9geQ9vCa+ZlvymHLuwiS4o3Nx7XoHI3w4Wiq46/P6JyvEIVUg+
 cGZOpCztHOb/F2AATqinPXTL77YFIPBXafoX+PZPqurFTm/wX8/I5jQJFgP4tp6ukgbSRcL9l
 Pnk/HpCywyHLiTBuyvRGRzPF+cK0S839i7NQadr4CaA6xcqkuzAwr7tSSKE648p9NEv3MQHCW
 g/sRAY5s6y0V52VDDpLaAVKv4ZcF74J0AbP+sOLK2ipFlpkXe/H8bWItAL4jZGR6ipiJx3Yl5
 843vd84dMN8j4Zfl/eBclIbo7ntfm7WOyKaj2nPkT30Utob1Qs/xU+veQcls0kJ63KesdDnF1
 DDEuhSxackF+vqCgcZV9UR+5iukCtfD8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ba1fd05..06759d4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -157,13 +157,18 @@ struct commit_message {
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
 
@@ -647,8 +652,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		error(command == TODO_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
-		      find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV),
-		      msg.subject);
+		      short_commit_name(commit), msg.subject);
 		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
 		goto leave;
@@ -880,9 +884,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
 			opts->action == REPLAY_PICK ?  "pick" : "revert",
-			find_unique_abbrev(commit->object.oid.hash,
-				DEFAULT_ABBREV),
-			subject_len, subject);
+			short_commit_name(commit), subject_len, subject);
 		unuse_commit_buffer(commit, commit_buffer);
 	}
 	return 0;
-- 
2.10.0.rc1.114.g2bd6b38


