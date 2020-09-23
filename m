Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E306DC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DF120708
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 17:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZqBiXz3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgIWRri (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 13:47:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52786 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWRri (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 13:47:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A51BF1070B0;
        Wed, 23 Sep 2020 13:47:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qzFwI+dV1eZOEPZJEglR6ceHyDo=; b=ZqBiXz
        3wk0GMly0KMe1MgoRhkyWmNDJq2icleYIUzNt8Cr62LY7Q4xNnuzuQTGAIplKEwV
        gzQkp9vkyxrz3srkR+d706y/NLEkDDvZ7JKEt+Merb8+obaBqNNM8Sp6pu3UbU1n
        6dT65+IvCPTxGpGuSei6tz18dwvdn1bmxvRc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B3uSm5ddJTpF5b/sakWc03uEHhOK7fnm
        UyqQRdEdCOTyzaNPrR+bvgqEpoEt2jTdDSteq9ArFz7Xn/wr5FhCLq+He9ifCGNL
        ybiJU0V8Uo994hDp/FIV3Z3epHNBUt1HgY+F2qxI/kvDeFIv/qlMwKvXoRlZKH5T
        zgD8fmxh/rE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E6CB1070AF;
        Wed, 23 Sep 2020 13:47:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D8AE21070AC;
        Wed, 23 Sep 2020 13:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: ignore generated files
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
Date:   Wed, 23 Sep 2020 10:47:32 -0700
In-Reply-To: <pull.735.git.1600375065498.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 17 Sep 2020 20:37:45
        +0000")
Message-ID: <xmqqsgb8idvv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC4344CE-FDC4-11EA-961A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When using CMake to generate the files required to build Git in Visual
> Studio, a bunch of files are generated. We will want to prevent them
> from being tracked in Git.

If we were to go this route, let's

 * update the log message to say that we assume we will use CMake to
   build in-place.

 * update the comment in the top part of the CMakeList.txt that
   suggests it is a possibility to use it from subdirectories.

 * optionally, update the same comment to recommend "clean -xdf"
   as a way to bring the source tree back to the pristine state.

Will queue with a tentative attempt to do the first bullet point to
save one roundtip, something like:

    When using CMake to generate the files required to build Git
    in-place for Visual Studio, ...

Other two points needs help from others (iow, I won't do so myself
right now).

Thanks.
