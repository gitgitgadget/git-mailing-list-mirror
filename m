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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E5C43461
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F0261139
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhEJPZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239143AbhEJPYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:24:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC22BC07E5E6
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:03:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v12so16967087wrq.6
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0B06Tkw8qdxbnDFfYbuatv5m0LEK/NsApklDZaRyQsI=;
        b=hw42F4oIJrro5SgES6t1/y6j6G+xIkpay+fVcJAvFUD1gqqBqEgyBVSOp2G72uFT0M
         nzFv9ZvVNSJH8rzGzxlP9h/oAvqN9UeBi3Hj9rQBk84HHyljOG6uZ4+x90ilORRxXw0q
         VU7qbtx0yH8TAYix3mYaQL3CkhWNjMNmg2o5G5FgRlkkKg0WU5+v7HTMIvZirjiQidPU
         NL2Y83wyLKldYl5cABxFVD+HPJsgbRO35Exv9u1BW2CAmzgmjKNYCW+noTV1PLprfBNW
         S9eYWSRQfTql/GRstxsEmA7BlANWD7vZVshyDprDezVjUbwULPZLSdRTNnFrUOU6UxHi
         ItKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0B06Tkw8qdxbnDFfYbuatv5m0LEK/NsApklDZaRyQsI=;
        b=fujDlySkU8Rl5MN0Wi+aepuQohNVF/i9fDQu55+U+lLQd60iyun5nPjHRrUYsVMkpM
         6AefBY4KfhBilvfBnaQUGaIjL+IghrDYlon23kBj2xxTR8f3IIZcviXsiU4mo3UDAmOM
         see2NG32gVBQrDyW1Jk3LfN+z8YGvlYe/x2IYiT/SYnfiDFRWtQWsRGZr829ZB15Qnpl
         kflpdgmsjcyP1js/UMgZZ082P+yEHq7YuMcVRnfdDco/qldAeaBLoiw5mXkQcZEGzRtg
         fteXgWxi3HGjKoeg71zSW7Ae+ttA+Xkr+4hZkCDo+tNotg7N1UQL6GCbOynxzG943npm
         XHfg==
X-Gm-Message-State: AOAM531Rlhew2EKwv5Kv6nVRrOZVLCgK5SeIURkrPlkUYxg4EWAIsGWm
        MrZZI/yjEFUbsUpQI7YIKgOm1mtGJpA=
X-Google-Smtp-Source: ABdhPJzkeBcXdCQjzg2ilNjFwe3IORE3twj6wMsG3NHlGtIF66QeceF5dpUsIyQ9V5xawqdhTCDbEQ==
X-Received: by 2002:adf:f205:: with SMTP id p5mr31795473wro.170.1620659001475;
        Mon, 10 May 2021 08:03:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm23519293wrn.13.2021.05.10.08.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:03:21 -0700 (PDT)
Message-Id: <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
In-Reply-To: <pull.951.git.1620487353.gitgitgadget@gmail.com>
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 May 2021 15:03:17 +0000
Subject: [PATCH v2 0/2] [GSOC][RFC] ref-filter: introduce enum atom_type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change from last version:

 * Remove the atom_type member from valid_atom at the suggestion of
   Christian and Junio, and use ATOM_* as the coordinates of valid_atom.
 * Add ATOM_INVALID and ATOM_UNKNOWN under Christian's suggestion, we can
   traverse valid_atom through them.
 * Add a note about enum atom_type to remind readers of its role.

ZheNing Hu (2):
  [GSOC] ref-filter: add objectsize to used_atom
  [GSOC] ref-filter: introduce enum atom_type

 ref-filter.c | 231 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 155 insertions(+), 76 deletions(-)


base-commit: 7e391989789db82983665667013a46eabc6fc570
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-951%2Fadlternative%2Fref-filter-atom-type-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-951/adlternative/ref-filter-atom-type-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/951

Range-diff vs v1:

 1:  91ca57c9d04a = 1:  91ca57c9d04a [GSOC] ref-filter: add objectsize to used_atom
 2:  3770df182983 ! 2:  a1f70b39b7ef [GSOC][RFC] ref-filter: introduce enum atom_type
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC][RFC] ref-filter: introduce enum atom_type
     +    [GSOC] ref-filter: introduce enum atom_type
      
          In the original ref-filter design, it will copy the parsed
          atom's name and attributes to `used_atom[i].name` in the
     @@ Commit message
          in the later specific ref attributes filling step. It use
          a lot of string matching to determine which atom we need.
      
     -    Introduce the enum member `valid_atom.atom_type` which
     -    record type of each valid_atom, in the first step of the
     -    atom parsing, `used_atom.atom_type` will record corresponding
     -    enum value from `valid_atom.atom_type`, and then in specific
     -    reference attribute filling step, only need to compare the
     -    value of the `used_atom.atom_type` to judge the atom type.
     +    Introduce the enum "atom_type", each enum value is named
     +    as `ATOM_*`, which is the index of each corresponding
     +    valid_atom entry. In the first step of the atom parsing,
     +    `used_atom.atom_type` will record corresponding enum value
     +    from valid_atom entry index, and then in specific reference
     +    attribute filling step, only need to compare the value of
     +    the `used_atom.atom_type` to judge the atom type.
      
     -    At the same time, The value of an atom_type is the coordinate
     -    of its corresponding valid_atom entry, we can quickly index
     -    to the corresponding valid_atom entry by the atom_type value.
     +    the enum value of `ATOM_UNKNOWN` is equals to zero, which
     +    could ensure that we can easily distinguish such a struct
     +    where the atom_type is known from such a struct where it
     +    is unknown yet.
     +
     +    the enum value of `ATOM_INVALID` is equals to the size of
     +    valid_atom array, which could help us iterate over
     +    valid_atom array using something like:
     +
     +    for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++)
     +            /* do something with valid_atom[i] */;
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ ref-filter.c: static struct ref_to_worktree_map {
       	struct worktree **worktrees;
       } ref_to_worktree_map;
       
     ++/*
     ++ * The enum atom_type is used as the coordinates of valid_atom entry.
     ++ * In the atom parsing stage, it will be passed to used_atom.atom_type
     ++ * as the identifier of the atom type. We can judge the type of used_atom
     ++ * entry by `if (used_atom[i].atom_type == ATOM_*)`.
     ++ *
     ++ * ATOM_UNKNOWN equals to 0, used as an enumeration value of uninitialized
     ++ * atom_type.
     ++ * ATOM_INVALID equals to the size of valid_atom array, which could help us
     ++ * iterate over valid_atom array like this:
     ++ *
     ++ * 	for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++) {
     ++ *		int len = strlen(valid_atom[i].name);
     ++ *		if (len == atom_len && !memcmp(valid_atom[i].name, sp, len))
     ++ *			break;
     ++ *	}
     ++ */
      +enum atom_type {
     ++ATOM_UNKNOWN,
      +ATOM_REFNAME,
      +ATOM_OBJECTTYPE,
      +ATOM_OBJECTSIZE,
     @@ ref-filter.c: static struct ref_to_worktree_map {
      +ATOM_IF,
      +ATOM_THEN,
      +ATOM_ELSE,
     ++ATOM_INVALID,
      +};
      +
       /*
        * An atom is a valid field atom listed below, possibly prefixed with
        * a "*" to denote deref_tag().
     -@@ ref-filter.c: static struct used_atom {
     - 	const char *name;
     - 	cmp_type type;
     - 	info_source source;
     -+	enum atom_type atom_type;
     - 	union {
     - 		char color[COLOR_MAXLEN];
     - 		struct align align;
     -@@ ref-filter.c: static int head_atom_parser(const struct ref_format *format, struct used_atom *a
     - }
     - 
     - static struct {
     +@@ ref-filter.c: static struct ref_to_worktree_map {
     +  * array.
     +  */
     + static struct used_atom {
      +	enum atom_type atom_type;
       	const char *name;
     + 	cmp_type type;
       	info_source source;
     - 	cmp_type cmp_type;
     +@@ ref-filter.c: static struct {
       	int (*parser)(const struct ref_format *format, struct used_atom *atom,
       		      const char *arg, struct strbuf *err);
       } valid_atom[] = {
     @@ ref-filter.c: static int head_atom_parser(const struct ref_format *format, struc
      -	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
      -	{ "then", SOURCE_NONE },
      -	{ "else", SOURCE_NONE },
     -+	{ ATOM_REFNAME, "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
     -+	{ ATOM_OBJECTTYPE, "objecttype", SOURCE_OTHER, FIELD_STR, objecttype_atom_parser },
     -+	{ ATOM_OBJECTSIZE, "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
     -+	{ ATOM_OBJECTNAME, "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
     -+	{ ATOM_DELTABASE, "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
     -+	{ ATOM_TREE, "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
     -+	{ ATOM_PARENT, "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
     -+	{ ATOM_NUMPARENT, "numparent", SOURCE_OBJ, FIELD_ULONG },
     -+	{ ATOM_OBJECT, "object", SOURCE_OBJ },
     -+	{ ATOM_TYPE, "type", SOURCE_OBJ },
     -+	{ ATOM_TAG, "tag", SOURCE_OBJ },
     -+	{ ATOM_AUTHOR, "author", SOURCE_OBJ },
     -+	{ ATOM_AUTHORNAME, "authorname", SOURCE_OBJ },
     -+	{ ATOM_AUTHOREMAIL, "authoremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
     -+	{ ATOM_AUTHORDATE, "authordate", SOURCE_OBJ, FIELD_TIME },
     -+	{ ATOM_COMMITTER, "committer", SOURCE_OBJ },
     -+	{ ATOM_COMMITTERNAME, "committername", SOURCE_OBJ },
     -+	{ ATOM_COMMITTEREMAIL, "committeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
     -+	{ ATOM_COMMITTERDATE, "committerdate", SOURCE_OBJ, FIELD_TIME },
     -+	{ ATOM_TAGGER, "tagger", SOURCE_OBJ },
     -+	{ ATOM_TAGGERNAME, "taggername", SOURCE_OBJ },
     -+	{ ATOM_TAGGEREMAIL, "taggeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
     -+	{ ATOM_TAGGERDATE, "taggerdate", SOURCE_OBJ, FIELD_TIME },
     -+	{ ATOM_CREATOR, "creator", SOURCE_OBJ },
     -+	{ ATOM_CREATORDATE, "creatordate", SOURCE_OBJ, FIELD_TIME },
     -+	{ ATOM_SUBJECT, "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
     -+	{ ATOM_BODY, "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
     -+	{ ATOM_TRAILERS, "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
     -+	{ ATOM_CONTENTS, "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
     -+	{ ATOM_UPSTREAM, "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
     -+	{ ATOM_PUSH, "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
     -+	{ ATOM_SYMREF, "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
     -+	{ ATOM_FLAG, "flag", SOURCE_NONE },
     -+	{ ATOM_HEAD, "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
     -+	{ ATOM_COLOR, "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
     -+	{ ATOM_WORKTREEPATH, "worktreepath", SOURCE_NONE },
     -+	{ ATOM_ALIGN, "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
     -+	{ ATOM_END, "end", SOURCE_NONE },
     -+	{ ATOM_IF, "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
     -+	{ ATOM_THEN, "then", SOURCE_NONE },
     -+	{ ATOM_ELSE, "else", SOURCE_NONE },
     ++	[ATOM_REFNAME] = { "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
     ++	[ATOM_OBJECTTYPE] = { "objecttype", SOURCE_OTHER, FIELD_STR, objecttype_atom_parser },
     ++	[ATOM_OBJECTSIZE] = { "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
     ++	[ATOM_OBJECTNAME] = { "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
     ++	[ATOM_DELTABASE] = { "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
     ++	[ATOM_TREE] = { "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
     ++	[ATOM_PARENT] = { "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
     ++	[ATOM_NUMPARENT] = { "numparent", SOURCE_OBJ, FIELD_ULONG },
     ++	[ATOM_OBJECT] = { "object", SOURCE_OBJ },
     ++	[ATOM_TYPE] = { "type", SOURCE_OBJ },
     ++	[ATOM_TAG] = { "tag", SOURCE_OBJ },
     ++	[ATOM_AUTHOR] = { "author", SOURCE_OBJ },
     ++	[ATOM_AUTHORNAME] = { "authorname", SOURCE_OBJ },
     ++	[ATOM_AUTHOREMAIL] = { "authoremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
     ++	[ATOM_AUTHORDATE] = { "authordate", SOURCE_OBJ, FIELD_TIME },
     ++	[ATOM_COMMITTER] = { "committer", SOURCE_OBJ },
     ++	[ATOM_COMMITTERNAME] = { "committername", SOURCE_OBJ },
     ++	[ATOM_COMMITTEREMAIL] = { "committeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
     ++	[ATOM_COMMITTERDATE] = { "committerdate", SOURCE_OBJ, FIELD_TIME },
     ++	[ATOM_TAGGER] = { "tagger", SOURCE_OBJ },
     ++	[ATOM_TAGGERNAME] = { "taggername", SOURCE_OBJ },
     ++	[ATOM_TAGGEREMAIL] = { "taggeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
     ++	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
     ++	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
     ++	[ATOM_CREATORDATE] = { "creatordate", SOURCE_OBJ, FIELD_TIME },
     ++	[ATOM_SUBJECT] = { "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
     ++	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
     ++	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
     ++	[ATOM_CONTENTS] = { "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
     ++	[ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
     ++	[ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
     ++	[ATOM_SYMREF] = { "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
     ++	[ATOM_FLAG] = { "flag", SOURCE_NONE },
     ++	[ATOM_HEAD] = { "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
     ++	[ATOM_COLOR] = { "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
     ++	[ATOM_WORKTREEPATH] = { "worktreepath", SOURCE_NONE },
     ++	[ATOM_ALIGN] = { "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
     ++	[ATOM_END] = { "end", SOURCE_NONE },
     ++	[ATOM_IF] = { "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
     ++	[ATOM_THEN] = { "then", SOURCE_NONE },
     ++	[ATOM_ELSE] = { "else", SOURCE_NONE },
       	/*
       	 * Please update $__git_ref_fieldlist in git-completion.bash
       	 * when you add new atoms
     +@@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
     + 	atom_len = (arg ? arg : ep) - sp;
     + 
     + 	/* Is the atom a valid one? */
     +-	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
     ++	for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++) {
     + 		int len = strlen(valid_atom[i].name);
     + 		if (len == atom_len && !memcmp(valid_atom[i].name, sp, len))
     + 			break;
     + 	}
     + 
     +-	if (ARRAY_SIZE(valid_atom) <= i)
     ++	if (i == ATOM_INVALID)
     + 		return strbuf_addf_ret(err, -1, _("unknown field name: %.*s"),
     + 				       (int)(ep-atom), atom);
     + 	if (valid_atom[i].source != SOURCE_NONE && !have_git_dir())
      @@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
       	at = used_atom_cnt;
       	used_atom_cnt++;
       	REALLOC_ARRAY(used_atom, used_atom_cnt);
     -+	used_atom[at].atom_type = valid_atom[i].atom_type;
     ++	used_atom[at].atom_type = i;
       	used_atom[at].name = xmemdupz(atom, ep - atom);
       	used_atom[at].type = valid_atom[i].cmp_type;
       	used_atom[at].source = valid_atom[i].source;
     @@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
       	if (*atom == '*')
       		need_tagged = 1;
      -	if (!strcmp(valid_atom[i].name, "symref"))
     -+	if (valid_atom[i].atom_type == ATOM_SYMREF)
     ++	if (i == ATOM_SYMREF)
       		need_symref = 1;
       	return at;
       }

-- 
gitgitgadget
