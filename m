Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A5BC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 16:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiI3Quq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiI3Quo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 12:50:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F017EEB4B
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 09:50:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lh5so10186841ejb.10
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=cBRZPD4j1d0bg2Luqs/eIJZS9H6fEE01TTbhyTYtEak=;
        b=jd2tZkB/UrxG9Yp6UPx5XZrW9Ed1c5LIo69x0JbSjTOhvoKe8wtCWPtlckDrL1vI5l
         H9tJd3Hq5LjyR5uqREjrSXahOH3X7cWmEffHxPqapk5mHRPQhWw8CWxt0ukcNh/UqO78
         smuUvdBYM63UDz0lBhx2DweJJQ6DXAnVPSIpHV4M/Jq9fw6Zh/Mno41+uI18iJHH/k71
         G6G+/5v/K/xLjxDB7OVKuyV39NB9D1i9Jov9kB+h7fKrOhp5AtExbD+dD1wOWC5lIZCy
         RJCvWLdRO8y9lBT/PntwevWCZOaQ5K9qiwMeHBA7u3dhanHqEmK5llGHGOA+QILZwRn4
         VJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=cBRZPD4j1d0bg2Luqs/eIJZS9H6fEE01TTbhyTYtEak=;
        b=0b08W8DdvZwFvh8jhibM7skJhLrmwl/PNsKyKU00bNuO/LW9m9LCeqcKNGqIWwxPOC
         UjmStvJnTD5Qu5nRMnlki+GAnE55oMDLZ6jt4ss7jp5pXZOa73/JlSf3ghQv+NCr1EVM
         FVkxdsRokXGetiVqHl4+Qhz5ys0C758Es+DvzKR5NExaNF3TFvwcz0sNIndnnBI1t/JD
         Mz6KR9k0gZIXECv/xQvr/VhL/hKT7SCapKdk3/nCou5iqHx5VorelOn+WC85TSLhUgNQ
         CXKMiEHCvf05Bl89oxks+BW7dm9oFylMtvzImkB3NbtzgvnJanoiE6aUcH7VAb/VJPlm
         7Awg==
X-Gm-Message-State: ACrzQf2pnQypzwZ1Oc2RH3MLU7zGIIw9hqrjsmvqptMTevoox2cSEKfw
        wbCTqhq239iGJx5qCvDGIVw2/DXxNw0cDw==
X-Google-Smtp-Source: AMsMyM67uXD+T1Y8W0XXx4xjBXNjgdWfASITf+dWbXhvYAaGMvNqEPqEyvVebQsn9TC+kCAymf6A+w==
X-Received: by 2002:a17:907:2cce:b0:77a:6958:5aaa with SMTP id hg14-20020a1709072cce00b0077a69585aaamr6926392ejc.245.1664556642813;
        Fri, 30 Sep 2022 09:50:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7c90b000000b004585eba4baesm1957490edt.80.2022.09.30.09.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:50:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oeJDl-001loJ-00;
        Fri, 30 Sep 2022 18:50:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] t3404-rebase-interactive: mark a test with REFFILES
 prereq
Date:   Fri, 30 Sep 2022 18:46:49 +0200
References: <20220930140948.80367-1-szeder.dev@gmail.com>
 <20220930140948.80367-3-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20220930140948.80367-3-szeder.dev@gmail.com>
Message-ID: <220930.86ill4vman.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 30 2022, SZEDER G=C3=A1bor wrote:

> The test '--update-refs: check failed ref update' added in b3b1a21d1a
> (sequencer: rewrite update-refs as user edits todo list, 2022-07-19)
> directly modifies the contents of a ref file, so mark this test with
> the REFFILES prereq.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 688b01e3eb..7f0df58628 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1964,7 +1964,7 @@ test_expect_success 'respect user edits to update-r=
ef steps' '
>  	test_cmp_rev HEAD refs/heads/no-conflict-branch
>  '
>=20=20
> -test_expect_success '--update-refs: check failed ref update' '
> +test_expect_success REFFILES '--update-refs: check failed ref update' '
>  	git checkout -B update-refs-error no-conflict-branch &&
>  	git branch -f base HEAD~4 &&
>  	git branch -f first HEAD~3 &&

We had various tests that depended on .git/refs/* for a good reason, and
some that didn't.

I may be missing something, but in this case this seems to be a "no good
reason" case. I.e. the fix seems to just be:

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 688b01e3eb6..f1c021a7f7b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1994,8 +1994,9 @@ test_expect_success '--update-refs: check failed ref =
update' '
 	# At this point, the values of first, second, and third are
 	# recorded in the update-refs file. We will force-update the
 	# "second" ref, but "git branch -f" will not work because of
-	# the lock in the update-refs file.
-	git rev-parse third >.git/refs/heads/second &&
+	# the lock in the update-refs file, so we need to use
+	# "update-ref".
+	git update-ref refs/heads/second third &&
=20
 	test_must_fail git rebase --continue 2>err &&
 	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&

As the comment notes if you try that with "git branch" you'll get an
error, even with --force, but update-ref works just fine...
