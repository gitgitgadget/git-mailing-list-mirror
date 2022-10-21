Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2263CC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJUWZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJUWZn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:25:43 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97381199F6B
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i65so3551779ioa.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbSj+Z9wbNDRkE/X6Pty5iAbu5ncyXxZ2bz7glk3cRo=;
        b=A5rWU4M8w3vj2rAsQk8xkgePNJSJ6XCl/TVru68hvZvXiLEGHwdIJ+CdNL0wOALj4k
         wDQse/lP00NLEwx602JWnCCHAYO/3eLw5pL+1rYi7T/xeaSDCS+ZoFa56FbF/cbmk0F2
         l1HSMOxGkW5GDRsMZvnnAjJmwia38WTT785fpUpal2KkdGXlOEgvdGrT/MST1//CORhk
         4ZiiNc7NxXGtppGkJ9jeS9Bvtdi7Fdh/0sVJo0ucqykMDV8JHlppbcf4ipljoStMNnIk
         pM8kJ5N/T7fWrRMe+GotjksNU56j98JvSAe3nqmDrtYjLh0WlF+dzKBj7NUY80O8qOZM
         b9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbSj+Z9wbNDRkE/X6Pty5iAbu5ncyXxZ2bz7glk3cRo=;
        b=Ywwm9jajadOpdX732nmbAWmOnjmxXPgQAbJf+DIwSoThtBZ4p+CcIGEBccv7pERwQq
         +LG4Pk/TCMiVKbSg+NXMQa+U8ptjj3bC41J4Xzn1cJQIoWcMIlUl6b2E7g07WS8L5z6U
         GmEhSReOGs2ysL84gxYqVylELvirrkqOu47MaT1vHfkEVTivllCRfSo/nqMMw5IjPxYt
         8KxjAMc2LHMNSuZ8HjI4ie9bsUA7DSihCWSgl0R9NqGaoeWCqEc19beaP22MCrbN5pqR
         sG51J40Hfp24fbYnKvbRqKhJPhYj3lsFwc1zwR8zlSo81KuMKOMPv4CiSlsKDwDuS2z9
         PfUg==
X-Gm-Message-State: ACrzQf1Vk0wihGa8RXPfdML7t1kJQwDv/oboCJDbk/D6nyD2ugTFZIIt
        5EvDp4s1au2U6+vmpaGnFLzbls9aNbHk9eld
X-Google-Smtp-Source: AMsMyM4Yof6EV0dSi9rQvTi8nTKpaMKZBWXX/eslrylF7+1l25jubJTO4Q5vzPvNGx/qFnuooqUHfA==
X-Received: by 2002:a05:6638:22c2:b0:365:c728:9ba4 with SMTP id j2-20020a05663822c200b00365c7289ba4mr16827235jat.224.1666391139044;
        Fri, 21 Oct 2022 15:25:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id az14-20020a056638418e00b00363f8e0ab41sm4621096jab.152.2022.10.21.15.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:25:38 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:25:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v3 0/7] shortlog: introduce `--group=<format>`
Message-ID: <cover.1666391136.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a (likely final) reroll of my series to implement arbitrary
pretty formats as shortlog `--group`'s, based on a suggestion from Jacob
Stopak.

The changes are cosmetic, based on the latest round of review from Peff.
There aren't any substantive changes from the last round.

Thanks in advance for your review.

Jeff King (1):
  shortlog: accept `--date`-related options

Taylor Blau (6):
  shortlog: make trailer insertion a noop when appropriate
  shortlog: extract `--group` fragment for translation
  shortlog: support arbitrary commit format `--group`s
  shortlog: extract `shortlog_finish_setup()`
  shortlog: implement `--group=author` in terms of `--group=<format>`
  shortlog: implement `--group=committer` in terms of `--group=<format>`

 Documentation/git-shortlog.txt |  8 ++++
 builtin/log.c                  |  1 +
 builtin/shortlog.c             | 87 +++++++++++++++++++++++-----------
 shortlog.h                     |  5 ++
 t/t4201-shortlog.sh            | 39 +++++++++++++++
 5 files changed, 113 insertions(+), 27 deletions(-)

Range-diff against v2:
1:  58baccbaa8 ! 1:  add457f319 shortlog: accept `--date`-related options
    @@ Documentation/git-shortlog.txt: OPTIONS
      	Each pretty-printed commit will be rewrapped before it is shown.
      
     +--date=<format>::
    -+	With a `--group=format:<format>`, show dates formatted
    -+	according to the given date string. (See the `--date` options
    -+	in the "COMMIT FORMATTING" section of linkgit:git-log[1].)
    ++	Show dates formatted according to the given date string. (See
    ++	the `--date` option in the "Commit Formatting" section of
    ++	linkgit:git-log[1]).
     +
      --group=<type>::
      	Group commits based on `<type>`. If no `--group` option is
2:  7decccad7c = 2:  25cdc28215 shortlog: make trailer insertion a noop when appropriate
3:  3665488fc9 = 3:  cf84f829aa shortlog: extract `--group` fragment for translation
4:  4a36c0ca4e ! 4:  f75a952421 shortlog: support arbitrary commit format `--group`s
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/git-shortlog.txt ##
    +@@ Documentation/git-shortlog.txt: OPTIONS
    + --date=<format>::
    + 	Show dates formatted according to the given date string. (See
    + 	the `--date` option in the "Commit Formatting" section of
    +-	linkgit:git-log[1]).
    ++	linkgit:git-log[1]). Useful with `--group=format:<format>`.
    + 
    + --group=<type>::
    + 	Group commits based on `<type>`. If no `--group` option is
     @@ Documentation/git-shortlog.txt: OPTIONS
         example, if your project uses `Reviewed-by` trailers, you might want
         to see who has been reviewing with
    @@ builtin/shortlog.c: static void insert_records_from_trailers(struct shortlog *lo
      	unuse_commit_buffer(commit, commit_buffer);
      }
      
    ++static int shortlog_needs_dedup(const struct shortlog *log)
    ++{
    ++	return log->format.nr > 1 || log->trailers.nr;
    ++}
    ++
     +static void insert_records_from_format(struct shortlog *log,
     +				       struct strset *dups,
     +				       struct commit *commit,
    @@ builtin/shortlog.c: static void insert_records_from_trailers(struct shortlog *lo
     +
     +		format_commit_message(commit, item->string, &buf, ctx);
     +
    -+		if (!(log->format.nr > 1 || log->trailers.nr) ||
    -+		    strset_add(dups, buf.buf))
    ++		if (!shortlog_needs_dedup(log) || strset_add(dups, buf.buf))
     +			insert_one_record(log, buf.buf, oneline);
     +	}
     +
    @@ t/t4201-shortlog.sh: test_expect_success 'shortlog --group=trailer:signed-off-by
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'shortlog multiple --group=format' '
    -+	git shortlog -s --date="format:%Y" --group="format:%cN (%cd)" \
    -+		HEAD >actual &&
    -+	cat >expect <<-\EOF &&
    -+	     4	C O Mitter (2005)
    -+	     1	Sin Nombre (2005)
    -+	EOF
    -+	test_cmp expect actual
    -+'
    -+
     +test_expect_success 'shortlog bogus --group' '
     +	test_must_fail git shortlog --group=bogus HEAD 2>err &&
     +	grep "unknown group type" err
    @@ t/t4201-shortlog.sh: test_expect_success 'shortlog can match multiple groups' '
      '
      
     +test_expect_success 'shortlog can match multiple format groups' '
    ++	GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME" \
    ++		git commit --allow-empty -m "identical names" &&
    ++	test_tick &&
     +	cat >expect <<-\EOF &&
    -+	     2	User B <b@example.com>
    -+	     1	A U Thor <author@example.com>
    -+	     1	User A <a@example.com>
    ++	     2	A U Thor
    ++	     1	C O Mitter
     +	EOF
    -+	git shortlog -ns \
    -+		--group="%(trailers:valueonly,key=some-trailer)" \
    -+		--group="%(trailers:valueonly,key=another-trailer)" \
    -+		-2 HEAD >actual.raw &&
    -+	grep -v "^$" actual.raw >actual &&
    ++	git shortlog -ns --group="%cn" --group="%an" -2 HEAD >actual &&
     +	test_cmp expect actual
     +'
     +
5:  f0044682be ! 5:  8dd69edcf8 shortlog: implement `--group=author` in terms of `--group=<format>`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    shortlog: implement `--group=author` in terms of `--group=<format>`
    +    shortlog: extract `shortlog_finish_setup()`
     
    -    Instead of handling SHORTLOG_GROUP_AUTHOR separately, reimplement it as
    -    a special case of the new `--group=<format>` mode, where the author mode
    -    is a shorthand for `--group='%aN <%aE>'.
    +    Extract a function which finishes setting up the shortlog struct for
    +    use. The caller in `make_cover_letter()` does not care about trailer
    +    sorting, so it isn't strictly necessary to add a call there in this
    +    patch.
     
    -    Note that we still need to keep the SHORTLOG_GROUP_AUTHOR enum since it
    -    has a different meaning in `read_from_stdin()`, where it is still used
    -    for a different purpose.
    +    But the next patch will add additional functionality to the new
    +    `shortlog_finish_setup()` function, which the caller in
    +    `make_cover_letter()` will care about.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_separ
      
     
      ## builtin/shortlog.c ##
    -@@ builtin/shortlog.c: void shortlog_add_commit(struct shortlog *log, struct commit *commit)
    - 	}
    - 	oneline_str = oneline.len ? oneline.buf : "<none>";
    - 
    --	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
    --		strbuf_reset(&ident);
    --		format_commit_message(commit,
    --				      log->email ? "%aN <%aE>" : "%aN",
    --				      &ident, &ctx);
    --		if (!HAS_MULTI_BITS(log->groups) ||
    --		    strset_add(&dups, ident.buf))
    --			insert_one_record(log, ident.buf, oneline_str);
    --	}
    - 	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
    - 		strbuf_reset(&ident);
    - 		format_commit_message(commit,
     @@ builtin/shortlog.c: void shortlog_init(struct shortlog *log)
      	log->format.strdup_strings = 1;
      }
      
     +void shortlog_finish_setup(struct shortlog *log)
     +{
    -+	if (log->groups & SHORTLOG_GROUP_AUTHOR)
    -+		string_list_append(&log->format,
    -+				   log->email ? "%aN <%aE>" : "%aN");
    -+
     +	string_list_sort(&log->trailers);
     +}
     +
-:  ---------- > 6:  f4f233fb48 shortlog: implement `--group=author` in terms of `--group=<format>`
6:  6a9e204177 = 7:  6ce06a054e shortlog: implement `--group=committer` in terms of `--group=<format>`
-- 
2.38.0.16.g393fd4c6db
