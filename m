Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C41200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeECXBW (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:01:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:56893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbeECXBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:01:21 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LtZcC-1eFq2g2Vtc-010xa3; Fri, 04 May 2018 01:01:14 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH v2 0/6] Let the sequencer handle `git rebase -i --root`
Date:   Fri,  4 May 2018 01:01:13 +0200
Message-Id: <cover.1525388472.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.38.g05ca542f78d
In-Reply-To: <cover.1524868165.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/BB0wovTJq08T837uDWiFDJ2PsXzjSFGv+hw+nBqGYfW3nsm0Dy
 2K79LcjAH5CkNX5MzBuyqGU30gHSlcwdxe25dz0yNkXvhBbmqIdo5+sMw5WSh+3VMYePUNe
 z/VAHGBcZEkGWE09fI/xFVGMpNgcvaIzp5Hvd2MfXco22TDje8xFdo5iS+fjm2xucw+D/k+
 fPVVc0MYI/mjGLKw9QQdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ik1UdlU5uT8=:sTHSUAsYHkKQYmscSKuS+R
 k24+fIFogysKf7+7RZFkAa9X+Gf++NV7SL63t016PFZAxCBT5CLt79q5cswO6pGO7L4r4hRWk
 ALHlBtuo6p6Ndtk/0w6dhFgwnw7Gh7rwPXhFrYkO5kTSpUXPvirrDIZHgMJLSi0IqVxkOu1It
 tzq93+wjUonBTMPjhiXJHpDOovM+F75XVjYeg//xeCfOq2zOo5WoHl4IIqW929iWjgHcX86ts
 BAKrF2Exlg24wyLI9EvK2TRa6NyLW9pTNTmtuZeEnG6tWiVR2E0nYtzSzi60sTqKOfd8wnT9o
 f3zMYolwaSI074IP3s8g1H47DCgRFzWuHojUd7wq8zcO6LefhcJ3e57SAGzvEYhQ/gJx/nzub
 pT/BxlheAUdPu28WAPgagxPpMDNgj9akMh44hnMw+DGvgi02o601uWtesDwt2VfqY1HusM57T
 VLrkHAjhjRoI03mF3oG7vzTI+E5R0oU/uRwI/52baAfPd+E2X3UvTsKT2phTd8vZiOgNb6CDL
 75CzhGFQ3X5225/GOKUmkGf8t+GEeOODnawbQaALEqF5G8odsoz925xG6tWD2hzqOzR9pYnLN
 7tlTjJFMruLECRHS5wkGqOb/ijsr83Ud946wyTE0boJoiPIFwGUyP2AoJoVq3uPaHA8iW/HVx
 KDAOLNPCXqJFqyFaZ1gCB3XPmF0k3cIglaXaUqQvMqE8Ul4gxV5PZswziTtHy7OLAD/CuaGlD
 WTxCnECkh+FkOSXeul7HagWWufqZN4m8i7xiraRu/Bpkkr58X6wcmzk+a9F1zDgl75x5f7Rt5
 0UMS7x0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I reimplemented the most performance-critical bits of the
interactive rebase in the sequencer, to speed up `git rebase -i`
particularly on Windows (even if the benefits are still quite notable on
Linux or macOS), I punted on the --root part.

I had always hoped that some other contributor (or I myself) would come
back later to address the --root part in the sequencer, too, with the
idea that this would move the last remaining complicated code from
git-rebase--interactive.sh into sequencer.c, to facilitate converting
the rest of git-rebase--interactive.sh.

When I say "the last remaining complicated code", of course I neglect
the --preserve-merges code, but as I worked hard on the --rebase-merges
patch series with the intention to eventually deprecate and maybe even
remove the --preserve-merges mode, I always implicitly assume that the
--preserve-merges code will be moved into its own shell script
(git-rebase--preserve-merges.sh, maybe?) and never be converted.

So here goes: the patches to move the handling of --root into the
sequencer. After two preparatory patches, the real conversion takes
place in the third patch. After that, we take care of the --root related
concerns that arise in conjunction with the --rebase-merges mode.

As the --rebase-merges/--root patches overlap quite a bit (not so much
in the code itself as in philosophical considerations such as "what
should happen if you try to merge a branch into a new root", or the
fact that the label/reset/merge commands make it desirable to be able to
create a new root commit in the middle of a todo list), I had to
consider in which order to contribute them. In the end, I decided to go
with --rebase-merges first, so the --root patches are based on the
--rebase-merges patch series.

I consider this patch series a critical prerequisite for Alban's Google
Summer of Code project to convert rebase -i into a builtin.

Changes since v1:

- Expanded is_pick_or_similar() to use a clear and verbose switch()
  statement, replacing the magic "command <= TODO_SQUASH".

- Completely revamped read_author_ident(), using sq_dequote(); Sadly,
  trying to reuse builtin/am.c's read_author_script() would result in
  substantialy more lines of code, and I also failed to find an easy way
  to allow for arbitrary order of the environment variables in
  author-script.


Johannes Schindelin (6):
  sequencer: extract helper to update active_cache_tree
  sequencer: learn about the special "fake root commit" handling
  rebase -i --root: let the sequencer handle even the initial part
  sequencer: allow introducing new root commits
  rebase --rebase-merges: a "merge" into a new root is a fast-forward
  rebase --rebase-merges: root commits can be cousins, too

 git-rebase--interactive.sh        |   4 +-
 sequencer.c                       | 206 ++++++++++++++++++++++++++----
 sequencer.h                       |   4 +
 t/t3404-rebase-interactive.sh     |  19 ++-
 t/t3421-rebase-topology-linear.sh |   6 +-
 t/t3430-rebase-merges.sh          |  72 +++++++++++
 6 files changed, 276 insertions(+), 35 deletions(-)


base-commit: 673fb9cb8b5c7d57cb560b6ade45e419c8dd09fc
Based-On: recreate-merges at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git recreate-merges
Published-As: https://github.com/dscho/git/releases/tag/sequencer-and-root-commits-v2
Fetch-It-Via: git fetch https://github.com/dscho/git sequencer-and-root-commits-v2

Branch-diff vs v1:
 1: 42db734a980 ! 1: 73398da7119 sequencer: learn about the special "fake root commit" handling
     @@ -54,40 +54,50 @@
       	return NULL;
       }
       
     ++/* Read author-script and return an ident line (author <email> timestamp) */
      +static const char *read_author_ident(struct strbuf *buf)
      +{
     -+	char *p, *p2;
     ++	const char *keys[] = {
     ++		"GIT_AUTHOR_NAME=", "GIT_AUTHOR_EMAIL=", "GIT_AUTHOR_DATE="
     ++	};
     ++	char *in, *out, *eol;
     ++	int i = 0, len;
      +
      +	if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
      +		return NULL;
      +
     -+	for (p = buf->buf; *p; p++)
     -+		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
     -+			strbuf_splice(buf, p - buf->buf, p2 - p, "'", 1);
     -+		else if (*p == '\'')
     -+			strbuf_splice(buf, p-- - buf->buf, 1, "", 0);
     -+
     -+	if (skip_prefix(buf->buf, "GIT_AUTHOR_NAME=", (const char **)&p)) {
     -+		strbuf_splice(buf, 0, p - buf->buf, "", 0);
     -+		p = strchr(buf->buf, '\n');
     -+		if (skip_prefix(p, "\nGIT_AUTHOR_EMAIL=", (const char **)&p2)) {
     -+			strbuf_splice(buf, p - buf->buf, p2 - p, " <", 2);
     -+			p = strchr(p, '\n');
     -+			if (skip_prefix(p, "\nGIT_AUTHOR_DATE=@",
     -+					(const char **)&p2)) {
     -+				strbuf_splice(buf, p - buf->buf, p2 - p,
     -+					      "> ", 2);
     -+				p = strchr(p, '\n');
     -+				if (p) {
     -+					strbuf_setlen(buf, p - buf->buf);
     -+					return buf->buf;
     -+				}
     -+			}
     ++	/* dequote values and construct ident line in-place */
     ++	for (in = out = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
     ++		if (!skip_prefix(in, keys[i], (const char **)&in)) {
     ++			warning("could not parse '%s' (looking for '%s'",
     ++				rebase_path_author_script(), keys[i]);
     ++			return NULL;
      +		}
     -+	}
     -+
     -+	warning(_("could not parse '%s'"), rebase_path_author_script());
     -+	return NULL;
     ++
     ++		eol = strchrnul(in, '\n');
     ++		*eol = '\0';
     ++		sq_dequote(in);
     ++		len = strlen(in);
     ++
     ++		if (i > 0) /* separate values by spaces */
     ++			*(out++) = ' ';
     ++		if (i == 1) /* email needs to be surrounded by <...> */
     ++			*(out++) = '<';
     ++		memmove(out, in, len);
     ++		out += len;
     ++		if (i == 1) /* email needs to be surrounded by <...> */
     ++			*(out++) = '>';
     ++		in = eol + 1;
     ++	}
     ++
     ++	if (i < 3) {
     ++		warning("could not parse '%s' (looking for '%s')",
     ++			rebase_path_author_script(), keys[i]);
     ++		return NULL;
     ++	}
     ++
     ++	buf->len = out - buf->buf;
     ++	return buf->buf;
      +}
      +
       static const char staged_changes_advice[] =
     @@ -159,7 +169,17 @@
      +/* Does this command create a (non-merge) commit? */
      +static int is_pick_or_similar(enum todo_command command)
      +{
     -+	return command <= TODO_SQUASH;
     ++	switch (command) {
     ++	case TODO_PICK:
     ++	case TODO_REVERT:
     ++	case TODO_EDIT:
     ++	case TODO_REWORD:
     ++	case TODO_FIXUP:
     ++	case TODO_SQUASH:
     ++		return 1;
     ++	default:
     ++		return 0;
     ++	}
      +}
      +
       static int update_squash_messages(enum todo_command command,
 2: 1c8740eaa91 = 2: 2dfe8315993 rebase -i --root: let the sequencer handle even the initial part
 3: 8a7f5751412 = 3: 0ee765bbb36 sequencer: allow introducing new root commits
 4: 0b7379b576b = 4: 29d7a9265e3 rebase --rebase-merges: a "merge" into a new root is a fast-forward
 5: 270b8fdf477 = 5: f7ee1b3de12 rebase --rebase-merges: root commits can be cousins, too
-- 
2.17.0.windows.1.38.g05ca542f78d

