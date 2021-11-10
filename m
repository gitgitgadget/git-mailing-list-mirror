Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A48C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F8161002
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhKJB34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhKJB3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 20:29:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A8C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 17:27:08 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso3314324wmc.2
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 17:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYZ5BJeHOLARNWF928KkmwqZ2ed9EusZx1VzN95DbrI=;
        b=jOl7V6l4S2ITBcZJ1xV+o7Ly0ABor80OFiGZyjzNe2skfpNhr0/Ka6OO+b8ep6Yni/
         pjclGjuQGQbE9Pzy4F7dSQ23ejNELYEy17U+t/MjhWfxlGqPTGxObsIbj6CXDo/YTCHg
         6PANwGhcmO61/iu3s5RDSEpAL8DAt/i5SFJSOu/6Y4W02PUVk9LX6D7PLWJkqBz1+w2+
         iiULcvI+2pTW9yr6KP7KJHOi+Wd51pyFI6dzhRQrcf5Ds60ZFsczQeM0pIl+PhBPmujN
         QNsRMyrCKuihUimNqihzWkydchFjk1wf/Xbw9mR0nWo2cLAISfZuLCqlYnWJo5ZvE9KG
         iAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYZ5BJeHOLARNWF928KkmwqZ2ed9EusZx1VzN95DbrI=;
        b=39IGDx5zVqhwev6LjjJP857qwPCYYnFnD7/mxfz5a4zLAazs5ghZbd8dhalkpqd/d0
         9zDT6Se+KMIsUn0Vk7Nna4WfllHg60L9AHGM6u/84wM8gMio8qaQEH2LEoHOyMDRjfvx
         EIxzxjxK0Ft7tSDjPKNdS1g2EkH0WZ0qptUX+JnyfFRhYI9gFfMK++wqQSux7MLJmCw6
         cVRvl1VlP9QZb/nriW6PXu4qfGSkj90+KwIYq0JTs/6TOuRq5+zug0xuUz3ojjqkhX00
         jO8DlAg4VaPVX+o7vXYy5lW9npb1MxBrzKUd8Ohj6oloNeG/Bfvvt4GPnSORLQT16HKZ
         Q8wg==
X-Gm-Message-State: AOAM531+JMAGSTNcRHqe1HKUiFTsyD4EeoMm2TToKouBi/kDQJvqikKY
        1/zAE9JE1hvbwZABM8pjZUHTw1HyZ6NObQ==
X-Google-Smtp-Source: ABdhPJzFuzyx0EIQv+IFwueCWRVyED1+59a7N0Rb15kN7GQcMzM/xudl3Lg9BCqskXMQi/7Y6BByHA==
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr12313973wmb.114.1636507627085;
        Tue, 09 Nov 2021 17:27:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t4sm3882252wmi.48.2021.11.09.17.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:27:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] parse-options.c: use "enum parse_opt_result" for parse_nodash_opt()
Date:   Wed, 10 Nov 2021 02:27:04 +0100
Message-Id: <patch-v2-1.1-376f76bb44e-20211110T012523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <211110.867ddgkjcp.gmgdl@evledraar.gmail.com>
References: <211110.867ddgkjcp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the parse_nodash_opt() function to use "enum
parse_opt_result".In 352e761388b (parse-options.[ch]: consistently
use "enum parse_opt_result", 2021-10-08) its only caller
parse_options_step() started using that return type, and the
get_value() which will be called and return from it uses the same
enum.

Let's do the same here so that this function always returns an "enum
parse_opt_result" value.

We could go for either PARSE_OPT_HELP (-2) or PARSE_OPT_ERROR (-1)
here. The reason we ended up with "-2" is that in code added in
07fe54db3cd (parse-opt: do not print errors on unknown options, return
"-2" instead., 2008-06-23) we used that value in a meaningful way.

Then in 51a9949eda7 (parseopt: add PARSE_OPT_NODASH, 2009-05-07) the
use of "-2" was seemingly copy/pasted from parse_long_opt(), which was
the function immediately above the parse_nodash_opt() function added
in that commit.

Since we only care about whether the return value here is non-zero
let's use the more generic PARSE_OPT_ERROR.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Now with an updated commit message per the v1 discussion. I peeled off
the 1/2 patch as it's already on "master" as 06a199f38b5
(parse-options.[ch]: revert use of "enum" for parse_options(),
2021-11-09).

Range-diff against v1:
1:  057a9f81b47 < -:  ----------- parse-options.[ch]: revert use of "enum" for parse_options()
2:  aa6224b10f8 ! 1:  376f76bb44e parse-options.c: use "enum parse_opt_result" for parse_nodash_opt()
    @@ Commit message
         parse-options.c: use "enum parse_opt_result" for parse_nodash_opt()
     
         Change the parse_nodash_opt() function to use "enum
    -    parse_opt_result". In 352e761388b (parse-options.[ch]: consistently
    +    parse_opt_result".In 352e761388b (parse-options.[ch]: consistently
         use "enum parse_opt_result", 2021-10-08) its only caller
         parse_options_step() started using that return type, and the
         get_value() which will be called and return from it uses the same
    @@ Commit message
         Let's do the same here so that this function always returns an "enum
         parse_opt_result" value.
     
    +    We could go for either PARSE_OPT_HELP (-2) or PARSE_OPT_ERROR (-1)
    +    here. The reason we ended up with "-2" is that in code added in
    +    07fe54db3cd (parse-opt: do not print errors on unknown options, return
    +    "-2" instead., 2008-06-23) we used that value in a meaningful way.
    +
    +    Then in 51a9949eda7 (parseopt: add PARSE_OPT_NODASH, 2009-05-07) the
    +    use of "-2" was seemingly copy/pasted from parse_long_opt(), which was
    +    the function immediately above the parse_nodash_opt() function added
    +    in that commit.
    +
    +    Since we only care about whether the return value here is non-zero
    +    let's use the more generic PARSE_OPT_ERROR.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## parse-options.c ##

 parse-options.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index fc5b43ff0b2..629e7963497 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -404,8 +404,9 @@ static enum parse_opt_result parse_long_opt(
 	return PARSE_OPT_UNKNOWN;
 }
 
-static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
-			    const struct option *options)
+static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
+					      const char *arg,
+					      const struct option *options)
 {
 	const struct option *all_opts = options;
 
@@ -415,7 +416,7 @@ static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
 		if (options->short_name == arg[0] && arg[1] == '\0')
 			return get_value(p, options, all_opts, OPT_SHORT);
 	}
-	return -2;
+	return PARSE_OPT_ERROR;
 }
 
 static void check_typos(const char *arg, const struct option *options)
-- 
2.34.0.rc1.741.gab7bfd97031

