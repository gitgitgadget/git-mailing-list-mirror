Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A818EC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1906135C
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhGILJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhGILJF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 07:09:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359A5C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 04:06:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d2so11687847wrn.0
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HH0Tgnig681QlFFf12gT3ACGTHNTc2nbNY8PQb3MXrY=;
        b=kX5V917bmLw6W4hNq9loR0CWqis/YokQoXuFryM0zNHqaL8Ev8jJ8wuEHvKWIeQj20
         cQcoWBZGZWvnhflD+Z6XmOijHjftk13hotebA3ZgmoHyjF3yAiUXTN92ZB0Si29n7rM+
         KsZxBoPQppC/Xhc6FkZx5gRPCP/Rr10A1wF/44nYIV9X5QQzwQVwowXWR/lT+O/t4h3+
         nIK3kOzEPxfaSop3qJ7c1ktH4U3IvJVI2rPDWedp/j5BCbbVswq0J49fRLZCIqUD71b/
         gyoN3LgDAqj2PZtgrdsaiTqpQJu7EwI7p5D9KYy36jXNU7X2Sxiy009TDCD9UFtz2Fsp
         Xomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HH0Tgnig681QlFFf12gT3ACGTHNTc2nbNY8PQb3MXrY=;
        b=tjfckWzW//HKBOEFfQ7vlUIMXyD0A01Vq0NJwL7obi7sHJtTvDITMUxT+GWI4Js8lI
         lIUSTKj2JPpBzochPnY8rf0myc11sjSS4Ts+ipvRjEpBqFGO9PSW2kWGNzbJ4KPcBnSh
         g5eGDiDmsUiPjA/s2w1nl0IMumBGxCO65lFTtgFoywz4IZWwrf92GdWUz9CvltjhfjLM
         c6uoVQ0mDDtddqbKZCRK+y6yHDuvfE5JS01TiYncJxSE5Gre50IRUsmjouFu+BVGIi3f
         2B4GAaD8O2Fc3RDvv6yAiNkWmbKACiseuGSgbxg4Ct3MT438MYpSxew0/PJZWe0fMMLO
         iy9g==
X-Gm-Message-State: AOAM531/8oHJGKAWf+r1NtB85Una6jqEvK7l3x4HdDMX1IyYBWYp1oua
        tMMmsyvf87+YEmPCn19Sb0QyoXFNV6lKZg==
X-Google-Smtp-Source: ABdhPJzZ2UBDJt5xb4Fm/OfKmJ5VoBdKbavYcRJ67AITNlYmxmXDu8jFFK4dMYoVR40jXPjH3DRNZQ==
X-Received: by 2002:adf:b605:: with SMTP id f5mr40808655wre.419.1625828779207;
        Fri, 09 Jul 2021 04:06:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a4sm4978167wru.55.2021.07.09.04.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:06:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/5] revision.[ch]: add --stdin parsing API, use in pack-objects
Date:   Fri,  9 Jul 2021 13:06:11 +0200
Message-Id: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of v3[1], this v4 fixes specific issues noted there, but
more importantly I've tried to address Junio's comments to the effect
of "what's the point of this churny thing?"" in [2].

As the new 3/5 explains what I really wanted this for is a new feature
for "git bundle create" that I have working locally, which allows it
to do:

    $ printf "e83c5163316f89bfbde7\trefs/heads/first-git-dot-git-commit\n" |
    git bundle create initial.bundle --stdin

As well as things like:

    $ git for-each-ref 'refs/remotes/origin' |
    sed 's!\trefs/remotes/origin/!\trefs/heads/!' |
    git bundle create origin.bundle --stdin

As elaborated on in 3/5 for that it's much better to have an API like
this, but since those changes also needed what I've got in
ab/bundle-updates and ab/bundle-doc (well, not that one really, but
the merge conflict would be painful otherwise) I split this series off
so I wouldn't end up with another 10-20 patch monster.

Junio: I hope that'll convence you to accept this, I can also submit
that "monster", but it'll be harder to read & review sinc so much of
it (e.g. this series, and doc refactoring) will be needed just to get
to the point of implementing that feature.

1. https://lore.kernel.org/git/cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com/
2. https://lore.kernel.org/git/xmqqfswoa1ku.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (5):
  upload-pack: run is_repository_shallow() before setup_revisions()
  revision.h: refactor "disable_stdin" and "read_from_stdin"
  revision.[ch]: add a "handle_stdin_line" API
  pack-objects.c: do stdin parsing via revision.c's API
  pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS

 builtin/am.c           |  4 +--
 builtin/blame.c        |  2 +-
 builtin/diff-tree.c    |  2 +-
 builtin/pack-objects.c | 61 +++++++++++++++++++-----------------------
 builtin/rev-list.c     |  2 +-
 revision.c             | 39 ++++++++++++++++++++++-----
 revision.h             | 59 ++++++++++++++++++++++++++++++++++++----
 sequencer.c            |  4 +--
 8 files changed, 120 insertions(+), 53 deletions(-)

Range-diff against v3:
1:  dd2efd1cfb9 < -:  ----------- pack-objects tests: cover blindspots in stdin handling
2:  a9702132385 < -:  ----------- pack-objects: fix segfault in --stdin-packs option
3:  3840ac28e8d = 1:  8b2872227c5 upload-pack: run is_repository_shallow() before setup_revisions()
4:  6f69644b808 ! 2:  630feb06650 revision.h: refactor "disable_stdin" and "read_from_stdin"
    @@ Commit message
         of "disable_stdin", rather we read stdin if we see the "--stdin"
         option.
     
    -    The "read" is intended to understood as "I read it", not "you should
    -    read it". Let's avoid this confusion by using "consume" and "consumed"
    -    instead, i.e. a word whose present and past tense isn't the same.
    +    The "read" is intended to understood as "I've read it already", not
    +    "you should read it". Let's avoid this confusion by using "consume"
    +    and "consumed" instead, i.e. a word whose present and past tense isn't
    +    the same.
     
         See 8b3dce56508 (Teach --stdin option to "log" family, 2009-11-03)
         where we added the "disable_stdin" flag, and a12cbe23ef7 (rev-list:
    @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
      					argv[left++] = arg;
      					continue;
     +				case REV_INFO_STDIN_CONSUME_ON_OPTION:
    -+					if (revs->consumed_stdin++)
    ++					if (revs->consumed_stdin)
     +						die("--stdin given twice?");
     +					read_revisions_from_stdin(revs, &prune_data);
    ++					revs->consumed_stdin = 1;
     +					continue;
      				}
     -				if (revs->read_from_stdin++)
    @@ revision.h: struct rev_cmdline_info {
      struct topo_walk_info;
      
     +enum rev_info_stdin {
    -+	REV_INFO_STDIN_CONSUME_ON_OPTION = 0,
    ++	REV_INFO_STDIN_CONSUME_ON_OPTION,
     +	REV_INFO_STDIN_IGNORE,
     +};
     +
    @@ revision.h: struct rev_info {
     +	 * option?
      	 */
     -	int read_from_stdin;
    -+	int consumed_stdin;
    ++	int consumed_stdin:1;
      
      	/* topo-sort */
      	enum rev_sort_order sort_order;
-:  ----------- > 3:  60ef49df3b8 revision.[ch]: add a "handle_stdin_line" API
5:  943b1b4c12a ! 4:  ebffeb5891f pack-objects.c: do stdin parsing via revision.c's API
    @@ Metadata
      ## Commit message ##
         pack-objects.c: do stdin parsing via revision.c's API
     
    -    Extend the rev_info stdin parsing API to support hooking into its
    -    read_revisions_from_stdin() function, and change the custom stdin
    -    parsing in pack-objects.c to use it.
    +    Use the new "handle_stdin_line" API in revision.c to parse stdin in
    +    pack-objects.c, instead of using custom pack-objects.c-specific code
    +    to do so.
    +
    +    This means that we can remove the "if (len && line[len - 1] == '\n')"
    +    check, it's now redundant to using strbuf_getline(), and we get to
    +    skip the whole "warn_on_object_refname_ambiguity" dance. The
    +    read_revisions_from_stdin() function in revision.c we're now using
    +    does it for us.
     
         The pack-objects.c code being refactored away here was first added in
         Linus's c323ac7d9c5 (git-pack-objects: create a packed object
    @@ Commit message
         and it moved to a more simpler strbuf API in 6e8d46f9d4b (revision:
         read --stdin with strbuf_getline(), 2015-10-28).
     
    -    Let's do the same here, as in 6e8d46f9d4b we can remove the "if (len
    -    && line[len - 1] == '\n')" check, it's now redundant to using
    -    strbuf_getline(), and we get to skip the whole
    -    "warn_on_object_refname_ambiguity" dance. The
    -    read_revisions_from_stdin() function in revision.c we're now using
    -    does it for us.
    -
    -    For now there isn't all that much point in this whole exercises. We
    -    just end up calling setup_revisions() to loop over stdin for us, but
    -    the callback we define makes no use of REV_INFO_STDIN_LINE_PROCESS, we
    +    For now we've just made setup_revisions() loop over stdin for us, but
    +    the callback we define makes no use of REV_INFO_STDIN_LINE_PROCESS. We
         still need to call handle_revision_arg() ourselves because we'd like
         to call it with different flags.
     
    @@ builtin/pack-objects.c: static void get_object_list(int ac, const char **av)
      	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
      		return;
      
    -
    - ## revision.c ##
    -@@ revision.c: static void read_revisions_from_stdin(struct rev_info *revs,
    - 		int len = sb.len;
    - 		if (!len)
    - 			break;
    -+
    -+		if (revs->handle_stdin_line) {
    -+			enum rev_info_stdin_line ret = revs->handle_stdin_line(
    -+				revs, &sb, revs->stdin_line_priv);
    -+
    -+			switch (ret) {
    -+			case REV_INFO_STDIN_LINE_PROCESS:
    -+				break;
    -+			case REV_INFO_STDIN_LINE_CONTINUE:
    -+				continue;
    -+			}
    -+		}
    -+
    - 		if (sb.buf[0] == '-') {
    - 			if (len == 2 && sb.buf[1] == '-') {
    - 				seen_dashdash = 1;
    -@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
    - 
    - 			if (!strcmp(arg, "--stdin")) {
    - 				switch (revs->stdin_handling) {
    -+				case REV_INFO_STDIN_ALWAYS_READ:
    - 				case REV_INFO_STDIN_IGNORE:
    - 					argv[left++] = arg;
    - 					continue;
    -@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
    - 		}
    - 	}
    - 
    -+	/*
    -+	 * We're asked to ALWAYS_READ from stdin, but no --stdin
    -+	 * option (or "consumed_stdin" would be set).
    -+	 */
    -+	if (!revs->consumed_stdin &&
    -+	    revs->stdin_handling == REV_INFO_STDIN_ALWAYS_READ)
    -+		read_revisions_from_stdin(revs, &prune_data);
    -+
    - 	if (prune_data.nr) {
    - 		/*
    - 		 * If we need to introduce the magic "a lone ':' means no
    -
    - ## revision.h ##
    -@@ revision.h: struct topo_walk_info;
    - enum rev_info_stdin {
    - 	REV_INFO_STDIN_CONSUME_ON_OPTION = 0,
    - 	REV_INFO_STDIN_IGNORE,
    -+	REV_INFO_STDIN_ALWAYS_READ,
    - };
    - 
    -+enum rev_info_stdin_line {
    -+	REV_INFO_STDIN_LINE_PROCESS,
    -+	REV_INFO_STDIN_LINE_CONTINUE,
    -+};
    -+
    -+typedef enum rev_info_stdin_line (*rev_info_stdin_line_func)(
    -+	struct rev_info *revs, struct strbuf *line, void *stdin_line_priv);
    -+
    - struct rev_info {
    - 	/* Starting list */
    - 	struct commit_list *commits;
    -@@ revision.h: struct rev_info {
    - 	 *
    - 	 * Can be set to REV_INFO_STDIN_IGNORE to ignore the --stdin
    - 	 * option.
    -+	 *
    -+	 * Set it to REV_INFO_STDIN_ALWAYS_READ if there's always data
    -+	 * on stdin to be read, even if no --stdin option is provided.
    - 	 */
    - 	enum rev_info_stdin stdin_handling;
    - 
    -@@ revision.h: struct rev_info {
    - 	 */
    - 	int consumed_stdin;
    - 
    -+	/*
    -+	 * When reading from stdin (see "stdin_handling" above) define
    -+	 * a handle_stdin_line function to consume the lines.
    -+	 *
    -+	 * - Return REV_INFO_STDIN_LINE_PROCESS to continue
    -+	 *   revision.c's normal processing of the line (after
    -+	 *   possibly munging the provided strbuf).
    -+	 *
    -+	 * - Return REV_INFO_STDIN_LINE_CONTINUE to indicate that the
    -+	 *   line is fully processed, moving onto the next line (if
    -+	 *   any)
    -+	 *
    -+	 * Use the "stdin_line_priv" to optionally pass your own data
    -+	 * around.
    -+	 */
    -+	rev_info_stdin_line_func handle_stdin_line;
    -+	void *stdin_line_priv;
    -+
    - 	/* topo-sort */
    - 	enum rev_sort_order sort_order;
    - 
6:  34750ab81cf ! 5:  0c049aee67c pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
    @@ Commit message
             anticipation of a future in-tree user.
     
          2. I have patches for such an in-tree user already in a series
    -        that'll be submitted after this one.
    +        that'll be submitted after this one. See the reference to "git
    +        bundle create --stdin" in the commit that added the "handle_stdin_line"
    +        API.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
-- 
2.32.0.636.g43e71d69cff

