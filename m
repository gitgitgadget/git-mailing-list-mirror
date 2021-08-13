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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ADFC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344C46056B
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbhHMIYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbhHMIXz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A69C06124C
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g138so6324228wmg.4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CwEVQU+nR+mX/AL1EZNUNs9TGHKLJB/OiZcOeV7vLyM=;
        b=OKzYr2ceTfmNY6SY7CXOdu4GG/CCCmHwIyia5cSVtysrjCNsm9FRsPQvhIYcQ9gfdH
         p6c/d30ChmiJLt0GSuVHV1BRdcsetM2stvCCtTHYelwQEeC7f83LJ8714RZWROGFEMEL
         dsNMBJidgHvue3yqO0+n4gugEXSUCwF4W9NXasHiC1bIEDMF70ocbm9+HsYIXfAzJ15g
         Rhc7ClRGgba3fx2Yqv3T7BGuglBp+h4FH9fDa47hQuDPm0c7VeJ1qTPp5QlYbQCd5kKm
         71hkeA8ori2SZDOhHOXuhxhkgDBVwHhZHviY/9r/tXk/2ReKToqu3yxAT4GImQ+/WaGE
         RO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CwEVQU+nR+mX/AL1EZNUNs9TGHKLJB/OiZcOeV7vLyM=;
        b=Ya/XW/Qp3FrJwiYzyQ149QJ6PNmcXWoI1GSZE6KFkxWY37poqgVxv4hx1KKGn8W3I3
         IlUt39R5RLLQazmbuyGsTIpZuQ2kshR8T4/Gt3s5QA/v1HSNkZcRc6s5LYvCLGntUBmH
         BKNWWSXvBR9vtPjVmk/JnnN1V26aS0CemjaKCMkduauZh55ClupGClhtxG/yaMcn5qmg
         Jls/XgEj/WFurn6vVixfMfKEzRUudcHxeH/VxPYn1SMpm0n6Y2iNLmT68sC0YH5wtUzj
         PStqn69yOUbGRGRgvFf/RYP7JBZKZA5Pyvk1SjM/FBDZzfp3i3lT1+JJUmJNf1TO27Xm
         g8kQ==
X-Gm-Message-State: AOAM530W/+0xT3/he02tJ1JfAY/4puHEBjPmBBd/lYp0fbf0IdPo62Lk
        F5xWnAtzBXuX19qNUmp09lrmrTWU5iU=
X-Google-Smtp-Source: ABdhPJxl8DlbQOwt6+d4XGTio8UqMKWgC7A0tGk4Ie68DdD6OeEpbpFmlz1WzIGB44TMa+zoofeZ2w==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr1427846wmi.176.1628843006707;
        Fri, 13 Aug 2021 01:23:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm827817wrw.13.2021.08.13.01.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:26 -0700 (PDT)
Message-Id: <bd568c73a2df0d6ac28fcaeb10d706073f73fe0a.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:23:07 +0000
Subject: [PATCH 24/27] [GSOC] ref-filter: introduce symref_atom_parser()
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

parse_ref_filter_atom() checks whether the type of the atom
is ATOM_SYMREF, this is not necessary for other atoms. So
add the symref_atom_parser() specifically to parse the atom,
and set need_symref in it. This can make the program logic
more concise.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index bde1f3de9eb..a0de5f21ff5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -481,6 +481,13 @@ static int person_email_atom_parser(struct ref_format *format, struct used_atom
 	return 0;
 }
 
+static int symref_atom_parser(struct ref_format *format, struct used_atom *atom,
+			       const char *arg, struct strbuf *err)
+{
+	need_symref = 1;
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name, err);
+}
+
 static int refname_atom_parser(struct ref_format *format, struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
@@ -620,7 +627,7 @@ static struct {
 	[ATOM_RAW] = { "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
 	[ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	[ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
-	[ATOM_SYMREF] = { "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
+	[ATOM_SYMREF] = { "symref", SOURCE_NONE, FIELD_STR, symref_atom_parser },
 	[ATOM_FLAG] = { "flag", SOURCE_NONE },
 	[ATOM_HEAD] = { "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
 	[ATOM_COLOR] = { "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
@@ -748,8 +755,6 @@ static int parse_ref_filter_atom(struct ref_format *format,
 		return -1;
 	if (deref)
 		need_tagged = 1;
-	if (i == ATOM_SYMREF)
-		need_symref = 1;
 	return at;
 }
 
-- 
gitgitgadget

