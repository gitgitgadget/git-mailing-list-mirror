Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110D0C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 12:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD27461413
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 12:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbhDUMab (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 08:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbhDUMaa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 08:30:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F03C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 05:29:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mh2so41693454ejb.8
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=s5WTsn69TU7ltr6jzxC/siJ7cIYf0xur2slSRsnyQdY=;
        b=duJ3ynAWXMg5zGr4VB1SPRhuWW9oJUCDvj8lMoZ6DCof6nqVVvgrcmIb8Nd+5hgdD7
         kmI701aUmvxfEBev/RKf/6c+AjZF+bZtAHweH/JY1dzJaE/Neg5L16NvZRdji5sXL+2B
         UKB2HxeZz2aCjjislNLXwCzfjVGsJDrkyXvSj5V5pG0ELWDQKDLuszcYpmElkkXODMds
         ZuaLTd5VVIzJHqAcSaa+WfiujPw8LswNiY5pAxCrxGXAfpHNj1y5II+2houzsuNmz6to
         FTIs67HlfGI7Ou2bESYYItMYkNDs5/aK2dSvKQfbF0fkSbeBRFrFu4nhuodEB6fbA1ZR
         Pgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=s5WTsn69TU7ltr6jzxC/siJ7cIYf0xur2slSRsnyQdY=;
        b=PWIMyv+srrbqQhFb2XfVfGCw+T/Ho7lGAyPkh4i4z8cXrbyj4JCiWYoKLkk2qzReTY
         d5WBQtfW1A452+XYSVNicXabI1wDZBse8CvGmDCPukJOQeGdMDkDdcSo6rCUAjQXzAIw
         PrWr6qf5FRoZ3bQxp9d5eXHDkmU1kA/rwAwwn/pYmhlGv0PfvAPpjcUkbk7yh/YthcAe
         wg3oVu4Z/XsAxgU7emksGc+ppeuLnRyntEH8pMdEFYULY8sNl3/FGPoGMqc9/lIdQNlx
         hpJAjMv6bM/x6yXeiwnFYsOgSd/psUeGN3vcOQ2e3CmRnkf1C2XNfj0Kd32Su6+KDHE1
         Dzeg==
X-Gm-Message-State: AOAM533+YjVoYlOTKIvAz+RWoMtqSgc0a9W1p1fNKQfQp/b9n9BmCCxe
        OshMHaSG/fsgzNQlFI7HpIj+L6/GGsmpng==
X-Google-Smtp-Source: ABdhPJyJxmjI+Pq9h0INAyKR1lztDgrkcaY2zvFxuu/O/Dz9h6hUFTgM5x1FW3gOmzoQe3QNfigJeA==
X-Received: by 2002:a17:906:3e54:: with SMTP id t20mr32618844eji.53.1619008195434;
        Wed, 21 Apr 2021 05:29:55 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j9sm3197969eds.71.2021.04.21.05.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:29:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 6/9] t4058: explore duplicate tree entry handling in
 a bit more detail
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
 <8db27892c598a3976c0742e23563f1d360b8dee1.1607677728.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <8db27892c598a3976c0742e23563f1d360b8dee1.1607677728.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 14:29:53 +0200
Message-ID: <87fszj3jni.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 11 2020, Elijah Newren via GitGitGadget wrote:

> While creating the last commit, I found a number of other cases where
> git would segfault when faced with trees that have duplicate entries.
> None of these segfaults are in the diffcore-rename code (they all occur
> in cache-tree and unpack-trees).  Further, to my knowledge, no one has
> ever been adversely affected by these bugs, and given that it has been
> 15 years and folks have fixed a few other issues with historical
> duplicate entries (as noted in the last commit), I am not sure we will
> ever run into anyone having problems with these.  So I am not sure these
> are worth fixing, but it doesn't hurt to at least document these
> failures in the same test file that is concerned with duplicate tree
> entries.
> [...]
> +test_expect_failure 'fast-forward from duplicate entries to non-duplicate' '
> +	git merge update
> +'
> +
>  test_done

Per https://lore.kernel.org/git/87lf9b3mth.fsf@evledraar.gmail.com/
isn't the noise of having a segfault from "git" worth fixing in itself
though? I.e. something like this, so we at least se why it fails:

diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index 54614b814db..ed91d9f7fe9 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -182,8 +182,10 @@ test_expect_success 'switch to base branch and force status to be clean' '
 	test_must_be_empty actual
 '
 
-test_expect_failure 'fast-forward from duplicate entries to non-duplicate' '
-	git merge update
+test_expect_success 'fast-forward from duplicate entries to non-duplicate' '
+	! git merge update 2>err &&
+	grep "^BUG: " err &&
+	grep -F "should have entry at o->src_index->cache[1]" err
 '
 
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 8a1afbc1e49..230cb073fe1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -789,8 +789,11 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 	 */
 	for (i = 0; i < nr_entries; i++) {
 		int new_ce_len, len, rc;
+		int j = pos + i;
 
-		src[0] = o->src_index->cache[pos + i];
+		src[0] = o->src_index->cache[j];
+		if (!src[0])
+			BUG("should have entry at o->src_index->cache[%d]", j);
 
 		len = ce_namelen(src[0]);
 		new_ce_len = cache_entry_size(len);

