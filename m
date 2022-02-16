Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E112FC433FE
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 09:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiBPJO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:14:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiBPJO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 04:14:27 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C1D66ADE
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:14:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m17so2710540edc.13
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YxqVW87FfeUUKg0wzuWn65Y3WT/BXIsL9WiJdIjYCTc=;
        b=fhAlYpcle7xExUHf1Clw/418ANHeRiZrXaNco/44GMVoyGbEKZfcyPzS9yI2e8pDlR
         OMuZLJu6c/2sA8Xu18WfBzhNcvH/qmnpmreROGHkQbhJVIDsXCjwDVvLllIiGnKyYKHX
         /e4GGELXWd/YoxpAfiYb5eMsdsYuoAg/XLrpV7b4I7uTA5C/2tY8SLa9mmUnw8Et0obB
         O/RgdtpNIva7FkhitsQKltHxtB81Pcp/t3KgdZzzY/6ww5/E9FXwa7/GnIbWS4pMFJ5v
         YiFjyUvwnILt++Hq3/GIdKYkOGALT+chgHYJZSzZPkjegxqTL+ApOSlqzqem5cRPVqP6
         IERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YxqVW87FfeUUKg0wzuWn65Y3WT/BXIsL9WiJdIjYCTc=;
        b=WLdhZbSDEjKGeViBAv0ATUnpCaiFrIu/D1yn5gDJKM5kAUFxm/TXxY9Aakjs68n+dH
         WibPt4o5hlhCw4PoQ4aXo+GKreF9/50ZW/1IkLIH4nM74HbOf+q1Fs6/lGrI0jVEUaUw
         rwB74vVD7PfAWrn5XWXWIIyNv9Esi6teZoijL8nFIGMB4ef+xtSxrlYU4QjmuIZ2ECZ8
         TJSCllMplSQ0R4kfdPAvpbpoIX51AK/510vSrUFB75/6wpdSkKm2wMX73FFpiGrYEidl
         THSjQriBw1UZPynmSdh9bOBUkObdcMHuO90hsppXTypfR+DeBLTt04mem7bUlwbT4c3O
         ZmPg==
X-Gm-Message-State: AOAM532AYkPP4sxW0OfOLPc4wcXkCqeiZCt1OJEnZi1D0SGyrzRKlYE1
        /HotKZIo4b5BcmXb7EyFox4t3F7lmI0eFw==
X-Google-Smtp-Source: ABdhPJw+eoD6TR64dRRxkWPuQWMWyDWxyfh1O8EUziy3umoEhcynb/c2qPENBhe+LxEZqoIG9W1lhQ==
X-Received: by 2002:a05:6402:5191:b0:40f:b9e0:4d1b with SMTP id q17-20020a056402519100b0040fb9e04d1bmr1921402edd.149.1645002852594;
        Wed, 16 Feb 2022 01:14:12 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f17sm3437901ejl.36.2022.02.16.01.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 01:14:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKGO3-0038qF-F0;
        Wed, 16 Feb 2022 10:14:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/5] repo_read_index: clear SKIP_WORKTREE bit from
 files present in worktree
Date:   Wed, 16 Feb 2022 09:57:54 +0100
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
 <11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com>
Message-ID: <220216.86o837uqak.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> [...]
>  	# Set up a strange condition of having a file edit
> -	# outside of the sparse-checkout cone. This is just
> -	# to verify that sparse-checkout and sparse-index
> -	# behave the same in this case.
> +	# outside of the sparse-checkout cone. We want to verify
> +	# that all modes handle this the same, and detect the
> +	# modification.
>  	write_script edit-content <<-\EOF &&
> -	mkdir folder1 &&
> +	mkdir -p folder1 &&
>  	echo content >>folder1/a
>  	EOF
> -	run_on_sparse ../edit-content &&
> +	run_on_all ../edit-content &&

The end-state of this series will pass its tests with this on top, only
the last "mkdir -p" you added for the ls-files test seems to do
anything:

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2a04b532f91..160c119e17d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -639,7 +639,7 @@ test_expect_success 'update-index modify outside sparse definition' '
 	# condition in which a `skip-worktree` enabled, outside-of-cone file
 	# exists on disk. It is used here to ensure `update-index` is stable
 	# and behaves predictably if such a condition occurs.
-	run_on_sparse mkdir -p folder1 &&
+	run_on_sparse mkdir folder1 &&
 	run_on_sparse cp ../initial-repo/folder1/a folder1/a &&
 	run_on_all ../edit-contents folder1/a &&
 
@@ -665,7 +665,7 @@ test_expect_success 'update-index --add outside sparse definition' '
 	EOF
 
 	# Create folder1, add new file
-	run_on_sparse mkdir -p folder1 &&
+	run_on_sparse mkdir folder1 &&
 	run_on_all ../edit-contents folder1/b &&
 
 	# The *untracked* out-of-cone file is added to the index because it does
@@ -949,7 +949,7 @@ test_expect_success 'checkout-index outside sparse definition' '
 
 	run_on_sparse rm -rf folder1 &&
 	echo test >new-a &&
-	run_on_sparse mkdir -p folder1 &&
+	run_on_sparse mkdir folder1 &&
 	run_on_all cp ../new-a folder1/a &&
 
 	test_all_match test_must_fail git checkout-index --ignore-skip-worktree-bits -- folder1/a &&
@@ -996,7 +996,7 @@ test_expect_success 'clean' '
 	test_all_match git commit -m "ignore bogus files" &&
 
 	run_on_sparse mkdir folder1 &&
-	run_on_all mkdir -p deep/untracked-deep &&
+	run_on_all mkdir deep/untracked-deep &&
 	run_on_all touch folder1/bogus &&
 	run_on_all touch folder1/untracked &&
 	run_on_all touch deep/untracked-deep/bogus &&

A bit nit-y I guess, but I do think tests are much easier to follow when
it's clear when we're doing initial setup v.s. using already set-up
data. In this case 

More importantnly I think between this and 19a0acc83e4 (t1092: test
interesting sparse-checkout scenarios, 2021-01-23) that introduced this
pattern there's a large foot-gun being left in place here by using these
"run_on_all" and "run_on_sparse" helpers to run POSIX tooling, as
opposed to git itself.

Utilities like "mv", "rm", "mkdir" etc. are differently chatty between
platform, and this helper captures their stdout/stderr for a later
test_cmp.

Now, I think actually there isn't a bug *now* because we clobber the
output, and seem to only call test_all_match() and other test_cmp
helpers right after we've run "git", not these POSIX utilities.

But since all we want in those cases is just a "run these commands in
these N dirs" it would be good to split up the helper.


