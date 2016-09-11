Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D5C207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755854AbcIKKyM (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:54:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:52790 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755479AbcIKKyK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:54:10 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MCcE2-1bsLnz1dMw-009Spm; Sun, 11 Sep 2016 12:54:05
 +0200
Date:   Sun, 11 Sep 2016 12:54:04 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 11/25] sequencer: refactor the code to obtain a short
 commit name
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <c825f6bce7d15c83725c99eda8926d3dfaddf71e.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ciNNeQ8T828h9yH+u+tmMaXG3BW+B/qnqzu8sIBZI8u/M3zo7yG
 qRSHv3EhHOwYVAe2oyF7e2oiR84g7omRYbX9X6SduP5fSHXJLoQg7R+qc+j25HCpjQ917v1
 XQqMxdajozglaSLWog1jqCfZ0E2Ub4M//yxXp/kT7h4kz9TE1e4IGPTGgEL6dzBEu6qw0ih
 8lggwsEgBMkSZtybGpX3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1MSwjKDDxtw=:63gvV/bI4ABprlpKdI8X/8
 EIzZ4M3LgAMjJofPewuRA/pHPtZW9GVH76Sbd3SiE4ji1kFqkirlPpzYO7PIdaj0MSHuyYybY
 kcXJ5HlIrZxbjOmMgSJ0ZVyjoEUYAW1tKcRcESUOLgdUMpW8J/CHNrg63DrBnaakvlbw/hFSv
 rWhK9cKGNhuYW+veDCFekrXm3IbVccKjkc4iqIFruOA3WrKE2Cv8Dms4JV4CQO2j9hSB0MTvy
 t8GmWkxoeEaYhDNp1LYBpf78IPvKQ6LoY5Nc5QIRjyTbSqtHC7SD+wQZf0Cw2kFTJd/cdLgiZ
 ZPnCi3zbr1oVpidNPfemHwQseCt55y/EpSYV7ylP9CL3u7rsVx7+Bcc/yN1xAQ86NZKJvx1Y8
 wdasDVFiTzqT2Ng/lKKeUTiyYmf2OUGfgy6e8hwRv7k7Z/TOxAJRhpnYnFGKa2T4J/oDb7vIt
 irl6Jx6X5PGTRz3WxflffHsso/Hq0/VWzrqRipgeOzK8uzrwu+BZqN0dYcLm5dtQXq9OiBsZd
 NX9HA47BbKGkZsPcCRw0F00CJcS4l50NlcumjLMmbLZqFC3nyFM/8u12pI1HjZPzBOqSNAjNW
 bcpV1M9ZZn+ITbwSzjmmYuiS2IeDbRaeOP5FcSrhNHSK75H9exYBFK9N6roIHYinIEiaP/ohD
 TPrG4LkWkqB1KIfMI2Q1PI5f7KDPAKP/H7UnkJdCwilG7BHZA2R/o5/3m07PbVLByHcvdVhhU
 LAd3k6tqvtvvxZVHeXgbgLSlpHW8tVBOBxgVdALkv3qT7I+4AQqMynJtdRjl1jpOENSzq1NYl
 Nl4M/bp
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
 sequencer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 053e78c..0c8dec4 100644
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
@@ -904,9 +908,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 		item->offset_in_buf = todo_list->buf.len;
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
-			find_unique_abbrev(commit->object.oid.hash,
-				DEFAULT_ABBREV),
-			subject_len, subject);
+			short_commit_name(commit), subject_len, subject);
 		unuse_commit_buffer(commit, commit_buffer);
 	}
 	return 0;
-- 
2.10.0.windows.1.10.g803177d


