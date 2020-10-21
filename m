Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBCCC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4094320678
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D9ixYDMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506823AbgJUWeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:34:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53432 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387512AbgJUWen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:34:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3201E104BA6;
        Wed, 21 Oct 2020 18:34:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cDTfVSt6nEGFoBZiP+/vvoLMP6o=; b=D9ixYD
        MHkrgvn9SPphGxOsF/5Z3xGuFRyMNfBwXv5hFl8biK8CG8eZb8fsp4jWYvVnrlYH
        Nisy1vEdTOTHgB/6X4I2x6oqpiHxVevG4K+tcjVSG4whkD88xt4diVBkWLsNZlz0
        Dunet6cHv7zA4vH+ATmrGbcvfBd+itpQY9XOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A7iBhmPg6MJdrc9x4ixGjIhnqTwGLVlu
        RQmpveXDO3QZwBFBFhPo2/CJIbx+oiHssMtbny50f4YNhtKUF32XjivAEgPwDnGB
        B1duVokhOg0MXW9QqLk52vTmtlTUx21iUpz+3a7iHNZhBTwnDVCBvnBqv9yPyvi1
        Yfezx+XdJjE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A4C6104BA5;
        Wed, 21 Oct 2020 18:34:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68BF5104BA0;
        Wed, 21 Oct 2020 18:34:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 06/10] t5703: adjust a test case for the upcoming
 default branch name
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <0d2511d18fb2908b1049afe4da7494f6ed7e26e8.1603135903.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 15:34:35 -0700
In-Reply-To: <0d2511d18fb2908b1049afe4da7494f6ed7e26e8.1603135903.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 19 Oct 2020
        19:31:37 +0000")
Message-ID: <xmqqlffz439g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99DB9368-13ED-11EB-A2E5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We want to rename the default branch name used by `git init` in the near
> future, using `main` as the new name.
>
> In preparation for that, we adjust a test case that wants to rename the
> default branch to a different name that however has the same length. We
> use `none` as that name because it matches the length of `main`.

The original chose word that not only is the same length but is
similarly spell (master vs raster).  Perhaps mirroring that
arrangement and picking 'rain' would have been even a better taste,
but this is good enough ;-)

The test pieces in this script seem to be arranged to be mostly
independent from each other, and especially because this one is at
the end of the script, making it run only when 'main' is in use,
and skipping otherwise, would not hurt anybody else.  We just need
to make sure that nobody adds new tests after this one that may be
affected by the allowRefInWant configuration setting.

Looking good.

Thanks.

> -test_expect_success 'server loses a ref - ref in want' '
> +test_expect_success PREPARE_FOR_MAIN_BRANCH 'server loses a ref - ref in want' '
>  	git -C "$REPO" config uploadpack.allowRefInWant true &&
>  	rm -rf local &&
>  	cp -r "$LOCAL_PRISTINE" local &&
> -	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
> +	echo "s/main/none/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
>  	test_must_fail git -C local fetch 2>err &&
>  
> -	test_i18ngrep "fatal: remote error: unknown ref refs/heads/raster" err
> +	test_i18ngrep "fatal: remote error: unknown ref refs/heads/none" err
>  '
>  
>  # DO NOT add non-httpd-specific tests here, because the last part of this
