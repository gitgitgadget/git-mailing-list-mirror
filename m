Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E4CC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 07:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D7A2070C
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 07:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="iFl61AlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGAHYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgGAHYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 03:24:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C7C061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 00:24:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f3so11278716pgr.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 00:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=gAwEwCmCrMFLHtKPgYnavl1SeBa556s+ChWNGqoHbl4=;
        b=iFl61AlPso/G/01rbl1zyzOgw+edNKpUD2XNduSBua0z0uqyMSRe1l3KZ5XncqvzIt
         fX2hPDVJLtFBcn/hXg/2S/+wTAh0FDcGSf8S9zzN2g8ZrnBWJGywmBeYe5rWga8xQoXh
         wnBu1LMW2/orSTn5Xwv/aYcFTEPYgcFr2SaFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=gAwEwCmCrMFLHtKPgYnavl1SeBa556s+ChWNGqoHbl4=;
        b=eKWLtK2ruF4ZZx9Pr7cFwRPfn9yHlNVANEP4ozZb9OynYHM6E1B7lBQSlabDMaNKvz
         ivjI/xAmaCns3ehb2Sf+tI5OCNAxHyt1wgT+ZyJ5+EqEIsqU+yzREyfZ+NAMzFIciv6S
         DuSVlIpU5BphDOJKBAhFGYSYQcklcVQmNf3WPcmrzHjeA9v5JMe17B7dXNxi5x69dPN8
         dOJfcmFWGBfA4VkcW3iyW+CcrHgl27bNs+cvDIgckCcyBJxeAvR96UiDtbQOo2stgPfF
         q9qUTkuF0MnN4bWjbBa1NUqOdYTmjtCnjd2CKFMMN5TMOENV+DSFVSBffLByMMb6XafA
         FLhA==
X-Gm-Message-State: AOAM531cH4PZBJ48amfuzIWFfucOOExzqZZxfeqN36dGal1Ym1UtRB4f
        mQ0uL/9Obv23frZSnmuIAAL62+DzuDs=
X-Google-Smtp-Source: ABdhPJybzy6tL7JcapLe9Xg8T628FbrA524iCLXKciBfRCRkhgtWIXiFjKvRQ8jCZlPsnVouM5EGOA==
X-Received: by 2002:a63:5915:: with SMTP id n21mr18830850pgb.323.1593588243276;
        Wed, 01 Jul 2020 00:24:03 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id gk5sm4125433pjb.4.2020.07.01.00.24.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 00:24:02 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>,
        =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'David Aguilar'" <davvid@gmail.com>
References: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com> <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
Subject: RE: [PATCH v5] Enable auto-merge for meld to follow the vim-diff beharior
Date:   Wed, 1 Jul 2020 15:23:56 +0800
Message-ID: <1514701d64f78$970ba180$c522e480$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHCkYwuu/FCSmveEZBDvCnrwyHmCQL1zGm+qQIdLPA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

The [PATH v5] is changed to following the comments from you, Junio, =
David.=20
Please review this newer version. Thank you.
The raw files is =
https://github.com/git/git/blob/344817d57970e3ac0910cdd8ad47bf97334ab2a6/=
mergetools/meld

Regards
Lin
-----Original Message-----
From: sunlin via GitGitGadget <gitgitgadget@gmail.com>=20
Sent: Wednesday, July 1, 2020 15:07
To: git@vger.kernel.org
Cc: sunlin <sunlin7@yahoo.com>; Lin Sun <lin.sun@zoom.us>
Subject: [PATCH v5] Enable auto-merge for meld to follow the vim-diff =
beharior

From: Lin Sun <lin.sun@zoom.us>

Make the mergetool used with "meld" backend behave similarly to how =
"vimdiff" behavior by telling it to auto-merge parts without conflicts =
and highlight the parts with conflicts when configuring =
`mergetool.meld.hasAutoMerge` with `true`, or `auto` for automatically =
detecting the option.

Signed-off-by: Lin Sun <lin.sun@zoom.us>
---
    Enable auto-merge for meld to follow the vimdiff beharior
   =20
    Hi, the mergetool "meld" does NOT merge the no-conflict changes, =
while
    the mergetool "vimdiff" will merge the no-conflict changes and =
highlight
    the conflict parts. This patch will make the mergetool "meld" =
similar to
    "vimdiff", auto-merge the no-conflict changes, highlight conflict =
parts.

Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fm=
aster-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-git-781/sunlin7/master-v5
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v4:

 1:  93ae3ec011 ! 1:  344817d579 Enable auto-merge for meld to follow =
the vim-diff beharior
     @@
       ## Metadata ##
     -Author: lin.sun <lin.sun@zoom.us>
     +Author: Lin Sun <lin.sun@zoom.us>
     =20
       ## Commit message ##
          Enable auto-merge for meld to follow the vim-diff beharior
     =20
          Make the mergetool used with "meld" backend behave similarly =
to
     -    how "vimdiff" beheaves by telling it to auto-merge parts =
without
     -    conflicts and highlight the parts with conflicts.
     +    how "vimdiff" behavior by telling it to auto-merge parts =
without
     +    conflicts and highlight the parts with conflicts when =
configuring
     +    `mergetool.meld.hasAutoMerge` with `true`, or `auto` for
     +    automatically detecting the option.
     =20
     -    Signed-off-by: lin.sun <lin.sun@zoom.us>
     +    Signed-off-by: Lin Sun <lin.sun@zoom.us>
     +
     + ## Documentation/config/mergetool.txt ##
     +@@ Documentation/config/mergetool.txt: mergetool.meld.hasOutput::
     + 	to `true` tells Git to unconditionally use the `--output` =
option,
     + 	and `false` avoids using `--output`.
     +=20
     ++mergetool.meld.hasAutoMerge::
     ++	Older versions of `meld` do not support the `--auto-merge` =
option.
     ++	Setting `mergetool.meld.hasOutput` to `true` tells Git to
     ++	unconditionally use the `--auto-merge` option, and `false` =
avoids using
     ++	`--auto-merge`, and `auto` detect whether `meld` supports =
`--auto-merge`
     ++	by inspecting the output of `meld --help`, otherwise, follow =
meld's
     ++	default behavior.
     ++
     + mergetool.keepBackup::
     + 	After performing a merge, the original file with conflict =
markers
     + 	can be saved as a file with a `.orig` extension.  If this =
variable
     =20
       ## mergetools/meld ##
      @@ mergetools/meld: diff_cmd () {
     @@ mergetools/meld: diff_cmd () {
      +# Get meld help message
      +get_meld_help_msg () {
      +	meld_path=3D"$(git config mergetool.meld.path || echo meld)"
     -+  $meld_path --help 2>&1
     ++	$meld_path --help 2>&1
      +}
      =20
      -	if meld_has_output_option=3D$(git config --bool =
mergetool.meld.hasOutput)
     @@ mergetools/meld: diff_cmd () {
      -		grep -e '--output=3D' -e '\[OPTION\.\.\.\]' >/dev/null
      +		meld_has_output_option=3D$(git config --bool =
mergetool.meld.hasOutput)
      +		if test "$meld_has_output_option" =3D true -o \
     -+						"$meld_has_output_option" =3D false
     ++			"$meld_has_output_option" =3D false
      +		then
      +			: use configured value
     -+		else												# treat meld_has_output_option as "auto"
     ++		else
     ++			# treat meld_has_output_option as "auto"
      +			if test -z "$meld_help_msg"
      +			then
      +				meld_help_msg=3D"$(get_meld_help_msg)"
      +			fi
      +
     -+			if echo "$meld_help_msg" |
     -+							grep -e '--output=3D' -e '\[OPTION\.\.\.\]' >/dev/null
     -+			then
     -+				: old ones mention --output and new ones just say OPTION...
     -+				meld_has_output_option=3Dtrue
     -+			else
     -+				meld_has_output_option=3Dfalse
     -+			fi
     ++			case "$meld_help_msg" in
     ++				*"--output=3D"* | *"[OPTION"???"]"*)
     ++					# old ones mention --output and new ones just say OPTION...
     ++					meld_has_output_option=3Dtrue ;;
     ++				*)
     ++					meld_has_output_option=3Dfalse ;;
     ++			esac
      +		fi
      +	fi
      +	# Check whether we should use 'meld --auto-merge ...'
     @@ mergetools/meld: diff_cmd () {
      -		meld_has_output_option=3Dtrue
      -	else
      -		meld_has_output_option=3Dfalse
     -+		meld_has_auto_merge_option=3D$(git config --bool =
mergetool.meld.hasAutoMerge)
     -+		if test "$meld_has_auto_merge_option" =3D true -o \
     -+						"$meld_has_auto_merge_option" =3D false
     ++		meld_has_auto_merge_option=3D$(git config =
mergetool.meld.hasAutoMerge)
     ++		if test "$meld_has_auto_merge_option" =3D auto
      +		then
     -+			: use configured value
     -+		else												# treat meld_has_auto_merge_option as "auto"
     ++			# testing the "--auto-merge" option only if config is "auto"
      +			if test -z "$meld_help_msg"
      +			then
      +					meld_help_msg=3D"$(get_meld_help_msg)"
      +			fi
      +
     -+			if echo "$meld_help_msg" | grep -e '--auto-merge' >/dev/null
     -+			then
     -+					meld_has_auto_merge_option=3Dtrue
     -+			else
     -+				meld_has_auto_merge_option=3Dfalse
     -+			fi
     ++			case "$meld_help_msg" in
     ++				*"--auto-merge"*)
     ++					: old ones mention --output and new ones just say OPTION...
     ++					meld_has_auto_merge_option=3Dtrue ;;
     ++				*)
     ++					meld_has_auto_merge_option=3Dfalse ;;
     ++			esac
      +		fi
       	fi
       }


 Documentation/config/mergetool.txt |  8 ++++
 mergetools/meld                    | 72 +++++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/mergetool.txt =
b/Documentation/config/mergetool.txt
index 09ed31dbfa..9a74bd98dc 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -30,6 +30,14 @@ mergetool.meld.hasOutput::
 	to `true` tells Git to unconditionally use the `--output` option,
 	and `false` avoids using `--output`.
=20
+mergetool.meld.hasAutoMerge::
+	Older versions of `meld` do not support the `--auto-merge` option.
+	Setting `mergetool.meld.hasOutput` to `true` tells Git to
+	unconditionally use the `--auto-merge` option, and `false` avoids =
using
+	`--auto-merge`, and `auto` detect whether `meld` supports =
`--auto-merge`
+	by inspecting the output of `meld --help`, otherwise, follow meld's
+	default behavior.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable =
diff --git a/mergetools/meld b/mergetools/meld index =
7a08470f88..9ee835b1e5 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,74 @@ diff_cmd () {
 }
=20
 merge_cmd () {
-	if test -z "${meld_has_output_option:+set}"
+	check_meld_for_features
+
+	option_auto_merge=3D
+	if test "$meld_has_auto_merge_option" =3D true
 	then
-		check_meld_for_output_version
+		option_auto_merge=3D"--auto-merge"
 	fi
=20
 	if test "$meld_has_output_option" =3D true
 	then
-		"$merge_tool_path" --output=3D"$MERGED" \
+		"$merge_tool_path" $option_auto_merge --output=3D"$MERGED" \
 			"$LOCAL" "$BASE" "$REMOTE"
 	else
-		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
 	fi
 }
=20
-# Check whether we should use 'meld --output <file>'
-check_meld_for_output_version () {
-	meld_path=3D"$(git config mergetool.meld.path)"
-	meld_path=3D"${meld_path:-meld}"
+# Get meld help message
+get_meld_help_msg () {
+	meld_path=3D"$(git config mergetool.meld.path || echo meld)"
+	$meld_path --help 2>&1
+}
=20
-	if meld_has_output_option=3D$(git config --bool =
mergetool.meld.hasOutput)
+# Check the features and set flags
+check_meld_for_features () {
+	# Check whether we should use 'meld --output <file>'
+	if test -z "${meld_has_output_option:+set}"
 	then
-		: use configured value
-	elif "$meld_path" --help 2>&1 |
-		grep -e '--output=3D' -e '\[OPTION\.\.\.\]' >/dev/null
+		meld_has_output_option=3D$(git config --bool =
mergetool.meld.hasOutput)
+		if test "$meld_has_output_option" =3D true -o \
+			"$meld_has_output_option" =3D false
+		then
+			: use configured value
+		else
+			# treat meld_has_output_option as "auto"
+			if test -z "$meld_help_msg"
+			then
+				meld_help_msg=3D"$(get_meld_help_msg)"
+			fi
+
+			case "$meld_help_msg" in
+				*"--output=3D"* | *"[OPTION"???"]"*)
+					# old ones mention --output and new ones just say OPTION...
+					meld_has_output_option=3Dtrue ;;
+				*)
+					meld_has_output_option=3Dfalse ;;
+			esac
+		fi
+	fi
+	# Check whether we should use 'meld --auto-merge ...'
+	if test -z "${meld_has_auto_merge_option:+set}"
 	then
-		: old ones mention --output and new ones just say OPTION...
-		meld_has_output_option=3Dtrue
-	else
-		meld_has_output_option=3Dfalse
+		meld_has_auto_merge_option=3D$(git config =
mergetool.meld.hasAutoMerge)
+		if test "$meld_has_auto_merge_option" =3D auto
+		then
+			# testing the "--auto-merge" option only if config is "auto"
+			if test -z "$meld_help_msg"
+			then
+					meld_help_msg=3D"$(get_meld_help_msg)"
+			fi
+
+			case "$meld_help_msg" in
+				*"--auto-merge"*)
+					: old ones mention --output and new ones just say OPTION...
+					meld_has_auto_merge_option=3Dtrue ;;
+				*)
+					meld_has_auto_merge_option=3Dfalse ;;
+			esac
+		fi
 	fi
 }

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
--
gitgitgadget

