Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72114C47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 13:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 429226023F
	for <git@archiver.kernel.org>; Sun, 30 May 2021 13:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhE3NDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 09:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3NDl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 09:03:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C59C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 06:02:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m18so8030582wrv.2
        for <git@vger.kernel.org>; Sun, 30 May 2021 06:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZoB+YL2umU8U72kpmS5D2Gk/nb/i1CzD8gh4aRuBMDU=;
        b=ib2J4au7vk/3e+6fU7R4oX7XZGAIO3Obj05S2zoOSX5rOM84q7oMIq5rcg+a+R1lAG
         Klb6nmqY2NrVxQ3ObitXnsygF9FVn0ilcLQ0MRjc3H21ey9HJXgMORUukWuYkFcn5EXl
         lGrBK0FUQXDaxOKXhgu457NaIhEm81niJd9/YGkrkMCV4iWGqXYWoNb8ZpUEhEkWX94Q
         ygbElm0bw8aFYfIiyAmWO0FvgkXnJX0lL4d3rO8wrlk/p1P6GoFHCehRGxFw7HaWezGh
         KQeZvBMUqfuKl1qukhC9poLF39dpjnBgVjcCotMSbo4uuFyc6oczTBRXkCtFdICoUTlf
         l8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZoB+YL2umU8U72kpmS5D2Gk/nb/i1CzD8gh4aRuBMDU=;
        b=j8PxY6zDWP4NBUmpJhl2KRDIyA/Rd7mCWM1fA3a/Wv+v2mUdQitqzU/0DtwrVd5gXt
         n3IhNadyJB86J1YX/1E/Nm8rtlchwcxZDaX3GqgVIRcQNY/unlP9TavdliIvl9dRPm8m
         je4DJBfkwk4QZNmbhG3o4F9o3FiQElAIk31xrojDNJXnUTUZfWXak3YpKyGugVZ6KlvG
         SS2qUqph14I7XCDaSBJ0t/w4y+HCowLpqHORs07RTvBWgQgbdHtoWlGbSYt8Yp+dn4Iu
         7tfGB1F7lCY/24/xEztg0yFljq1YLeWuFb2tcfj+tPWv3al96atfQ5aRoDbEaWxtYdvE
         s7WA==
X-Gm-Message-State: AOAM533LHbQ96VQ2qYWzo8948H131EViwdUkGIN0u/6mhfYY1Jiwpsfd
        SdnmHMAqanZCS3/DPrBBx7Uj37ZNh6c=
X-Google-Smtp-Source: ABdhPJzTjFhfGco94axBisp7R66kGkp0wV9En3af3BWpUOMp7fukdyqhxTq99QHZazu7j4+a8lAcUA==
X-Received: by 2002:a05:6000:137a:: with SMTP id q26mr17546188wrz.216.1622379720177;
        Sun, 30 May 2021 06:02:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c64sm20441563wma.15.2021.05.30.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 06:01:59 -0700 (PDT)
Message-Id: <pull.963.v2.git.1622379718.gitgitgadget@gmail.com>
In-Reply-To: <pull.963.git.1622126603.gitgitgadget@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 May 2021 13:01:56 +0000
Subject: [PATCH v2 0/2] [GSOC] ref-filter: add %(raw) atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make git cat-file --batch use ref-filter logic, I add %(raw)
atom to ref-filter.

Change from last version:

 1. Use more elegant memcasecmp().
 2. Allow %(raw:size) used with --<lang>.
 3. Remove redundant BUG() in then_atom_handler().
 4. Roll back to origin function name grab_sub_body_contents().
 5. Split the check of object type in grab_sub_body_contents() into the
    previous patch.

ZheNing Hu (2):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom

 Documentation/git-for-each-ref.txt |  14 ++
 ref-filter.c                       | 158 ++++++++++++++++++-----
 t/t6300-for-each-ref.sh            | 200 +++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+), 34 deletions(-)


base-commit: 5d5b1473453400224ebb126bf3947e0a3276bdf5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-963%2Fadlternative%2Fref-filter-raw-atom-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-963/adlternative/ref-filter-raw-atom-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/963

Range-diff vs v1:

 -:  ------------ > 1:  e6c26d19a3f3 [GSOC] ref-filter: add obj-type check in grab contents
 1:  b3848f24f2d3 ! 2:  e44a2ed0db59 [GSOC] ref-filter: add %(raw) atom
     @@ Commit message
      
          The raw data of blob, tree objects may contain '\0', but most of
          the logic in `ref-filter` depands on the output of the atom being
     -    a structured string (end with '\0').
     +    text (specifically, no embedded NULs in it).
      
          E.g. `quote_formatting()` use `strbuf_addstr()` or `*._quote_buf()`
          add the data to the buffer. The raw data of a tree object is
     @@ Commit message
          can record raw object size, it can help us add raw object data to
          the buffer or compare two buffers which contain raw object data.
      
     -    Beyond, `--format=%(raw)` should not combine with `--python`, `--shell`,
     +    Beyond, `--format=%(raw)` cannot be used with `--python`, `--shell`,
          `--tcl`, `--perl` because if our binary raw data is passed to a variable
          in the host language, the host languages may cause escape errors.
      
     +    Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Based-on-patch-by: Olga Telezhnaya <olyatelezhnaya@gmail.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-for-each-ref.txt: and `date` to extract the named component.
      +raw:size::
      +	The raw data size of the object.
      +
     -+Note that `--format=%(raw)` should not combine with `--python`, `--shell`, `--tcl`,
     ++Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
      +`--perl` because if our binary raw data is passed to a variable in the host language,
      +the host languages may cause escape errors.
      +
     @@ ref-filter.c: static int contents_atom_parser(const struct ref_format *format, s
      +static int raw_atom_parser(const struct ref_format *format, struct used_atom *atom,
      +				const char *arg, struct strbuf *err)
      +{
     -+	if (!arg) {
     ++	if (!arg)
      +		atom->u.raw_data.option = RAW_BARE;
     -+	} else if (!strcmp(arg, "size"))
     ++	else if (!strcmp(arg, "size"))
      +		atom->u.raw_data.option = RAW_LENGTH;
      +	else
      +		return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s"), arg);
     @@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
       		return strbuf_addf_ret(err, -1, _("malformed field name: %.*s"),
       				       (int)(ep-atom), atom);
       
     -+	if (format->quote_style && starts_with(sp, "raw"))
     -+		return strbuf_addf_ret(err, -1, _("--format=%.*s should not combine with"
     +-	/* Do we have the atom already used elsewhere? */
     +-	for (i = 0; i < used_atom_cnt; i++) {
     +-		int len = strlen(used_atom[i].name);
     +-		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
     +-			return i;
     +-	}
     +-
     + 	/*
     + 	 * If the atom name has a colon, strip it and everything after
     + 	 * it off - it specifies the format for this entry, and
     +@@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
     + 	arg = memchr(sp, ':', ep - sp);
     + 	atom_len = (arg ? arg : ep) - sp;
     + 
     ++	if (format->quote_style && !strncmp(sp, "raw", 3) && !arg)
     ++		return strbuf_addf_ret(err, -1, _("--format=%.*s cannot be used with"
      +				"--python, --shell, --tcl, --perl"), (int)(ep-atom), atom);
      +
     - 	/* Do we have the atom already used elsewhere? */
     - 	for (i = 0; i < used_atom_cnt; i++) {
     - 		int len = strlen(used_atom[i].name);
     ++	/* Do we have the atom already used elsewhere? */
     ++	for (i = 0; i < used_atom_cnt; i++) {
     ++		int len = strlen(used_atom[i].name);
     ++		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
     ++			return i;
     ++	}
     ++
     + 	/* Is the atom a valid one? */
     + 	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
     + 		int len = strlen(valid_atom[i].name);
      @@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
       	return at;
       }
     @@ ref-filter.c: static int then_atom_handler(struct atom_value *atomv, struct ref_
       	 */
       	if (if_then_else->cmp_status == COMPARE_EQUAL) {
      -		if (!strcmp(if_then_else->str, cur->output.buf))
     -+		if (!if_then_else->str)
     -+			BUG("when if_then_else->cmp_status == COMPARE_EQUAL,"
     -+			    "if_then_else->str must not be null");
      +		if (str_len == cur->output.len &&
      +		    !memcmp(if_then_else->str, cur->output.buf, cur->output.len))
       			if_then_else->condition_satisfied = 1;
       	} else if (if_then_else->cmp_status == COMPARE_UNEQUAL) {
      -		if (strcmp(if_then_else->str, cur->output.buf))
     -+		if (!if_then_else->str)
     -+			BUG("when if_then_else->cmp_status == COMPARE_UNEQUAL,"
     -+			    "if_then_else->str must not be null");
      +		if (str_len != cur->output.len ||
      +		    memcmp(if_then_else->str, cur->output.buf, cur->output.len))
       			if_then_else->condition_satisfied = 1;
     @@ ref-filter.c: static int end_atom_handler(struct atom_value *atomv, struct ref_f
       	}
       	strbuf_release(&s);
      @@ ref-filter.c: static void append_lines(struct strbuf *out, const char *buf, unsigned long size
     - }
       
       /* See grab_values */
     --static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
     -+static void grab_raw_data(struct atom_value *val, int deref, void *buf, unsigned long buf_size, struct object *obj)
     + static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
     +-				   struct object *obj)
     ++				   unsigned long buf_size, struct object *obj)
       {
       	int i;
       	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
     -@@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
     - 			continue;
     +@@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
       		if (deref)
       			name++;
     --		if (strcmp(name, "body") &&
     --		    !starts_with(name, "subject") &&
     --		    !starts_with(name, "trailers") &&
     --		    !starts_with(name, "contents"))
     -+
     + 
      +		if (starts_with(name, "raw")) {
      +			if (atom->u.raw_data.option == RAW_BARE) {
      +				v->s = xmemdupz(buf, buf_size);
      +				v->s_size = buf_size;
     -+			} else if (atom->u.raw_data.option == RAW_LENGTH)
     ++			} else if (atom->u.raw_data.option == RAW_LENGTH) {
      +				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
     ++			}
      +			continue;
      +		}
      +
     -+		if ((obj->type != OBJ_TAG &&
     -+		     obj->type != OBJ_COMMIT) ||
     -+		    (strcmp(name, "body") &&
     -+		     !starts_with(name, "subject") &&
     -+		     !starts_with(name, "trailers") &&
     -+		     !starts_with(name, "contents")))
     - 			continue;
     - 		if (!subpos)
     - 			find_subpos(buf,
     + 		if ((obj->type != OBJ_TAG &&
     + 		     obj->type != OBJ_COMMIT) ||
     + 		    (strcmp(name, "body") &&
      @@ ref-filter.c: static void fill_missing_values(struct atom_value *val)
        * pointed at by the ref itself; otherwise it is the object the
        * ref (which is a tag) refers to.
     @@ ref-filter.c: static void fill_missing_values(struct atom_value *val)
       	switch (obj->type) {
       	case OBJ_TAG:
       		grab_tag_values(val, deref, obj);
     --		grab_sub_body_contents(val, deref, buf);
     -+		grab_raw_data(val, deref, buf, buf_size, obj);
     +-		grab_sub_body_contents(val, deref, buf, obj);
     ++		grab_sub_body_contents(val, deref, buf, buf_size, obj);
       		grab_person("tagger", val, deref, buf);
       		break;
       	case OBJ_COMMIT:
       		grab_commit_values(val, deref, obj);
     --		grab_sub_body_contents(val, deref, buf);
     -+		grab_raw_data(val, deref, buf, buf_size, obj);
     +-		grab_sub_body_contents(val, deref, buf, obj);
     ++		grab_sub_body_contents(val, deref, buf, buf_size, obj);
       		grab_person("author", val, deref, buf);
       		grab_person("committer", val, deref, buf);
       		break;
       	case OBJ_TREE:
       		/* grab_tree_values(val, deref, obj, buf, sz); */
     -+		grab_raw_data(val, deref, buf, buf_size, obj);
     ++		grab_sub_body_contents(val, deref, buf, buf_size, obj);
       		break;
       	case OBJ_BLOB:
       		/* grab_blob_values(val, deref, obj, buf, sz); */
     -+		grab_raw_data(val, deref, buf, buf_size, obj);
     ++		grab_sub_body_contents(val, deref, buf, buf_size, obj);
       		break;
       	default:
       		die("Eh?  Object of type %d?", obj->type);
     @@ ref-filter.c: static int compare_detached_head(struct ref_array_item *a, struct
       
      +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
      +{
     -+	size_t i;
     -+	const char *s1 = (const char *)vs1;
     -+	const char *s2 = (const char *)vs2;
     ++	const char *s1 = (const void *)vs1;
     ++	const char *s2 = (const void *)vs2;
     ++	const char *end = s1 + n;
      +
     -+	for (i = 0; i < n; i++) {
     -+		unsigned char u1 = s1[i];
     -+		unsigned char u2 = s2[i];
     -+		int U1 = toupper (u1);
     -+		int U2 = toupper (u2);
     -+		int diff = (UCHAR_MAX <= INT_MAX ? U1 - U2
     -+			: U1 < U2 ? -1 : U2 < U1);
     ++	for (; s1 < end; s1++, s2++) {
     ++		int diff = tolower(*s1) - tolower(*s2);
      +		if (diff)
      +			return diff;
      +	}
     @@ ref-filter.c: static int compare_detached_head(struct ref_array_item *a, struct
       static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
       {
       	struct atom_value *va, *vb;
     -@@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
     - 	int cmp_detached_head = 0;
     - 	cmp_type cmp_type = used_atom[s->atom].type;
     - 	struct strbuf err = STRBUF_INIT;
     -+	size_t slen = 0;
     - 
     - 	if (get_ref_atom_value(a, s->atom, &va, &err))
     - 		die("%s", err.buf);
      @@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
       	} else if (s->sort_flags & REF_SORTING_VERSION) {
       		cmp = versioncmp(va->s, vb->s);
     @@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array
      +			int (*cmp_fn)(const void *, const void *, size_t);
      +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
      +				? memcasecmp : memcmp;
     ++			size_t a_size = va->s_size == ATOM_VALUE_S_SIZE_INIT ?
     ++					strlen(va->s) : va->s_size;
     ++			size_t b_size = vb->s_size == ATOM_VALUE_S_SIZE_INIT ?
     ++					strlen(vb->s) : vb->s_size;
      +
     -+			if (va->s_size != ATOM_VALUE_S_SIZE_INIT &&
     -+			    vb->s_size != ATOM_VALUE_S_SIZE_INIT) {
     -+				cmp = cmp_fn(va->s, vb->s, va->s_size > vb->s_size ?
     -+				       vb->s_size : va->s_size);
     -+			} else if (va->s_size == ATOM_VALUE_S_SIZE_INIT) {
     -+				slen = strlen(va->s);
     -+				cmp = cmp_fn(va->s, vb->s, slen > vb->s_size ?
     -+					     vb->s_size : slen);
     -+			} else {
     -+				slen = strlen(vb->s);
     -+				cmp = cmp_fn(va->s, vb->s, slen > va->s_size ?
     -+					     slen : va->s_size);
     ++			cmp = cmp_fn(va->s, vb->s, b_size > a_size ?
     ++				     a_size : b_size);
     ++			if (!cmp) {
     ++				if (a_size > b_size)
     ++					cmp = 1;
     ++				else if (a_size < b_size)
     ++					cmp = -1;
      +			}
     -+			cmp = cmp ? cmp : va->s_size - vb->s_size;
      +		}
       	} else {
       		if (va->value < vb->value)
     @@ t/t6300-for-each-ref.sh: test_atom refs/myblobs/first contents:body ""
      +	refs/myblobs/first not empty
      +	EOF
      +	git for-each-ref --format="%(refname) %(if)%(raw)%(then)not empty%(else)empty%(end)" \
     -+	refs/myblobs/ >actual &&
     ++		refs/myblobs/ >actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t6300-for-each-ref.sh: test_atom refs/myblobs/first contents:body ""
      +	test_must_fail git for-each-ref --format="%(raw)" --sort=raw --shell
      +'
      +
     ++test_expect_success '%(raw:size) with --shell' '
     ++	git for-each-ref --format="%(raw:size)" | while read line
     ++	do
     ++		echo "'\''$line'\''" >>expect
     ++	done &&
     ++	git for-each-ref --format="%(raw:size)" --shell >actual &&
     ++	test_cmp expect actual
     ++'
     ++
      +test_expect_success 'for-each-ref --format compare with cat-file --batch' '
      +	git rev-parse refs/mytrees/first | git cat-file --batch >expected &&
      +	git for-each-ref --format="%(objectname) %(objecttype) %(objectsize)
 2:  aa6d73f3e526 < -:  ------------ [GSOC] ref-filter: add %(header) atom

-- 
gitgitgadget
