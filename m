Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3EEC001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 04:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjHDEXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 00:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHDEXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 00:23:34 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08DD4200
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 21:23:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41B8D2E9B7;
        Fri,  4 Aug 2023 00:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OqRgT6YQVRQN
        3zNFr4/IX5KL2JucCyZB7s01nkna3E0=; b=gkQ4iuaPQgkenTh38AW3MhujMBpS
        pBbc7ey+2DkBjhlaxQBqyXctVLjVrm1UdSQ7hGkOiIKRn4sL5NuN9f7kkTE04JYv
        R5GoYEVjysUKZlzLHIrfYWWPmMRfXfxvma0kP78O0A1b8u/EINNMrAv6nYGwwJn8
        pRlLwxogF8o3NY4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 399D62E9B6;
        Fri,  4 Aug 2023 00:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 74D562E9B5;
        Fri,  4 Aug 2023 00:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH v2 1/3] run-command: conditionally define locate_in_PATH()
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
        <dc9c0812d203a4eb777659bb54fda60022bf9650.1691122124.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 21:23:28 -0700
In-Reply-To: <dc9c0812d203a4eb777659bb54fda60022bf9650.1691122124.git.gitgitgadget@gmail.com>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Fri, 04
 Aug 2023
        04:08:42 +0000")
Message-ID: <xmqqo7jn3073.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA076124-327E-11EE-850A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthias A=C3=9Fhauer via GitGitGadget"  <gitgitgadget@gmail.com>
writes:

> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>
> This commit doesn't change any behaviour by itself, but allows us to ea=
sily
> define compat replacements for locate_in_PATH(). It prepares us for the=
 next
> commit that adds a native Windows implementation of locate_in_PATH().
>
> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> ---
>  run-command.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/run-command.c b/run-command.c
> index 60c94198664..85fc1507288 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -170,6 +170,7 @@ int is_executable(const char *name)
>  	return st.st_mode & S_IXUSR;
>  }
> =20
> +#ifndef locate_in_PATH
>  /*
>   * Search $PATH for a command.  This emulates the path search that
>   * execvp would perform, without actually executing the command so it

Micronit.  The comment should be shared across different platform
implementations of this interface, so "#ifndef" would want to come
immediately after this comment, not before, I would think.

It does not affect the correctness, of course ;-)

> @@ -218,6 +219,7 @@ static char *locate_in_PATH(const char *file)
>  	strbuf_release(&buf);
>  	return NULL;
>  }
> +#endif
> =20
>  int exists_in_PATH(const char *command)
>  {
