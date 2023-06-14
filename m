Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDA5EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 16:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjFNQOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjFNQOH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 12:14:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB52116
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:14:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3afd2f9bdso28368505ad.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686759245; x=1689351245;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6TcPUIaY4CsoAn2fUnoxIreviv/skTm5eiia/N1IQM=;
        b=jSkIJ6k4ex+yLHteb+91EfSYznne/taknUc1LBHoFwVFMGNrOkTKyUOD/rC6WaXqvI
         H5pFzwuQ02/Ph2DiHhnKKx9r0ALom2GY0Rmt6q8FsjO7PjGmxil8OiSGCTcuSvfVyjcd
         0vY9G1BTnXKraBbkHFTvB5odvxyo5XCjv6dzzKyQ+K02h7fNfO9Si+BPTKq8R5odFwoZ
         OONbAGU+nPzC88iyHhJU4NxiC8p7ax2PKbBflHbiaq6Ib/pnsrnLci4bBj+0UQ+8Pysw
         sNbibxnxZH70AypWWkVX9kMJ0F+ahVzd13vxAT9aRsanrdZfLu7ESck5KSzZ/Q3zCV8U
         NGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686759245; x=1689351245;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H6TcPUIaY4CsoAn2fUnoxIreviv/skTm5eiia/N1IQM=;
        b=Xc5WWsi3rqs6NwvuU0phrB17HC0w5swMZ2OpVQ3NgwpK+WAkHjptaRY9RWTQy+syzf
         nrxwakKUMgOQwGZy3F0evc+kxsQ8+GH3a+fGnyW1D1npIeJ1vxQ52QmeJbaDJyRFryKv
         c6HYFla0QcgBz9pmgZ9nCIXoaQKSuqFy602kJe+gznWweHjEhYCZaAlCwVGLGZQOYx88
         /oRGirRm6hhnLYmDvBV5oRFaEYqCTdhdF2DBgQQllHZXb4PUmUAGV1PvgvlYiJEc8x4d
         ezzfswDRxtDQ01PINZrVqnFifPwHTl6MzEzNjGGGFx7L10gHziVg2cWcZiTN6ivGIE1C
         PHLg==
X-Gm-Message-State: AC+VfDx5vm2E4KVEhdd1HtIMak646PskC2GJYgwBMmWNAaoYe6PrcukY
        QWlcBpjKySbopAqOvsvGTGs=
X-Google-Smtp-Source: ACHHUZ7SxNrmnG1dEyZkKUBmnIIyfzTCdnQOoCLAxnPv2XrFBDACnHJ4jOiYHDmHj8pLYtyN8HMBvA==
X-Received: by 2002:a17:902:ab87:b0:1b2:1d98:2511 with SMTP id f7-20020a170902ab8700b001b21d982511mr11054198plr.50.1686759245131;
        Wed, 14 Jun 2023 09:14:05 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id jd4-20020a170903260400b001b3b83b7d4esm7547792plb.211.2023.06.14.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 09:14:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff-lib: honor override_submodule_config flag bit
References: <20230614153142.3138028-1-sokcevic@google.com>
Date:   Wed, 14 Jun 2023 09:14:04 -0700
In-Reply-To: <20230614153142.3138028-1-sokcevic@google.com> (Josip Sokcevic's
        message of "Wed, 14 Jun 2023 08:31:42 -0700")
Message-ID: <xmqqa5x2xbqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josip Sokcevic <sokcevic@google.com> writes:

> +add_submodule_commits_and_validate () {
> +	HASH=$(git rev-parse HEAD) &&
> +	git update-index --add --cacheinfo 160000,$HASH,sub &&
> +	git commit -m "create submodule" &&
> +	git ls-tree HEAD >output &&
> +	test_when_finished "rm -f output" &&
> +	grep "$HASH" output

If ls-tree exits with non-zero status, test_when_finished will not
be seen, and will not arrange output to be removed.  If we are going
to use test_when_finished to remove the file, we should do so before
we do anything that potentially creates the file.

The test with "grep" is overly loose, as I suspect that you won't be
happy to see the $HASH (i.e. the commit object name) just anywhere
in the output, but exactly where you placed it, i.e. at path "sub".

So it may make more sense to do the test like so:

	...
	git commit -m "create" &&

	echo "160000 commit $HASH	sub" >expect &&
	git ls-tree HEAD -- sub >actual &&
	test_cmp expect actual

If we were to add

	test_when_finished "rm -f expect actual" &&

we would do so immediately after "git commit" step, but I personally
do not think it is worth doing in this case.  These two files are
what many if not most of our test pieces use and having them as
untracked files is a norm.  Unless we have a need to have strict
control of what untracked files are in the working tree in later
tests, it is OK to leave these files around.

Other than that, looking much better.

Thanks.

> +}
> +
> +test_expect_success 'commit with staged submodule change' '
> +	add_submodule_commits_and_validate
> +'
> +
> +test_expect_success 'commit with staged submodule change with ignoreSubmodules dirty' '
> +	test_config diff.ignoreSubmodules dirty &&
> +	add_submodule_commits_and_validate
> +'
> +
> +test_expect_success 'commit with staged submodule change with ignoreSubmodules all' '
> +	test_config diff.ignoreSubmodules all &&
> +	add_submodule_commits_and_validate
> +'
> +
>  test_done
