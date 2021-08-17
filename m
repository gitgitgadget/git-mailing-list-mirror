Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979BBC4320E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8001C60EFE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhHQImV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbhHQImT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:42:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47656C0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w24so5414265wmi.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2LPza4Pdca2u9DgmCdoJioGdYNEprZiHckukoyYvxvU=;
        b=KTIZM+jLkxgd4IyEfZcXUay52v3aUGh79K1NadOhIbCaHT2vNTfoj86py0ZPEknHTo
         aqgMY+JkkQJ2G0i9/thUeMbLYd6y4d0LaxARLa92p9IHMym1/kOMHZjSHrVBeg6HsjZy
         GsnA5qmzFpJmycfWxVkE7+uMe0YBYDPw6sx0lrOaCPK45EYIzTt+7gOJlzBZVfDmIksU
         FIjYWNt7sroyGb8HyONU9F5ZIlCI7USH/hHyy9ONQie1/G8KTaJaAyJVM6uyEVXDhEH4
         Q7xxxBVL+E0eaYj2qoUnqM8xlxneZKX3umNsFJkyNcBlAwWgerRFYnR0QtB5fc3wR7ZH
         p/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2LPza4Pdca2u9DgmCdoJioGdYNEprZiHckukoyYvxvU=;
        b=tX1PIggmJjpa1nDiUGUdlkLStNQWwRPaopByc+APZJ0GXG+JFSgnOUeOTr3ijMLoRE
         IMRZHHJ88XcR7lG6oBugDN83RrdEnoHL2nPTJFO33sZon8L/dUYwyVYSp4ARgOd/EOJX
         GwDbukRpkiaB/IzmCj+89lUfAGAZu9AjwraKjwq3WfH1tV3XV5Thg3F+YeYAzXYksAhw
         RgN53zvwE2yOWY0hLEpkuW6Kvuxm+iPA0teE1zQzYWJGXKtLzw1ILVocZO6L86cZ7Gci
         to74yfQsl+3mn9dW2mpp2Lyfck4mwF+3nyw2DUend9tiKNQ959sM0KWHGSOkCvFP43z3
         fTtQ==
X-Gm-Message-State: AOAM532hfPE2QRwW22dT0gQTyluVPOtxuMY889JyzLlthPunzJcaivYy
        5P5savktqnwQokY/TBU0ryYbbEtmfrs=
X-Google-Smtp-Source: ABdhPJyR0Q41mJ3qbxvo8sovipYS9FWTbCeN2yQozck8JK5w2CcsoA3jLGoJwXSfuMSukL7ti9A+Eg==
X-Received: by 2002:a05:600c:1405:: with SMTP id g5mr2114125wmi.40.1629189704870;
        Tue, 17 Aug 2021 01:41:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm1579539wru.31.2021.08.17.01.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:41:44 -0700 (PDT)
Message-Id: <38a36881f0a8db983be46c0c2bfe085d28225748.1629189701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
References: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 08:41:37 +0000
Subject: [PATCH 4/8] [GSOC] ref-filter: introducing xstrvfmt_len() and
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

In the logic of ref-filter, if we already specified v->s_size (the
length of the data), we can avoid using strlen() to calculate the
length of the data in strbuf_addstr() or perl_quote_buf_with_len()...

xstrfmt(), xstrvfmt(), they are functions used to add format strings
to a dynamic allocated buffer. Because their implementation uses strbuf
to store its buffer and its length, so we can easily pass its length
to the caller, furthermore, in ref-filter, we can reduce the use of
strlen().

So introduce xstrvfmt_len() and xstrfmt_len() which can fetch the length
of the buffer through the parameter `len`. This can bring a slight
performance improvement.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 73 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 875c2e4c39c..3784c0af57c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -228,6 +228,29 @@ static int strbuf_addf_ret(struct strbuf *sb, int ret, const char *fmt, ...)
 	return ret;
 }
 
+__attribute__((format (printf, 2, 0)))
+static char *xstrvfmt_len(ssize_t *len, const char *fmt, va_list ap)
+{
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_vaddf(&buf, fmt, ap);
+	if (len)
+		*len = buf.len;
+	return strbuf_detach(&buf, NULL);
+}
+
+__attribute__((format (printf, 2, 3)))
+static  char *xstrfmt_len(ssize_t *len, const char *fmt, ...)
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
 static int color_atom_parser(struct ref_format *format, struct used_atom *atom,
 			     const char *color_value, struct strbuf *err)
 {
@@ -1083,10 +1106,10 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
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
@@ -1139,7 +1162,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		}
 		if (atom_type == ATOM_NUMPARENT) {
 			v->value = commit_list_count(commit->parents);
-			v->s = xstrfmt("%lu", (unsigned long)v->value);
+			v->s = xstrfmt_len(&v->s_size, "%lu", (unsigned long)v->value);
 		}
 		else if (atom_type == ATOM_PARENT) {
 			struct commit_list *parents;
@@ -1417,7 +1440,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 				v->s = xmemdupz(buf, buf_size);
 				v->s_size = buf_size;
 			} else if (atom->u.raw_data.option == RAW_LENGTH) {
-				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
+				v->s = xstrfmt_len(&v->s_size, "%"PRIuMAX, (uintmax_t)buf_size);
 			}
 			continue;
 		}
@@ -1444,7 +1467,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 		} else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
 		else if (atom->u.contents.option == C_LENGTH)
-			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
+			v->s = xstrfmt_len(&v->s_size, "%"PRIuMAX, (uintmax_t)strlen(subpos));
 		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)
@@ -1611,56 +1634,56 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
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
@@ -1849,7 +1872,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 			refname = branch_get_upstream(branch, NULL);
 			if (refname)
-				fill_remote_ref_details(atom, refname, branch, &v->s);
+				fill_remote_ref_details(atom, refname, branch, v);
 			else
 				v->s = xstrdup("");
 			continue;
@@ -1870,7 +1893,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			}
 			/* We will definitely re-init v->s on the next line. */
 			free((char *)v->s);
-			fill_remote_ref_details(atom, refname, branch, &v->s);
+			fill_remote_ref_details(atom, refname, branch, v);
 			continue;
 		} else if (atom_type == ATOM_COLOR) {
 			v->s = xstrdup(atom->u.color);
@@ -1933,7 +1956,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		if (!deref)
 			v->s = xstrdup(refname);
 		else
-			v->s = xstrfmt("%s^{}", refname);
+			v->s = xstrfmt_len(&v->s_size, "%s^{}", refname);
 		free((char *)refname);
 	}
 
-- 
gitgitgadget

