Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C5C43216
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32452610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbhHMIYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbhHMIXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E74C0617AF
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r6so12168808wrt.4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RVBdyjgdTjkcwxA3c9OBtKd0HvGOq5DiNb8Kn1yXPqc=;
        b=LqombtknxBINtDR6PAGYeTbfg2lpTTo+nEOCyWFOJZ3f9BlgBLeXqxkClN2niwv4qN
         vwyEsUzloWfjPsVdFV3DFV17lBuXYdZtdb06Q915nybNDVWhbZDUZ3AtAWudvoKK94Jg
         xHP2WZr2yEVkMCeQ6bNtM/2Td1rCxWIOrdDcvaVnq2PTRhKQBH5/WoqYj8HsAEwFImcF
         IzcdhqfqWv+AJOtCNmQNA8HiPxdx69ZaLqoQCFp7jQC+aDUQNm6hpvYURoKkH/knEYuD
         XI41+CrUDL7fdbxO5rLBopNudbLzZDtPMB14FQSl38XM+AXO+2Xay4JbO4PsmkkzfU82
         0WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RVBdyjgdTjkcwxA3c9OBtKd0HvGOq5DiNb8Kn1yXPqc=;
        b=b6bFhfpvZrBzCWKK/M/KED0A7jGUG2rwgKrmtFonwG/InlpceLfFmjvTC29xi4O5u5
         qaUm+noUlVbbquT34CCGdKQBixIOjiEAZD9s00jfbKp1VWxDtNjD4IqSDpEd0RoxJd9u
         2DB/CXG4Wcw1ciRjcwSOdgPsBuU41KNtqiytZXwuPiqJvBKceJDlFYc0ThpsYsIRyfsX
         EhCqzreNHq1oA8KqLGxHC5jeCxt0sIIEDmbmmkdz+1Wf80u/1NE7DMf7taFQHfDzrRo4
         EmmQBRixCWa2+R48oFOH9+zNApqFWrvoxxTlK8BlA3P4BUGuEIkzjAbZ9MNiDZo8rhxF
         XI2g==
X-Gm-Message-State: AOAM533RWxqXitcFDjLQzbKrw/X3PeIAzckUvTdK7as+BES6LF77YCJu
        ctysy7w7ZRcoUmyk6h3EGjSv3uvaXyI=
X-Google-Smtp-Source: ABdhPJyFMM/jyt+XpLxZLCsSl9jRA8tzc5roLHw42ilCPWFValrHaXvvMJYcYqGcY4CQcCk1H+gphg==
X-Received: by 2002:a5d:5906:: with SMTP id v6mr1674992wrd.194.1628843004264;
        Fri, 13 Aug 2021 01:23:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm811667wrt.82.2021.08.13.01.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:24 -0700 (PDT)
Message-Id: <5afac0d412869d68f8e5a231e3967ab7d62e8707.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:23:03 +0000
Subject: [PATCH 20/27] [GSOC] ref-filter: introducing xstrvfmt_len() and
 xstrfmt_len()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

xstrfmt(), xstrvfmt(), they are functions used to add formatt strings
to a dynamic memory. Because their implementation uses strbuf to store
its buffer and its length, so we can easily pass its length to the caller,
so create xstrvfmt_len() and xstrfmt_len() which can fetch the length
of the buffer through the parameter `len`. This can reduce the cost of
calculating the length of the string later through strlen().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 50 +++++++++++++++++++++++++-------------------------
 strbuf.c     | 21 +++++++++++++++++++++
 strbuf.h     |  6 ++++++
 3 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index be4c4405b12..6e904389d6b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1115,10 +1115,10 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 		else if (atom_type == ATOM_OBJECTSIZE) {
 			if (used_atom[i].u.objectsize.option == O_SIZE_DISK) {
 				v->value = oi->disk_size;
-				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)oi->disk_size);
+				v->s = xstrfmt_len(&v->s_size, "%"PRIuMAX, (uintmax_t)oi->disk_size);
 			} else if (used_atom[i].u.objectsize.option == O_SIZE) {
 				v->value = oi->size;
-				v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
+				v->s = xstrfmt_len(&v->s_size, "%"PRIuMAX , (uintmax_t)oi->size);
 			}
 		} else if (atom_type == ATOM_DELTABASE)
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
@@ -1171,7 +1171,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		}
 		if (atom_type == ATOM_NUMPARENT) {
 			v->value = commit_list_count(commit->parents);
-			v->s = xstrfmt("%lu", (unsigned long)v->value);
+			v->s = xstrfmt_len(&v->s_size, "%lu", (unsigned long)v->value);
 		}
 		else if (atom_type == ATOM_PARENT) {
 			struct commit_list *parents;
@@ -1449,7 +1449,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 				v->s = xmemdupz(buf, buf_size);
 				v->s_size = buf_size;
 			} else if (atom->u.raw_data.option == RAW_LENGTH) {
-				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
+				v->s = xstrfmt_len(&v->s_size, "%"PRIuMAX, (uintmax_t)buf_size);
 			}
 			continue;
 		}
@@ -1476,7 +1476,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 		} else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
 		else if (atom->u.contents.option == C_LENGTH)
-			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
+			v->s = xstrfmt_len(&v->s_size, "%"PRIuMAX, (uintmax_t)strlen(subpos));
 		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)
@@ -1645,56 +1645,56 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 }
 
 static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
-				    struct branch *branch, const char **s)
+				    struct branch *branch, struct atom_value *v)
 {
 	int num_ours, num_theirs;
 	if (atom->u.remote_ref.option == RR_REF)
-		*s = show_ref(&atom->u.remote_ref.refname, refname);
+		v->s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
 				       NULL, atom->u.remote_ref.push,
 				       AHEAD_BEHIND_FULL) < 0) {
-			*s = xstrdup(msgs.gone);
+			v->s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
-			*s = xstrdup("");
+			v->s = xstrdup("");
 		else if (!num_ours)
-			*s = xstrfmt(msgs.behind, num_theirs);
+			v->s = xstrfmt_len(&v->s_size, msgs.behind, num_theirs);
 		else if (!num_theirs)
-			*s = xstrfmt(msgs.ahead, num_ours);
+			v->s = xstrfmt_len(&v->s_size, msgs.ahead, num_ours);
 		else
-			*s = xstrfmt(msgs.ahead_behind,
+			v->s= xstrfmt_len(&v->s_size, msgs.ahead_behind,
 				     num_ours, num_theirs);
-		if (!atom->u.remote_ref.nobracket && *s[0]) {
-			const char *to_free = *s;
-			*s = xstrfmt("[%s]", *s);
+		if (!atom->u.remote_ref.nobracket && v->s[0]) {
+			const char *to_free = v->s;
+			v->s = xstrfmt_len(&v->s_size, "[%s]", v->s);
 			free((void *)to_free);
 		}
 	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
 				       NULL, atom->u.remote_ref.push,
 				       AHEAD_BEHIND_FULL) < 0) {
-			*s = xstrdup("");
+			v->s = xstrdup("");
 			return;
 		}
 		if (!num_ours && !num_theirs)
-			*s = xstrdup("=");
+			v->s = xstrdup("=");
 		else if (!num_ours)
-			*s = xstrdup("<");
+			v->s = xstrdup("<");
 		else if (!num_theirs)
-			*s = xstrdup(">");
+			v->s = xstrdup(">");
 		else
-			*s = xstrdup("<>");
+			v->s = xstrdup("<>");
 	} else if (atom->u.remote_ref.option == RR_REMOTE_NAME) {
 		int explicit;
 		const char *remote = atom->u.remote_ref.push ?
 			pushremote_for_branch(branch, &explicit) :
 			remote_for_branch(branch, &explicit);
-		*s = xstrdup(explicit ? remote : "");
+		v->s = xstrdup(explicit ? remote : "");
 	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
 		const char *merge;
 
 		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push);
-		*s = xstrdup(merge ? merge : "");
+		v->s = xstrdup(merge ? merge : "");
 	} else
 		BUG("unhandled RR_* enum");
 }
@@ -1922,7 +1922,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 			refname = branch_get_upstream(branch, NULL);
 			if (refname)
-				fill_remote_ref_details(atom, refname, branch, &v->s);
+				fill_remote_ref_details(atom, refname, branch, v);
 			else
 				v->s = xstrdup("");
 			continue;
@@ -1943,7 +1943,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			}
 			/* We will definitely re-init v->s on the next line. */
 			free((char *)v->s);
-			fill_remote_ref_details(atom, refname, branch, &v->s);
+			fill_remote_ref_details(atom, refname, branch, v);
 			continue;
 		} else if (atom_type == ATOM_COLOR) {
 			v->s = xstrdup(atom->u.color);
@@ -2006,7 +2006,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		if (!deref)
 			v->s = xstrdup(refname);
 		else
-			v->s = xstrfmt("%s^{}", refname);
+			v->s = xstrfmt_len(&v->s_size, "%s^{}", refname);
 		free((char *)refname);
 	}
 
diff --git a/strbuf.c b/strbuf.c
index c8a5789694c..8358d9c3f86 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -982,6 +982,15 @@ char *xstrvfmt(const char *fmt, va_list ap)
 	return strbuf_detach(&buf, NULL);
 }
 
+char *xstrvfmt_len(ssize_t *len, const char *fmt, va_list ap)
+{
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_vaddf(&buf, fmt, ap);
+	if (len)
+		*len = buf.len;
+	return strbuf_detach(&buf, NULL);
+}
+
 char *xstrfmt(const char *fmt, ...)
 {
 	va_list ap;
@@ -994,6 +1003,18 @@ char *xstrfmt(const char *fmt, ...)
 	return ret;
 }
 
+char *xstrfmt_len(ssize_t *len, const char *fmt, ...)
+{
+	va_list ap;
+	char *ret;
+
+	va_start(ap, fmt);
+	ret = xstrvfmt_len(len ,fmt, ap);
+	va_end(ap);
+
+	return ret;
+}
+
 void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 		     int tz_offset, int suppress_tz_name)
 {
diff --git a/strbuf.h b/strbuf.h
index 5b1113abf8f..5211e0b714f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -738,4 +738,10 @@ char *xstrvfmt(const char *fmt, va_list ap);
 __attribute__((format (printf, 1, 2)))
 char *xstrfmt(const char *fmt, ...);
 
+
+__attribute__((format (printf, 2, 0)))
+char *xstrvfmt_len(ssize_t *len, const char *fmt, va_list ap);
+__attribute__((format (printf, 2, 3)))
+char *xstrfmt_len(ssize_t *len, const char *fmt, ...);
+
 #endif /* STRBUF_H */
-- 
gitgitgadget

