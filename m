Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A70C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJUDLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJUDLa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:11:30 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790E9120ED3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:28 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y80so1278049iof.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFZz7RRfX406N+lMw1r4LEdeljGhFpY+TsTMUATnl8E=;
        b=SvwYkPuP48lQu0MIYaoyAz47zAQF+DfOHH17UAxpXQOUMTGL5aHdic4X4b5TCcG3m3
         ByJkNOO/5TcFHajK7SbiZ0c0JUrCPeHYwFlt0oueFIgoGewau9ZShYIyYQV8Z6CErL3y
         1wteJ5vkRNvKYKV/XldxIVzf2tCET/w5bCx5xGdeUR978dcIuWs+9wVk6+U/zSBIR44Y
         vR+vP4bu5SYbew4DKfMJnomUtshu40ZI6Ted2EkWuOwT2MVsnGviAPX2Vwxi/2NQiaTI
         yJ1l2ECtz/3r6lDDZ8JJI0E7WNZUNpT+JYQnJJROXdkoobuUiJQMvJUuSX/waCGXtC6w
         ulSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFZz7RRfX406N+lMw1r4LEdeljGhFpY+TsTMUATnl8E=;
        b=Eqf9z18uVq4wmQWC+UvAnSUv6KPVjtVV8hiYEwmELkM+VxaGkc0X2LjXtL0hgQMfi0
         UlH4Xn5Y9kb16637+FbAV0/THKDHqdcsIlzvrp1NrWIPIAZyzzKjOwBt6mtvMDb4/nr9
         PHD+SXT5RiDBJNkKOjyS4KgKgEbRn1jfuM+QU24T5CrKipoXnYKfRO5TzGuAoaC3CvdQ
         qT1144vVVKcKi1q30KUd074EGHbn+bwd4NjMknMs6j6QdpcwUO/qVk0uKl419+CGcLOV
         l+zBqsF6er6WyHnM6DzWKbBHm9xzEUw6WcrYf07Jt8MMYfV3o1LRwdk/fWmQObDrZJZN
         5HRA==
X-Gm-Message-State: ACrzQf3ezceeKLGJr2uDZIz9+/ekJynTfeqKaNt8weP0oIm7zYJJk46v
        BmMt0ifQqbdvZDzLgTM/H5YaWNBsZsMsW2ng
X-Google-Smtp-Source: AMsMyM4KqudZRaQ/R9I62CpMd9sdLubmmlQy6XJRtnRPEXQgnTxWa6E7uYGs9gp+k3hSd/B0IfibIA==
X-Received: by 2002:a6b:3fd5:0:b0:6bc:76e8:b3c0 with SMTP id m204-20020a6b3fd5000000b006bc76e8b3c0mr11925218ioa.132.1666321887480;
        Thu, 20 Oct 2022 20:11:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cx4-20020a056638490400b00363cce75bffsm3755656jab.151.2022.10.20.20.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:11:27 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:11:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v2 0/6] shortlog: introduce `--group=<format>`
Message-ID: <cover.1666320509.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of my series to implement arbitrary pretty formats as
shortlog `--group`'s, based on a suggestion from Jacob Stopak.

The changes are somewhat minimal, including a rebase onto the current
tip of master. Less minimal, however, is dropping the reimplementation
of `--group=trailer:<key>` in terms of the format group, since this
ended up being more trouble than it was worth.

There are also a handful of small tweaks throughout based on feedback
from Peff.

Thanks in advance for your review.

Jeff King (1):
  shortlog: accept `--date`-related options

Taylor Blau (5):
  shortlog: make trailer insertion a noop when appropriate
  shortlog: extract `--group` fragment for translation
  shortlog: support arbitrary commit format `--group`s
  shortlog: implement `--group=author` in terms of `--group=<format>`
  shortlog: implement `--group=committer` in terms of `--group=<format>`

 Documentation/git-shortlog.txt |  8 ++++
 builtin/log.c                  |  1 +
 builtin/shortlog.c             | 83 +++++++++++++++++++++++-----------
 shortlog.h                     |  5 ++
 t/t4201-shortlog.sh            | 51 +++++++++++++++++++++
 5 files changed, 121 insertions(+), 27 deletions(-)

Range-diff against v1:
1:  eaec59daa1 < -:  ---------- Documentation: extract date-options.txt
2:  b587b8ea4a ! 1:  58baccbaa8 shortlog: accept `--date`-related options
    @@ Metadata
      ## Commit message ##
         shortlog: accept `--date`-related options
     
    -    Prepare for the future patch which will introduce arbitrary pretty
    -    formats via the `--group` argument.
    +    Prepare for a future patch which will introduce arbitrary pretty formats
    +    via the `--group` argument.
     
         To allow additional customizability (for example, to support something
         like `git shortlog -s --group='%aD' --date='format:%Y-%m' ...` (which
         groups commits by the datestring 'YYYY-mm' according to author date), we
         must store off the `--date` parsed from calling `parse_revision_opt()`.
     
    +    Note that this also affects custom output `--format` strings in `git
    +    shortlog`. Though this is a behavior change, this is arguably fixing a
    +    long-standing bug (ie., that `--format` strings are not affected by
    +    `--date` specifiers as they should be).
    +
         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/git-shortlog.txt ##
    -@@ Documentation/git-shortlog.txt: options or the revision range, when confusion arises.
    - :git-shortlog: 1
    - include::rev-list-options.txt[]
    +@@ Documentation/git-shortlog.txt: OPTIONS
      
    -+include::date-options.txt[]
    + 	Each pretty-printed commit will be rewrapped before it is shown.
    + 
    ++--date=<format>::
    ++	With a `--group=format:<format>`, show dates formatted
    ++	according to the given date string. (See the `--date` options
    ++	in the "COMMIT FORMATTING" section of linkgit:git-log[1].)
     +
    - MAPPING AUTHORS
    - ---------------
    - 
    + --group=<type>::
    + 	Group commits based on `<type>`. If no `--group` option is
    + 	specified, the default is `author`. `<type>` is one of:
     
      ## builtin/shortlog.c ##
     @@ builtin/shortlog.c: void shortlog_add_commit(struct shortlog *log, struct commit *commit)
    @@ shortlog.h: struct shortlog {
      
      	enum {
      		SHORTLOG_GROUP_AUTHOR = (1 << 0),
    +
    + ## t/t4201-shortlog.sh ##
    +@@ t/t4201-shortlog.sh: test_expect_success 'pretty format' '
    + 	test_cmp expect log.predictable
    + '
    + 
    ++test_expect_success 'pretty format (with --date)' '
    ++	sed "s/SUBJECT/2005-04-07 OBJECT_NAME/" expect.template >expect &&
    ++	git shortlog --format="%ad %H" --date=short HEAD >log &&
    ++	fuzz log >log.predictable &&
    ++	test_cmp expect log.predictable
    ++'
    ++
    + test_expect_success '--abbrev' '
    + 	sed s/SUBJECT/OBJID/ expect.template >expect &&
    + 	git shortlog --format="%h" --abbrev=35 HEAD >log &&
-:  ---------- > 2:  7decccad7c shortlog: make trailer insertion a noop when appropriate
3:  c3f50465cb = 3:  3665488fc9 shortlog: extract `--group` fragment for translation
4:  6f38990cc2 ! 4:  4a36c0ca4e shortlog: support arbitrary commit format `--group`s
    @@ Documentation/git-shortlog.txt: OPTIONS
         example, if your project uses `Reviewed-by` trailers, you might want
         to see who has been reviewing with
         `git shortlog -ns --group=trailer:reviewed-by`.
    -+ - `<format>`, any string accepted by the `--format` option of 'git log'.
    -+   (See the "PRETTY FORMATS" section of linkgit:git-log[1].)
    ++ - `format:<format>`, any string accepted by the `--format` option of
    ++   'git log'. (See the "PRETTY FORMATS" section of
    ++   linkgit:git-log[1].)
      +
      Note that commits that do not include the trailer will not be counted.
      Likewise, commits with multiple trailers (e.g., multiple signoffs) may
    @@ builtin/shortlog.c: static void insert_records_from_trailers(struct shortlog *lo
     +
     +		format_commit_message(commit, item->string, &buf, ctx);
     +
    -+		if (strset_add(dups, buf.buf))
    ++		if (!(log->format.nr > 1 || log->trailers.nr) ||
    ++		    strset_add(dups, buf.buf))
     +			insert_one_record(log, buf.buf, oneline);
     +	}
     +
    @@ builtin/shortlog.c: static void insert_records_from_trailers(struct shortlog *lo
      {
      	struct strbuf ident = STRBUF_INIT;
     @@ builtin/shortlog.c: void shortlog_add_commit(struct shortlog *log, struct commit *commit)
    - 	if (log->groups & SHORTLOG_GROUP_TRAILER) {
    - 		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
    + 			insert_one_record(log, ident.buf, oneline_str);
      	}
    + 	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
     +	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);
      
      	strset_clear(&dups);
    @@ builtin/shortlog.c: static int parse_group_option(const struct option *opt, cons
      		log->groups |= SHORTLOG_GROUP_TRAILER;
      		string_list_append(&log->trailers, field);
     -	} else
    -+	} else if (strchrnul(arg, '%')) {
    ++	} else if (skip_prefix(arg, "format:", &field)) {
    ++		log->groups |= SHORTLOG_GROUP_FORMAT;
    ++		string_list_append(&log->format, field);
    ++	} else if (strchr(arg, '%')) {
     +		log->groups |= SHORTLOG_GROUP_FORMAT;
     +		string_list_append(&log->format, arg);
     +	} else {
    @@ t/t4201-shortlog.sh: test_expect_success 'shortlog --group=trailer:signed-off-by
      	test_cmp expect actual
      '
      
    -+test_expect_success 'shortlog --group=<format>' '
    ++test_expect_success 'shortlog --group=format' '
    ++	git shortlog -s --date="format:%Y" --group="format:%cN (%cd)" \
    ++		HEAD >actual &&
    ++	cat >expect <<-\EOF &&
    ++	     4	C O Mitter (2005)
    ++	     1	Sin Nombre (2005)
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'shortlog --group=<format> DWIM' '
     +	git shortlog -s --date="format:%Y" --group="%cN (%cd)" HEAD >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'shortlog multiple --group=format' '
    ++	git shortlog -s --date="format:%Y" --group="format:%cN (%cd)" \
    ++		HEAD >actual &&
     +	cat >expect <<-\EOF &&
     +	     4	C O Mitter (2005)
     +	     1	Sin Nombre (2005)
     +	EOF
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'shortlog bogus --group' '
    ++	test_must_fail git shortlog --group=bogus HEAD 2>err &&
    ++	grep "unknown group type" err
    ++'
     +
      test_expect_success 'trailer idents are split' '
      	cat >expect <<-\EOF &&
      	     2	C O Mitter
    +@@ t/t4201-shortlog.sh: test_expect_success 'shortlog can match multiple groups' '
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'shortlog can match multiple format groups' '
    ++	cat >expect <<-\EOF &&
    ++	     2	User B <b@example.com>
    ++	     1	A U Thor <author@example.com>
    ++	     1	User A <a@example.com>
    ++	EOF
    ++	git shortlog -ns \
    ++		--group="%(trailers:valueonly,key=some-trailer)" \
    ++		--group="%(trailers:valueonly,key=another-trailer)" \
    ++		-2 HEAD >actual.raw &&
    ++	grep -v "^$" actual.raw >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'set up option selection tests' '
    + 	git commit --allow-empty -F - <<-\EOF
    + 	subject
5:  55a6ef7bc0 ! 5:  f0044682be shortlog: implement `--group=author` in terms of `--group=<format>`
    @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_separ
      	log.in2 = 4;
      	log.file = rev->diffopt.file;
      	log.groups = SHORTLOG_GROUP_AUTHOR;
    -+	shortlog_init_group(&log);
    ++	shortlog_finish_setup(&log);
      	for (i = 0; i < nr; i++)
      		shortlog_add_commit(&log, list[i]);
      
    @@ builtin/shortlog.c: void shortlog_init(struct shortlog *log)
      	log->format.strdup_strings = 1;
      }
      
    -+void shortlog_init_group(struct shortlog *log)
    ++void shortlog_finish_setup(struct shortlog *log)
     +{
    -+	if (!log->groups)
    -+		log->groups = SHORTLOG_GROUP_AUTHOR;
    -+
     +	if (log->groups & SHORTLOG_GROUP_AUTHOR)
     +		string_list_append(&log->format,
     +				   log->email ? "%aN <%aE>" : "%aN");
    ++
    ++	string_list_sort(&log->trailers);
     +}
     +
      int cmd_shortlog(int argc, const char **argv, const char *prefix)
      {
      	struct shortlog log = { STRING_LIST_INIT_NODUP };
     @@ builtin/shortlog.c: int cmd_shortlog(int argc, const char **argv, const char *prefix)
    - 	log.file = rev.diffopt.file;
    - 	log.date_mode = rev.date_mode;
      
    --	if (!log.groups)
    --		log.groups = SHORTLOG_GROUP_AUTHOR;
    -+	shortlog_init_group(&log);
    -+
    - 	string_list_sort(&log.trailers);
    + 	if (!log.groups)
    + 		log.groups = SHORTLOG_GROUP_AUTHOR;
    +-	string_list_sort(&log.trailers);
    ++	shortlog_finish_setup(&log);
      
      	/* assume HEAD if from a tty */
    + 	if (!nongit && !rev.pending.nr && isatty(0))
     
      ## shortlog.h ##
     @@ shortlog.h: struct shortlog {
      };
      
      void shortlog_init(struct shortlog *log);
    -+void shortlog_init_group(struct shortlog *log);
    ++void shortlog_finish_setup(struct shortlog *log);
      
      void shortlog_add_commit(struct shortlog *log, struct commit *commit);
      
6:  814ee4b8d8 ! 6:  6a9e204177 shortlog: implement `--group=committer` in terms of `--group=<format>`
    @@ builtin/shortlog.c: void shortlog_add_commit(struct shortlog *log, struct commit
     -		    strset_add(&dups, ident.buf))
     -			insert_one_record(log, ident.buf, oneline_str);
     -	}
    - 	if (log->groups & SHORTLOG_GROUP_TRAILER) {
    - 		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
    - 	}
    + 	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
      	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);
      
      	strset_clear(&dups);
    @@ builtin/shortlog.c: void shortlog_add_commit(struct shortlog *log, struct commit
      	strbuf_release(&oneline);
      }
      
    -@@ builtin/shortlog.c: void shortlog_init_group(struct shortlog *log)
    +@@ builtin/shortlog.c: void shortlog_finish_setup(struct shortlog *log)
      	if (log->groups & SHORTLOG_GROUP_AUTHOR)
      		string_list_append(&log->format,
      				   log->email ? "%aN <%aE>" : "%aN");
     +	if (log->groups & SHORTLOG_GROUP_COMMITTER)
     +		string_list_append(&log->format,
     +				   log->email ? "%cN <%cE>" : "%cN");
    - }
      
    - int cmd_shortlog(int argc, const char **argv, const char *prefix)
    + 	string_list_sort(&log->trailers);
    + }
7:  02adc297e7 < -:  ---------- shortlog: implement `--group=trailer` in terms of `--group=<format>`
-- 
2.38.0.16.g393fd4c6db
