Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7F5C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 12:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E28261418
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 12:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFDMOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFDMOT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 08:14:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7815EC06174A
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 05:12:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z8so9059843wrp.12
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T/Ex24mZxdXz376UL5QR2I5VF58PIfopaRnsmJh89FA=;
        b=HgCo59RFqGjyGHMO/sPW4F61y1ijUiRnRRKTPl89qLLDSLhcZAzkFd7hhm/xFXlAEo
         DAPjE+1Wrl2m7KsiVuigH8nFk4vKCSWs+tKCFeg9T2bGW5IIXKvw/nlfc/60Z0708hCJ
         LMtwbWo7T31GIjlaBXWs/YcdmFsfJuWzca7H0+G/vyLngiDeNbzGcdvdFqZlcG0pSTsH
         SWETLlj45VZsMNuRgvMAsLFT7O6B3xH7QQxfLs2QU/FAQzSZzPEQwF5dO5aPnkTTGz0c
         BAuxxnZa9ca2kBetHqU02iBQ/O96F/AaVWZMArKDN3fyyigCt4GHaEKazl4P0cDciLio
         59uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T/Ex24mZxdXz376UL5QR2I5VF58PIfopaRnsmJh89FA=;
        b=MhG9L/8MHkWQB/QPM3Zlcdp38fEuSSUwqGngb1NXKbduogYd1jHr5VuW1iDhhmS3As
         F5q4+ezyqEyUZxs7og+1N+TS1PJbBCogOSMtE/M/wm0+7IlC3g6m83v7CfcfspJPOi1n
         T6jBqq4gN2oL5Ywx+JtivR+EGBd2VPSatJoVYe3OlH+W9pa7/Iqpjj0UfqhyP9eOh/pD
         b6gSOUbU+wNSg9iVAE3GuefPIn7PR32qASLhbIhS/7Ov56ZsEC9CfL+cjf4JNPsxGpe4
         xZ9NNpQRJTuLDrs7jZT99exX86DQLfj1Lf9bQJKq6ukfUUD0gGAe2pbXW5/13x7IlbEm
         mTkA==
X-Gm-Message-State: AOAM533+dgLu1oF0Q8gU24+Lpp5M26iJv48vT6hUgQTuDtkeN1mbkDpo
        ZyjZWOBCM8sSxVxWAdIFLFzhXd33g+k=
X-Google-Smtp-Source: ABdhPJyfB5jKfJqFA2pTAil8WLFwIr95U8VTfZcVYYROotIULB7FdVz/f51N7TeSjEVu6qUpyN4TQA==
X-Received: by 2002:adf:fc11:: with SMTP id i17mr3526778wrr.374.1622808752104;
        Fri, 04 Jun 2021 05:12:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9sm5452004wme.21.2021.06.04.05.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 05:12:31 -0700 (PDT)
Message-Id: <pull.966.v2.git.1622808751.gitgitgadget@gmail.com>
In-Reply-To: <pull.966.git.1622558243.gitgitgadget@gmail.com>
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 12:12:28 +0000
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

In order to make git cat-file --batch use ref-filter logic, %(raw) atom is
adding to ref-filter.

Change from last version:

 1. Change --<lang> and --format=%(raw) checkpoint to verify_ref_format(),
    which make it more scalable.
 2. Change grab_sub_body_contents() use struct expand_data *data instread of
    using obj,buf,buf_size to pass object info which can reduce the delivery
    of function parameters.

ZheNing Hu (2):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom

 Documentation/git-for-each-ref.txt |   9 ++
 ref-filter.c                       | 164 +++++++++++++++++------
 t/t6300-for-each-ref.sh            | 207 +++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+), 37 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-966%2Fadlternative%2Fref-filter-raw-atom-v4-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-966/adlternative/ref-filter-raw-atom-v4-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/966

Range-diff vs v1:

 1:  97955705c22e ! 1:  48d256db5c34 [GSOC] ref-filter: add obj-type check in grab contents
     @@ ref-filter.c: static void append_lines(struct strbuf *out, const char *buf, unsi
       
       /* See grab_values */
      -static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
     -+static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
     -+				   struct object *obj)
     ++static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
       {
       	int i;
       	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
     + 	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
     ++	void *buf = data->content;
     + 
     + 	for (i = 0; i < used_atom_cnt; i++) {
     + 		struct used_atom *atom = &used_atom[i];
      @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
       			continue;
       		if (deref)
     @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int der
      -		    !starts_with(name, "trailers") &&
      -		    !starts_with(name, "contents"))
      +
     -+		if ((obj->type != OBJ_TAG &&
     -+		     obj->type != OBJ_COMMIT) ||
     ++		if ((data->type != OBJ_TAG &&
     ++		     data->type != OBJ_COMMIT) ||
      +		    (strcmp(name, "body") &&
      +		     !starts_with(name, "subject") &&
      +		     !starts_with(name, "trailers") &&
     @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int der
       			continue;
       		if (!subpos)
       			find_subpos(buf,
     -@@ ref-filter.c: static void grab_values(struct atom_value *val, int deref, struct object *obj, v
     +@@ ref-filter.c: static void fill_missing_values(struct atom_value *val)
     +  * pointed at by the ref itself; otherwise it is the object the
     +  * ref (which is a tag) refers to.
     +  */
     +-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
     ++static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
     + {
     ++	void *buf = data->content;
     ++
       	switch (obj->type) {
       	case OBJ_TAG:
       		grab_tag_values(val, deref, obj);
      -		grab_sub_body_contents(val, deref, buf);
     -+		grab_sub_body_contents(val, deref, buf, obj);
     ++		grab_sub_body_contents(val, deref, data);
       		grab_person("tagger", val, deref, buf);
       		break;
       	case OBJ_COMMIT:
       		grab_commit_values(val, deref, obj);
      -		grab_sub_body_contents(val, deref, buf);
     -+		grab_sub_body_contents(val, deref, buf, obj);
     ++		grab_sub_body_contents(val, deref, data);
       		grab_person("author", val, deref, buf);
       		grab_person("committer", val, deref, buf);
       		break;
     +@@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref, struct object **obj
     + 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
     + 					       oid_to_hex(&oi->oid), ref->refname);
     + 		}
     +-		grab_values(ref->value, deref, *obj, oi->content);
     ++		grab_values(ref->value, deref, *obj, oi);
     + 	}
     + 
     + 	grab_common_values(ref->value, deref, oi);
 2:  5a94705cdbc1 ! 2:  0efed9435b59 [GSOC] ref-filter: add %(raw) atom
     @@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
       	arg = memchr(sp, ':', ep - sp);
       	atom_len = (arg ? arg : ep) - sp;
       
     -+	if (format->quote_style && !strncmp(sp, "raw", 3) && !arg)
     -+		return strbuf_addf_ret(err, -1, _("--format=%.*s cannot be used with"
     -+				"--python, --shell, --tcl, --perl"), (int)(ep-atom), atom);
     -+
      +	/* Do we have the atom already used elsewhere? */
      +	for (i = 0; i < used_atom_cnt; i++) {
      +		int len = strlen(used_atom[i].name);
     @@ ref-filter.c: static int end_atom_handler(struct atom_value *atomv, struct ref_f
       		strbuf_swap(&current->output, &s);
       	}
       	strbuf_release(&s);
     -@@ ref-filter.c: static void append_lines(struct strbuf *out, const char *buf, unsigned long size
     +@@ ref-filter.c: int verify_ref_format(struct ref_format *format)
     + 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
     + 		if (at < 0)
     + 			die("%s", err.buf);
     ++		if (format->quote_style && used_atom[at].atom_type == ATOM_RAW &&
     ++		    used_atom[at].u.raw_data.option == RAW_BARE)
     ++			die(_("--format=%.*s cannot be used with"
     ++			      "--python, --shell, --tcl, --perl"), (int)(ep - sp - 2), sp + 2);
     + 		cp = ep + 1;
       
     - /* See grab_values */
     - static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
     --				   struct object *obj)
     -+				   unsigned long buf_size, struct object *obj)
     - {
     - 	int i;
     + 		if (skip_prefix(used_atom[at].name, "color:", &color))
     +@@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
       	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
     -@@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
     + 	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
     + 	void *buf = data->content;
     ++	unsigned long buf_size = data->size;
     + 
     + 	for (i = 0; i < used_atom_cnt; i++) {
       		struct used_atom *atom = &used_atom[i];
       		const char *name = atom->name;
       		struct atom_value *v = &val[i];
     @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int der
      +			continue;
      +		}
      +
     - 		if ((obj->type != OBJ_TAG &&
     - 		     obj->type != OBJ_COMMIT) ||
     + 		if ((data->type != OBJ_TAG &&
     + 		     data->type != OBJ_COMMIT) ||
       		    (strcmp(name, "body") &&
     -@@ ref-filter.c: static void fill_missing_values(struct atom_value *val)
     -  * pointed at by the ref itself; otherwise it is the object the
     -  * ref (which is a tag) refers to.
     -  */
     --static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
     -+static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
     - {
     -+	void *buf = data->content;
     -+	unsigned long buf_size = data->size;
     -+
     - 	switch (obj->type) {
     - 	case OBJ_TAG:
     - 		grab_tag_values(val, deref, obj);
     --		grab_sub_body_contents(val, deref, buf, obj);
     -+		grab_sub_body_contents(val, deref, buf, buf_size, obj);
     - 		grab_person("tagger", val, deref, buf);
     - 		break;
     - 	case OBJ_COMMIT:
     - 		grab_commit_values(val, deref, obj);
     --		grab_sub_body_contents(val, deref, buf, obj);
     -+		grab_sub_body_contents(val, deref, buf, buf_size, obj);
     - 		grab_person("author", val, deref, buf);
     - 		grab_person("committer", val, deref, buf);
     +@@ ref-filter.c: static void grab_values(struct atom_value *val, int deref, struct object *obj, s
       		break;
       	case OBJ_TREE:
       		/* grab_tree_values(val, deref, obj, buf, sz); */
     -+		grab_sub_body_contents(val, deref, buf, buf_size, obj);
     ++		grab_sub_body_contents(val, deref, data);
       		break;
       	case OBJ_BLOB:
       		/* grab_blob_values(val, deref, obj, buf, sz); */
     -+		grab_sub_body_contents(val, deref, buf, buf_size, obj);
     ++		grab_sub_body_contents(val, deref, data);
       		break;
       	default:
       		die("Eh?  Object of type %d?", obj->type);
     -@@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref, struct object **obj
     - 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
     - 					       oid_to_hex(&oi->oid), ref->refname);
     - 		}
     --		grab_values(ref->value, deref, *obj, oi->content);
     -+		grab_values(ref->value, deref, *obj, oi);
     - 	}
     - 
     - 	grab_common_values(ref->value, deref, oi);
      @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbuf *err)
       		int deref = 0;
       		const char *refname;

-- 
gitgitgadget
