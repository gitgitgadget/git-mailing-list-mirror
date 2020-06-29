Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD40BC433E1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFB220663
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="FVgHb81D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbgF2UvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbgF2TNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:30 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43735C008771
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 02:08:09 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id l6so14586907qkc.6
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 02:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:thread-index:content-language;
        bh=wt5QepBw/8eG/pJJ/hmhbh/UIaeviIL+uFKN+UVtQ9E=;
        b=FVgHb81Dugscr9tzwVuOQNidYCz5/6/w+EgTybvAaFqfNru9UjcOQSvHhbbUrLKdSK
         fUhbzFu0CYwuiH+44pV6EP45I/l3u1Uh6uLCZ6PYRYJiHTm2XkoF3uGjo19pvPl5NdSZ
         psFw1AfDoIfUkapFMLr1Woc6T7H1bN+ss6/Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:thread-index:content-language;
        bh=wt5QepBw/8eG/pJJ/hmhbh/UIaeviIL+uFKN+UVtQ9E=;
        b=Jhn6LjrDiH1l09RbxK9pUDHvF7JbrWqd8qLFfj0i0LQj7o8DT9Gt4T0o+ehMME3fFF
         T7VSbPR0nETdwXH9mQFWZ6DZmaTmPy7z74CLII8Q81LcpBACssn209LHj1zyT6n5rN2A
         rF02PgeQtqYF732Q08/1gv0FSx9616WIMsXA8ec40ETTL9h1gz8rMcVPGo6cRVQJjxJh
         1uES37lT5SbgpXhwhFvYQjrm8dDLo1l9qjgryPYQswGiDSZnsdUa/1OEGpJKHSkw+f/k
         aphOpZVc9wCA3qHwDCX1OOc1wSK9HXBmhEI7+NuCLxrGJfoXJfPX6Cz6ZC/pj6fPAWNn
         9ulA==
X-Gm-Message-State: AOAM532lMbGft23ANtgSGtcKPmoq4MgjKZoFQpcXECLUlk5u9+BBOpxy
        2LABEW7fM5hyXAAMR5E4HntqgQ==
X-Google-Smtp-Source: ABdhPJw2DTYoEZPoqA6X65RrFcJ5iDAuakkNZKu4KWYQRzrVUbww9LBcfCa4d1KyZorPe4ub/JaDbQ==
X-Received: by 2002:a37:8142:: with SMTP id c63mr11251851qkd.97.1593421688016;
        Mon, 29 Jun 2020 02:08:08 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id d78sm15378553qkg.106.2020.06.29.02.08.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 02:08:07 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>, "'David Aguilar'" <davvid@gmail.com>
Cc:     "'Pratyush Yadav'" <me@yadavpratyush.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>
References: <311401d63e0e$b1ffe490$15ffadb0$@zoom.us> <0c2401d64d14$aeafa680$0c0ef380$@zoom.us> <20200628103755.GB26319@danh.dev>
In-Reply-To: <20200628103755.GB26319@danh.dev>
Subject: RE: [PATCH v2] Enable auto-merge for meld to follow the vim-diff beharior
Date:   Mon, 29 Jun 2020 17:08:02 +0800
Message-ID: <bfc401d64df4$cd189e70$6749db50$@zoom.us>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_BFC5_01D64E37.DB3CA1C0"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHphUzghMrol5AeU7CziB+seEvqZAIML4LCAhTxLhOop7WB0A==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_BFC5_01D64E37.DB3CA1C0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Danh,

> It seems like only David Aguilar (Cc-ed) works on that file.
>Look into  b12d04503b (mergetools/meld: make usage of `--output` =
configurable and more robust, 2014-10-15), it looks like we need to =
check if --auto-merge option is available in meld.
>Someone still live with the ancient tools ;).
>meld has known --output for a long time but we still have a check for =
it.

Thank you for your hints, I changed the patch for checking the option =
"--auto-merge" in meld and use this option only if it's available.
The last patch is appended in attachment, or =
https://github.com/git/git/commit/3b70fd0bfc4086a08e27c869ff7492d567e8fdc=
2

Look forward it can be merged this time.=20
Thanks

Regards
Lin

------=_NextPart_000_BFC5_01D64E37.DB3CA1C0
Content-Type: application/octet-stream;
	name="0001-Enable-auto-merge-for-meld-to-follow-the-vim-diff-be.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Enable-auto-merge-for-meld-to-follow-the-vim-diff-be.patch"

From 3b70fd0bfc4086a08e27c869ff7492d567e8fdc2 Mon Sep 17 00:00:00 2001=0A=
From: "lin.sun" <lin.sun@zoom.us>=0A=
Date: Thu, 7 May 2020 07:31:14 +0800=0A=
Subject: [PATCH] Enable auto-merge for meld to follow the vim-diff =
beharior=0A=
=0A=
The mergetool "meld" does NOT merge the no-conflict changes, while the=0A=
mergetool "vimdiff" will merge the no-conflict parts and highlight the=0A=
conflict parts.=0A=
This patch will make the mergetool "meld" similar to "vimdiff",=0A=
auto-merge the no-conflict parts, highlight conflict parts.=0A=
=0A=
Signed-off-by: Lin Sun <lin.sun@zoom.us>=0A=
---=0A=
 mergetools/meld | 32 ++++++++++++++++++++++++++++++--=0A=
 1 file changed, 30 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/mergetools/meld b/mergetools/meld=0A=
index 7a08470..91b65ff 100644=0A=
--- a/mergetools/meld=0A=
+++ b/mergetools/meld=0A=
@@ -7,13 +7,23 @@ merge_cmd () {=0A=
 	then=0A=
 		check_meld_for_output_version=0A=
 	fi=0A=
+	if test -z "${meld_has_auto_merge_option:+set}"=0A=
+	then=0A=
+		check_meld_for_auto_merge_version=0A=
+	fi=0A=
+=0A=
+	option_auto_merge=3D=0A=
+	if test "$meld_has_auto_merge_option" =3D true=0A=
+	then=0A=
+		option_auto_merge=3D"--auto-merge"=0A=
+	fi=0A=
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
@@ -34,3 +44,21 @@ check_meld_for_output_version () {=0A=
 		meld_has_output_option=3Dfalse=0A=
 	fi=0A=
 }=0A=
+=0A=
+# Check whether we should use 'meld --auto-merge ...'=0A=
+check_meld_for_auto_merge_version () {=0A=
+	meld_path=3D"$(git config mergetool.meld.path)"=0A=
+	meld_path=3D"${meld_path:-meld}"=0A=
+=0A=
+	if meld_has_auto_merge_option=3D$(git config --bool =
mergetool.meld.hasAutoMerge)=0A=
+	then=0A=
+		: use configured value=0A=
+	elif "$meld_path" --help 2>&1 |=0A=
+		grep -e '--auto-merge' -e '\[OPTION\.\.\.\]' >/dev/null=0A=
+	then=0A=
+		: old ones mention --auto-merge and new ones just say OPTION...=0A=
+		meld_has_auto_merge_option=3Dtrue=0A=
+	else=0A=
+		meld_has_auto_merge_option=3Dfalse=0A=
+	fi=0A=
+}=0A=
-- =0A=
2.2.0=0A=
=0A=

------=_NextPart_000_BFC5_01D64E37.DB3CA1C0--

