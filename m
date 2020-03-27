Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC2EC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70E22071B
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="InfqlU/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgC0SEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:04:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53756 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0SEi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 14:04:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97747535EB;
        Fri, 27 Mar 2020 14:04:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=d2xictaAhnCV
        zXCRDubEfxOmMqs=; b=InfqlU/XwYtaWiRj/4B7k9NxJQ3ADst3q0Gc4IutOOz1
        DuRGxuMZsH7u4KAhuNipqxhl/qVice7oUbMcdwoiVx2vJPGAJq/pxS74tY4zR3GG
        y8UfvSu1NQsPWUNQ7J1tF/w0pLqsYOl7cC+YknxFcz6oIAYFYuyJyVDkzRztFnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QEibiQ
        nLYF2bWI3mAPKDWVxhSJh168dAYG3yTPmyRrhwNqZUsulTQ3fiR9L01vDf4chaff
        xVwMVMREMxQQCYEsVAJljrVq2qn6mWIvUuPICjtk2cd3gux75BfD2jp6Pq0Zcp21
        74tShHo6jKyWEL+Tscaud2t5UCwXRfvsjlbqM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87190535E9;
        Fri, 27 Mar 2020 14:04:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1501B535E8;
        Fri, 27 Mar 2020 14:04:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Andr=C3=A1s_Kucsma_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?Q?Andr=C3=A1s?= Kucsma <r0maikx02b@gmail.com>
Subject: Re: [PATCH v3] run-command: trigger PATH lookup properly on Cygwin
References: <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
        <pull.587.v3.git.1585269403947.gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 11:04:35 -0700
In-Reply-To: <pull.587.v3.git.1585269403947.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Andr=C3=A1s?=
        Kucsma via GitGitGadget"'s message of "Fri, 27 Mar 2020 00:36:43
        +0000")
Message-ID: <xmqqeetdhdxo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B2F5E14-7055-11EA-A4A4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andr=C3=A1s Kucsma via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v3] run-command: trigger PATH lookup properly on Cy=
gwin

You phrased it much better than my earlier attempt.  Succinct,
accurate and to the point.  Good.

>  compat/win32/path-utils.h | 11 +++++++++++
>  git-compat-util.h         |  8 ++++++++
>  run-command.c             | 10 +++++-----
>  3 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
> index f2e70872cd2..18eff7899e9 100644
> --- a/compat/win32/path-utils.h
> +++ b/compat/win32/path-utils.h
> @@ -20,6 +20,17 @@ static inline char *win32_find_last_dir_sep(const ch=
ar *path)
>  	return ret;
>  }
>  #define find_last_dir_sep win32_find_last_dir_sep
> +static inline int win32_has_dir_sep(const char *path)
> +{
> +	/*
> +	 * See how long the non-separator part of the given path is, and
> +	 * if and only if it covers the whole path (i.e. path[len] is NULL),

The name of the ASCII character '\0' is NUL, not NULL (I'll fix it
while applying, so no need to resend if you do not have anything
else that needs updating).

Otherwise, the patch looks good.=20

Thanks.
