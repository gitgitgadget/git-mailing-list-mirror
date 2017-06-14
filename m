Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED21A20282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbdFNNHN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:07:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:63607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdFNNHN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:07:13 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEFlg-1daU4j1vce-00FWs5; Wed, 14
 Jun 2017 15:07:01 +0200
Date:   Wed, 14 Jun 2017 15:06:58 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v5 00/10] The final building block for a faster rebase -i
Message-ID: <cover.1497444257.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aE4/ZkkTL71QomsKeKdXLXOUvi1VIp1Paf+UtF4bjsc9dE/SS2p
 QnO8Otyu2oAB63FRM8ZcRP7+eBq6mj3SOE8Agn+oTrILsXsMG6KlP67YdX429ykXdZAn7NJ
 oEWcSbwcwoQu67dzvtvFYYBx94S68dE2tH0luRq14V/4oxTrtB1SLTYuae+W/C0gKdFq94s
 sHzKnitY29R1V1DporwQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:05zaLDvDdTc=:NksFt1e+7D/s/og1J8MV9Y
 C7p5gaQmWujKbfv0XSufJqIACZ6diaq935g2feSs4+v68K0MqAPhMRwW0vmbFPFXYgf1JQXPB
 paKd1B0BeQE4Q9TsFsSH0T2nOyjjEt6+t1dUMOIrip3LvPIDfWyPvTT1kBU7JRNnwoMruUTBm
 aNX4gCh1y/K5zxPFJiTdnKmIiiSaiYYEutn7sZ90It9fRSbcDkXj5zdORBid58Uubi4iZFHJR
 uacCwKRTUCzXZTR8qqy8QTjm1kwQJK2aTyXbtw2ZZ4C0xFQQsmW1/V8khtZ/nddLjLwvm8EaI
 ix/za/HsiEsKtTjoXhN77RrTrfK79qHBIqjO1z70PKQbtt0murRbWZyy/2/vYd2hM8p9h0Rjq
 KM0eS4Uwi9B3kzAfaquI1Oj5iInGw3aMyreRtmxJrIBt+0KKCzTEJmfG0EDOV6Zw4JjzPDEvJ
 selrjHFlKGKB5zwicKRnfEfPR6hmKTMwyv0hO2zMZJVywmvru46tbxcHNBmZ/cUGs5tL3dqAN
 +Y14Tsw0Vq4HZuD20MhybZtUQ73M0vjC7e519rRE3mWf0DbG7R26ybzwD4PoaKT+OWYhnI52N
 00tqSu99IyggiMqrrbBlkvsNTmmNmghOwVdCg34V0ZAUssN5uHMOF2017WfEJWEHQAvUL7AB4
 DrGm+jUjet0wBEjSQI/S8wmNk19Y0nkUlr2qgEfeyKDB3EmCyShBRqHinVsPZVThcc7SvWriG
 cO2J1gTeN0DZv05YZ1rR9U/G27PYrUjPuG1DPImI4CjjN1Nlohoo467bNXj6Ebyk5sffhxpqz
 Q0SDmuy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series reimplements the expensive pre- and post-processing of
the todo script in C.

And it concludes the work I did to accelerate rebase -i so far.

I am still unwilling to replace a compile-time safe way to pass the
options to the revision machinery by the alternative (which I am still
flabbergasted about) proposed by Junio. This will not change.

Changes since v4:

- replaced the "sha1s" part of the names by "ids", to reflect the
  current effort to move away from the cryptographically unsafe SHA-1

- replaced the confusing term "instruction sheet" in an error message by
  the more commonly used "todo list"


Johannes Schindelin (10):
  t3415: verify that an empty instructionFormat is handled as before
  rebase -i: generate the script via rebase--helper
  rebase -i: remove useless indentation
  rebase -i: do not invent onelines when expanding/collapsing SHA-1s
  rebase -i: also expand/collapse the SHA-1s via the rebase--helper
  t3404: relax rebase.missingCommitsCheck tests
  rebase -i: check for missing commits in the rebase--helper
  rebase -i: skip unnecessary picks using the rebase--helper
  t3415: test fixup with wrapped oneline
  rebase -i: rearrange fixup/squash lines using the rebase--helper

 Documentation/git-rebase.txt  |  16 +-
 builtin/rebase--helper.c      |  29 ++-
 git-rebase--interactive.sh    | 373 ++++-------------------------
 sequencer.c                   | 530 ++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                   |   8 +
 t/t3404-rebase-interactive.sh |  22 +-
 t/t3415-rebase-autosquash.sh  |  28 ++-
 7 files changed, 646 insertions(+), 360 deletions(-)


base-commit: 02a2850ad58eff6de70eb2dc5f96345c463857ac
Based-On: rebase--helper at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git rebase--helper
Published-As: https://github.com/dscho/git/releases/tag/rebase-i-extra-v5
Fetch-It-Via: git fetch https://github.com/dscho/git rebase-i-extra-v5

Interdiff vs v4:
 diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
 index e6591f01112..64b36d429fa 100644
 --- a/builtin/rebase--helper.c
 +++ b/builtin/rebase--helper.c
 @@ -25,9 +25,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
  				ABORT),
  		OPT_CMDMODE(0, "make-script", &command,
  			N_("make rebase script"), MAKE_SCRIPT),
 -		OPT_CMDMODE(0, "shorten-sha1s", &command,
 +		OPT_CMDMODE(0, "shorten-ids", &command,
  			N_("shorten SHA-1s in the todo list"), SHORTEN_SHA1S),
 -		OPT_CMDMODE(0, "expand-sha1s", &command,
 +		OPT_CMDMODE(0, "expand-ids", &command,
  			N_("expand SHA-1s in the todo list"), EXPAND_SHA1S),
  		OPT_CMDMODE(0, "check-todo-list", &command,
  			N_("check the todo list"), CHECK_TODO_LIST),
 diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
 index 71d190766cf..3b0340e7cc9 100644
 --- a/git-rebase--interactive.sh
 +++ b/git-rebase--interactive.sh
 @@ -714,11 +714,11 @@ do_rest () {
  }
  
  expand_todo_ids() {
 -	git rebase--helper --expand-sha1s
 +	git rebase--helper --expand-ids
  }
  
  collapse_todo_ids() {
 -	git rebase--helper --shorten-sha1s
 +	git rebase--helper --shorten-ids
  }
  
  # Add commands after a pick or after a squash/fixup serie
 diff --git a/sequencer.c b/sequencer.c
 index 6373f20a019..06c97e12267 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -2464,7 +2464,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
  }
  
  
 -int transform_todo_ids(int shorten_sha1s)
 +int transform_todo_ids(int shorten_ids)
  {
  	const char *todo_file = rebase_path_todo();
  	struct todo_list todo_list = TODO_LIST_INIT;
 @@ -2484,7 +2484,7 @@ int transform_todo_ids(int shorten_sha1s)
  	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
  	if (res) {
  		todo_list_release(&todo_list);
 -		return error(_("unusable instruction sheet: '%s'"), todo_file);
 +		return error(_("unusable todo list: '%s'"), todo_file);
  	}
  
  	out = fopen(todo_file, "w");
 @@ -2503,7 +2503,7 @@ int transform_todo_ids(int shorten_sha1s)
  		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
  			fwrite(p, eol - bol, 1, out);
  		else {
 -			const char *sha1 = shorten_sha1s ?
 +			const char *id = shorten_ids ?
  				short_commit_name(item->commit) :
  				oid_to_hex(&item->commit->object.oid);
  			int len;
 @@ -2512,7 +2512,7 @@ int transform_todo_ids(int shorten_sha1s)
  			len = strcspn(p, " \t"); /* length of command */
  
  			fprintf(out, "%.*s %s %.*s\n",
 -				len, p, sha1, item->arg_len, item->arg);
 +				len, p, id, item->arg_len, item->arg);
  		}
  	}
  	fclose(out);
 @@ -2762,9 +2762,9 @@ static int subject2item_cmp(const struct subject2item_entry *a,
  }
  
  /*
 - * Rearrange the todo list that has both "pick sha1 msg" and "pick sha1
 - * fixup!/squash! msg" in it so that the latter is put immediately after the
 - * former, and change "pick" to "fixup"/"squash".
 + * Rearrange the todo list that has both "pick commit-id msg" and "pick
 + * commit-id fixup!/squash! msg" in it so that the latter is put immediately
 + * after the former, and change "pick" to "fixup"/"squash".
   *
   * Note that if the config has specified a custom instruction format, each log
   * message will have to be retrieved from the commit (as the oneline in the
 diff --git a/sequencer.h b/sequencer.h
 index 1c94bec7622..6f3d3df82c0 100644
 --- a/sequencer.h
 +++ b/sequencer.h
 @@ -48,7 +48,7 @@ int sequencer_remove_state(struct replay_opts *opts);
  int sequencer_make_script(int keep_empty, FILE *out,
  		int argc, const char **argv);
  
 -int transform_todo_ids(int shorten_sha1s);
 +int transform_todo_ids(int shorten_ids);
  int check_todo_list(void);
  int skip_unnecessary_picks(void);
  int rearrange_squash(void);
-- 
2.13.1.windows.1.1.ga36e14b3aaa

