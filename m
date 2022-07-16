Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23699C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 07:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGPHlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 03:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPHlL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 03:41:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AEE201AF
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:41:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 72so6327965pge.0
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/atULR2DqHI/rggd9HsFoKvV/OapAGQUmyI3tiWTevM=;
        b=jeHiX+vLAhGRJnLFdlRi0Og7VgRDvJ/X6mtCBJx+ueWn4ye0r4lsCzvqY4+AFJVj00
         u+H8rNIjhq2dJhpGC1YFwy8zdjMRV6BxpN6rXYNd32wKyJjtypXJWdtGw5knifkczGp1
         Pd7tTqt8LoYmw/u2mboxHHQ5w/IgXmeigBTVdiEZEeJS1O0ywkJyf87lsPfzKXdIEPVi
         E0ffq4Oi5y2Oqr1wazjRBXmY9Imy42eCxXbuxXbsZr5MPTVHU1MaaAGwUyYcUDaGuy6F
         BETOPZq29CEj/eJxEjs+0KHvW4XAwxzqZKW6OPuU1ECxBM5xomcvkuy4J+eSMcMMMkjC
         U6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/atULR2DqHI/rggd9HsFoKvV/OapAGQUmyI3tiWTevM=;
        b=gBDA1FR1cnWPvVcbI+mirWBaY2fC/Fw589uKz2+v2gWW2/nnIsrD/JQ1bFoV5zCwRc
         h8WhoPT54gNAK7M5gDhr9Dndp2/OT8TeBNbjiuPFCx+L80T5Uje7hxMB2rchm3edYgCd
         Z53B8pfolciMwLs8Y7VsqwyKeeWarytYcPzdreqfPwAkITnGYguDgEojKjQgkqPpN9fS
         Nq9IpSKRo2rfWEvYF8HjRgJEjt5lcGmWK3MptFjrDoJCRcSJf4yplPevEwO8TuSWhiSg
         pf6IhHQd3Zrgzajny7Ae2LKOQIM19UYDtbof67adyY+9YrADYseJ+I6BGIun4TZ6rrAm
         892g==
X-Gm-Message-State: AJIora9qcL/GKJArO22LqRulqBbxXEtDqy9Zel82tRtOqVc5d6N3mElq
        fMXCQqxDikNleOVQ+Ql6lqk5oLlJ0iaNX+pe
X-Google-Smtp-Source: AGRyM1u+LQ6QLA7MEeX0vsMvddG4bIHtjXosh5qllhARGBOknXk2KA7cZTbNLm+xsksp+6eP4342Aw==
X-Received: by 2002:a05:6a00:228e:b0:52b:13d2:2627 with SMTP id f14-20020a056a00228e00b0052b13d22627mr15867947pfe.42.1657957269011;
        Sat, 16 Jul 2022 00:41:09 -0700 (PDT)
Received: from HB2.. ([110.225.168.189])
        by smtp.gmail.com with ESMTPSA id i27-20020a63541b000000b004161e62a3a5sm4325923pgb.78.2022.07.16.00.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 00:41:08 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 0/4] Add support for mailmap in cat-file
Date:   Sat, 16 Jul 2022 13:10:51 +0530
Message-Id: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.1.120.g001f220fb8
In-Reply-To: <20220712160634.213956-1-siddharthasthana31@gmail.com>
References: <20220712160634.213956-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot Johannes and Junio for helping me identify and fix the memory
corruption in commit_rewrite_person()!  :)

= Description

This patch series adds mailmap support to the git-cat-file command. It
adds the mailmap support only for the commit and tag objects by
replacing the idents for "author", "committer" and "tagger" headers. The
mailmap only takes effect when --[no-]-use-mailmap or --[no-]-mailmap
option is passed to the git cat-file command. The changes will work with
the batch mode as well.

So, if one wants to enable mailmap they can use either of the following
commands:
$ git cat-file --use-mailmap -p <object>
$ git cat-file --use-mailmap <type> <object>

To use it in the batch mode, one can use the following command:
$ git cat-file --use-mailmap --batch

= Patch Organization

- The first patch improves the commit_rewrite_person() by restricting it 
  to traverse only through the header part of the commit object buffer.
  It also adds an argument called headers which the callers can pass. 
  The function will replace idents only on these  passed headers. 
  Thus, the caller won't have to make repeated calls to the function.
- The second patch moves commit_rewrite_person() to ident.c to expose it
  as a public function so that it can be used to replace idents in the
  headers of desired objects.
- The third patch renames commit_rewrite_person() to a name which
  describes its functionality clearly. It is renamed to
  apply_mailmap_to_header().
- The last patch adds mailmap support to the git cat-file command. It
  adds the required documentation and tests as well.

Changes in v5:
- In commit_rewrite_person(), we make calls to rewrite_ident_line(),
  where the strbuf can grow. This moves the buffer to a new address,
  which invalidates the `line` pointer, which still points at the same
  address . This issue has been fixed by breaking out of the inner for
  loop as soon as there we find a match for any commit headers that we
  are passing to the function.
- The commit_rewrite_person() no longer has a `linelen` variable and
  instead we now rely on `buf_offset` for navigating through the buffer.
- Some overly long lines have been wrapped.

Siddharth Asthana (4):
  revision: improve commit_rewrite_person()
  ident: move commit_rewrite_person() to ident.c
  ident: rename commit_rewrite_person() to apply_mailmap_to_header()
  cat-file: add mailmap support

 Documentation/git-cat-file.txt |  6 +++
 builtin/cat-file.c             | 43 ++++++++++++++++++-
 cache.h                        |  6 +++
 ident.c                        | 75 ++++++++++++++++++++++++++++++++++
 revision.c                     | 50 ++---------------------
 t/t4203-mailmap.sh             | 59 ++++++++++++++++++++++++++
 6 files changed, 191 insertions(+), 48 deletions(-)

Range-diff against v4:
1:  9e95326c58 ! 1:  8c29ad9351 revision: improve commit_rewrite_person()
    @@ Commit message
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: John Cai <johncai86@gmail.com>
         Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## revision.c ##
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     +/*
     + * Returns the difference between the new and old length of the ident line.
     + */
    -+static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct string_list *mailmap)
    ++static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
    ++								  struct string_list *mailmap)
      {
     -	char *person, *endp;
     +	char *endp;
    @@ revision.c: static int commit_rewrite_person(struct strbuf *buf, const char *wha
      	return 0;
      }
      
    -+static void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
    ++static void commit_rewrite_person(struct strbuf *buf, const char **header,
    ++								  struct string_list *mailmap)
     +{
     +	size_t buf_offset = 0;
     +
    @@ revision.c: static int commit_rewrite_person(struct strbuf *buf, const char *wha
     +
     +	for (;;) {
     +		const char *person, *line;
    -+		size_t i, linelen;
    ++		size_t i;
     +
     +		line = buf->buf + buf_offset;
    -+		linelen = strchrnul(line, '\n') - line + 1;
    ++		if (!*line || *line == '\n')
    ++			return; /* End of header */
     +
    -+		if (linelen <= 1)
    -+			/* End of header */
    -+			return;
    ++		for (i = 0; header[i]; i++)
    ++			if (skip_prefix(line, header[i], &person)) {
    ++				rewrite_ident_line(person, buf, mailmap);
    ++				break;
    ++			}
     +
    -+		buf_offset += linelen;
    -+
    -+		for (i = 0; headers[i]; i++)
    -+			if (skip_prefix(line, headers[i], &person))
    -+				buf_offset += rewrite_ident_line(person, buf, mailmap);
    ++		buf_offset = strchrnul(buf->buf + buf_offset, '\n') - buf->buf;
    ++		if (buf->buf[buf_offset] == '\n')
    ++			++buf_offset;
     +	}
     +}
     +
2:  d9395cb8b2 ! 2:  ccb7f72fcb ident: move commit_rewrite_person() to ident.c
    @@ cache.h: struct ident_split {
     + * Given a commit object buffer and the commit headers, replaces the idents
     + * in the headers with their canonical versions using the mailmap mechanism.
     + */
    -+void commit_rewrite_person(struct strbuf *buf, const char **commit_headers, struct string_list *mailmap);
    ++void commit_rewrite_person(struct strbuf *, const char **, struct string_list *);
     +
      /*
       * Compare split idents for equality or strict ordering. Note that we
    @@ ident.c: int split_ident_line(struct ident_split *split, const char *line, int l
     +/*
     + * Returns the difference between the new and old length of the ident line.
     + */
    -+static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct string_list *mailmap)
    ++static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
    ++								  struct string_list *mailmap)
     +{
     +	char *endp;
     +	size_t len, namelen, maillen;
    @@ ident.c: int split_ident_line(struct ident_split *split, const char *line, int l
     +	return 0;
     +}
     +
    -+void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
    ++void commit_rewrite_person(struct strbuf *buf, const char **header,
    ++						   struct string_list *mailmap)
     +{
     +	size_t buf_offset = 0;
     +
    @@ ident.c: int split_ident_line(struct ident_split *split, const char *line, int l
     +
     +	for (;;) {
     +		const char *person, *line;
    -+		size_t i, linelen;
    ++		size_t i;
     +
     +		line = buf->buf + buf_offset;
    -+		linelen = strchrnul(line, '\n') - line + 1;
    -+
    -+		if (linelen <= 1)
    -+			/* End of header */
    -+			return;
    -+
    -+		buf_offset += linelen;
    -+
    -+		for (i = 0; headers[i]; i++)
    -+			if (skip_prefix(line, headers[i], &person))
    -+				buf_offset += rewrite_ident_line(person, buf, mailmap);
    ++		if (!*line || *line == '\n')
    ++			return; /* End of header */
    ++
    ++		for (i = 0; header[i]; i++)
    ++			if (skip_prefix(line, header[i], &person)) {
    ++				rewrite_ident_line(person, buf, mailmap);
    ++				break;
    ++			}
    ++
    ++		buf_offset = strchrnul(buf->buf + buf_offset, '\n') - buf->buf;
    ++		if (buf->buf[buf_offset] == '\n')
    ++			++buf_offset;
     +	}
     +}
      
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     -/*
     - * Returns the difference between the new and old length of the ident line.
     - */
    --static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct string_list *mailmap)
    +-static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
    +-								  struct string_list *mailmap)
     -{
     -	char *endp;
     -	size_t len, namelen, maillen;
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     -	return 0;
     -}
     -
    --static void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
    +-static void commit_rewrite_person(struct strbuf *buf, const char **header,
    +-								  struct string_list *mailmap)
     -{
     -	size_t buf_offset = 0;
     -
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     -
     -	for (;;) {
     -		const char *person, *line;
    --		size_t i, linelen;
    +-		size_t i;
     -
     -		line = buf->buf + buf_offset;
    --		linelen = strchrnul(line, '\n') - line + 1;
    --
    --		if (linelen <= 1)
    --			/* End of header */
    --			return;
    --
    --		buf_offset += linelen;
    --
    --		for (i = 0; headers[i]; i++)
    --			if (skip_prefix(line, headers[i], &person))
    --				buf_offset += rewrite_ident_line(person, buf, mailmap);
    +-		if (!*line || *line == '\n')
    +-			return; /* End of header */
    +-
    +-		for (i = 0; header[i]; i++)
    +-			if (skip_prefix(line, header[i], &person)) {
    +-				rewrite_ident_line(person, buf, mailmap);
    +-				break;
    +-			}
    +-
    +-		buf_offset = strchrnul(buf->buf + buf_offset, '\n') - buf->buf;
    +-		if (buf->buf[buf_offset] == '\n')
    +-			++buf_offset;
     -	}
     -}
     -
3:  355bbda25e ! 3:  38c18fd10d ident: rename commit_rewrite_person() to apply_mailmap_to_header()
    @@ cache.h: struct ident_split {
     + * Given a commit or tag object buffer and the commit or tag headers, replaces
     + * the idents in the headers with their canonical versions using the mailmap mechanism.
       */
    --void commit_rewrite_person(struct strbuf *buf, const char **commit_headers, struct string_list *mailmap);
    -+void apply_mailmap_to_header(struct strbuf *buf, const char **headers, struct string_list *mailmap);
    +-void commit_rewrite_person(struct strbuf *, const char **, struct string_list *);
    ++void apply_mailmap_to_header(struct strbuf *, const char **, struct string_list *);
      
      /*
       * Compare split idents for equality or strict ordering. Note that we
     
      ## ident.c ##
    -@@ ident.c: static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct
    +@@ ident.c: static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
      	return 0;
      }
      
    --void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
    -+void apply_mailmap_to_header(struct strbuf *buf, const char **headers, struct string_list *mailmap)
    +-void commit_rewrite_person(struct strbuf *buf, const char **header,
    +-						   struct string_list *mailmap)
    ++void apply_mailmap_to_header(struct strbuf *buf, const char **header,
    ++							 struct string_list *mailmap)
      {
      	size_t buf_offset = 0;
      
4:  ac532965b4 ! 4:  0a459d4c53 cat-file: add mailmap support
    @@ Commit message
         This patch also introduces new test cases to test the mailmap mechanism in
         git cat-file command.
     
    -    The tests added in this patch series rely on the side effects of the earlier
    -    test case `set up symlink tests`. However, that test case is guarded behind the
    -    `SYMLINKS` prereq, therefore it is not run e.g. on Windows which can cause the
    -    added tests to fail on Windows. So, fix that by removing the prereq from the
    -    `set up` test case, and adjusting its title to reflect its broadened responsibility.
    -
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: John Cai <johncai86@gmail.com>
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
      		batch.all_objects = 1;
     
      ## t/t4203-mailmap.sh ##
    -@@ t/t4203-mailmap.sh: test_expect_success 'find top-level mailmap from subdir' '
    - 	test_cmp expect actual
    - '
    - 
    --test_expect_success SYMLINKS 'set up symlink tests' '
    -+test_expect_success 'prepare for symlink/--use-mailmap tests' '
    - 	git commit --allow-empty -m foo --author="Orig <orig@example.com>" &&
    - 	echo "New <new@example.com> <orig@example.com>" >map &&
    - 	rm -f .mailmap
     @@ t/t4203-mailmap.sh: test_expect_success SYMLINKS 'symlinks not respected in-tree' '
      	test_cmp expect actual
      '
      
    ++test_expect_success 'prepare for cat-file --mailmap' '
    ++	rm -f .mailmap &&
    ++	git commit --allow-empty -m foo --author="Orig <orig@example.com>"
    ++'
    ++
     +test_expect_success '--no-use-mailmap disables mailmap in cat-file' '
     +	test_when_finished "rm .mailmap" &&
     +	cat >.mailmap <<-EOF &&
-- 
2.37.1.120.g001f220fb8

