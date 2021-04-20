Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43CDC43462
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E66F61001
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhDTMvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhDTMv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF5C06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w3so58129941ejc.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lg6Be/2RnLL//TNIFmdhCixSwsglxA29rZChFQKBCw=;
        b=qAoFZCE5Ai2GFyEifj8COf/i1CMYvl/PHuc3qddMo2KsCr2YoT1PALTLS8/XDEPwfS
         47leSOewFGQAqaIxW/m9XgDAI/Cl32CtpblbC6vBvCoM0ZlZ/DI4tIIya2XITYQXMrrw
         j0pwfsjQ4JaN8pt1rDmIx3CO942tQSVOOHM7QBHBRWwY4n4/oUz8YxaZ33SHEoJsZ948
         PUwnKoxQaq8Mka46qCCZT3/fOaiaS3olKWb4BDcUJrglypuz6O7P7jpvVo40gn1jV32f
         PisueQWRlElL49Z3v3iB5pvtybUtYo6In1qekATfgps0+onXD40dJfZCUy3Qa3yhURlE
         E4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lg6Be/2RnLL//TNIFmdhCixSwsglxA29rZChFQKBCw=;
        b=deIm7L31sgIMSrURvXjvPQiFSnzPEFshwYar5ZQq53EF+/XyhUzRTU/sCrHnFneFsT
         HNeK1EhM3kkaK/0q0TGj9i8jqVxVvvmEXoiZdqEZL7LPiOHu0TT9EVbkSxAco63pgjiw
         NCWMq/AeMqwEz7UJ2o97aoD6kRvAqtp2Ns7ro7IUqt+kl2wisqQdwq+A1dfDpsknGWT/
         gL/jCllmym6CxySFX/ktb3DGEEkubOPDrkBbvt6q6N8RUt744esTTMrMpVrGsipYTKM1
         DL7T09m+O9qQnX+m5dzh00LUtuRODmZN9zGYc6CMj8MKxTmezr33y+JOBZSn9C6of4+q
         t30w==
X-Gm-Message-State: AOAM5306soLROpwAzRtryAT4E9jOOhVrSJdQonBBLfr1V0/YTAzAj8nN
        xjjh1jDSMLdPiJJQLdl1lYrRJiZ9lLl1kQ==
X-Google-Smtp-Source: ABdhPJyIhf/+jKBdDjuIKb0TCb/q2zGJgXOWPaF8p7hiST5WqS9gXNfymE0iTaxH3jEyYDnHcu8E5w==
X-Received: by 2002:a17:906:8055:: with SMTP id x21mr27705522ejw.72.1618923052821;
        Tue, 20 Apr 2021 05:50:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/10] mktree: stop setting *ntr++ to NIL
Date:   Tue, 20 Apr 2021 14:50:42 +0200
Message-Id: <patch-09.10-e463fe5f6a-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 58ce21b819e (builtin/mktree: remove hard-coded constant,
2018-10-15) we have not made any subsequent use of the ntr variable
itself, but we did rely on it to NIL-delimit the string we were about
to feed to type_from_string().

Using type_from_string() here results in needless work, as we'd do a
strlen() on it, just to find point at which we had a SPC
character (now NIL) earlier in this function.

We can instead skip incrementing the ntr pointer, then pass the
pointer and length to the type_from_string() function instead.

Doing so would have been buggy in cases where the type was invalid
until a preceding commit fixed the die() invocation in
type_from_string() to also pay attention to the length. A preceding
commit added a test to t1010-mktree.sh which would fail if not for
that fix in type_from_string(), i.e. we'd end up printing the rest of
the line, not just the invalid type.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktree.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 891991b00d..7a27cfa2e0 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -95,9 +95,6 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 	if (S_ISGITLINK(mode))
 		allow_missing = 1;
 
-
-	*ntr++ = 0; /* now at the beginning of SHA1 */
-
 	path = (char *)p + 1;  /* at the beginning of name */
 	if (!nul_term_line && path[0] == '"') {
 		struct strbuf p_uq = STRBUF_INIT;
@@ -111,7 +108,7 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 	 * These should all agree.
 	 */
 	mode_type = object_type(mode);
-	if (mode_type != type_from_string(ptr)) {
+	if (mode_type != type_from_string_gently(ptr, ntr - ptr, 0)) {
 		die("entry '%s' object type (%s) doesn't match mode type (%s)",
 			path, ptr, type_name(mode_type));
 	}
-- 
2.31.1.723.ga5d7868e4a

