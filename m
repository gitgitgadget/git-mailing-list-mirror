Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512A2C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7AE22CBB
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGxAbl28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgHEVvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgHEVvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:51:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA3AC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:51:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t14so7772773wmi.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=arEeK/qb5+fxc/H2gzbG4zGtM+sb6SddO4Fc38ErP5g=;
        b=mGxAbl28fFuVwCAjcxBJvl+aEDy7omAtdyfOZEBaP/G+2Fwdb6fwYEx0TKAUbmHST4
         IjIx8y6ZuGA1LzCxjGZaPMdPAadm9b0T8rgrz/vv5tPSg+Jp37d10vJ6J4Mu840/JZbM
         bgLi6yiD/HR5MiI5R+1gftt6TZeLeJyrVHtbOiEII7uKXFvg5/kzasLjmclbLCX6DO5A
         Og2OfBIhxawFDXepRkccvMEOHpfYR/FQi5ABqML0qTtzZl95WicIgL+6n7itT6SzUL0/
         eCZwDsCK11FBbCvWSqt0jJ7gfiH1yviO5qOCssyQb4SJEjOU12DQOQdfzqvF+a/toZyq
         W+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=arEeK/qb5+fxc/H2gzbG4zGtM+sb6SddO4Fc38ErP5g=;
        b=JFXezg/GXAoseVBN7XEmSh17xSXIJckQ1JQGwYIfWANwXky4zUWcH1HqITuw5h2nk8
         w/gIKucNfCX39FyS0ZgOZyGkwxnlzMP9kXNBknqk6YwMvOKSVipnfQuRWQSXesDY4Duj
         x6VpLPBSSikXUtT1B5aejAIG/RrLaoFDvasSophV/yBsDC7/2rYdSSqblSKQutEfp8cW
         E3Rc+jmtKjSst3kUlXaiZRTARp6yVnm9OAU+OphWe6BtG7vM7QDT6wkk2QmnXPCWTzFS
         zj//D75vCuv4hLtCbF7QX6rEu68T6WD96tKmZttLVP+IkvXTx9omecuOMRbE6sZMWa8L
         vsBg==
X-Gm-Message-State: AOAM531Cx75gnhuCXFE4Jv3urjjH9GMhSB6nfeWSqgvtG5vjp3jqA2rx
        TqQn7DHRN7FzoYe8JCdW8XROzYgF
X-Google-Smtp-Source: ABdhPJzpg00WI+tgB2jlkocWqfYrVpfpgxdQL4bGQpw4twY4lQrv5m+gwbsZGYjee9Bx9MNBKr6qRg==
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr5059203wmh.33.1596664307645;
        Wed, 05 Aug 2020 14:51:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l81sm4281350wmf.4.2020.08.05.14.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:51:47 -0700 (PDT)
Message-Id: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.git.1595882588.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 21:51:36 +0000
Subject: [PATCH v2 0/9] [GSoC] Improvements to ref-filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first patch series that introduces some improvements and
features to file ref-filter.{c,h}. These changes are useful to ref-filter,
but in near future also will allow us to use ref-filter's logic in pretty.c

I plan to add more to format-support.{c,h} in the upcoming patch series.
That will lead to more improved and feature-rich ref-filter.c

Hariom Verma (9):
  ref-filter: support different email formats
  ref-filter: refactor `grab_objectname()`
  ref-filter: modify error messages in `grab_objectname()`
  ref-filter: rename `objectname` related functions and fields
  ref-filter: add `short` modifier to 'tree' atom
  ref-filter: add `short` modifier to 'parent' atom
  pretty: refactor `format_sanitized_subject()`
  format-support: move `format_sanitized_subject()` from pretty
  ref-filter: add `sanitize` option for 'subject' atom

 Documentation/git-for-each-ref.txt |  10 +-
 Makefile                           |   1 +
 format-support.c                   |  43 ++++++++
 format-support.h                   |   6 ++
 pretty.c                           |  40 +-------
 ref-filter.c                       | 159 +++++++++++++++++++----------
 t/t6300-for-each-ref.sh            |  35 +++++++
 7 files changed, 202 insertions(+), 92 deletions(-)
 create mode 100644 format-support.c
 create mode 100644 format-support.h


base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-684%2Fharry-hov%2Fonly-rf6-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-684/harry-hov/only-rf6-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/684

Range-diff vs v1:

  1:  aeb116c5aa !  1:  78e69032df ref-filter: support different email formats
     @@ Metadata
       ## Commit message ##
          ref-filter: support different email formats
      
     -    Currently, ref-filter only supports printing email with arrow brackets.
     +    Currently, ref-filter only supports printing email with angle brackets.
      
          Let's add support for two more email options.
     -    - trim : print email without arrow brackets.
     -    - localpart : prints the part before the @ sign
     +    - trim : for email without angle brackets.
     +    - localpart : for the part before the @ sign out of trimmed email
      
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
          Mentored-by: Heba Waly <heba.waly@gmail.com>
          Signed-off-by: Hariom Verma <hariom18599@gmail.com>
      
     + ## Documentation/git-for-each-ref.txt ##
     +@@ Documentation/git-for-each-ref.txt: These are intended for working on a mix of annotated and lightweight tags.
     + 
     + Fields that have name-email-date tuple as its value (`author`,
     + `committer`, and `tagger`) can be suffixed with `name`, `email`,
     +-and `date` to extract the named component.
     ++and `date` to extract the named component.  For email fields (`authoremail`,
     ++`committeremail` and `taggeremail`), `:trim` can be appended to get the email
     ++without angle brackets, and `:localpart` to get the part before the `@` symbol
     ++out of the trimmed email.
     + 
     + The message in a commit or a tag object is `contents`, from which
     + `contents:<part>` can be used to extract various parts out of:
     +
       ## ref-filter.c ##
     -@@ ref-filter.c: static struct ref_to_worktree_map {
     - 	struct worktree **worktrees;
     - } ref_to_worktree_map;
     +@@ ref-filter.c: static struct used_atom {
     + 			enum { O_FULL, O_LENGTH, O_SHORT } option;
     + 			unsigned int length;
     + 		} objectname;
     ++		struct email_option {
     ++			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
     ++		} email_option;
     + 		struct refname_atom refname;
     + 		char *head;
     + 	} u;
     +@@ ref-filter.c: static int objectname_atom_parser(const struct ref_format *format, struct used_a
     + 	return 0;
     + }
       
     -+static struct email_option{
     -+	enum { EO_INVALID, EO_RAW, EO_TRIM, EO_LOCALPART } option;
     -+} email_option;
     ++static int person_email_atom_parser(const struct ref_format *format, struct used_atom *atom,
     ++				    const char *arg, struct strbuf *err)
     ++{
     ++	if (!arg)
     ++		atom->u.email_option.option = EO_RAW;
     ++	else if (!strcmp(arg, "trim"))
     ++		atom->u.email_option.option = EO_TRIM;
     ++	else if (!strcmp(arg, "localpart"))
     ++		atom->u.email_option.option = EO_LOCALPART;
     ++	else
     ++		return strbuf_addf_ret(err, -1, _("unrecognized email option: %s"), arg);
     ++	return 0;
     ++}
      +
     - /*
     -  * An atom is a valid field atom listed below, possibly prefixed with
     -  * a "*" to denote deref_tag().
     -@@ ref-filter.c: static const char *copy_email(const char *buf)
     + static int refname_atom_parser(const struct ref_format *format, struct used_atom *atom,
     + 			       const char *arg, struct strbuf *err)
     + {
     +@@ ref-filter.c: static struct {
     + 	{ "tag", SOURCE_OBJ },
     + 	{ "author", SOURCE_OBJ },
     + 	{ "authorname", SOURCE_OBJ },
     +-	{ "authoremail", SOURCE_OBJ },
     ++	{ "authoremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
     + 	{ "authordate", SOURCE_OBJ, FIELD_TIME },
     + 	{ "committer", SOURCE_OBJ },
     + 	{ "committername", SOURCE_OBJ },
     +-	{ "committeremail", SOURCE_OBJ },
     ++	{ "committeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
     + 	{ "committerdate", SOURCE_OBJ, FIELD_TIME },
     + 	{ "tagger", SOURCE_OBJ },
     + 	{ "taggername", SOURCE_OBJ },
     +-	{ "taggeremail", SOURCE_OBJ },
     ++	{ "taggeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
     + 	{ "taggerdate", SOURCE_OBJ, FIELD_TIME },
     + 	{ "creator", SOURCE_OBJ },
     + 	{ "creatordate", SOURCE_OBJ, FIELD_TIME },
     +@@ ref-filter.c: static const char *copy_name(const char *buf)
     + 	return xstrdup("");
     + }
     + 
     +-static const char *copy_email(const char *buf)
     ++static const char *copy_email(const char *buf, struct used_atom *atom)
     + {
     + 	const char *email = strchr(buf, '<');
       	const char *eoemail;
       	if (!email)
       		return xstrdup("");
      -	eoemail = strchr(email, '>');
     -+	switch (email_option.option) {
     ++	switch (atom->u.email_option.option) {
      +	case EO_RAW:
     -+		eoemail = strchr(email, '>') + 1;
     ++		eoemail = strchr(email, '>');
     ++		if (eoemail)
     ++			eoemail++;
      +		break;
      +	case EO_TRIM:
      +		email++;
     @@ ref-filter.c: static const char *copy_email(const char *buf)
      +	case EO_LOCALPART:
      +		email++;
      +		eoemail = strchr(email, '@');
     ++		if (!eoemail)
     ++			eoemail = strchr(email, '>');
      +		break;
     -+	case EO_INVALID:
      +	default:
     -+		return xstrdup("");
     ++		BUG("unknown email option");
      +	}
      +
       	if (!eoemail)
     @@ ref-filter.c: static void grab_person(const char *who, struct atom_value *val, i
       		else if (!strcmp(name + wholen, "name"))
       			v->s = copy_name(wholine);
      -		else if (!strcmp(name + wholen, "email"))
     -+		else if (starts_with(name + wholen, "email")) {
     -+			email_option.option = EO_INVALID;
     -+			if (!strcmp(name + wholen, "email"))
     -+				email_option.option = EO_RAW;
     -+			if (!strcmp(name + wholen, "email:trim"))
     -+				email_option.option = EO_TRIM;
     -+			if (!strcmp(name + wholen, "email:localpart"))
     -+				email_option.option = EO_LOCALPART;
     - 			v->s = copy_email(wholine);
     -+		}
     +-			v->s = copy_email(wholine);
     ++		else if (starts_with(name + wholen, "email"))
     ++			v->s = copy_email(wholine, &used_atom[i]);
       		else if (starts_with(name + wholen, "date"))
       			grab_date(wholine, v, name);
       	}
  -:  ---------- >  2:  b6b6acab9a ref-filter: refactor `grab_objectname()`
  -:  ---------- >  3:  65fee332a3 ref-filter: modify error messages in `grab_objectname()`
  -:  ---------- >  4:  976f2041a4 ref-filter: rename `objectname` related functions and fields
  -:  ---------- >  5:  dda7400b14 ref-filter: add `short` modifier to 'tree' atom
  2:  49344f1b55 !  6:  764bb23b59 ref-filter: add `short` option for 'tree' and 'parent'
     @@ Metadata
      Author: Hariom Verma <hariom18599@gmail.com>
      
       ## Commit message ##
     -    ref-filter: add `short` option for 'tree' and 'parent'
     +    ref-filter: add `short` modifier to 'parent' atom
      
     -    Sometimes while using 'parent' and 'tree' atom, user might
     -    want to see abbrev hash instead of full 40 character hash.
     +    Sometimes while using 'parent' atom, user might want to see abbrev hash
     +    instead of full 40 character hash.
      
     -    'objectname' and 'refname' already supports printing abbrev hash.
     -    It might be convenient for users to have the same option for printing
     -    'parent' and 'tree' hash.
     +    Just like 'objectname', it might be convenient for users to have the
     +    `:short` and `:short=<length>` option for printing 'parent' hash.
      
     -    Let's introduce `short` option to 'parent' and 'tree' atom.
     -
     -    `tree:short` - for abbrev tree hash
     -    `parent:short` - for abbrev parent hash
     +    Let's introduce `short` option to 'parent' atom.
      
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
          Mentored-by: Heba Waly <heba.waly@gmail.com>
          Signed-off-by: Hariom Verma <hariom18599@gmail.com>
      
     + ## Documentation/git-for-each-ref.txt ##
     +@@ Documentation/git-for-each-ref.txt: worktreepath::
     + In addition to the above, for commit and tag objects, the header
     + field names (`tree`, `parent`, `object`, `type`, and `tag`) can
     + be used to specify the value in the header field.
     +-Field `tree` can also be used with modifier `:short` and
     ++Fields `tree` and `parent` can also be used with modifier `:short` and
     + `:short=<length>` just like `objectname`.
     + 
     + For commit and tag objects, the special `creatordate` and `creator`
     +
       ## ref-filter.c ##
     +@@ ref-filter.c: static struct {
     + 	{ "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
     + 	{ "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
     + 	{ "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
     +-	{ "parent", SOURCE_OBJ },
     ++	{ "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
     + 	{ "numparent", SOURCE_OBJ, FIELD_ULONG },
     + 	{ "object", SOURCE_OBJ },
     + 	{ "type", SOURCE_OBJ },
      @@ ref-filter.c: static void grab_commit_values(struct atom_value *val, int deref, struct object
     - 			continue;
     - 		if (deref)
     - 			name++;
     --		if (!strcmp(name, "tree")) {
     -+		if (!strcmp(name, "tree"))
     - 			v->s = xstrdup(oid_to_hex(get_commit_tree_oid(commit)));
     --		}
     -+		else if (!strcmp(name, "tree:short"))
     -+			v->s = xstrdup(find_unique_abbrev(get_commit_tree_oid(commit), DEFAULT_ABBREV));
     - 		else if (!strcmp(name, "numparent")) {
       			v->value = commit_list_count(commit->parents);
       			v->s = xstrfmt("%lu", (unsigned long)v->value);
       		}
     @@ ref-filter.c: static void grab_commit_values(struct atom_value *val, int deref,
       			struct commit_list *parents;
       			struct strbuf s = STRBUF_INIT;
       			for (parents = commit->parents; parents; parents = parents->next) {
     - 				struct commit *parent = parents->item;
     +-				struct commit *parent = parents->item;
     ++				struct object_id *oid = &parents->item->object.oid;
       				if (parents != commit->parents)
       					strbuf_addch(&s, ' ');
      -				strbuf_addstr(&s, oid_to_hex(&parent->object.oid));
     -+				if (!strcmp(name, "parent"))
     -+					strbuf_addstr(&s, oid_to_hex(&parent->object.oid));
     -+				else if (!strcmp(name, "parent:short"))
     -+					strbuf_add_unique_abbrev(&s, &parent->object.oid, DEFAULT_ABBREV);
     ++				strbuf_addstr(&s, do_grab_oid("parent", oid, &used_atom[i]));
       			}
       			v->s = strbuf_detach(&s, NULL);
       		}
      
       ## t/t6300-for-each-ref.sh ##
     -@@ t/t6300-for-each-ref.sh: test_atom head objectname:short $(git rev-parse --short refs/heads/master)
     - test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
     - test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
     - test_atom head tree $(git rev-parse refs/heads/master^{tree})
     -+test_atom head tree:short $(git rev-parse --short refs/heads/master^{tree})
     +@@ t/t6300-for-each-ref.sh: test_atom head tree:short $(git rev-parse --short refs/heads/master^{tree})
     + test_atom head tree:short=1 $(git rev-parse --short=1 refs/heads/master^{tree})
     + test_atom head tree:short=10 $(git rev-parse --short=10 refs/heads/master^{tree})
       test_atom head parent ''
      +test_atom head parent:short ''
     ++test_atom head parent:short=1 ''
     ++test_atom head parent:short=10 ''
       test_atom head numparent 0
       test_atom head object ''
       test_atom head type ''
     -@@ t/t6300-for-each-ref.sh: test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
     - test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
     - test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
     - test_atom tag tree ''
     -+test_atom tag tree:short ''
     +@@ t/t6300-for-each-ref.sh: test_atom tag tree:short ''
     + test_atom tag tree:short=1 ''
     + test_atom tag tree:short=10 ''
       test_atom tag parent ''
      +test_atom tag parent:short ''
     ++test_atom tag parent:short=1 ''
     ++test_atom tag parent:short=10 ''
       test_atom tag numparent ''
       test_atom tag object $(git rev-parse refs/tags/testtag^0)
       test_atom tag type 'commit'
  3:  69b9d221c0 !  7:  95035765a0 pretty: refactor `format_sanitized_subject()`
     @@ Metadata
       ## Commit message ##
          pretty: refactor `format_sanitized_subject()`
      
     -    This commit refactors `format_sanitized_subject()` in the
     -    hope to use same logic in ref-filter.c
     +    The function 'format_sanitized_subject()' is responsible for
     +    sanitized subject line in pretty.c
     +    e.g.
     +    the subject line
     +    the-sanitized-subject-line
     +
     +    It would be a nice enhancement to `subject` atom to have the
     +    same feature. So in the later commits, we plan to add this feature
     +    to ref-filter.
     +
     +    Refactor `format_sanitized_subject()`, so it can be reused in
     +    ref-filter.c for adding new modifier `sanitize` to "subject" atom.
     +
     +    Currently, the loop inside `format_sanitized_subject()` runs
     +    until `\n` is found. But now, we stored the first occurrence
     +    of `\n` in a variable `eol` and passed it in
     +    `format_sanitized_subject()`. And the loop runs upto `eol`.
     +
     +    But this change isn't sufficient to reuse this function in
     +    ref-filter.c because there exist tags with multiline subject.
     +
     +    It's wise to replace `\n` with ' ', if `format_sanitized_subject()`
     +    encounters `\n` before end of subject line, just like `copy_subject()`.
     +    Because we'll be only using `format_sanitized_subject()` for
     +    "%(subject:sanitize)", instead of `copy_subject()` and
     +    `format_sanitized_subject()` both. So, added the code:
     +    ```
     +    if (char == '\n') /* never true if called inside pretty.c */
     +        char = ' ';
     +    ```
     +
     +    Now, it's ready to be reused in ref-filter.c
      
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
          Mentored-by: Heba Waly <heba.waly@gmail.com>
  4:  9dc619b448 !  8:  1c43f55d7c format-support: move `format_sanitized_subject()` from pretty
     @@ Commit message
      
          In hope of some new features in `subject` atom, move funtion
          `format_sanitized_subject()` and all the function it uses
     -    to new file format-support.[c/h].
     +    to new file format-support.{c,h}.
      
          Consider this new file as a common interface between functions that
          pretty.c and ref-filter.c shares.
  5:  7b9103cbad !  9:  feace82752 ref-filter: add `sanitize` option for 'subject' atom
     @@ Commit message
      
          `subject:sanitize` - print sanitized subject line, suitable for a filename.
      
     +    e.g.
     +    %(subject): "the subject line"
     +    %(subject:sanitize): "the-subject-line"
     +
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
          Mentored-by: Heba Waly <heba.waly@gmail.com>
          Signed-off-by: Hariom Verma <hariom18599@gmail.com>
      
     + ## Documentation/git-for-each-ref.txt ##
     +@@ Documentation/git-for-each-ref.txt: contents:subject::
     + 	The first paragraph of the message, which typically is a
     + 	single line, is taken as the "subject" of the commit or the
     + 	tag message.
     ++	Instead of `contents:subject`, field `subject` can also be used to
     ++	obtain same results. `:sanitize` can be appended to `subject` for
     ++	subject line suitable for filename.
     + 
     + contents:body::
     + 	The remainder of the commit or the tag message that follows
     +
       ## ref-filter.c ##
      @@
       #include "worktree.h"
     @@ ref-filter.c: static struct used_atom {
       			unsigned int nobracket : 1, push : 1, push_remote : 1;
       		} remote_ref;
       		struct {
     --			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
     -+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_SUB_SANITIZE, C_TRAILERS } option;
     +-			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH,
     +-			       C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
     ++			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH, C_LINES,
     ++			       C_SIG, C_SUB, C_SUB_SANITIZE, C_TRAILERS } option;
       			struct process_trailer_options trailer_opts;
       			unsigned int nlines;
       		} contents;
     @@ ref-filter.c: static int body_atom_parser(const struct ref_format *format, struc
       {
      -	if (arg)
      -		return strbuf_addf_ret(err, -1, _("%%(subject) does not take arguments"));
     -+	if (arg) {
     -+		if (!strcmp(arg, "sanitize")) {
     -+			atom->u.contents.option = C_SUB_SANITIZE;
     -+			return 0;
     -+		} else {
     -+			return strbuf_addf_ret(err, -1, _("unrecognized %%(subject) argument: %s"), arg);
     -+		}
     -+	}
     - 	atom->u.contents.option = C_SUB;
     +-	atom->u.contents.option = C_SUB;
     ++	if (!arg)
     ++		atom->u.contents.option = C_SUB;
     ++	else if (!strcmp(arg, "sanitize"))
     ++		atom->u.contents.option = C_SUB_SANITIZE;
     ++	else
     ++		return strbuf_addf_ret(err, -1, _("unrecognized %%(subject) argument: %s"), arg);
       	return 0;
       }
     + 
      @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
     - 		struct used_atom *atom = &used_atom[i];
     - 		const char *name = atom->name;
     - 		struct atom_value *v = &val[i];
     -+
     - 		if (!!deref != (*name == '*'))
       			continue;
       		if (deref)
       			name++;
     - 		if (strcmp(name, "subject") &&
     -+		    strcmp(name, "subject:sanitize") &&
     - 		    strcmp(name, "body") &&
     +-		if (strcmp(name, "subject") &&
     +-		    strcmp(name, "body") &&
     ++		if (strcmp(name, "body") &&
     ++		    !starts_with(name, "subject") &&
       		    !starts_with(name, "trailers") &&
       		    !starts_with(name, "contents"))
     + 			continue;
      @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
       
       		if (atom->u.contents.option == C_SUB)
     @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int der
      +			v->s = strbuf_detach(&sb, NULL);
      +		} else if (atom->u.contents.option == C_BODY_DEP)
       			v->s = xmemdupz(bodypos, bodylen);
     - 		else if (atom->u.contents.option == C_BODY)
     - 			v->s = xmemdupz(bodypos, nonsiglen);
     + 		else if (atom->u.contents.option == C_LENGTH)
     + 			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
      
       ## t/t6300-for-each-ref.sh ##
      @@ t/t6300-for-each-ref.sh: test_atom head taggerdate ''

-- 
gitgitgadget
