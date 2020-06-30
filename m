Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFC3C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 11:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B153B206E9
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 11:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="ezoltpfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgF3LZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgF3LZP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 07:25:15 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5BAC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 04:25:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id u12so15205299qth.12
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:thread-index:content-language;
        bh=d6DxGgwJbXV5xBfVSOHrx15HJRZJsPhzNj4VrsQ6n+g=;
        b=ezoltpfVu15MZkwz/dYNMUphJX6dBJc5jrFPyA/DZJXMGp5+rDTk4n+Mkq1BPIy8TQ
         wMCCvkTY5gFEB6Cf1I5Fe9o6cinW8KePHPnzSyuhfcFZ6D9tpm3QEIYs+nZImd4/utMk
         8c4WU6LuV644lE7Z09RlkVI0GvLDDk84kUS1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:thread-index:content-language;
        bh=d6DxGgwJbXV5xBfVSOHrx15HJRZJsPhzNj4VrsQ6n+g=;
        b=O9GDp6sKdXhuufD8/mzwXU1OEbeK4nTIZHw44awyy274Wv4o0veptOW5jN8QaXd68P
         VONBWgj0wBV7WAa//nChNfmnP9iZX3hldtGQxjHwR20w+418mclmUvrYYslQYmZ08trp
         2hrzG6Dm6ImrZAXWLnQMl8TbsIbTLh81zgfA+ImQYP+q+A58caq/eg34W1hLTj1luDm1
         +NyrlAYQ6WIzbcgD3H+kLU3xT5SmjJsXNaqhpXTXViVuvtOKzxhY5SDYCd5C6GZUvibl
         aF2vUE57ovfzyrOSXfGKuME6hyBBJ7l6g5f3fYGY7wyYU9E3CPoergKB5+taRuI8Yp+x
         b27g==
X-Gm-Message-State: AOAM531lmCQY49y2EW9vVq8krJfHt4GQSRS0O+BpVEfCQ84tCO6C1iZE
        o3fX0//xUcGt6UGBuxF9M7giCw==
X-Google-Smtp-Source: ABdhPJxV16uhxTLb+4WsbmOwPT4YpoW99cOh8Po5xztuN7PYkcACRpBN8y83L7HzIXqnD8zIJs1knw==
X-Received: by 2002:ac8:76c2:: with SMTP id q2mr20922646qtr.295.1593516313706;
        Tue, 30 Jun 2020 04:25:13 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id g41sm3112620qtb.37.2020.06.30.04.25.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 04:25:12 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'David Aguilar'" <davvid@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v2.git.git.1591672753363.gitgitgadget@gmail.com> <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com> <xmqqeepxfmdm.fsf@gitster.c.googlers.com> <20200630074204.GA2144485@gmail.com>
In-Reply-To: <20200630074204.GA2144485@gmail.com>
Subject: RE: [PATCH v3] Enable auto-merge for meld to follow the vim-diff beharior
Date:   Tue, 30 Jun 2020 19:25:07 +0800
Message-ID: <f61a01d64ed1$1e36af40$5aa40dc0$@zoom.us>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_F61B_01D64F14.2C5A8B80"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHRJ5MuIWMkBHXT+uLjlpK0dGJPAAHpZEAUAj9VN80CNchbFajIW/9g
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_F61B_01D64F14.2C5A8B80
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David, Junio,

Appreciate for your comments, I rewrite the "mergetool/meld" to follow =
your comments and suggestions.
It will respect the git config first, then detect the options if no =
configuration for them, and also reduce the subprocess calling.
Both the modified-file and patch-file are appended.
Please review again. Thanks

Regards
Lin Sun

------=_NextPart_000_F61B_01D64F14.2C5A8B80
Content-Type: application/octet-stream;
	name="0001-Enable-auto-merge-for-meld-to-follow-the-vim-diff-be.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Enable-auto-merge-for-meld-to-follow-the-vim-diff-be.patch"

From 93ae3ec011e7b55cc9971f91345cb4aab5189cb4 Mon Sep 17 00:00:00 2001=0A=
From: "lin.sun" <lin.sun@zoom.us>=0A=
Date: Thu, 7 May 2020 07:31:14 +0800=0A=
Subject: [PATCH] Enable auto-merge for meld to follow the vim-diff =
beharior=0A=
=0A=
Make the mergetool used with "meld" backend behave similarly to=0A=
how "vimdiff" beheaves by telling it to auto-merge parts without=0A=
conflicts and highlight the parts with conflicts.=0A=
=0A=
Signed-off-by: lin.sun <lin.sun@zoom.us>=0A=
---=0A=
 mergetools/meld | 73 =
++++++++++++++++++++++++++++++++++++++++++++-------------=0A=
 1 file changed, 57 insertions(+), 16 deletions(-)=0A=
=0A=
diff --git a/mergetools/meld b/mergetools/meld=0A=
index 7a08470..1b92771 100644=0A=
--- a/mergetools/meld=0A=
+++ b/mergetools/meld=0A=
@@ -3,34 +3,75 @@ diff_cmd () {=0A=
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
+get_meld_help_msg () {=0A=
+	meld_path=3D"$(git config mergetool.meld.path || echo meld)"=0A=
+  $meld_path --help 2>&1=0A=
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
+		if test "$meld_has_output_option" =3D true -o \=0A=
+						"$meld_has_output_option" =3D false=0A=
+		then=0A=
+			: use configured value=0A=
+		else												# treat meld_has_output_option as "auto"=0A=
+			if test -z "$meld_help_msg"=0A=
+			then=0A=
+				meld_help_msg=3D"$(get_meld_help_msg)"=0A=
+			fi=0A=
+=0A=
+			if echo "$meld_help_msg" |=0A=
+							grep -e '--output=3D' -e '\[OPTION\.\.\.\]' >/dev/null=0A=
+			then=0A=
+				: old ones mention --output and new ones just say OPTION...=0A=
+				meld_has_output_option=3Dtrue=0A=
+			else=0A=
+				meld_has_output_option=3Dfalse=0A=
+			fi=0A=
+		fi=0A=
+	fi=0A=
+	# Check whether we should use 'meld --auto-merge ...'=0A=
+	if test -z "${meld_has_auto_merge_option:+set}"=0A=
 	then=0A=
-		: old ones mention --output and new ones just say OPTION...=0A=
-		meld_has_output_option=3Dtrue=0A=
-	else=0A=
-		meld_has_output_option=3Dfalse=0A=
+		meld_has_auto_merge_option=3D$(git config --bool =
mergetool.meld.hasAutoMerge)=0A=
+		if test "$meld_has_auto_merge_option" =3D true -o \=0A=
+						"$meld_has_auto_merge_option" =3D false=0A=
+		then=0A=
+			: use configured value=0A=
+		else												# treat meld_has_auto_merge_option as "auto"=0A=
+			if test -z "$meld_help_msg"=0A=
+			then=0A=
+					meld_help_msg=3D"$(get_meld_help_msg)"=0A=
+			fi=0A=
+=0A=
+			if echo "$meld_help_msg" | grep -e '--auto-merge' >/dev/null=0A=
+			then=0A=
+					meld_has_auto_merge_option=3Dtrue=0A=
+			else=0A=
+				meld_has_auto_merge_option=3Dfalse=0A=
+			fi=0A=
+		fi=0A=
 	fi=0A=
 }=0A=
-- =0A=
2.2.0=0A=
=0A=

------=_NextPart_000_F61B_01D64F14.2C5A8B80
Content-Type: application/octet-stream;
	name="meld"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="meld"

diff_cmd () {=0A=
	"$merge_tool_path" "$LOCAL" "$REMOTE"=0A=
}=0A=
=0A=
merge_cmd () {=0A=
	check_meld_for_features=0A=
=0A=
	option_auto_merge=3D=0A=
	if test "$meld_has_auto_merge_option" =3D true=0A=
	then=0A=
		option_auto_merge=3D"--auto-merge"=0A=
	fi=0A=
=0A=
	if test "$meld_has_output_option" =3D true=0A=
	then=0A=
		"$merge_tool_path" $option_auto_merge --output=3D"$MERGED" \=0A=
			"$LOCAL" "$BASE" "$REMOTE"=0A=
	else=0A=
		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"=0A=
	fi=0A=
}=0A=
=0A=
# Get meld help message=0A=
get_meld_help_msg () {=0A=
	meld_path=3D"$(git config mergetool.meld.path || echo meld)"=0A=
  $meld_path --help 2>&1=0A=
}=0A=
=0A=
# Check the features and set flags=0A=
check_meld_for_features () {=0A=
	# Check whether we should use 'meld --output <file>'=0A=
	if test -z "${meld_has_output_option:+set}"=0A=
	then=0A=
		meld_has_output_option=3D$(git config --bool mergetool.meld.hasOutput)=0A=
		if test "$meld_has_output_option" =3D true -o \=0A=
						"$meld_has_output_option" =3D false=0A=
		then=0A=
			: use configured value=0A=
		else												# treat meld_has_output_option as "auto"=0A=
			if test -z "$meld_help_msg"=0A=
			then=0A=
				meld_help_msg=3D"$(get_meld_help_msg)"=0A=
			fi=0A=
=0A=
			if echo "$meld_help_msg" |=0A=
							grep -e '--output=3D' -e '\[OPTION\.\.\.\]' >/dev/null=0A=
			then=0A=
				: old ones mention --output and new ones just say OPTION...=0A=
				meld_has_output_option=3Dtrue=0A=
			else=0A=
				meld_has_output_option=3Dfalse=0A=
			fi=0A=
		fi=0A=
	fi=0A=
	# Check whether we should use 'meld --auto-merge ...'=0A=
	if test -z "${meld_has_auto_merge_option:+set}"=0A=
	then=0A=
		meld_has_auto_merge_option=3D$(git config --bool =
mergetool.meld.hasAutoMerge)=0A=
		if test "$meld_has_auto_merge_option" =3D true -o \=0A=
						"$meld_has_auto_merge_option" =3D false=0A=
		then=0A=
			: use configured value=0A=
		else												# treat meld_has_auto_merge_option as "auto"=0A=
			if test -z "$meld_help_msg"=0A=
			then=0A=
					meld_help_msg=3D"$(get_meld_help_msg)"=0A=
			fi=0A=
=0A=
			if echo "$meld_help_msg" | grep -e '--auto-merge' >/dev/null=0A=
			then=0A=
					meld_has_auto_merge_option=3Dtrue=0A=
			else=0A=
				meld_has_auto_merge_option=3Dfalse=0A=
			fi=0A=
		fi=0A=
	fi=0A=
}=0A=

------=_NextPart_000_F61B_01D64F14.2C5A8B80--

