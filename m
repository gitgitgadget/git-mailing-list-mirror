Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31011C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 21:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbhKVVHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:07:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60854 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhKVVH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 16:07:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F643F521C;
        Mon, 22 Nov 2021 16:04:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AjoaUC1mvNaR
        uliKyOZ2GAbiLTMng7GjsY9vYrHzGo0=; b=BqGxQfrlG+HE7AfnYZzbtc+RV4LZ
        Fu7eFoQIAPCOoU8DheXLNcqSyraxuRmfvh7yM8Kelkj/X4Mnq5bSqHKj4Zl+CYNX
        lNEZsyrQUrXVfaCsHhdLq9M08TZkk1DNaqPSPEVwfO8Wx7JWZxgDwVmCBweA6hIv
        u+sMQ4TBQth33L4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 669D5F521B;
        Mon, 22 Nov 2021 16:04:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF43BF5219;
        Mon, 22 Nov 2021 16:04:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 1/5] archive-tar: use our own cmd.buf in error message
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
        <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
        <patch-1.5-1d8cab554bb-20211122T153605Z-avarab@gmail.com>
Date:   Mon, 22 Nov 2021 13:04:20 -0800
In-Reply-To: <patch-1.5-1d8cab554bb-20211122T153605Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 22 Nov
 2021 17:04:03 +0100")
Message-ID: <xmqqr1b7ewbv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C3E11C00-4BD7-11EC-A82A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use the "cmd.buf" we just created in this function, instead of the
> argv[0], which we assigned "cmd.buf" for. This is in preparation for
> getting rid of the use of "argv" in this function.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  archive-tar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index 05d2455870d..4154d9a0953 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -447,7 +447,7 @@ static int write_tar_filter_archive(const struct ar=
chiver *ar,
>  	filter.in =3D -1;
> =20
>  	if (start_command(&filter) < 0)
> -		die_errno(_("unable to start '%s' filter"), argv[0]);
> +		die_errno(_("unable to start '%s' filter"), cmd.buf);
>  	close(1);
>  	if (dup2(filter.in, 1) < 0)
>  		die_errno(_("unable to redirect descriptor"));
> @@ -457,7 +457,7 @@ static int write_tar_filter_archive(const struct ar=
chiver *ar,
> =20
>  	close(1);
>  	if (finish_command(&filter) !=3D 0)
> -		die(_("'%s' filter reported error"), argv[0]);
> +		die(_("'%s' filter reported error"), cmd.buf);
> =20
>  	strbuf_release(&cmd);
>  	return r;

Is this really needed to be a separate step?  If we update this
function to

 - lose local argv[] array;
 - instead use the embedded filter.args

i.e. something like the attached, such a "modern" code that uses
child_process .args would not require further changes when the
run-command API is streamlined by the remainder of the series, no?

IOW, if can arrange this step to be trivially and obviously correct
so that it can go in without fixing any bugs (if exists) in the main
part of the series, and the API update would not require such code
that already uses cp.args not cp.argv, that would be much easier to
grok.  With this "this is half a change in preparation", reviewers
need to keep this promise in their heads that argv[] will be then
removed from the function.

 archive-tar.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git c/archive-tar.c w/archive-tar.c
index 05d2455870..3c74db1746 100644
--- c/archive-tar.c
+++ w/archive-tar.c
@@ -430,7 +430,6 @@ static int write_tar_filter_archive(const struct arch=
iver *ar,
 {
 	struct strbuf cmd =3D STRBUF_INIT;
 	struct child_process filter =3D CHILD_PROCESS_INIT;
-	const char *argv[2];
 	int r;
=20
 	if (!ar->data)
@@ -440,14 +439,12 @@ static int write_tar_filter_archive(const struct ar=
chiver *ar,
 	if (args->compression_level >=3D 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);
=20
-	argv[0] =3D cmd.buf;
-	argv[1] =3D NULL;
-	filter.argv =3D argv;
+	strvec_push(&filter.args, cmd.buf);
 	filter.use_shell =3D 1;
 	filter.in =3D -1;
=20
 	if (start_command(&filter) < 0)
-		die_errno(_("unable to start '%s' filter"), argv[0]);
+		die_errno(_("unable to start '%s' filter"), cmd.buf);
 	close(1);
 	if (dup2(filter.in, 1) < 0)
 		die_errno(_("unable to redirect descriptor"));
@@ -457,7 +454,7 @@ static int write_tar_filter_archive(const struct arch=
iver *ar,
=20
 	close(1);
 	if (finish_command(&filter) !=3D 0)
-		die(_("'%s' filter reported error"), argv[0]);
+		die(_("'%s' filter reported error"), cmd.buf);
=20
 	strbuf_release(&cmd);
 	return r;
