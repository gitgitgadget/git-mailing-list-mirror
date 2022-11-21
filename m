Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058C9C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 06:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiKUGCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 01:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUGCf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 01:02:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0466FF02
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 22:02:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id k5so9519022pjo.5
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 22:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+QW6ZG/dQg+HlVyL76Qu1pFXutOZe6kyI2LmK8yfkA=;
        b=Y3eh6teiY0RmG44/9FfAGeicc9ukXhb3vo0QmW39A5CJKMOo3LeA6gBv9fsKpB1Xeu
         18+oBT7jr8fpHIyVDwB/V9iXK2Tsd57gG/3WE5cOoOthlNZz5l/7DWaBBOMbezKAp4TW
         EDVR6Bi2I/+9NoP3qu3hp/35LJKoSUAeW7NhIYUeg/e+y6ciH7U6i2qEbA2ne4Ose0Dx
         f4Nc9c1is8VpTv6X2MSbpqbuaetHEW7sdk3WnT6QU3TNOT9cpMFJyYf8nETQbfLgsrUC
         365x/Pj7DMI40G08/FYknu6HWbS8T6rqbzSvNo2b4A3Iw/LwgU3eeiSTUrjOlP69ivp+
         rY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+QW6ZG/dQg+HlVyL76Qu1pFXutOZe6kyI2LmK8yfkA=;
        b=k8DmyJHsc2cMfYYd2/0AGLx31OA98F7HA3bXG2bLebeX9EeBHtYhJXSmCUxzn9AW9V
         dRN9eY3gRKzM84fSkrfxUvibUvAYmjqr96ne8vJT6OTSWDcE4iGCkD21XITCi1trlZbu
         ExjhOCO+5D21wxp9f0++ZhlyZHb5v+VVc4GS6dyoJx7wRBMfUqUaG0IwjM3Cd3j6oht0
         uNhLJtXUr8eqIMFTfVF/XBqMtM2VvuCC35CN9lRFAG2Yhho8jia/ZH8R+pBNp2HLqGUe
         IGBk17NmaMy6ixOU3L0k8j4aErvPT4bpUQTJd+gIeDIvyUZscIpkblqsMI+0oFgTbJfu
         eorg==
X-Gm-Message-State: ANoB5pmQ/ql9Sq4wC3hMHb680nHuj+RnYXBn+tFaNuTvpc88xTcNTElf
        LyVXzOcj4I2wiRryjaqb5CxBaB3wOFiDZw==
X-Google-Smtp-Source: AA0mqf4AikVDUsY/MyaG4ssuDdDb4KOki92yglvN64515kvDMoisWwXR1PBperFsonyuT/Gwpf0BSQ==
X-Received: by 2002:a17:902:f813:b0:17f:8011:dd03 with SMTP id ix19-20020a170902f81300b0017f8011dd03mr1519374plb.59.1669010552361;
        Sun, 20 Nov 2022 22:02:32 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q27-20020aa7983b000000b0056246403534sm7659039pfl.88.2022.11.20.22.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 22:02:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] prune: quiet ENOENT on missing directories
References: <20221119201213.2398081-1-e@80x24.org>
Date:   Mon, 21 Nov 2022 15:02:31 +0900
In-Reply-To: <20221119201213.2398081-1-e@80x24.org> (Eric Wong's message of
        "Sat, 19 Nov 2022 20:12:13 +0000")
Message-ID: <xmqq5yf8yhe0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> $GIT_DIR/objects/pack may be removed to save inodes in shared
> repositories.  Quiet down prune in cases where either
> $GIT_DIR/objects or $GIT_DIR/objects/pack is non-existent,

Wouldn't setup.c::is_git_directory() say "nope, you do not have a
repository there" if you are missing $GIT_DIR/objects?  So I suspect
that the only case this matters in practice is a missing pack/
subdirectory.

I agree that silently ignoring missing objects/pack/ is perfectly
fine, whether we auto-vivify it when we actually create a pack.

> but emit the system error in other cases to help users diagnose
> permissions problems or resource constraints.

OK.

> @@ -127,7 +127,9 @@ static void remove_temporary_files(const char *path)
>  
>  	dir = opendir(path);
>  	if (!dir) {
> -		fprintf(stderr, "Unable to open directory %s\n", path);
> +		if (errno != ENOENT)
> +			fprintf(stderr, "Unable to open directory %s: %s\n",
> +				path, strerror(errno));
>  		return;
>  	}

This is called twice, with $GIT_OBJECT_DIRECTORY and its pack
subdirectory, as it does not recurse.  

This is a tangent, I have to wonder how effective the first call
would be, though.  When writing a loose object file, we compute its
object name first in-core and determine the final filename, create a
temporary file in the same directory as the final file, write into
it and then finally rename the temporary to the final name.  The
fan-out $GIT_OBJECT_DIRECTORY/??/ directories may have temporary
files left when such a process crashed, but do we create cruft "git
prune" should remove in $GIT_OBJECT_DIRECTORY/ itself?

> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index 8ae314af58..d65a5f94b4 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -29,6 +29,14 @@ test_expect_success setup '
>  	git gc
>  '
>  
> +test_expect_success 'bare repo prune is quiet without $GIT_DIR/objects/pack' '
> +	git clone -q --shared --template= --bare . bare.git &&
> +	rmdir bare.git/objects/pack &&
> +	git --git-dir=bare.git prune --no-progress 2>prune.err &&
> +	test_must_be_empty prune.err &&
> +	rm -r bare.git prune.err
> +'
> +
>  test_expect_success 'prune stale packs' '
>  	orig_pack=$(echo .git/objects/pack/*.pack) &&
>  	>.git/objects/tmp_1.pack &&
