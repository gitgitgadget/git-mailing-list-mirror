Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5922018E
	for <e@80x24.org>; Tue, 23 Aug 2016 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbcHWQHi (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:07:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:64917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753283AbcHWQHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:07:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MUTSJ-1blkl11d7T-00RLk0; Tue, 23 Aug 2016 18:07:12
 +0200
Date:   Tue, 23 Aug 2016 18:07:11 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/15] sequencer: lib'ify read_populate_todo()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <0de75bbce8ade0c6e5cf87d3647faa71a89c6275.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4fby13CTU4xuvRWPXulLYCXe/hGtquzAj6sdTlGWhnB8fksxem3
 Oj8yUDydiI88cnZHxtc2RzVQW9XpNTUiLHSc1mDgP0VIx2NL/EHvVm9n9QBC6zY/CDEvBr5
 w3hbFphkXGHOPc7yYOxi8B6yKfcF+Rt2zHrq2AHTB5mQtE2QIyFHr/s36jd9TEURh+jfR8h
 W6DaaCQfCxXbHqrgGv5AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hw/wHnJNpWs=:1lxXZFE+U/XoBMnRsbPWzi
 bKjwXEPJ4XnSutGGeJJR1El1utUl6KACywmLJp7frxh7u66V5BOCIKesnnvCKwktvmGmURM4h
 0bXch77Q1uEtc1hZ0IWiV/qTWlDCj31LHPehrZne97ZOoeUJa2PHNTuNlqUrhuSot7biqPmmp
 u+OMDuqG3XtsIOIpqSZfEba38kr/RuOd9iKpNAahVcfehd5HjY1XsJGN87P63vAh29Qi0NL1t
 Y0N9cPt6MKwxe0Gg4opbUNrjeSTLwS9hM05p3/eismfuQTQPAfjdIBJEzDz+D8zL0bwwtiNpr
 nPPtm/yPxpd9bwKuLZWjG+AWOSFnPqmKnf0SOdgY+9y516mCwOuR1ZrihUM8H9aKVP7pUyGls
 Tvee+O7jve9SzMjkHKNxCDzbSO2q24GDO3r7qGnZejUOkG6EgvTeq5GXzHnaikFP3bYUyrImF
 70hwnOgUMkjyLhHbOp4a5Lj80TC6ibeXiti3ytTXxw0/plUYuliGPV/8Y3aeBUEqV/f3WppP5
 T8fBV0+AUx7GQX7yWNgQro1QUJn5530/BwMC8E9aoRkhcMCetamJ9SMdSdm/9VevdvmE8j+u7
 1WuceWy1bYfphXJFhu764jWxuofv8OL25G+/44ye6VovigC5mn9GtpW/DfzncudpwcujuKlxD
 tq7WeL5bfV/xgBvbxu9DgVBGV/yuTvEDV+XRmVivqbg9GgDa1oYc87aQg/HSbIk7xCDDHsLeJ
 //i2jUtIz+fSmJu7u6UPulreN7zafBOMDmA9mnRUNprOjYk3vr9zvS7JBoSCGx0vwpjOJ/AOQ
 w8q2Bos
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a8c3a48..5f6b020 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -746,7 +746,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 	return 0;
 }
 
-static void read_populate_todo(struct commit_list **todo_list,
+static int read_populate_todo(struct commit_list **todo_list,
 			struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -754,18 +754,21 @@ static void read_populate_todo(struct commit_list **todo_list,
 
 	fd = open(git_path_todo_file(), O_RDONLY);
 	if (fd < 0)
-		die_errno(_("Could not open %s"), git_path_todo_file());
+		return error(_("Could not open %s (%s)"),
+			git_path_todo_file(), strerror(errno));
 	if (strbuf_read(&buf, fd, 0) < 0) {
 		close(fd);
 		strbuf_release(&buf);
-		die(_("Could not read %s."), git_path_todo_file());
+		return error(_("Could not read %s."), git_path_todo_file());
 	}
 	close(fd);
 
 	res = parse_insn_buffer(buf.buf, todo_list, opts);
 	strbuf_release(&buf);
 	if (res)
-		die(_("Unusable instruction sheet: %s"), git_path_todo_file());
+		return error(_("Unusable instruction sheet: %s"),
+			git_path_todo_file());
+	return 0;
 }
 
 static int populate_opts_cb(const char *key, const char *value, void *data)
@@ -1015,7 +1018,8 @@ static int sequencer_continue(struct replay_opts *opts)
 	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
 	read_populate_opts(&opts);
-	read_populate_todo(&todo_list, opts);
+	if (read_populate_todo(&todo_list, opts))
+		return -1;
 
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path_cherry_pick_head()) ||
-- 
2.10.0.rc1.99.gcd66998


