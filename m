Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD41C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5DC20760
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="QK/rmkS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbgGAPcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732005AbgGAPcT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 11:32:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95557C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 08:32:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k5so1620084pjg.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:thread-index:content-language;
        bh=2BVD70GpNmoGFyzPF1dV8eM3yxXM9GrRc03blHlS9co=;
        b=QK/rmkS98wxfp1QT2jd5cyjHvzQ+MGIM/payIzvPfGk2HuiFZEpTZwwDUfFyWeos3Y
         yKB/Uj1DGOsRmHk11gGTF38T91VIHr3f22O6qQeL0vKaxY7n9HxgunG9cnZgJjqBoozj
         rLvy2ehgNQD7G61nO3eb6GAW+1mLwbKB2wmw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:thread-index:content-language;
        bh=2BVD70GpNmoGFyzPF1dV8eM3yxXM9GrRc03blHlS9co=;
        b=jVVVyGCg/WmsKWGugGboHTzVP9IlYVtRNsBZTzLtCyKt+Ox8g3vujoPY1UlDHeJj/P
         zYRDLx4nTySC7b/ddbnL9u3j/l2yl2cUvPpZ/TeINAOqnHSdaIOlu7o0Cq/ksZ+RhV5I
         hFhTVrqlwEM8btwqGeW0Tqu1tDz6oWhftfUQWrLzzg++aMrfyu0iTWDmL29yhpORjgS7
         NrZoYk0T+OytD3RMABLmhN9PkRIKhCtUMVBDB1Q9ecpRNEGVCTYwfalWECHoPByfnTZN
         o55pUxRMQ2KuC0aVrstx+y4/BWvmOFvy6mfInJLN30RMK0Bj3pgYGo6mr+yDBwsVD81U
         FHjg==
X-Gm-Message-State: AOAM530cBMcgpcUes0pK9uMswazk/uCZOxeC0RGS6Xqr906vWesV82bb
        A4O1kAROPl1cDTU8tPmWFgASSA==
X-Google-Smtp-Source: ABdhPJxBY7csGiiRir1XAO2GaVFYklKByrcDfwPQ4rDkegDUlCMnsNhRbqLDPeGV3FFFZvSEMLQBrw==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr20715476pjt.49.1593617538195;
        Wed, 01 Jul 2020 08:32:18 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id s68sm5725820pjb.38.2020.07.01.08.32.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:32:17 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'Lin Sun'" <lin.sun@zoom.us>
References: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com> <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com> <20200701141755.GB1966@danh.dev>
In-Reply-To: <20200701141755.GB1966@danh.dev>
Subject: RE: [PATCH v5] Enable auto-merge for meld to follow the vim-diff beharior
Date:   Wed, 1 Jul 2020 23:32:11 +0800
Message-ID: <1764101d64fbc$ccf9d7a0$66ed86e0$@zoom.us>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_17642_01D64FFF.DB1E2910"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHCkYwuu/FCSmveEZBDvCnrwyHmCQL1zGm+AhjQO/6o8eEFgA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_17642_01D64FFF.DB1E2910
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Danh,

Thank you for your comments, and changes apply to the last patch with =
your suggestions. Please refer the attachment for [PATH v6].
Thank you.

Regards
Lin=20

-----Original Message-----
From: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com>=20
Sent: Wednesday, July 1, 2020 22:18
To: sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org; sunlin <sunlin7@yahoo.com>; Lin Sun =
<lin.sun@zoom.us>
Subject: Re: [PATCH v5] Enable auto-merge for meld to follow the =
vim-diff beharior

On 2020-07-01 07:06:46+0000, sunlin via GitGitGadget =
<gitgitgadget@gmail.com> wrote:
> From: Lin Sun <lin.sun@zoom.us>
>=20
> Make the mergetool used with "meld" backend behave similarly to how=20
> "vimdiff" behavior by telling it to auto-merge parts without conflicts =

> and highlight the parts with conflicts when configuring=20
> `mergetool.meld.hasAutoMerge` with `true`, or `auto` for automatically =

> detecting the option.
>=20
> Signed-off-by: Lin Sun <lin.sun@zoom.us>
> ---
> diff --git a/Documentation/config/mergetool.txt=20
> b/Documentation/config/mergetool.txt
> index 09ed31dbfa..9a74bd98dc 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -30,6 +30,14 @@ mergetool.meld.hasOutput::
>  	to `true` tells Git to unconditionally use the `--output` option,
>  	and `false` avoids using `--output`.
> =20
> +mergetool.meld.hasAutoMerge::
> +	Older versions of `meld` do not support the `--auto-merge` option.
> +	Setting `mergetool.meld.hasOutput` to `true` tells Git to

s/hasOutput/hasAutoMerge/

Bikeshed opinion: I don't know if hasAutoMerge is a good name :)

> +	unconditionally use the `--auto-merge` option, and `false` avoids =
using
> +	`--auto-merge`, and `auto` detect whether `meld` supports =
`--auto-merge`
> +	by inspecting the output of `meld --help`, otherwise, follow meld's
> +	default behavior.
> +
>  mergetool.keepBackup::
>  	After performing a merge, the original file with conflict markers
>  	can be saved as a file with a `.orig` extension.  If this variable=20
> diff --git a/mergetools/meld b/mergetools/meld index=20
> 7a08470f88..9ee835b1e5 100644
> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -3,34 +3,74 @@ diff_cmd () {
>  }
> =20
>  merge_cmd () {
> -	if test -z "${meld_has_output_option:+set}"
> +	check_meld_for_features
> +
> +	option_auto_merge=3D
> +	if test "$meld_has_auto_merge_option" =3D true
>  	then
> -		check_meld_for_output_version
> +		option_auto_merge=3D"--auto-merge"
>  	fi
> =20
>  	if test "$meld_has_output_option" =3D true
>  	then
> -		"$merge_tool_path" --output=3D"$MERGED" \
> +		"$merge_tool_path" $option_auto_merge --output=3D"$MERGED" \
>  			"$LOCAL" "$BASE" "$REMOTE"
>  	else
> -		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> +		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
>  	fi
>  }
> =20
> -# Check whether we should use 'meld --output <file>'
> -check_meld_for_output_version () {
> -	meld_path=3D"$(git config mergetool.meld.path)"
> -	meld_path=3D"${meld_path:-meld}"
> +# Get meld help message
> +get_meld_help_msg () {
> +	meld_path=3D"$(git config mergetool.meld.path || echo meld)"
> +	$meld_path --help 2>&1
> +}

I'm actually prefer this change in 2 separated patches to reduce noise.
But given that mergetool/meld doesn't attract much attention, I don't =
know.

> =20
> -	if meld_has_output_option=3D$(git config --bool =
mergetool.meld.hasOutput)
> +# Check the features and set flags
> +check_meld_for_features () {
> +	# Check whether we should use 'meld --output <file>'
> +	if test -z "${meld_has_output_option:+set}"
>  	then
> -		: use configured value
> -	elif "$meld_path" --help 2>&1 |
> -		grep -e '--output=3D' -e '\[OPTION\.\.\.\]' >/dev/null
> +		meld_has_output_option=3D$(git config --bool =
mergetool.meld.hasOutput)
> +		if test "$meld_has_output_option" =3D true -o \
> +			"$meld_has_output_option" =3D false

The coding guideline seems to not like "test -o".
I think it's acceptable in this case since we control its input.
The output is comming out of "git config --bool" anyway, so =
meld_has_output_option must be either "", "true", or "false"

I think we're better to do this instead:

	if test -n "$meld_has_output_option"
	then
		: use configured output
	else
		: messing with help
	fi

> +		then
> +			: use configured value
> +		else
> +			# treat meld_has_output_option as "auto"
> +			if test -z "$meld_help_msg"
> +			then
> +				meld_help_msg=3D"$(get_meld_help_msg)"
> +			fi

If I were writing this patch, I probably changed get_meld_help_msg to

	init_meld_help_msg () {
		if test -z "$meld_help_msg"
		then
			meld_path=3D"$(git config mergetool.meld.path || echo meld)"
			meld_help_msg=3D$($meld_path --help 2>&1)
		fi
	}

And call init_meld_help_msg unconditionally here, (and in --auto-merge =
arm below, maybe other arms in the future).

I'm writing without much thought into this, please take my word with a =
grain of salt :)

> +}


> +
> +			case "$meld_help_msg" in
> +				*"--output=3D"* | *"[OPTION"???"]"*)

I think Git project prefer aligning case arm with case, IOW, move left 1 =
TAB.

> +					# old ones mention --output and new ones just say OPTION...
> +					meld_has_output_option=3Dtrue ;;

It's nice to see this update, good.
The comment is no longer correct, though.
The version 3.20.2 has --output but not OPTIONS.

It's not introduced by your change, but I think it's better to say:

	# All versions that has [OPTIONS???] supports --output

> +				*)
> +					meld_has_output_option=3Dfalse ;;
> +			esac
> +		fi
> +	fi
> +	# Check whether we should use 'meld --auto-merge ...'
> +	if test -z "${meld_has_auto_merge_option:+set}"
>  	then
> -		: old ones mention --output and new ones just say OPTION...
> -		meld_has_output_option=3Dtrue
> -	else
> -		meld_has_output_option=3Dfalse
> +		meld_has_auto_merge_option=3D$(git config =
mergetool.meld.hasAutoMerge)
> +		if test "$meld_has_auto_merge_option" =3D auto

Since we don't canonicallise to bool output of =
mergetool.meld.hasAutoMerge, I think we would need:

	case "$meld_has_auto_merge_option" in
	[Tt]rue|[Yy]es|[Oo]n)
		meld_has_auto_merge_option=3Dtrue ;;
	auto)
		: this shenanigan ;;
	esac

But, that's a bit messy. Let's see other's opinions.

> +		then
> +			# testing the "--auto-merge" option only if config is "auto"
> +			if test -z "$meld_help_msg"
> +			then
> +					meld_help_msg=3D"$(get_meld_help_msg)"
> +			fi
> +
> +			case "$meld_help_msg" in
> +				*"--auto-merge"*)
> +					: old ones mention --output and new ones just say OPTION...

This comment doesn't apply here.

> +					meld_has_auto_merge_option=3Dtrue ;;
> +				*)
> +					meld_has_auto_merge_option=3Dfalse ;;
> +			esac
> +		fi
>  	fi
>  }
>=20
> base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
> --
> gitgitgadget

--
Danh

------=_NextPart_000_17642_01D64FFF.DB1E2910
Content-Type: application/octet-stream;
	name="0001-Enable-auto-merge-for-meld-to-follow-the-vim-diff-be.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Enable-auto-merge-for-meld-to-follow-the-vim-diff-be.patch"

From 33968fb9e52a6ead7b9fc64943d4c82c3f893865 Mon Sep 17 00:00:00 2001=0A=
From: Lin Sun <lin.sun@zoom.us>=0A=
Date: Thu, 7 May 2020 07:31:14 +0800=0A=
Subject: [PATCH] Enable auto-merge for meld to follow the vim-diff =
beharior=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Make the mergetool used with "meld" backend behave similarly to=0A=
how "vimdiff" behavior by telling it to auto-merge parts without=0A=
conflicts and highlight the parts with conflicts when configuring=0A=
`mergetool.meld.hasAutoMerge` with `true`, or `auto` for=0A=
automatically detecting the option.=0A=
=0A=
Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh =
<congdanhqx@gmail.com>=0A=
Signed-off-by: Lin Sun <lin.sun@zoom.us>=0A=
---=0A=
 Documentation/config/mergetool.txt |  8 ++++=0A=
 mergetools/meld                    | 80 =
++++++++++++++++++++++++++++++--------=0A=
 2 files changed, 72 insertions(+), 16 deletions(-)=0A=
=0A=
diff --git a/Documentation/config/mergetool.txt =
b/Documentation/config/mergetool.txt=0A=
index 09ed31d..d2af88c 100644=0A=
--- a/Documentation/config/mergetool.txt=0A=
+++ b/Documentation/config/mergetool.txt=0A=
@@ -30,6 +30,14 @@ mergetool.meld.hasOutput::=0A=
 	to `true` tells Git to unconditionally use the `--output` option,=0A=
 	and `false` avoids using `--output`.=0A=
 =0A=
+mergetool.meld.hasAutoMerge::=0A=
+	Older versions of `meld` do not support the `--auto-merge` option.=0A=
+	Setting `mergetool.meld.hasAutoMerge` to `true` tells Git to=0A=
+	unconditionally use the `--auto-merge` option, and `false` avoids using=0A=
+	`--auto-merge`, and `auto` detect whether `meld` supports =
`--auto-merge`=0A=
+	by inspecting the output of `meld --help`, otherwise, follow meld's=0A=
+	default behavior.=0A=
+=0A=
 mergetool.keepBackup::=0A=
 	After performing a merge, the original file with conflict markers=0A=
 	can be saved as a file with a `.orig` extension.  If this variable=0A=
diff --git a/mergetools/meld b/mergetools/meld=0A=
index 7a08470..c6f499d 100644=0A=
--- a/mergetools/meld=0A=
+++ b/mergetools/meld=0A=
@@ -3,34 +3,82 @@ diff_cmd () {=0A=
 }=0A=
 =0A=
 merge_cmd () {=0A=
-	if test -z "${meld_has_output_option:+set}"=0A=
+	check_meld_for_features=0A=
+=0A=
+	option_auto_merge=3D=0A=
+	if test "$meld_has_auto_merge_option" =3D true=0A=
 	then=0A=
-		check_meld_for_output_version=0A=
+		option_auto_merge=3D"--auto-merge"=0A=
 	fi=0A=
 =0A=
 	if test "$meld_has_output_option" =3D true=0A=
 	then=0A=
-		"$merge_tool_path" --output=3D"$MERGED" \=0A=
+		"$merge_tool_path" $option_auto_merge --output=3D"$MERGED" \=0A=
 			"$LOCAL" "$BASE" "$REMOTE"=0A=
 	else=0A=
-		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"=0A=
+		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"=0A=
 	fi=0A=
 }=0A=
 =0A=
-# Check whether we should use 'meld --output <file>'=0A=
-check_meld_for_output_version () {=0A=
-	meld_path=3D"$(git config mergetool.meld.path)"=0A=
-	meld_path=3D"${meld_path:-meld}"=0A=
+# Get meld help message=0A=
+init_meld_help_msg () {=0A=
+	if test -z "${meld_help_msg:+set}"=0A=
+	then=0A=
+		meld_path=3D"$(git config mergetool.meld.path || echo meld)"=0A=
+		meld_help_msg=3D$($meld_path --help 2>&1)=0A=
+	fi=0A=
+}=0A=
 =0A=
-	if meld_has_output_option=3D$(git config --bool =
mergetool.meld.hasOutput)=0A=
+# Check the features and set flags=0A=
+check_meld_for_features () {=0A=
+	# Check whether we should use 'meld --output <file>'=0A=
+	if test -z "${meld_has_output_option:+set}"=0A=
 	then=0A=
-		: use configured value=0A=
-	elif "$meld_path" --help 2>&1 |=0A=
-		grep -e '--output=3D' -e '\[OPTION\.\.\.\]' >/dev/null=0A=
+		meld_has_output_option=3D$(git config --bool mergetool.meld.hasOutput)=0A=
+		case "$meld_has_output_option" in=0A=
+		true|false)=0A=
+			: use configured value=0A=
+			;;=0A=
+		*)=0A=
+			: treat meld_has_output_option as "auto"=0A=
+			init_meld_help_msg=0A=
+=0A=
+			case "$meld_help_msg" in=0A=
+			*"--output=3D"* | *"[OPTION"???"]"*)=0A=
+				# All version that has [OPTION???] supports --output=0A=
+				meld_has_output_option=3Dtrue=0A=
+				;;=0A=
+			*)=0A=
+				meld_has_output_option=3Dfalse=0A=
+				;;=0A=
+			esac=0A=
+			;;=0A=
+		esac=0A=
+	fi=0A=
+	# Check whether we should use 'meld --auto-merge ...'=0A=
+	if test -z "${meld_has_auto_merge_option:+set}"=0A=
 	then=0A=
-		: old ones mention --output and new ones just say OPTION...=0A=
-		meld_has_output_option=3Dtrue=0A=
-	else=0A=
-		meld_has_output_option=3Dfalse=0A=
+		meld_has_auto_merge_option=3D$(git config mergetool.meld.hasAutoMerge)=0A=
+		case "$meld_has_auto_merge_option" in=0A=
+		[Tt]rue|[Yy]es|[Oo]n|1)=0A=
+			meld_has_auto_merge_option=3Dtrue=0A=
+			;;=0A=
+		auto)=0A=
+			# testing the "--auto-merge" option only if config is "auto"=0A=
+			init_meld_help_msg=0A=
+=0A=
+			case "$meld_help_msg" in=0A=
+			*"--auto-merge"*)=0A=
+				meld_has_auto_merge_option=3Dtrue=0A=
+				;;=0A=
+			*)=0A=
+				meld_has_auto_merge_option=3Dfalse=0A=
+				;;=0A=
+			esac=0A=
+			;;=0A=
+		*)=0A=
+			meld_has_auto_merge_option=3Dfalse=0A=
+			;;=0A=
+		esac=0A=
 	fi=0A=
 }=0A=
-- =0A=
2.2.0=0A=
=0A=

------=_NextPart_000_17642_01D64FFF.DB1E2910--

