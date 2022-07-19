Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0123C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiGSVV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiGSVV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:21:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242462B242
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:21:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77B9B12734C;
        Tue, 19 Jul 2022 17:21:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C/gb13jYn07g
        Eq19d9i3dxP4+/hPqGpe6+f8+dRVYIo=; b=AWSWmXWJkl//lwPBqC4hdTfnIwev
        X1kPOkd6jJxvtSpy3Gx/J2xDIyzM7riIENCUpN9y6z/6X+RLgvmdrVjAq/0uKCfF
        4/sfD1ebaNGGkeyTcRUR4zgK6k5d0yMKVRByXjCd08lkG87guRdnp0mQR5HYVdRW
        /HZstonunQoit44=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7027312734B;
        Tue, 19 Jul 2022 17:21:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAB4012734A;
        Tue, 19 Jul 2022 17:21:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v2 01/24] submodule--helper: replace memset() with { 0
 }-initialization
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
        <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <patch-v2-01.24-fcdf4a2e2d9-20220719T204458Z-avarab@gmail.com>
Date:   Tue, 19 Jul 2022 14:21:53 -0700
In-Reply-To: <patch-v2-01.24-fcdf4a2e2d9-20220719T204458Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 19 Jul
 2022 22:46:52
        +0200")
Message-ID: <xmqqwnc894su.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0E80BF6-07A8-11ED-9F2E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use the less verbose { 0 }-initialization syntax rather than memset()
> in builtin/submodule--helper.c, this doesn't make a difference in
> terms of behavior, but as we're about to modify adjacent code makes
> this more consistent, and lets us avoid worrying about when the
> memset() happens v.s. a "goto cleanup".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/submodule--helper.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

These four hunks form two pairs of two hunks, one declaring (and in
the new code, initializing) a variable, the other clearing (and in
the new code, there is no need to) the variable.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index fac52ade5e1..73717be957c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1744,7 +1744,7 @@ static int module_clone(int argc, const char **ar=
gv, const char *prefix)
>  {
>  	int dissociate =3D 0, quiet =3D 0, progress =3D 0, require_init =3D 0=
;
>  	struct module_clone_data clone_data =3D MODULE_CLONE_DATA_INIT;
> -	struct list_objects_filter_options filter_options;
> +	struct list_objects_filter_options filter_options =3D { 0 };
> =20
>  	struct option module_clone_options[] =3D {
>  		OPT_STRING(0, "prefix", &clone_data.prefix,
> @@ -1786,7 +1786,6 @@ static int module_clone(int argc, const char **ar=
gv, const char *prefix)
>  		NULL
>  	};
> =20
> -	memset(&filter_options, 0, sizeof(filter_options));
>  	argc =3D parse_options(argc, argv, prefix, module_clone_options,
>  			     git_submodule_helper_usage, 0);
> @@ -2563,7 +2562,7 @@ static int module_update(int argc, const char **a=
rgv, const char *prefix)
>  {
>  	struct pathspec pathspec;
>  	struct update_data opt =3D UPDATE_DATA_INIT;
> -	struct list_objects_filter_options filter_options;
> +	struct list_objects_filter_options filter_options =3D { 0 };
>  	int ret;
> =20
>  	struct option module_update_options[] =3D {
> @@ -2623,7 +2622,6 @@ static int module_update(int argc, const char **a=
rgv, const char *prefix)
>  	update_clone_config_from_gitmodules(&opt.max_jobs);
>  	git_config(git_update_clone_config, &opt.max_jobs);
> =20
> -	memset(&filter_options, 0, sizeof(filter_options));
>  	argc =3D parse_options(argc, argv, prefix, module_update_options,
>  			     git_submodule_helper_usage, 0);

The fact that this patch is harder to read without wider context
tells us that these two changes are good idea.  Absolutely nothing
happens in the first function between the declaration of the
variable and memset() but it is hard to see in a patch because they
are so far apart.  In the second function, some things happen but
they are not using the variable before they get initialized, but
again, it is hard to see in a patch without wider context.

The post-image of this patch allows readers easily to see that
nobody uses these variables without initialization, which is a great
improvement.

Thanks, will queue.
