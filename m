Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA60BC433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 01:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8591320700
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 01:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+iG6mmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgGZBxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jul 2020 21:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGZBxT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jul 2020 21:53:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87267C0619D2
        for <git@vger.kernel.org>; Sat, 25 Jul 2020 18:53:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id il6so1607655pjb.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2020 18:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vX+plzfVOIkHza1n5JwISXTbVy8oZ58yIBt8mM4NDHc=;
        b=P+iG6mmOMINyFMjEZHUc2K3u0xEywEoC3pTyeXvtYETgbJlKBLN71nM9V5tRyxKxE3
         kStmy9oll4CLGPaIqel0okodBx77aSt1xASHk1n3jp1JLNMuGovOqI9VR6uayegn8qIq
         Yx5rJQ9bLyJ1hpcwGVb9GoRO15sgnhjIRTudGel8KyHsoaRUdze99Bq4SG17HERcuQOx
         LW3oOkRG2fuamrcxPvp2DaIsipB/98grRJQJQkwp/TYsaMgDbDPyKzmdWlcyP/1zlvHg
         FlsRBzdxB3FUHeooMNmfiNGWrR0ZayKrZu4/3JAFgcRige8VNuhAyJ20RIBhlyGhs+I3
         9fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vX+plzfVOIkHza1n5JwISXTbVy8oZ58yIBt8mM4NDHc=;
        b=lkuDWG04s2jKjzKmFLDL9l2j6qEZrHBLOpZ8wPq+Fefm5rH9vBv+FcPShxtLIjcCoF
         fEdhlcXjwybu7DOnsIIF3271O8OW3QBsvGyLan1SSvGOfiMwFV22NtiL0+t54F4jlNFC
         79rpzsJMsEqTnVHBrucisrDmYpDB+mpTL7BS4Aul4M3N6/qWloVaVRMcOdKXWcVX/vBw
         3eNbfKJHzSa32pnqXB9jJX0t7azsLAfJcP22oPqxpB5Y7TER0KWwQpt549QD2NS4TPzQ
         Xfcn1+wlodx5v8cwLKohwzN2025ZbfC6ntVo7Gp2o+C6O+WCGrszEiKZ1bnL2dbLooRU
         ieYA==
X-Gm-Message-State: AOAM530tTA3XIJK7ik4sSohY7m1gK3qtM6MGvqLYaYT+VT6wgaALyt3+
        +QM0wvLKV37x8TXHgxJZflOftNAt8PU=
X-Google-Smtp-Source: ABdhPJznhUxsiOiijPI23mxx7jiIrkkcofHRyF1DFV8m83Vbjm5qRiBn6oleUK3mpyWvGbxVvNt+3A==
X-Received: by 2002:a17:90a:eb98:: with SMTP id o24mr3201589pjy.150.1595728399038;
        Sat, 25 Jul 2020 18:53:19 -0700 (PDT)
Received: from localhost ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id w2sm9859203pjt.19.2020.07.25.18.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 18:53:18 -0700 (PDT)
Date:   Sun, 26 Jul 2020 08:53:16 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v5 04/13] bisect--helper: reimplement `bisect_autostart`
 shell function in C
Message-ID: <20200726015300.GB8046@danh.dev>
References: <20200717105406.82226-1-mirucam@gmail.com>
 <20200717105406.82226-5-mirucam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717105406.82226-5-mirucam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-17 12:53:57+0200, Miriam Rubio <mirucam@gmail.com> wrote:
> From: Pranit Bauva <pranit.bauva@gmail.com>
> 
> +static int bisect_autostart(struct bisect_terms *terms)
> +{
> +	int res;
> +	const char *yesno;
> +
> +	if (file_is_not_empty(git_path_bisect_start()))
> +		return 0;
> +
> +	fprintf_ln(stderr, _("You need to start by \"git bisect "
> +			  "start\"\n"));
> +
> +	if (!isatty(STDIN_FILENO))
> +		return 0;
> +
> +	/*
> +	 * TRANSLATORS: Make sure to include [Y] and [n] in your
> +	 * translation. The program will only accept English input
> +	 * at this point.
> +	 */
> +	yesno = git_prompt(_("Do you want me to do it for you "
> +			     "[Y/n]? "), PROMPT_ECHO);
> +	res = tolower(*yesno) == 'n' ?
> +		-1 : bisect_start(terms, 0, NULL, 0);

Applying 01-04 ontop of v2.28.0-rc2-3-g418cca9555 (current git/git.git's master).

This line crash my git-bisect, MVCE:

	./git-bisect--helper --bisect-autostart

Since it will pass NULL as argv to bisect_start, which expect an array
of "argc + 1" of "char*" (the last element is NULL).
And bisect_start attempts to log bisect entry for this call.

Quick fix:
----------------8<---------------
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7662ec0ce3..25d3d07721 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -673,7 +673,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 	yesno = git_prompt(_("Do you want me to do it for you "
 			     "[Y/n]? "), PROMPT_ECHO);
 	res = tolower(*yesno) == 'n' ?
-		-1 : bisect_start(terms, 0, NULL, 0);
+		-1 : bisect_start(terms, 0, empty_argv, 0);
 
 		return res;
 }
-------------------->8------------------


> +
> +		return res;

This line is over-indented. IOW, move left 1 TAB.

-- 
Danh
