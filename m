Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583371F933
	for <e@80x24.org>; Sat, 14 Jul 2018 21:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbeGNWFR (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40186 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731213AbeGNWFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so28259647wrn.7
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CfnqksrI7Y7hU1lMt/wQBAyk6YEoKJolhMzFb09voxI=;
        b=N+wvskxHorzvV4Le0cU46tYUUb/OnAD6EMVk2fTS6SWsRRdLtUilKi+aF4K9yvL57o
         nHTFq3/Gao9UiDQC/0XdIJXcN0jGzwNRdtktNINxfNhotYzB7JJE26N28Yhh0ncnSI/j
         6FxQqWtsHIwT+a2FXkFriP02BUinWhvpPtzOA5n968bqaNBmkbYsMakHDhHZ7OjqS/DO
         cGtXOCYZDWK6rqxb2ooNXBtrS+cZrwJWD2xzoayCY8RBZwWnSa9+TaTdbKPhIQN3pIfQ
         qIfJlFQsjtYvAxmfF4mu2sTPMdtx53K4YEfy2rQIKhUp/FlL3m6MFiMe4yOcQX5fzohC
         1ubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CfnqksrI7Y7hU1lMt/wQBAyk6YEoKJolhMzFb09voxI=;
        b=tlTw65igvI+ZoC2uoV1qHMs4I6jh4cVn91v2FWCYV44rqqKIzOd3fTuykaUdf5OJyi
         tDkcAqbk8wl+fzMj5zjDlEG2NYlSonA/X2jgkU0UbXgSNGSDniA2RAw17+6WCCRJ79z1
         jIzpX81RVcHoLFasUEHt9+PtFTnyVEC29vFiSC4zkJ5IUr+vPKqJ1pDN/Howcq3U1C1M
         DEjnqdPhr00IJkgf0hYvd2sO+CxfIZbuFp/GjfB7Xfdn36DKQyA1M1e5qifRF1LBeA3f
         vis7MIaAUci4wjH3bLlHr+fA+lDC8EJ6lyPTxPa3RQfDOrg2KE+5K6+azD8wHa75v8Dg
         kSFQ==
X-Gm-Message-State: AOUpUlFJud/dtQKWQwEFuLcnXOViA3DehTUHJMpOur8NMBYUhXfQQ3X4
        s+ToEkpH2vNpBqE1BUHd4n3dUg1P
X-Google-Smtp-Source: AAOMgpd0AJJOkysndq0zi49U5yhS72ZPAXrVPbek8BVazjxJDjuZ613I0pPtcAIEjZ3Udkwz123UXg==
X-Received: by 2002:adf:fd12:: with SMTP id e18-v6mr7924120wrr.280.1531604688917;
        Sat, 14 Jul 2018 14:44:48 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id 79-v6sm3773719wmf.5.2018.07.14.14.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:44:47 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 00/11] rerere: handle nested conflicts
Date:   Sat, 14 Jul 2018 22:44:32 +0100
Message-Id: <20180714214443.7184-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous rounds were at
<20180520211210.1248-1-t.gummerer@gmail.com> and
<20180605215219.28783-1-t.gummerer@gmail.com>.

This round is a more polished version of the previous round, as
suggested by Junio in <xmqq1scgmemy.fsf@gitster-ct.c.googlers.com>.
It's also rebased on v2.18.

The series grew by one patch, because 8/10 has been split into two
patches hopefully making it easier to follow.

range-diff before below:

1:  2825342cc2 = 1:  018bd68a8a rerere: unify error messages when read_cache fails
2:  d1500028aa ! 2:  281fcbf24f rerere: lowercase error messages
    @@ -4,7 +4,8 @@
     
         Documentation/CodingGuidelines mentions that error messages should be
         lowercase.  Prior to marking them for translation follow that pattern
    -    in rerere as well.
    +    in rerere as well, so translators won't have to translate messages
    +    that don't conform to our guidelines.
     
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
    @@ -87,3 +88,12 @@
      
      	/* Nuke the recorded resolution for the conflict */
      	id = new_rerere_id(sha1);
    +@@
    + 		handle_cache(path, sha1, rerere_path(id, "thisimage"));
    + 		if (read_mmfile(&cur, rerere_path(id, "thisimage"))) {
    + 			free(cur.ptr);
    +-			error("Failed to update conflicted state in '%s'", path);
    ++			error("failed to update conflicted state in '%s'", path);
    + 			goto fail_exit;
    + 		}
    + 		cleanly_resolved = !try_merge(id, path, &cur, &result);
3:  ed3601ee71 = 3:  b6d5e2e26d rerere: wrap paths in output in sq
4:  6ead84a199 ! 4:  45f0d7a99f rerere: mark strings for translation
    @@ -4,7 +4,7 @@
     
         'git rerere' is considered a plumbing command and as such its output
         should be translated.  Its functionality is also only enabled through
    -    a config setting, so scripts really shouldn't rely on its output
    +    a config setting, so scripts really shouldn't rely on the output
         either way.
     
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
    @@ -219,8 +219,8 @@
      		handle_cache(path, sha1, rerere_path(id, "thisimage"));
      		if (read_mmfile(&cur, rerere_path(id, "thisimage"))) {
      			free(cur.ptr);
    --			error("Failed to update conflicted state in '%s'", path);
    -+			error(_("Failed to update conflicted state in '%s'"), path);
    +-			error("failed to update conflicted state in '%s'", path);
    ++			error(_("failed to update conflicted state in '%s'"), path);
      			goto fail_exit;
      		}
      		cleanly_resolved = !try_merge(id, path, &cur, &result);
5:  caad276aca ! 5:  993857a816 rerere: add some documentation
    @@ -1,6 +1,6 @@
     Author: Thomas Gummerer <t.gummerer@gmail.com>
     
    -    rerere: add some documentation
    +    rerere: add documentation for conflict normalization
     
         Add some documentation for the logic behind the conflict normalization
         in rerere.
    @@ -27,30 +27,28 @@
     +when different conflict style settings are used, rerere normalizes the
     +conflicts before writing them to the rerere database.
     +
    -+Differnt conflict styles and branch names are dealt with by stripping
    -+that information from the conflict markers, and removing extraneous
    -+information from the `diff3` conflict style.
    -+
    -+Branches being merged in different order are dealt with by sorting the
    -+conflict hunks.  More on each of those parts in the following
    -+sections.
    ++Different conflict styles and branch names are normalized by stripping
    ++the labels from the conflict markers, and removing extraneous
    ++information from the `diff3` conflict style. Branches that are merged
    ++in different order are normalized by sorting the conflict hunks.  More
    ++on each of those steps in the following sections.
     +
     +Once these two normalization operations are applied, a conflict ID is
    -+created based on the normalized conflict, which is later used by
    ++calculated based on the normalized conflict, which is later used by
     +rerere to look up the conflict in the rerere database.
     +
     +Stripping extraneous information
     +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     +
     +Say we have three branches AB, AC and AC2.  The common ancestor of
    -+these branches has a file with with a line with the string "A" (for
    -+brevity this line is called "line A" for brevity in the following) in
    -+it.  In branch AB this line is changed to "B", in AC, this line is
    -+changed to C, and branch AC2 is forked off of AC, after the line was
    -+changed to C.
    ++these branches has a file with a line containing the string "A" (for
    ++brevity this is called "line A" in the rest of the document).  In
    ++branch AB this line is changed to "B", in AC, this line is changed to
    ++"C", and branch AC2 is forked off of AC, after the line was changed to
    ++"C".
     +
    -+Now forking a branch ABAC off of branch AB and then merging AC into it,
    -+we'd get a conflict like the following:
    ++Forking a branch ABAC off of branch AB and then merging AC into it, we
    ++get a conflict like the following:
     +
     +    <<<<<<< HEAD
     +    B
    @@ -58,9 +56,9 @@
     +    C
     +    >>>>>>> AC
     +
    -+Now doing the analogous with AC2 (forking a branch ABAC2 off of branch
    -+AB and then merging branch AC2 into it), maybe using the diff3
    -+conflict style, we'd get a conflict like the following:
    ++Doing the analogous with AC2 (forking a branch ABAC2 off of branch AB
    ++and then merging branch AC2 into it), using the diff3 conflict style,
    ++we get a conflict like the following:
     +
     +    <<<<<<< HEAD
     +    B
6:  ad88a6b8a8 = 6:  a7a0f657f3 rerere: fix crash when conflict goes unresolved
7:  15f9efcba6 = 7:  f1afd4b9a4 rerere: only return whether a path has conflicts or not
8:  1490efaad3 ! 8:  1f5cef506a rerere: factor out handle_conflict function
    @@ -3,53 +3,14 @@
         rerere: factor out handle_conflict function
     
         Factor out the handle_conflict function, which handles a single
    -    conflict in a path.  This is a preparation for the next step, where
    -    this function will be re-used.  No functional changes intended.
    +    conflict in a path.  This is in preparation for a subsequent commit,
    +    where this function will be re-used.  No functional changes intended.
     
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
     diff --git a/rerere.c b/rerere.c
     --- a/rerere.c
     +++ b/rerere.c
    -@@
    - 		ferr_puts(str, io->output, &io->wrerror);
    - }
    - 
    --/*
    -- * Write a conflict marker to io->output (if defined).
    -- */
    --static void rerere_io_putconflict(int ch, int size, struct rerere_io *io)
    --{
    --	char buf[64];
    --
    --	while (size) {
    --		if (size <= sizeof(buf) - 2) {
    --			memset(buf, ch, size);
    --			buf[size] = '\n';
    --			buf[size + 1] = '\0';
    --			size = 0;
    --		} else {
    --			int sz = sizeof(buf) - 1;
    --
    --			/*
    --			 * Make sure we will not write everything out
    --			 * in this round by leaving at least 1 byte
    --			 * for the next round, giving the next round
    --			 * a chance to add the terminating LF.  Yuck.
    --			 */
    --			if (size <= sz)
    --				sz -= (sz - size) + 1;
    --			memset(buf, ch, sz);
    --			buf[sz] = '\0';
    --			size -= sz;
    --		}
    --		rerere_io_putstr(buf, io);
    --	}
    --}
    --
    - static void rerere_io_putmem(const char *mem, size_t sz, struct rerere_io *io)
    - {
    - 	if (io->output)
     @@
      	return isspace(*buf);
      }
    @@ -67,14 +28,7 @@
     - * hunks and -1 if an error occured.
     - */
     -static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
    -+static void rerere_strbuf_putconflict(struct strbuf *buf, int ch, size_t size)
    -+{
    -+	strbuf_addchars(buf, ch, size);
    -+	strbuf_addch(buf, '\n');
    -+}
    -+
    -+static int handle_conflict(struct strbuf *out, struct rerere_io *io,
    -+			   int marker_size, git_SHA_CTX *ctx)
    ++static int handle_conflict(struct rerere_io *io, int marker_size, git_SHA_CTX *ctx)
      {
     -	git_SHA_CTX ctx;
     -	int has_conflicts = 0;
    @@ -88,38 +42,39 @@
     -
     -	if (sha1)
     -		git_SHA1_Init(&ctx);
    --
    -+	int has_conflicts = 1;
    ++	int has_conflicts = -1;
    + 
      	while (!io->getline(&buf, io)) {
    --		if (is_cmarker(buf.buf, '<', marker_size)) {
    + 		if (is_cmarker(buf.buf, '<', marker_size)) {
     -			if (hunk != RR_CONTEXT)
     -				goto bad;
     -			hunk = RR_SIDE_1;
    --		} else if (is_cmarker(buf.buf, '|', marker_size)) {
    -+		if (is_cmarker(buf.buf, '<', marker_size))
    -+			goto bad;
    -+		else if (is_cmarker(buf.buf, '|', marker_size)) {
    ++			break;
    + 		} else if (is_cmarker(buf.buf, '|', marker_size)) {
      			if (hunk != RR_SIDE_1)
    - 				goto bad;
    +-				goto bad;
    ++				break;
      			hunk = RR_ORIGINAL;
    -@@
    - 				goto bad;
    + 		} else if (is_cmarker(buf.buf, '=', marker_size)) {
    + 			if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
    +-				goto bad;
    ++				break;
    + 			hunk = RR_SIDE_2;
    + 		} else if (is_cmarker(buf.buf, '>', marker_size)) {
    + 			if (hunk != RR_SIDE_2)
    +-				goto bad;
    ++				break;
      			if (strbuf_cmp(&one, &two) > 0)
      				strbuf_swap(&one, &two);
    --			has_conflicts = 1;
    + 			has_conflicts = 1;
     -			hunk = RR_CONTEXT;
    --			rerere_io_putconflict('<', marker_size, io);
    --			rerere_io_putmem(one.buf, one.len, io);
    --			rerere_io_putconflict('=', marker_size, io);
    --			rerere_io_putmem(two.buf, two.len, io);
    --			rerere_io_putconflict('>', marker_size, io);
    + 			rerere_io_putconflict('<', marker_size, io);
    + 			rerere_io_putmem(one.buf, one.len, io);
    + 			rerere_io_putconflict('=', marker_size, io);
    + 			rerere_io_putmem(two.buf, two.len, io);
    + 			rerere_io_putconflict('>', marker_size, io);
     -			if (sha1) {
     -				git_SHA1_Update(&ctx, one.buf ? one.buf : "",
    -+			rerere_strbuf_putconflict(out, '<', marker_size);
    -+			strbuf_addbuf(out, &one);
    -+			rerere_strbuf_putconflict(out, '=', marker_size);
    -+			strbuf_addbuf(out, &two);
    -+			rerere_strbuf_putconflict(out, '>', marker_size);
     +			if (ctx) {
     +				git_SHA1_Update(ctx, one.buf ? one.buf : "",
      					    one.len + 1);
    @@ -129,7 +84,7 @@
      			}
     -			strbuf_reset(&one);
     -			strbuf_reset(&two);
    -+			goto out;
    ++			break;
      		} else if (hunk == RR_SIDE_1)
      			strbuf_addbuf(&one, &buf);
      		else if (hunk == RR_ORIGINAL)
    @@ -143,9 +98,6 @@
     -		hunk = 99; /* force error exit */
     -		break;
      	}
    -+bad:
    -+	has_conflicts = -1;
    -+out:
      	strbuf_release(&one);
      	strbuf_release(&two);
      	strbuf_release(&buf);
    @@ -169,24 +121,20 @@
     +{
     +	git_SHA_CTX ctx;
     +	struct strbuf buf = STRBUF_INIT;
    -+	struct strbuf out = STRBUF_INIT;
     +	int has_conflicts = 0;
     +	if (sha1)
     +		git_SHA1_Init(&ctx);
     +
     +	while (!io->getline(&buf, io)) {
     +		if (is_cmarker(buf.buf, '<', marker_size)) {
    -+			has_conflicts = handle_conflict(&out, io, marker_size,
    -+							    sha1 ? &ctx : NULL);
    ++			has_conflicts = handle_conflict(io, marker_size,
    ++							sha1 ? &ctx : NULL);
     +			if (has_conflicts < 0)
     +				break;
    -+			rerere_io_putmem(out.buf, out.len, io);
    -+			strbuf_reset(&out);
     +		} else
     +			rerere_io_putstr(buf.buf, io);
     +	}
     +	strbuf_release(&buf);
    -+	strbuf_release(&out);
     +
      	if (sha1)
      		git_SHA1_Final(sha1, &ctx);
-:  ---------- > 9:  8ac0d3e903 rerere: return strbuf from handle path
9:  6619650c42 ! 10:  ef84fdc201 rerere: teach rerere to handle nested conflicts
    @@ -27,7 +27,7 @@
             >>>>>>> branch-2
             >>>>>>> branch-3~
     
    -    it would be reordered as follows in the preimage:
    +    it would be recorde as follows in the preimage:
     
             <<<<<<<
             1
    @@ -40,14 +40,16 @@
             >>>>>>>
     
         and the conflict ID would be calculated as
    +
             sha1(1<NUL><<<<<<<
             2
             =======
             3
             >>>>>>><NUL>)
     
    -    Stripping out vs. leaving the conflict markers in place should have no
    -    practical impact, but it simplifies the implementation.
    +    Stripping out vs. leaving the conflict markers in place in the inner
    +    conflict should have no practical impact, but it simplifies the
    +    implementation.
     
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
    @@ -63,9 +65,11 @@
     +~~~~~~~~~~~~~~~~
     +
     +Nested conflicts are handled very similarly to "simple" conflicts.
    -+Same as before, labels on conflict markers and diff3 output is
    -+stripped, and the conflict hunks are sorted, for both the outer and
    -+the inner conflict.
    ++Similar to simple conflicts, the conflict is first normalized by
    ++stripping the labels from conflict markers, stripping the diff3
    ++output, and the sorting the conflict hunks, both for the outer and the
    ++inner conflict.  This is done recursively, so any number of nested
    ++conflicts can be handled.
     +
     +The only difference is in how the conflict ID is calculated.  For the
     +inner conflict, the conflict markers themselves are not stripped out
    @@ -83,16 +87,16 @@
     +    >>>>>>> branch-2
     +    >>>>>>> branch-3~
     +
    -+After stripping out the labels of the conflict markers, the conflict
    -+would look as follows:
    ++After stripping out the labels of the conflict markers, and sorting
    ++the hunks, the conflict would look as follows:
     +
     +    <<<<<<<
     +    1
     +    =======
     +    <<<<<<<
    -+    3
    -+    =======
     +    2
    ++    =======
    ++    3
     +    >>>>>>>
     +    >>>>>>>
     +
    @@ -108,23 +112,21 @@
      	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
     -	struct strbuf buf = STRBUF_INIT;
     +	struct strbuf buf = STRBUF_INIT, conflict = STRBUF_INIT;
    - 	int has_conflicts = 1;
    + 	int has_conflicts = -1;
    + 
      	while (!io->getline(&buf, io)) {
    --		if (is_cmarker(buf.buf, '<', marker_size))
    --			goto bad;
    --		else if (is_cmarker(buf.buf, '|', marker_size)) {
    -+		if (is_cmarker(buf.buf, '<', marker_size)) {
    + 		if (is_cmarker(buf.buf, '<', marker_size)) {
    +-			break;
     +			if (handle_conflict(&conflict, io, marker_size, NULL) < 0)
    -+				goto bad;
    ++				break;
     +			if (hunk == RR_SIDE_1)
     +				strbuf_addbuf(&one, &conflict);
     +			else
     +				strbuf_addbuf(&two, &conflict);
     +			strbuf_release(&conflict);
    -+		} else if (is_cmarker(buf.buf, '|', marker_size)) {
    + 		} else if (is_cmarker(buf.buf, '|', marker_size)) {
      			if (hunk != RR_SIDE_1)
    - 				goto bad;
    - 			hunk = RR_ORIGINAL;
    + 				break;
     
     diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
     --- a/t/t4200-rerere.sh
    @@ -169,6 +171,5 @@
     +	cat test >actual &&
     +	test_cmp expect actual
     +'
    -+
     +
      test_done
10:  4b11dce7dd = 11:  35a826908f rerere: recalculate conflict ID when unresolved conflict is committed


Thomas Gummerer (11):
  rerere: unify error messages when read_cache fails
  rerere: lowercase error messages
  rerere: wrap paths in output in sq
  rerere: mark strings for translation
  rerere: add documentation for conflict normalization
  rerere: fix crash when conflict goes unresolved
  rerere: only return whether a path has conflicts or not
  rerere: factor out handle_conflict function
  rerere: return strbuf from handle path
  rerere: teach rerere to handle nested conflicts
  rerere: recalculate conflict ID when unresolved conflict is committed

 Documentation/technical/rerere.txt | 182 +++++++++++++++++++++
 builtin/rerere.c                   |   4 +-
 rerere.c                           | 243 ++++++++++++++---------------
 t/t4200-rerere.sh                  |  66 ++++++++
 4 files changed, 366 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/technical/rerere.txt

-- 
2.18.0.233.g985f88cf7e
