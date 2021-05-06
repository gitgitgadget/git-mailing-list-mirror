Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFE0C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24994610FB
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhEFI5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 04:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbhEFI5j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 04:57:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9683AC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 01:56:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u3so7080949eja.12
        for <git@vger.kernel.org>; Thu, 06 May 2021 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=B5CQqTlaK7aGvEru8YysOZ0wmH1O/yOpi0IVYGKKQwU=;
        b=OBi4AOzBdGdUiylwKkL7QIElm4f1qqlRip0KUdTVf355AeAuUbYnreufCulhywtfaw
         jb9YVYbSF22HW2wlnhdhU5shVSllG4LNQ4EXqTqp5dKWwLx3iIyjFFTrv3SeJK435F33
         vjVQGsp/wsK66+NWMfrdbllzXkahuOAygUec6WCKQldtpE/bztPPKf8sH6kDmN/RnVeY
         1OkeUnu+gu9IHgoi5d63iH5VsfrOyNRLdpN9dUGWN0nwKHC8qEd5TDfoQw4I8vx1T7nl
         CSeWpbPG0bMfQuUmwgFSWCQ1BJ4CujloKjudS2NlX5QAzVqK3bcv9DsbvXSk6U5S3KnK
         d2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=B5CQqTlaK7aGvEru8YysOZ0wmH1O/yOpi0IVYGKKQwU=;
        b=LDh/PXQkIXoFnB8Q0oNjSCx0xmWOq95X/bVMkU8S0NzQFin2TOoJVpfIbsBySgrIjv
         g+El9LnnYeOAsyNLM6FQpETHJT3psB8f3bbQ57qSUnZuxoyaGJacKh1u6/6GniVZI1D/
         0XOHgQxF4fUmbewGhWDEd6hTuqIh9Mnlra2DHY6KYthsoNkJ9OI1Ii7+0hsMcgwaTRUq
         iUxXgDu+IIopCcbPTEmw5PmMWbVrSHRS1t0pbGdPQ2JvvTkl7ugPTUZv18/MrVCtEjS+
         0dimSDo3XoyYi8LkvjRfn8reQdX1lNlIcfyBeJX/B9dosNeQfe72hRrLr0rpHrrEjYDp
         NG2Q==
X-Gm-Message-State: AOAM533trwk/VNZ7Dd0f838ffzyjBmQ+2y+Hk2lgriWkN+ggZdeYvnUZ
        YyBuaXukDwDlzgjwL9kdBsw=
X-Google-Smtp-Source: ABdhPJyPyorR8oQMIbRBMeV0T/NjOTqXTM9SGtOGvzpfrMEwDVd5Bx86JdOrMocRvfBnhIrVSO3hYQ==
X-Received: by 2002:a17:907:9612:: with SMTP id gb18mr3321339ejc.408.1620291399215;
        Thu, 06 May 2021 01:56:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y2sm948415ejg.123.2021.05.06.01.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 01:56:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sparse-index.c: don't call prepare_repo_settings()
 twice in a row
Date:   Thu, 06 May 2021 10:49:59 +0200
References: <cover-0.2-00000000000-20210505T121028Z-avarab@gmail.com>
 <patch-2.2-8bca02efcee-20210505T121028Z-avarab@gmail.com>
 <7954338a-bb44-1345-61b6-787782063c3c@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <7954338a-bb44-1345-61b6-787782063c3c@gmail.com>
Message-ID: <87v97wuto9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 05 2021, Derrick Stolee wrote:

> On 5/5/2021 8:11 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change code added in 58300f47432 (sparse-index: add index.sparse
>> config option, 2021-03-30) to only call prepare_repo_settings()
>> once. We know that our own set_sparse_index_config() has just finished
>> calling it, so we don't need to call it if we're acting on "test_env".
>
> I'm not sure about the value here. prepare_repo_settings() returns
> quickly if the settings have already been prepared, so a second call
> is negligible in cost.

I changed that while I was at it to make it easier to read, it's not an
optimization. I.e. one wonders what the side-effect is of calling
prepare_repo_settings() twice, discovers there isn't one...

>> @@ -133,11 +133,12 @@ int convert_to_sparse(struct index_state *istate)
>>  	test_env =3D git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
>>  	if (test_env >=3D 0)
>>  		set_sparse_index_config(istate->repo, test_env);
>> +	else
>> +		prepare_repo_settings(istate->repo);
>
> The change presented here to either call set_sparse_index_config()
> _or_ prepare_repo_settings() seems like it knows too much about
> how set_sparse_index_config() works.

It seems reasonable to assume that a function to set config has
initialized (or died, if it couldn't) enough of our config state to do
its job.

Besides, it's a few lines above the changed code in the same file.=20

But looking at this again 2/3 callers of set_sparse_index_config()
aren't checking the return value. Wouldn't something like [1] on top be
a good idea here?

Also, is GIT_TEST_SPARSE_INDEX=3Dtrue itself supposed to work? Running the
test suite with it fails 3 test files for me, all /sparse/, i.e. tests
that (presumably) assume it's not already turned on by this code.

1.=20

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a4bdd7c4940..bea1e7dd00e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -280,8 +280,9 @@ static int set_config(enum sparse_checkout_mode mode)
 				      "core.sparseCheckoutCone",
 				      mode =3D=3D MODE_CONE_PATTERNS ? "true" : NULL);
=20
-	if (mode =3D=3D MODE_NO_PATTERNS)
-		set_sparse_index_config(the_repository, 0);
+	if (mode =3D=3D MODE_NO_PATTERNS &&
+	    set_sparse_index_config(the_repository, 0) < 0)
+		die(_("could not set index.sparse=3D0"));
=20
 	return 0;
 }
diff --git a/sparse-index.c b/sparse-index.c
index 5bad05de645..3938bcec962 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -131,10 +131,13 @@ int convert_to_sparse(struct index_state *istate)
 	 * index.sparse config variable to be on.
 	 */
 	test_env =3D git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
-	if (test_env >=3D 0)
-		set_sparse_index_config(istate->repo, test_env);
-	else
+	if (test_env >=3D 0) {
+		if (set_sparse_index_config(istate->repo, test_env) < 0)
+			die(_("could not set index.sparse based on GIT_TEST_SPARSE_INDEX=3D%d"),
+			    test_env);
+	} else {
 		prepare_repo_settings(istate->repo);
+	}
=20
 	/*
 	 * Only convert to sparse if index.sparse is set.
