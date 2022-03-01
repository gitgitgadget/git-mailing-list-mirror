Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EABC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiCAEmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiCAEmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:39 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1CD70077
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:54 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id c15-20020a17090a674f00b001bc9019ce17so827434pjm.8
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=R4gn/Lgz/0jYl0rWTMo4SAD9i7exfSROby50q/4fVN8=;
        b=MOqHLVeMUN69QEpmbrR4cJOMQtf2oj8FM85+Kjf1s5Xoww8w62sUu15mHSVebITqVG
         UUoO3dpDp5O6dtxfC/zmBEEi69LlQvOeF625SpRe3Jtr6rakSRvyV2UghsoBij2egh+W
         B+qXgnjtxvQF1y914Ik41Dy5IE/hZn1wT+ybj+GFx/8R2XHjqioSftEo9f3S2zrFf2yc
         21g0WJU1M4rV2pw6j4TgBCMeKKYK9PoHEwTs+/LuDvt8CImjAKnb9GLcd2i2ZGtcrtL2
         FtP0uLeKRxRbo+NYSwrnwUtiYpiJe4+fupvCps7pnR1imZQmXU7Gh6+w6PDpNocJfJXD
         4aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=R4gn/Lgz/0jYl0rWTMo4SAD9i7exfSROby50q/4fVN8=;
        b=sDJ6i6UBTUphYl5UNaVbUleUE6F6/bHsGS8hSoD4/UQVOtsdzaDxg+k8purOpUwSV/
         qtQDBhxFw39b3nTldZAcRMRxPgDduYR+NnBOe60D2Q4fCD0e1Cf2E0WaJ8iwajvg+KBf
         FQtoVpgqYP/KBPkAWCYDF+zoZkF6NFFrZMPx8XH4eCjUduwAVEyWgSAt1tEx9FYpfFLk
         ls3cBxPvcVmR7uOjec6rr4UzNEURY3TaVV643piPgkasCdE/dKWxVVKtIO1BqSDmZd1A
         Xqb8N0Ja6zmnYAv54YtI1/BW/qblpYySXJdIEf8fjl2wbplzgXo08+Xn91n3fsThbndI
         lU8A==
X-Gm-Message-State: AOAM531u1+wXBqZBvJQ9ihuGk2p41vrYzYbE8G6YpRgVLlroL2saSeHV
        01CtPdRKRouyrm+Pzpj/Fu9oOMW+9xXJyKEowP5QApIfGNl31RPwaeYB5ldHYxHrs7SArlK4X4o
        m0LZTN41aKE+SHXl0PYwEqyM/RjMf4WV+vY4te6/5j45tq/o0vyh47wl2n8YMMO4=
X-Google-Smtp-Source: ABdhPJx04YxFDP3PA4u7TQV6d/Y1+1xEsXGB1A7e6096H/D3pSgeL7P5KrV7zC1bYO3Mjk0m6SzPAoa775x89A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1d13:b0:4e1:7958:b59d with SMTP
 id a19-20020a056a001d1300b004e17958b59dmr25156571pfx.68.1646109714055; Mon,
 28 Feb 2022 20:41:54 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:28 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-10-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 09/13] submodule--helper: refactor get_submodule_displaypath()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We create a function called `do_get_submodule_displaypath()` that
generates the display path required by several submodule functions, and
takes a custom superprefix parameter, instead of reading it from the
environment.

We then redefine the existing `get_submodule_displaypath()` function
as a call to this new function, where the superprefix is obtained from
the environment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 99341fb343..11afdeea8a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -247,11 +247,8 @@ static int resolve_relative_url_test(int argc, const c=
har **argv, const char *pr
 	return 0;
 }
=20
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+static char *do_get_submodule_displaypath(const char *path, const char *pr=
efix, const char *super_prefix)
 {
-	const char *super_prefix =3D get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -267,6 +264,13 @@ static char *get_submodule_displaypath(const char *pat=
h, const char *prefix)
 	}
 }
=20
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+{
+	const char *super_prefix =3D get_super_prefix();
+	return do_get_submodule_displaypath(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb =3D STRBUF_INIT;
--=20
2.33.GIT

