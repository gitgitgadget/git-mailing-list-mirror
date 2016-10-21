Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D376F20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755472AbcJUMZJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:25:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:54750 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755451AbcJUMZI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:25:08 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M6O1v-1cqV2l3kwl-00yNGU; Fri, 21 Oct 2016 14:25:01
 +0200
Date:   Fri, 21 Oct 2016 14:25:00 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 12/27] sequencer: remember the onelines when parsing the
 todo file
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <f04cdced2060e8c813db0de513856206a72cb921.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2r0OMfpkXxS64ZilYUDKbU8Y4EkYA6TnweY4wtRAC+RGYSM5ZDW
 +7JNkx6JCaWg1rykTPalbhGAiWDVoknkwJoHDc+ICsUVR5Laf4iDz2PGdH9akRkAi1ybKIm
 I/id7TbijnE95aJnKJgVzDcWcpc7Hfvyt3RelcTB5APtPZVSHoG30ccVefYJLha6QjR1ZFj
 M4VTRFATM219guE5xOFcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oLwpwEWN9Hw=:YAU4HY+Bwgr+L4b4c/eNar
 ULaNgbHmBUXV1Hg+obkxB8vVcqLYuVbNmSIT6Io5T30YJwdoIS7EC6UCO1IvNCqTjro+UjRaQ
 SK4mW4CKlSIac8z9x/Fyeu1PQ32CbshAo83Q2VuWHz4ZKLJp/7ZAANSvarNe2TV88LCv1Fylv
 0VeGoRCPWdHZ0PLSQ4p1aWroxdpRowQSiixggEfXNEtld85Zuv2kytLQPUNEwPZ6zO/kE20LK
 4bIFZUaeCit3q6NfEirnEnEqLowPtf2M0KPrwimEbpj7+3glUEwxyJ5jaXh0yKtXWJgiqUoaA
 6vofr1d/LiIE6d0jKD9g2A1gXeOpusje5fvv8hyt2b4kJhCbr3k/xM5PgLz/jOjOsusB9CvmS
 l3P+liomUJ+qeAxBUe6bNJdsJiRSuyqR6Kln2Ohs2reD3xkeQkpEejxSdQgEUqxYESO2MDLNJ
 7d/RXe8iCPPm5IoiBh+a8YRZGuJEC4WUhFiul8iOhrGsKcaLnR/Bc9Q9Z/jMkgQf5K/sc2ptC
 zOnVNXR7QYyxepb2b9ph6zSz9p/qMn4eRloJKQKEOytAXzzBgs57psCftjgPjEitDjirWGwBE
 CCV9pHMur5qeaq3yt3maU/0J+ZOhcz6BeK1rNtO+VPnORN+ka9qHKInKjlpD8CyI4lQGqOCCT
 tSH2zSqrL/wQbaiTff0Vuy0tr8YaHKqoBkGORicH9JXF7R4Cx4EfSTOFX7HeaqqsKTZNOD31E
 E9ZTW5JqzyWilp1d5XAjQ5nfJNsRDiGEhjAPx6LYbcM5KDsWOyikPcZcYPOySbvm15Am0/TMU
 hkvJHyt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git-rebase-todo` file contains a list of commands. Most of those
commands have the form

	<verb> <sha1> <oneline>

The <oneline> is displayed primarily for the user's convenience, as
rebase -i really interprets only the <verb> <sha1> part. However, there
are *some* places in interactive rebase where the <oneline> is used to
display messages, e.g. for reporting at which commit we stopped.

So let's just remember it when parsing the todo file; we keep a copy of
the entire todo file anyway (to write out the new `done` and
`git-rebase-todo` file just before processing each command), so all we
need to do is remember the begin offsets and lengths.

As we will have to parse and remember the command-line for `exec` commands
later, we do not call the field "oneline" but rather "arg" (and will reuse
that for exec's command-line).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 9f22c5e..3d1fdac 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -706,6 +706,8 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 struct todo_item {
 	enum todo_command command;
 	struct commit *commit;
+	const char *arg;
+	int arg_len;
 	size_t offset_in_buf;
 };
 
@@ -757,6 +759,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	status = get_sha1(bol, commit_sha1);
 	*end_of_object_name = saved;
 
+	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
+	item->arg_len = (int)(eol - item->arg);
+
 	if (status < 0)
 		return -1;
 
@@ -907,6 +912,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 
 		item->command = command;
 		item->commit = commit;
+		item->arg = NULL;
+		item->arg_len = 0;
 		item->offset_in_buf = todo_list->buf.len;
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
-- 
2.10.1.583.g721a9e0


