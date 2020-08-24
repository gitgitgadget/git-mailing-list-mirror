Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B3EC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E921C20738
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qzsXWVSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHXSvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:51:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54341 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXSvp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 14:51:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1997CD9971;
        Mon, 24 Aug 2020 14:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y/TN06SmoBaf
        DV1cBbWqOcUHCQg=; b=qzsXWVSiewVewt+eSu6XsfrLuFzIfLmMeNd+eczcTAyM
        Ppn0Ue6Kl+3WABDTaKmv7VtduB9bhx9pPfIv2l5HoFFTJOyUpjG3ITPhv5/SSCjS
        gUO8eaI5qgYoLoXoSi2UVKQnt/P0sfc5ZYb5h1WRjImum7k1il3xjg6/vMDVOcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JZ0C15
        JRXn0RriWrB6iy8E/8nvN+g5S4/PulN4+R4hN9APmUawT1UpJE1c1vmnb+Di4PEB
        o0Ut4jIp8ex5GtiXnhH+N1ccfJSXkuwER3c9nAa8/vHaydFfXuG2F1nyGrAe4yUP
        CeUW6Ps+jOp6CQlKxavqoBKxY8PYgXbLojRWc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1237CD9970;
        Mon, 24 Aug 2020 14:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 52882D996E;
        Mon, 24 Aug 2020 14:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Vadim Sannikov via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Vadim Sannikov <vsj.vadim@gmail.com>
Subject: Re: [PATCH 1/2] Unify `update-index --cacheinfo` usage
References: <pull.708.git.1598280703.gitgitgadget@gmail.com>
        <fc2138e1db2de46793100b87c00dbde270f6b350.1598280704.git.gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 11:51:34 -0700
In-Reply-To: <fc2138e1db2de46793100b87c00dbde270f6b350.1598280704.git.gitgitgadget@gmail.com>
        (Vadim Sannikov via GitGitGadget's message of "Mon, 24 Aug 2020
        14:51:42 +0000")
Message-ID: <xmqqv9h7513d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D62613F6-E63A-11EA-8FFD-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Vadim Sannikov via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 1/2] Unify `update-index --cacheinfo` usage

Perhaps

	update-index: use single-argument form of --cacheinfo

see Documentation/SubmittingPatches[[summary-section]]

> Different parts of Git code use different syntax, so the commit unifies
> it. According to `git-update-index` manual page, the new form is
> preferred.

It is _encouraged_ to new users, but it is not like the old form is
getting removed.  IOW, there is no strong "preference".

	The "--cacheinfo" option of "update-index" can take two
	forms, but we encourage new users to use the form where the
	mode, object, and path are concatenated with a comma, into a
	single parameter.  Update the in-tree users of the command
	to also use the form to help new users who may want to copy
	and paste from our code.

or something?

This step is good, but it is not welcome to change the tests in such
a way that the three-separate-parameter form is not tested at all.
As long as we have tests to ensure the single-parameter form works
OK, no change is needed.

Thanks.

> Signed-off-by: Vadim Sannikov <vsj.vadim@gmail.com>
> ---
>  git-merge-one-file.sh | 6 +++---
>  git-mergetool.sh      | 2 +-
>  merge-recursive.c     | 2 +-
>  po/bg.po              | 4 ++--
>  po/ca.po              | 4 ++--
>  po/de.po              | 4 ++--
>  po/el.po              | 2 +-
>  po/es.po              | 4 ++--
>  po/fr.po              | 4 ++--
>  po/git.pot            | 2 +-
>  po/it.po              | 4 ++--
>  po/ko.po              | 4 ++--
>  po/ru.po              | 8 ++++++--
>  po/sv.po              | 4 ++--
>  po/tr.po              | 4 ++--
>  po/vi.po              | 4 ++--
>  po/zh_CN.po           | 4 ++--
>  po/zh_TW.po           | 4 ++--
>  18 files changed, 37 insertions(+), 33 deletions(-)
>
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index f6d9852d2f..5691c4e7ff 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -71,7 +71,7 @@ case "${1:-.}${2:-.}${3:-.}" in
>  ".$2.")
>  	# the other side did not add and we added so there is nothing
>  	# to be done, except making the path merged.
> -	exec git update-index --add --cacheinfo "$6" "$2" "$4"
> +	exec git update-index --add --cacheinfo "$6","$2","$4"
>  	;;
>  "..$3")
>  	echo "Adding $4"
> @@ -80,7 +80,7 @@ case "${1:-.}${2:-.}${3:-.}" in
>  		echo "ERROR: untracked $4 is overwritten by the merge." >&2
>  		exit 1
>  	fi
> -	git update-index --add --cacheinfo "$7" "$3" "$4" &&
> +	git update-index --add --cacheinfo "$7","$3","$4" &&
>  		exec git checkout-index -u -f -- "$4"
>  	;;
> =20
> @@ -95,7 +95,7 @@ case "${1:-.}${2:-.}${3:-.}" in
>  		exit 1
>  	fi
>  	echo "Adding $4"
> -	git update-index --add --cacheinfo "$6" "$2" "$4" &&
> +	git update-index --add --cacheinfo "$6","$2","$4" &&
>  		exec git checkout-index -u -f -- "$4"
>  	;;
> =20
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index e3f6d543fb..ad37b15f4b 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -224,7 +224,7 @@ stage_submodule () {
>  	)
>  	test -n "$work_rel_path" ||
>  	die "fatal: unable to get path of module $path relative to work tree"
> -	git update-index --add --replace --cacheinfo 160000 "$submodule_sha1"=
 "${work_rel_path%/}" || die
> +	git update-index --add --replace --cacheinfo 160000,"$submodule_sha1"=
,"${work_rel_path%/}" || die
>  }
> =20
>  checkout_staged_file () {
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d0214335a7..dfe6f67ec8 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1259,7 +1259,7 @@ static int merge_submodule(struct merge_options *=
opt,
>  		       "If this is correct simply add it to the index "
>  		       "for example\n"
>  		       "by using:\n\n"
> -		       "  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
> +		       "  git update-index --cacheinfo 160000,%s,\"%s\"\n\n"
>  		       "which will accept this suggestion.\n"),
>  		       oid_to_hex(&merges.objects[0].item->oid), path);
>  		break;
> diff --git a/po/bg.po b/po/bg.po
> index a189b16dc4..517c0e6b49 100644
> --- a/po/bg.po
> +++ b/po/bg.po
> @@ -4737,13 +4737,13 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "=D0=90=D0=BA=D0=BE =D1=82=D0=BE=D0=B2=D0=B0 =D0=B5 =D1=82=D0=B0=D0=BA=
=D0=B0, =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=B5=D1=82=D0=B5 =D0=B3=D0=BE =D0=
=BA=D1=8A=D0=BC =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0 =D1=81 =D0=BA=D0=
=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 =D0=BA=D0=B0=D1=82=D0=BE =D1=81=D0=BB=D0=
=B5=D0=B4=D0=BD=D0=B0=D1=82=D0=B0:\n"
>  "\n"
> -"    git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "=D0=A2=D0=BE=D0=B2=D0=B0 =D0=BF=D1=80=D0=B8=D0=B5=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=B5=D0=B4=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=BE=D1=82=D0=BE.\n"
> =20
> diff --git a/po/ca.po b/po/ca.po
> index c43c21bc22..61c3a7f9b0 100644
> --- a/po/ca.po
> +++ b/po/ca.po
> @@ -4592,12 +4592,12 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "Si aix=C3=B2 =C3=A9s correcte simplement afegiu-ho a l'=C3=ADndex per=
 exemple utilitzant "
> -"git update-index --cacheinfo 160000 per cents \"%s\" que acceptaran a=
quest "
> +"  git update-index --cacheinfo 160000,%s,\"%s\" que acceptaran aquest=
 "
>  "suggeriment.\n"
> =20
>  #: merge-recursive.c:1268
> diff --git a/po/de.po b/po/de.po
> index 656de24218..ec0106f2b8 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -4641,14 +4641,14 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "Falls das korrekt ist, f=C3=BCgen Sie es einfach der Staging-Area, zu=
m Beispiel "
>  "mit:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "hinzu, um diesen Vorschlag zu akzeptieren.\n"
> =20
> diff --git a/po/el.po b/po/el.po
> index 703f46d0c7..e775885187 100644
> --- a/po/el.po
> +++ b/po/el.po
> @@ -3075,7 +3075,7 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
> diff --git a/po/es.po b/po/es.po
> index 41a72ca6fb..1c1aeebe47 100644
> --- a/po/es.po
> +++ b/po/es.po
> @@ -4572,14 +4572,14 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "Si esto es correcto simplemente agr=C3=A9galo al =C3=ADndice por ejem=
plo\n"
>  "usando:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "el cual aceptar=C3=A1 esta sugerencia.\n"
> =20
> diff --git a/po/fr.po b/po/fr.po
> index d20fc440ab..157c41ff4c 100644
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -4714,14 +4714,14 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "Si c'est correct, ajoutez le simplement =C3=A0 l'index\n"
>  "en utilisant par exemple=C2=A0:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "qui acceptera cette suggestion.\n"
> =20
> diff --git a/po/git.pot b/po/git.pot
> index 198b6e0a4a..2d50bebf5a 100644
> --- a/po/git.pot
> +++ b/po/git.pot
> @@ -4256,7 +4256,7 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
> diff --git a/po/it.po b/po/it.po
> index 53523e76df..c8264dd7bc 100644
> --- a/po/it.po
> +++ b/po/it.po
> @@ -4649,14 +4649,14 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "Se =C3=A8 corretta aggiungila semplicemente all'indice, ad esempio\n"
>  "usando:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "per accettare questo suggerimento.\n"
> =20
> diff --git a/po/ko.po b/po/ko.po
> index dcfe21c223..47b611edee 100644
> --- a/po/ko.po
> +++ b/po/ko.po
> @@ -2361,14 +2361,14 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "=EC=9D=B4 =EC=A0=9C=EC=95=88=EC=9D=B4 =EB=A7=9E=EC=9C=BC=EB=A9=B4 =EC=
=9D=B8=EB=8D=B1=EC=8A=A4=EC=97=90 =EC=B6=94=EA=B0=80=ED=95=98=EB=A9=B4 =EB=
=90=A9=EB=8B=88=EB=8B=A4. =EC=98=88=EB=A5=BC =EB=93=A4=EC=96=B4\n"
>  "=EB=8B=A4=EC=9D=8C =EB=AA=85=EB=A0=B9=EC=9D=84 =EC=82=AC=EC=9A=A9=ED=95=
=98=EB=A9=B4:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "=EC=A0=9C=EC=95=88=EC=9D=84 =EB=B0=9B=EC=95=84=EB=93=A4=EC=9D=B4=EA=B2=
=8C =EB=90=A9=EB=8B=88=EB=8B=A4.\n"
> =20
> diff --git a/po/ru.po b/po/ru.po
> index a77b462e62..a928cd879e 100644
> --- a/po/ru.po
> +++ b/po/ru.po
> @@ -3523,10 +3523,14 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
> -msgstr "=D0=95=D1=81=D0=BB=D0=B8 =D0=BE=D0=BD=D0=BE =D0=B2=D0=B5=D1=80=
=D0=BD=D0=BE=D0=B5, =D1=82=D0=BE =D0=BF=D1=80=D0=BE=D1=81=D1=82=D0=BE =D0=
=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8C=D1=82=D0=B5 =D0=B5=D0=B3=D0=BE =D0=B2 =D0=
=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81, =D0=BD=D0=B0=D0=BF=D1=80=D0=B8=D0=BC=D0=
=B5=D1=80 =D1=82=D0=B0=D0=BA:\n\n  git update-index --cacheinfo 160000 %s=
 \"%s\"\n\n=D1=82=D0=B5=D0=BC =D1=81=D0=B0=D0=BC=D1=8B=D0=BC =D0=BF=D1=80=
=D0=B8=D0=BD=D0=B8=D0=BC=D0=B0=D1=8F =D1=8D=D1=82=D0=BE =D0=BF=D1=80=D0=B5=
=D0=B4=D0=BF=D0=BE=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5.\n"
> +msgstr "=D0=95=D1=81=D0=BB=D0=B8 =D0=BE=D0=BD=D0=BE =D0=B2=D0=B5=D1=80=
=D0=BD=D0=BE=D0=B5, =D1=82=D0=BE =D0=BF=D1=80=D0=BE=D1=81=D1=82=D0=BE =D0=
=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8C=D1=82=D0=B5 =D0=B5=D0=B3=D0=BE =D0=B2 =D0=
=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81, =D0=BD=D0=B0=D0=BF=D1=80=D0=B8=D0=BC=D0=
=B5=D1=80 =D1=82=D0=B0=D0=BA:\n"
> +"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
> +"\n"
> +"=D1=82=D0=B5=D0=BC =D1=81=D0=B0=D0=BC=D1=8B=D0=BC =D0=BF=D1=80=D0=B8=D0=
=BD=D0=B8=D0=BC=D0=B0=D1=8F =D1=8D=D1=82=D0=BE =D0=BF=D1=80=D0=B5=D0=B4=D0=
=BF=D0=BE=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5.\n"
> =20
>  #: merge-recursive.c:1252
>  #, c-format
> diff --git a/po/sv.po b/po/sv.po
> index 93f3c6f3f7..f5a850f0b7 100644
> --- a/po/sv.po
> +++ b/po/sv.po
> @@ -4551,14 +4551,14 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "Om detta =C3=A4r riktigt l=C3=A4gger du bara till det i indexet, till=
\n"
>  "exempel s=C3=A5 h=C3=A4r:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "vilket godtar l=C3=B6sningen.\n"
> =20
> diff --git a/po/tr.po b/po/tr.po
> index 9a17c19b25..af5f9ba7f8 100644
> --- a/po/tr.po
> +++ b/po/tr.po
> @@ -4619,13 +4619,13 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "E=C4=9Fer bu do=C4=9Fruysa yaln=C4=B1zca indekse ekleyin, =C3=B6rne=C4=
=9Finbu =C3=B6neriyi kabul edecek:\n"
>  "\n"
> -"\tgit update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "komutunu kullanman=C4=B1z yeterlidir.\n"
> =20
> diff --git a/po/vi.po b/po/vi.po
> index d730cf1141..beec050125 100644
> --- a/po/vi.po
> +++ b/po/vi.po
> @@ -4548,14 +4548,14 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "N=E1=BA=BFu =C4=91=C3=A2y l=C3=A0 =C4=91=C3=BAng =C4=91=C6=A1n gi=E1=BA=
=A3n th=C3=AAm n=C3=B3 v=C3=A0o m=E1=BB=A5c l=E1=BB=A5c v=C3=AD d=E1=BB=A5=
\n"
>  "b=E1=BA=B1ng c=C3=A1ch d=C3=B9ng:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "c=C3=A1i m=C3=A0 s=E1=BA=BD ch=E1=BA=A5p nh=E1=BA=ADn g=E1=BB=A3i =C3=
=BD n=C3=A0y.\n"
> =20
> diff --git a/po/zh_CN.po b/po/zh_CN.po
> index a531819623..69dd29140b 100644
> --- a/po/zh_CN.po
> +++ b/po/zh_CN.po
> @@ -4567,13 +4567,13 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "=E5=A6=82=E6=9E=9C=E8=BF=99=E4=B8=AA=E6=AD=A3=E7=A1=AE=EF=BC=8C=E5=B0=
=86=E5=85=B6=E6=B7=BB=E5=8A=A0=E5=88=B0=E7=B4=A2=E5=BC=95=EF=BC=8C=E4=BE=8B=
=E5=A6=82=E4=BD=BF=E7=94=A8=E5=91=BD=E4=BB=A4=EF=BC=9A\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "=E4=BB=A5=E6=8E=A5=E5=8F=97=E6=AD=A4=E5=BB=BA=E8=AE=AE=E3=80=82\n"
> =20
> diff --git a/po/zh_TW.po b/po/zh_TW.po
> index 9334b46faa..18e6b8985a 100644
> --- a/po/zh_TW.po
> +++ b/po/zh_TW.po
> @@ -4692,13 +4692,13 @@ msgid ""
>  "If this is correct simply add it to the index for example\n"
>  "by using:\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "which will accept this suggestion.\n"
>  msgstr ""
>  "=E5=A6=82=E6=9E=9C=E9=80=99=E5=80=8B=E6=AD=A3=E7=A2=BA=EF=BC=8C=E5=B0=
=87=E5=85=B6=E6=96=B0=E5=A2=9E=E5=88=B0=E7=B4=A2=E5=BC=95=EF=BC=8C=E4=BE=8B=
=E5=A6=82=E4=BD=BF=E7=94=A8=E6=8C=87=E4=BB=A4=EF=BC=9A\n"
>  "\n"
> -"  git update-index --cacheinfo 160000 %s \"%s\"\n"
> +"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
>  "\n"
>  "=E4=BB=A5=E6=8E=A5=E5=8F=97=E6=AD=A4=E5=BB=BA=E8=AD=B0=E3=80=82\n"
