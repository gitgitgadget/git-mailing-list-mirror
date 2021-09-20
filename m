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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8791C433FE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE6F60FF2
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhITHj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 03:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhITHj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 03:39:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DD5C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:38:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x6so27081465wrv.13
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E9Xnu4Db9PcWhZ7UVxFBMUCRFfaw5AAgBIdeQQjJIFw=;
        b=HtZHEnt1wbxWbeRDP5sNbovNEh/GN7uZVMPNUyVHb721J2nK7jIoWtsv+QtAvPG0uI
         R8AK4g30/lSoMnattsGK/fwnn6TnO5xyIa4yEAkNoeF5hvKUI4xUk+kMRL7rnFBsIaZX
         AnMQLleq/1Spn5n0Pd85Phv+Q0bGI2m6cl6L8hrOeIhy29JMy3JPXtU1EeW1IQiPSKS0
         0zQWdlUulyihASL2ZQ4mvoGWvmYJIONIrCmt/maNKpBAvzk/kqud/zK6zGc8ZnDRI+qf
         KVUq7mjLcVP+KFvUUgEwG2r0KNto1DxDq9hVO9gunWfpAbLKDN+1S/pLrtj7smTjE4Lg
         daAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E9Xnu4Db9PcWhZ7UVxFBMUCRFfaw5AAgBIdeQQjJIFw=;
        b=tTrbwc3eZ1wx2qeBOfEyCVODTO+4PMrFZpgSuSBqTBrGcHl8eFe1tFIMZK/2kGhU1f
         6EjKUpdMl7AlbgxZC9kJNgSV1jHoF1vPBpHm163S7oj/4M35WJU1sz/XjUtF/Skx1GN9
         GjmNZwVbMKwe6c6vPQvMZX49gt5/dYrAhiqGQx6s/ZXRgkjGzEnWNsrNDWmnkix/U9P0
         eu4r2b8ExAlSMjbXEmGtqW+vI7xfRRl9Zx5fCJ5sZ38gnBRKYqZrOYPme7M9WfUUmlUC
         jslSbBt7I9yD4r8BCdfZKK5m1Md3cfgIGzQpP/Kdcu3h7lQugvvoUmPTT7nYtjTGqbjA
         m6iQ==
X-Gm-Message-State: AOAM531eMlI4Dy7uvT6B7WQtUPn6CuSzQo3e8/kQd3ReMaqgSONbmJxO
        YTwME4/MEz965L9pDvlBx+izFyG5g1o=
X-Google-Smtp-Source: ABdhPJx2KoUZ/vV+jv7kbMwmN5UcPwJNIoxztOB6ZdjixlqAQL/qykvdcREoJ1kN4mX2hGcRwmEyjg==
X-Received: by 2002:a5d:64a3:: with SMTP id m3mr14674078wrp.157.1632123479742;
        Mon, 20 Sep 2021 00:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm14521520wrt.28.2021.09.20.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:37:59 -0700 (PDT)
Message-Id: <6f49635819aadad473dffc689ef1da7754d4ba63.1632123476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1042.git.1632123476.gitgitgadget@gmail.com>
References: <pull.1042.git.1632123476.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 07:37:54 +0000
Subject: [PATCH 2/4] ref-filter: provide ref_flags to pretty_print_ref()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

pretty_print_ref() creates a ref_item through new_ref_array_item(),
but such ref_item does not set its flag member, this means that %(symref)
will not be processed in populate_value().

So provide ref_flags parameter to pretty_print_ref() and verify_tag().
pretty_print_ref() has two callers: cmd_verify_tag(), verify_tag(),
let for_each_tag_name() use read_ref_full() instread of read_ref() to
generate the ref_flags and pass to pretty_print_ref(); However,
cmd_verify_tag() needs to be modified later to support providing ref_flags
to pretty_print_ref().

At the same time, let verify_tag() pass "ref" instread of "name" to
gpg_verify_tag() and pretty_print_ref(), which can help pretty_print_ref
get fullref name.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/tag.c        | 15 ++++++++-------
 builtin/verify-tag.c |  2 +-
 ref-filter.c         |  3 ++-
 ref-filter.h         |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 065b6bf093e..ce5678d179f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -83,7 +83,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 }
 
 typedef int (*each_tag_name_fn)(const char *name, const char *ref,
-				const struct object_id *oid, void *cb_data);
+				const struct object_id *oid, void *cb_data, int ref_flags);
 
 static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 			     void *cb_data)
@@ -92,16 +92,17 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 	struct strbuf ref = STRBUF_INIT;
 	int had_error = 0;
 	struct object_id oid;
+	int ref_flags;
 
 	for (p = argv; *p; p++) {
 		strbuf_reset(&ref);
 		strbuf_addf(&ref, "refs/tags/%s", *p);
-		if (read_ref(ref.buf, &oid)) {
+		if (read_ref_full(ref.buf, RESOLVE_REF_READING, &oid, &ref_flags)) {
 			error(_("tag '%s' not found."), *p);
 			had_error = 1;
 			continue;
 		}
-		if (fn(*p, ref.buf, &oid, cb_data))
+		if (fn(*p, ref.buf, &oid, cb_data, ref_flags))
 			had_error = 1;
 	}
 	strbuf_release(&ref);
@@ -109,7 +110,7 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 }
 
 static int collect_tags(const char *name, const char *ref,
-			const struct object_id *oid, void *cb_data)
+			const struct object_id *oid, void *cb_data, int unused_flags)
 {
 	struct string_list *ref_list = cb_data;
 
@@ -143,7 +144,7 @@ static int delete_tags(const char **argv)
 }
 
 static int verify_tag(const char *name, const char *ref,
-		      const struct object_id *oid, void *cb_data)
+		      const struct object_id *oid, void *cb_data, int ref_flags)
 {
 	int flags;
 	struct ref_format *format = cb_data;
@@ -152,11 +153,11 @@ static int verify_tag(const char *name, const char *ref,
 	if (format->format)
 		flags = GPG_VERIFY_OMIT_STATUS;
 
-	if (gpg_verify_tag(oid, name, flags))
+	if (gpg_verify_tag(oid, ref, flags))
 		return -1;
 
 	if (format->format)
-		pretty_print_ref(name, oid, format);
+		pretty_print_ref(ref, oid, format, ref_flags);
 
 	return 0;
 }
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f45136a06ba..403f2080efa 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -71,7 +71,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		}
 
 		if (format.format)
-			pretty_print_ref(name, &oid, &format);
+			pretty_print_ref(name, &oid, &format, 0);
 	}
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 93ce2a6ef2e..6c51ef25136 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2632,7 +2632,7 @@ int format_ref_array_item(struct ref_array_item *info,
 }
 
 void pretty_print_ref(const char *name, const struct object_id *oid,
-		      struct ref_format *format)
+		      struct ref_format *format, int ref_flags)
 {
 	struct ref_array_item *ref_item;
 	struct strbuf output = STRBUF_INIT;
@@ -2640,6 +2640,7 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
 
 	ref_item = new_ref_array_item(name, oid);
 	ref_item->kind = ref_kind_from_refname(name);
+	ref_item->flag = ref_flags;
 	if (format_ref_array_item(ref_item, format, &output, &err))
 		die("%s", err.buf);
 	fwrite(output.buf, 1, output.len, stdout);
diff --git a/ref-filter.h b/ref-filter.h
index c15dee8d6b9..edd9a3b6652 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -140,7 +140,7 @@ void setup_ref_filter_porcelain_msg(void);
  * name must be a fully qualified refname.
  */
 void pretty_print_ref(const char *name, const struct object_id *oid,
-		      struct ref_format *format);
+		      struct ref_format *format, int ref_flags);
 
 /*
  * Push a single ref onto the array; this can be used to construct your own
-- 
gitgitgadget

