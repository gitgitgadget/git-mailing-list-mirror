Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23659C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE83205ED
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a2AAfpos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgCXUvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:51:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59794 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgCXUvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 16:51:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D9014B74B;
        Tue, 24 Mar 2020 16:51:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O2ODJPXPvyuu
        QJFSvAN1oOuMp4o=; b=a2AAfposcDxe6vDouTozvTxE7dYC+Ok1MYn7tTuFsq5X
        9LyxB92RWPUhjrGMduKUF4TBw8zy7wU906LF4D3uZ+y5yuBc0ETGi1qCw20ODDmy
        tvjsx392F1HxMoQ+kkuaxrgpX62LYAHjmirUDDTBGRSIMi6y18RTR6iwTmgR6I4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CMwfGB
        S0HbvW98Mq9RXlf35O9TaYlED27CJV4+0juQt3zVIECTMQabaPPUGvU5xILZ2k6g
        idkoUl7CDdYbvTnsp9NKWL386lfAjnG7v4r+x2cvdHa+iP/raLouSxwe3/cSSjAx
        mk9IOIxld0ZDYQL9MJYqDvEmG4pZ9t9BEGqtU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 330124B74A;
        Tue, 24 Mar 2020 16:51:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7D184B748;
        Tue, 24 Mar 2020 16:51:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Andr=C3=A1s_Kucsma_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Andr=C3=A1s?= Kucsma <r0maikx02b@gmail.com>
Subject: Re: [PATCH] Fix dir sep handling of GIT_ASKPASS on Windows
References: <pull.587.git.1584997990694.gitgitgadget@gmail.com>
Date:   Tue, 24 Mar 2020 13:51:17 -0700
In-Reply-To: <pull.587.git.1584997990694.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Andr=C3=A1s?=
        Kucsma via GitGitGadget"'s message of "Mon, 23 Mar 2020 21:13:10
        +0000")
Message-ID: <xmqqlfnp1np6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 355D7DAC-6E11-11EA-8266-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andr=C3=A1s Kucsma via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: Andras Kucsma <r0maikx02b@gmail.com>
>
> On Windows with git installed through cygwin, GIT_ASKPASS failed to run
> for relative and absolute paths containing only backslashes as director=
y
> separators.
>
> The reason was that git assumed that if there are no forward slashes in
> the executable path, it has to search for the executable on the PATH.

Also if I were reading the discussion correctly, there was a doubt
about locate_in_PATH() that may not work on Windows for at least two
reasons.  Is it OK to ignore these issues, and if so why?

I know if you have a full path, a broken locate_in_PATH() would be
skipped and won't cause an immediate issue, but this change to make
the code realize that "a\\b" is not asking to search in %PATH% feels
just a beginning of a fix, not the whole fix, at least to me.

> The fix is to look for OS specific directory separators, not just
> forward slashes.

Yes, but it is quite unfortunate that you would use a function that
has to scan the string to the end because it asks for the last one.

Perhaps introduce=20

--------------------------------------------------
#ifndef has_dir_sep
static inline int git_has_dir_sep(const char *path)
{
	return !!strchr(path, '/');
}
#define has_dir_sep(path) git_has_dir_sep(path)
#endif
--------------------------------------------------

in <git-compat-util.h>, with a replacement definition in
<compat/win32/path-utils.h> that may read

--------------------------------------------------
#define has_dir_sep(path) win32_has_dir_sep(path)
static inline int has_dir_sep(const char *path)
{
        /*=20
         * See how long the non-separator part of the given path is, and
         * if and only if it covers the whole path (i.e. path[len] is NUL=
),
         * there is no separator in the path---otherwise there is a separ=
aptor.
         */
        size_t len =3D strcspn(path, "/\\");
        return !!path[len];
}
--------------------------------------------------

and use that instead?


> diff --git a/run-command.c b/run-command.c
> index f5e1149f9b3..9fcc12ebf9c 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -421,12 +421,12 @@ static int prepare_cmd(struct argv_array *out, co=
nst struct child_process *cmd)
>  	}
> =20
>  	/*
> -	 * If there are no '/' characters in the command then perform a path
> -	 * lookup and use the resolved path as the command to exec.  If there
> -	 * are '/' characters, we have exec attempt to invoke the command
> -	 * directly.
> +	 * If there are no dir separator characters in the command then perfo=
rm
> +	 * a path lookup and use the resolved path as the command to exec. If
> +	 * there are dir separator characters, we have exec attempt to invoke
> +	 * the command directly.
>  	 */
> -	if (!strchr(out->argv[1], '/')) {
> +	if (find_last_dir_sep(out->argv[1]) =3D=3D NULL) {
>  		char *program =3D locate_in_PATH(out->argv[1]);
>  		if (program) {
>  			free((char *)out->argv[1]);
>
> base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
