Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A3AC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86B66101C
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhIVAAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 20:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhIVAAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 20:00:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD949C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:58:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g8so2830132edt.7
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cpvqqVIkXjnA74gyvMeqyft/rZkUiaTFzefnhBxJcVU=;
        b=LKvvlWQPGpbppbtNtsEph4pmbUrYPUZGeDjIlzWJCcIzoa3T2xkUoYv7hQFWRxfzDL
         MhjTs9mQyLsbCboeOBflgujZ7nBzBi3gMf3oJzSZcZkAMAijMBEfGmjmOK9FX9q7PFX4
         n/AeUHz8YBmwSj7irBOP8q179KIbJDl97M3hhmzzSmNM0XW2cSctoZ/9Rl893hwvpMYg
         7f5j5IdnreyGYOd2Bm57Y4tOQ8qorOwPdZXT7jdUYEtiQUPSX+k5UydkXFx/kOHZT5ek
         qcoMRUaylrXzrCbHccLfPoVCq+n1pB8mClAAVrl80Z14qvuUQ1KEC7Iy3M7ebNjVWAuv
         zSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cpvqqVIkXjnA74gyvMeqyft/rZkUiaTFzefnhBxJcVU=;
        b=BTgHGNy/zpufog/UMYUdJBaAJ/UvrwRd++p56LGwlYwQYzDvt8c7/cZ6J3TIqJaLEt
         DvGUQugFluqxGHNdwY9twqPJbhHh4zfvgMzfQLZLEQuRSTou2C0SaeHnocr0fD29hqwh
         Al7TBnToNuAUfdbFE6z0L6mCusuHwn7j4z1dafaBBKjVwQTAyL16x3KdoLPywJBrYOeZ
         Y9X7l09O8mHJibN970Z8V/08XsV4mJiFsAH1MxhQeGKmccPjAFgZyblM2Q9HQvMeRUsd
         AwCFWLOQjaFctYU/n8lvJ0HyKdMliwN0Lx6fE/2Nsy2aKtOXC+89PRKiLU/Sx+Mk62EG
         spLA==
X-Gm-Message-State: AOAM530taycpy7Zma0oFAqzE/S/ssO6JgI73XpHVORlz9Oo0SVPoGTzD
        pzmHBMb7tFp7icMrOHpw63YwXVmeLTCXGw==
X-Google-Smtp-Source: ABdhPJzAnRm3kjDKMpqHXQtqD4HxHU5hjK6BxCYonryrz71zTFmLtxy9AbJ6JQ9Osb2bML41UFKQ7Q==
X-Received: by 2002:aa7:cdc8:: with SMTP id h8mr39222166edw.272.1632268715123;
        Tue, 21 Sep 2021 16:58:35 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x7sm190138ede.86.2021.09.21.16.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 16:58:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 5/6] core.fsyncobjectfiles: tests for batch mode
Date:   Wed, 22 Sep 2021 01:54:16 +0200
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
 <afb0028e79648c1f7be8d77df5c6d675bd27d983.1632176111.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <afb0028e79648c1f7be8d77df5c6d675bd27d983.1632176111.git.gitgitgadget@gmail.com>
Message-ID: <87a6k58or9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Add test cases to exercise batch mode for 'git add'
> and 'git stash'. These tests ensure that the added
> data winds up in the object database.
>
> I verified the tests by introducing an incorrect rename
> in do_sync_and_rename.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  t/lib-unique-files.sh | 34 ++++++++++++++++++++++++++++++++++
>  t/t3700-add.sh        | 11 +++++++++++
>  t/t3903-stash.sh      | 14 ++++++++++++++
>  3 files changed, 59 insertions(+)
>  create mode 100644 t/lib-unique-files.sh
>
> diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
> new file mode 100644
> index 00000000000..a8a25eba61d
> --- /dev/null
> +++ b/t/lib-unique-files.sh
> @@ -0,0 +1,34 @@
> +# Helper to create files with unique contents
> +
> +test_create_unique_files_base__=$(date -u)
> +test_create_unique_files_counter__=0
> +
> +# Create multiple files with unique contents. Takes the number of
> +# directories, the number of files in each directory, and the base
> +# directory.
> +#
> +# test_create_unique_files 2 3 . -- Creates 2 directories with 3 files
> +#				    each in the specified directory, all
> +#				    with unique contents.
> +
> +test_create_unique_files() {
> +	test "$#" -ne 3 && BUG "3 param"
> +
> +	local dirs=$1
> +	local files=$2
> +	local basedir=$3
> +
> +	rm -rf $basedir >/dev/null

Why the >/dev/null? It's not a "-rfv", and any errors would go to
stderr.

> +		mkdir -p "$dir" > /dev/null

Ditto.

> +		for j in $(test_seq $files)
> +		do
> +			test_create_unique_files_counter__=$((test_create_unique_files_counter__ + 1))
> +			echo "$test_create_unique_files_base__.$test_create_unique_files_counter__"  >"$dir/file$j.txt"

Would be much more readable if we these variables were shorter.

But actually, why are we trying to create files as a function of "date
-u" at all? This is all in the trash directory, which is rm -rf'd beween
runs, why aren't names created with test_seq or whatever OK? I.e. just
1.txt, 2.txt....

> +test_expect_success 'stash with core.fsyncobjectfiles=batch' "
> +	test_create_unique_files 2 4 fsync-files &&
> +	git -c core.fsyncobjectfiles=batch stash push -u -- ./fsync-files/ &&
> +	rm -f fsynced_files &&
> +
> +	# The files were untracked, so use the third parent,
> +	# which contains the untracked files
> +	git ls-tree -r stash^3 -- ./fsync-files/ > fsynced_files &&
> +	test_line_count = 8 fsynced_files &&
> +	cat fsynced_files | awk '{print \$3}' | xargs -n1 git cat-file -e
> +"
> +
> +
>  test_expect_success 'stash -c stash.useBuiltin=false warning ' '
>  	expected="stash.useBuiltin support has been removed" &&

We really prefer our tests to create the same data each time if
possible, but as noted with the "date -u" comment above you're
explicitly bypassing that, but I still can't see why...
