Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F49C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 16:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiGGQQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiGGQQl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 12:16:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4243C9F
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 09:16:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e16so7589917pfm.11
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RLlu5RrvBnuqVu3dhbsIUR6ppljNlWct3lfrI/Mkmro=;
        b=PdYT9LabYNgya00DC2yBvmlW5djWZVP2ksbzeGB5PY5q0sxtgKAkEI+hqK9EyWHaDp
         Y3T/DdqN/7gLUR5kBOt4li9F9Cd12L9LbjyYNM2SK9jCl4gAe2EY7SyRQuj5vzOa+Edi
         6Lo/Cn0xuNA+8YPAu0qlEsR0RFoZmPiJIkOliypyNAuT3ryT6R0OzN2SLfll9bwzNvX4
         Z9vn4q47Og+gA7m9HC64g000aFiwKLmSIAZINtUaJiWd7xD1ou4EZ6yAVzuz0OxQhdzd
         ryzMlRe+1cUPeXs/BpS9vw/zixQno4Z25FXc/0LyLYeRXJV6XXPx+UsSHkgFEQe6q6ki
         jhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLlu5RrvBnuqVu3dhbsIUR6ppljNlWct3lfrI/Mkmro=;
        b=ro6kse4LWT9yfn0oi5sXf0fZSZf4/3X0WeQO4hcb5kwP1/ucsc7k6ZoWPCEeZwg3ak
         I5ASk9WG+aQhmtSTNtbL4G7boOsD29RqFGkk4pGFJH+OHfj3X0XsvpXlS1rVf/t2TiOX
         S7stAF0TQxM4ED4JuPIl1p6Lqpldbb2yLmks8xBnPCc9TcMD3pcK6J3USY/CWf8yFhXX
         qQsbj79rPb/k07Xe8rPR0+WOJhs/TOjerclN08F9zIGiExN3G1vyQTKg6UZRYrVi3kV1
         EFOgBxI233I6wjjGjRPwFYf1UaCEkXh53NPU+RFbOh4wbXz1retsYdkQkJfzIfjmi3BV
         I+EQ==
X-Gm-Message-State: AJIora+JDdLEi7SeVQa1P3BG5AGUALPCNu7cpov5ef4ZZ9zXldYDjYYL
        94S03n1UHosZCuhJZvaGGEvzoHA10kCq8X6E
X-Google-Smtp-Source: AGRyM1tGD/fz+ymHcc1jSNd2N5u5lpGk66SClyOO78SWGA6O3jKj+x/HasRK8VBMJ6eJYKXwi103jw==
X-Received: by 2002:a63:ff66:0:b0:412:6f4c:1e11 with SMTP id s38-20020a63ff66000000b004126f4c1e11mr13607657pgk.396.1657210599072;
        Thu, 07 Jul 2022 09:16:39 -0700 (PDT)
Received: from HB2.. ([122.175.103.204])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b0015ee985999dsm27996199plr.97.2022.07.07.09.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:16:38 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        phillip.wood@dunelm.org.uk, avarab@gmail.com, congdanhqx@gmail.com,
        gitster@pobox.com, christian.couder@gmail.com, johncai86@gmail.com
Subject: [PATCH v2 0/4] Add support for mailmap in cat-file
Date:   Thu,  7 Jul 2022 21:45:50 +0530
Message-Id: <20220707161554.6900-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.ga6a61a26c1.dirty
In-Reply-To: <20220630142444.651948-1-siddharthasthana31@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot for the review and suggestions Phillip, Danh, Ævar and Junio.
Really grateful for that :)

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

Changes in v2:
- The commit_rewrite_person() has been improved by restricting it to
  traverse only the header part of the object buffers.
- The callers of commit_rewrite_person() now don't require to call it
  multiple times for different headers. They can pass an array of
  headers and commit_rewrite_person() replaces idents only on those
  headers.
- commit_rewrite_person() has been renamed to a suitable name which
  expresses its functionality clearly.
- More tests have been added to test the --[no-]-use-mailmap option for
  the tag objects.
- Redundant operations from the tests have been removed.

Siddharth Asthana (4):
  revision: improve commit_rewrite_person()
  ident: move commit_rewrite_person() to ident.c
  ident: rename commit_rewrite_person() to apply_mailmap_to_header()
  cat-file: add mailmap support

 Documentation/git-cat-file.txt |  6 +++
 builtin/cat-file.c             | 31 ++++++++++++++-
 cache.h                        |  6 +++
 ident.c                        | 69 ++++++++++++++++++++++++++++++++++
 revision.c                     | 49 +-----------------------
 t/t4203-mailmap.sh             | 54 ++++++++++++++++++++++++++
 6 files changed, 167 insertions(+), 48 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  64e1f750e1 revision: improve commit_rewrite_person()
1:  8749b6024f ! 2:  b18ced0ece ident: move commit_rewrite_person() to ident.c
    @@ Metadata
      ## Commit message ##
         ident: move commit_rewrite_person() to ident.c
     
    -    commit_rewrite_person() is a static function defined in revision.c.
    -    As the name suggests, this function can be used to replace author's,
    -    committer's or tagger's name in the commit/tag object buffer.
    +    commit_rewrite_person() and rewrite_ident_line() are static functions
    +    defined in revision.c.
     
    -    This patch moves this function from revision.c to ident.c which contains
    -    many other functions related to identification like split_ident_line. By
    -    moving this function to ident.c, we intend to use it in git-cat-file to
    -    replace committer's, author's and tagger's names and emails with their
    -    canonical name and email using the mailmap mechanism. The function
    -    is moved as is for now to make it clear that there are no other changes,
    -    but will be renamed in a following commit.
    +    Their usages are as follows:
    +    - commit_rewrite_person() takes a commit buffer and replaces the author
    +      and committer idents with their canonical versions using the mailmap
    +      mechanism
    +    - rewrite_ident_line() takes author/committer header lines from the
    +      commit buffer and replaces the idents with their canonical versions
    +      using the mailmap mechanism.
     
    +    This patch moves commit_rewrite_person() and rewrite_ident_line() to
    +    ident.c which contains many other functions related to idents like
    +    split_ident_line(). By moving commit_rewrite_person() to ident.c, we
    +    also intend to use it in git-cat-file to replace committer and author
    +    idents from the headers to their canonical versions using the mailmap
    +    mechanism. The function is moved as is for now to make it clear that
    +    there are no other changes, but it will be renamed in a following
    +    commit.
    +
    +    Mentored-by: Christian Couder <christian.couder@gmail.com>
    +    Mentored-by: John Cai <johncai86@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## cache.h ##
    @@ cache.h: struct ident_split {
      int split_ident_line(struct ident_split *, const char *, int);
      
     +/*
    -+ * Given a commit or tag object buffer, replaces the person's
    -+ * (author/committer/tagger) name and email with their canonical
    -+ * name and email using mailmap mechanism. Signals a success with
    -+ * 1 and failure with a 0.
    ++ * Given a commit object buffer and the commit headers, replaces the idents
    ++ * in the headers with their canonical versions using the mailmap mechanism.
     + */
    -+int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap);
    ++void commit_rewrite_person(struct strbuf *buf, const char **commit_headers, struct string_list *mailmap);
     +
      /*
       * Compare split idents for equality or strict ordering. Note that we
    @@ ident.c: int split_ident_line(struct ident_split *split, const char *line, int l
      	return 0;
      }
      
    -+int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
    ++/*
    ++ * Returns the difference between the new and old length of the ident line.
    ++ */
    ++static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct string_list *mailmap)
     +{
    -+	char *person, *endp;
    ++	char *endp;
     +	size_t len, namelen, maillen;
     +	const char *name;
     +	const char *mail;
     +	struct ident_split ident;
     +
    -+	person = strstr(buf->buf, what);
    -+	if (!person)
    -+		return 0;
    -+
    -+	person += strlen(what);
     +	endp = strchr(person, '\n');
     +	if (!endp)
     +		return 0;
    @@ ident.c: int split_ident_line(struct ident_split *split, const char *line, int l
     +
     +	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
     +		struct strbuf namemail = STRBUF_INIT;
    ++		size_t newlen;
     +
     +		strbuf_addf(&namemail, "%.*s <%.*s>",
     +			    (int)namelen, name, (int)maillen, mail);
    @@ ident.c: int split_ident_line(struct ident_split *split, const char *line, int l
     +			      ident.mail_end - ident.name_begin + 1,
     +			      namemail.buf, namemail.len);
     +
    ++		newlen = namemail.len;
    ++
     +		strbuf_release(&namemail);
     +
    -+		return 1;
    ++		return newlen - (ident.mail_end - ident.name_begin + 1);
     +	}
     +
     +	return 0;
    ++}
    ++
    ++void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
    ++{
    ++	size_t buf_offset = 0;
    ++
    ++	if (!mailmap)
    ++		return;
    ++
    ++	for (;;) {
    ++		const char *person, *line = buf->buf + buf_offset;
    ++		int i, linelen = strchrnul(line, '\n') - line + 1;
    ++
    ++		if (!linelen || linelen == 1)
    ++			/* End of header */
    ++			return;
    ++
    ++		buf_offset += linelen;
    ++
    ++		for (i = 0; headers[i]; i++)
    ++			if (skip_prefix(line, headers[i], &person))
    ++				buf_offset += rewrite_ident_line(person, buf, mailmap);
    ++	}
     +}
      
      static void ident_env_hint(enum want_ident whose_ident)
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
      	return 0;
      }
      
    --static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
    +-/*
    +- * Returns the difference between the new and old length of the ident line.
    +- */
    +-static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct string_list *mailmap)
     -{
    --	char *person, *endp;
    +-	char *endp;
     -	size_t len, namelen, maillen;
     -	const char *name;
     -	const char *mail;
     -	struct ident_split ident;
     -
    --	person = strstr(buf->buf, what);
    --	if (!person)
    --		return 0;
    --
    --	person += strlen(what);
     -	endp = strchr(person, '\n');
     -	if (!endp)
     -		return 0;
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     -
     -	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
     -		struct strbuf namemail = STRBUF_INIT;
    +-		size_t newlen;
     -
     -		strbuf_addf(&namemail, "%.*s <%.*s>",
     -			    (int)namelen, name, (int)maillen, mail);
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     -			      ident.mail_end - ident.name_begin + 1,
     -			      namemail.buf, namemail.len);
     -
    +-		newlen = namemail.len;
    +-
     -		strbuf_release(&namemail);
     -
    --		return 1;
    +-		return newlen - (ident.mail_end - ident.name_begin + 1);
     -	}
     -
     -	return 0;
     -}
    +-
    +-static void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
    +-{
    +-	size_t buf_offset = 0;
    +-
    +-	if (!mailmap)
    +-		return;
    +-
    +-	for (;;) {
    +-		const char *person, *line = buf->buf + buf_offset;
    +-		int i, linelen = strchrnul(line, '\n') - line + 1;
    +-
    +-		if (!linelen || linelen == 1)
    +-			/* End of header */
    +-			return;
    +-
    +-		buf_offset += linelen;
    +-
    +-		for (i = 0; headers[i]; i++)
    +-			if (skip_prefix(line, headers[i], &person))
    +-				buf_offset += rewrite_ident_line(person, buf, mailmap);
    +-	}
    +-}
     -
      static int commit_match(struct commit *commit, struct rev_info *opt)
      {
2:  aff60f541b < -:  ---------- ident: rename commit_rewrite_person() to rewrite_ident_line()
-:  ---------- > 3:  2494ce1ed2 ident: rename commit_rewrite_person() to apply_mailmap_to_header()
3:  2a697167db ! 4:  94838a2566 cat-file: add mailmap support
    @@ Metadata
      ## Commit message ##
         cat-file: add mailmap support
     
    -    git cat-file is not a plumbing command anymore, especially as it gained
    -    more and more high level features like its `--batch-command` mode. So
    -    tools do use it to get commit and tag contents that are then displayed
    -    to users. This content which has author, committer or tagger
    -    information, could benefit from passing through the mailmap mechanism,
    -    before being sent or displayed.
    +    git-cat-file is used by tools like GitLab to get commit tag contents
    +    that are then displayed to users. This content which has author,
    +    committer or tagger information, could benefit from passing through the
    +    mailmap mechanism before being sent or displayed.
     
         This patch adds --[no-]use-mailmap command line option to the git
         cat-file command. It also adds --[no-]mailmap option as an alias to
         --[no-]use-mailmap.
     
    -    At this time, this patch only adds a command line
    -    option, but perhaps a `cat-file.mailmap` config option could be added as
    -    well in the same way as for `git log`.
    -
    +    Mentored-by: Christian Couder <christian.couder@gmail.com>
    +    Mentored-by: John Cai <johncai86@gmail.com>
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/git-cat-file.txt ##
    @@ Documentation/git-cat-file.txt: OPTIONS
      
     +--[no-]mailmap::
     +--[no-]use-mailmap::
    -+	Use mailmap file to map author, committer and tagger names
    -+	and email addresses to canonical real names and email addresses.
    -+	See linkgit:git-shortlog[1].
    ++       Use mailmap file to map author, committer and tagger names
    ++       and email addresses to canonical real names and email addresses.
    ++       See linkgit:git-shortlog[1].
     +
      --textconv::
      	Show the content as transformed by a textconv filter. In this case,
    @@ builtin/cat-file.c: struct batch_options {
     +{
     +	struct strbuf sb = STRBUF_INIT;
     +	strbuf_attach(&sb, object_buf, *size, *size + 1);
    -+	rewrite_ident_line(&sb, "\nauthor ", &mailmap);
    -+	rewrite_ident_line(&sb, "\ncommitter ", &mailmap);
    -+	rewrite_ident_line(&sb, "\ntagger ", &mailmap);
    ++	const char *headers[] = { "author ", "committer ", "tagger ", NULL };
    ++	apply_mailmap_to_header(&sb, headers, &mailmap);
     +	*size = sb.len;
     +	return strbuf_detach(&sb, NULL);
     +}
    @@ t/t4203-mailmap.sh: test_expect_success SYMLINKS 'symlinks not respected in-tree
     +	author Orig <orig@example.com>
     +	EOF
     +	git cat-file --no-use-mailmap commit HEAD >log &&
    -+	grep author log >actual &&
    -+	sed -e "/^author/q" actual >log &&
    -+	sed -e "s/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//" log >actual &&
    ++	sed -n "/^author /s/\([^>]*>\).*/\1/p" log >actual &&
     +	test_cmp expect actual
     +'
     +
    @@ t/t4203-mailmap.sh: test_expect_success SYMLINKS 'symlinks not respected in-tree
     +	author A U Thor <author@example.com>
     +	EOF
     +	git cat-file --use-mailmap commit HEAD >log &&
    -+	grep author log >actual &&
    -+	sed -e "/^author/q" actual >log &&
    -+	sed -e "s/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//" log >actual &&
    ++	sed -n "/^author /s/\([^>]*>\).*/\1/p" log >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success '--no-mailmap disables mailmap in cat-file for annotated tag objects' '
    ++	test_when_finished "rm .mailmap" &&
    ++	cat >.mailmap <<-EOF &&
    ++	Orig <orig@example.com> C O Mitter <committer@example.com>
    ++	EOF
    ++	cat >expect <<-EOF &&
    ++	tagger C O Mitter <committer@example.com>
    ++	EOF
    ++	git tag -a -m "annotated tag" v1 &&
    ++	git cat-file --no-mailmap -p v1 >log &&
    ++	sed -n "/^tagger /s/\([^>]*>\).*/\1/p" log >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success '--mailmap enables mailmap in cat-file for annotated tag objects' '
    ++	test_when_finished "rm .mailmap" &&
    ++	cat >.mailmap <<-EOF &&
    ++	Orig <orig@example.com> C O Mitter <committer@example.com>
    ++	EOF
    ++	cat >expect <<-EOF &&
    ++	tagger Orig <orig@example.com>
    ++	EOF
    ++	git tag -a -m "annotated tag" v2 &&
    ++	git cat-file --mailmap -p v2 >log &&
    ++	sed -n "/^tagger /s/\([^>]*>\).*/\1/p" log >actual &&
     +	test_cmp expect actual
     +'
     +
-- 
2.37.0.6.ga6a61a26c1.dirty

