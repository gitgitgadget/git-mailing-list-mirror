Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905DCD37B1
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 00:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbjIPAik (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbjIPAiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 20:38:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F8F2D48
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 17:36:01 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414a929a6f9so15854711cf.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694824521; x=1695429321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSi8bLrOTMAUobwx7jt4tptljLX4JxVbk1grBj6UQV0=;
        b=DpyEnkVwMZOcj+F6OVM+YdNU+QTnwbPRnVFEp31yoZU5YRTTD2ElZJFv2J1Ym+7yab
         dqvfqV/QU7lgTnMG9DGQZkp6jWpjN6GWyXTCuPvPzJ7BBs25IkX4Cl/2jT3HcQT6ezzM
         9i5fYVhnXDPdQChdBHg0ER1kngsizXMweGeyVx+jeCvrL4OYJV8LmIUekBaQIvNgIIoR
         T8RCWhd2k17+ND9kbLvWzJ3xjTP2IfDm4mvAI31SeJ4LFM92JbVSr+oV1DRlJ63d3GF8
         4mn5mucwqRRpFd6Cp24p4YQ30W/kB4ZAgfU8l5jzShYSkJdGYafjLwd3Pc8t3wXPySm8
         UW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824521; x=1695429321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSi8bLrOTMAUobwx7jt4tptljLX4JxVbk1grBj6UQV0=;
        b=CLQW/Dh7EHqUo8/DLyOMh2pDc8/TyMF5Q4MQ45SupF9S/0Bjm+r6IWlNBurC6DMm5i
         RGrz7kRXrCUXwUE1TykkH9ambTmw4xGoOPxgR3Nc2eE7TLAVe1zL9odx3fu8GuDJ9KKG
         ZmvD/IXapbVoqgDx+2beIDEGACqd9eZJ9NOTEEM8gPqa9XeF0A4VGHrLwdXl6s1pGlF4
         bYV3cGvhVv4napXFzR8DffvBIx1f540aaB+bGawkxQWIDIetz5DxWxuDIvXcUL4PQd1p
         NtTCicetxt+tmYpE8PtWnroZjYEYEu7qk6XUC9/ijpYr3VoGn6TEEDXkAVjWedr1UjkW
         ohkg==
X-Gm-Message-State: AOJu0YzDTvOarUmPLI1iiByHbjiAfvf72+QsjLjjrwMDpxVpwsqnyZbW
        qJch/R3BjD92QOkovWqZT4fiqb9ZaUTh3g==
X-Google-Smtp-Source: AGHT+IFjqEHfGUG4uZz7gQsofwi5JaL17YuHi3DptkXjnbrChIXdyErtCu26cSZqkz6DH+RPhamQZw==
X-Received: by 2002:a05:620a:258a:b0:772:64b3:889f with SMTP id x10-20020a05620a258a00b0077264b3889fmr3417736qko.29.1694824521297;
        Fri, 15 Sep 2023 17:35:21 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id s4-20020a05620a16a400b0076d0312b8basm1552505qkj.131.2023.09.15.17.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 17:35:21 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     gitster@pobox.com, johannes.schindelin@gmx.de,
        me@yadavpratyush.com, git@vger.kernel.org
Cc:     Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-gui - re-enable use of hook scripts
Date:   Fri, 15 Sep 2023 20:35:16 -0400
Message-ID: <20230916003516.51053-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <454d8b7b-96df-ec8f-2285-e022de66c66c@gmail.com>
References: <454d8b7b-96df-ec8f-2285-e022de66c66c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit aae9560a introduced search in $PATH to find executables before
running them, avoiding an issue where on Windows a same named file in
the current directory can be executed in preference to anything on the
path. The updated search excludes files given with an absolute path (e.g.,
/bin/sh). However this change precludes operation of hook scripts as these
are named with a relative path (.git/hooks/$HOOK), while a search on $PATH
can succeed only for bare file names, not relative paths. Furthermore,
the current repository's .git/hooks directory is in general not listed
in PATH.

Fix this by changing the "absolute" check to a check for more than one
component in the pathname, thereby avoiding the PATH check for anything
given with a relative path as well. Bare "git" has one component, "/sh"
has two components, and .git/hooks/$HOOK has more than two, so relative
and absolute pathnames avoid the check.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8bc8892..8603437 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -118,7 +118,7 @@ proc sanitize_command_line {command_line from_index} {
 	set i $from_index
 	while {$i < [llength $command_line]} {
 		set cmd [lindex $command_line $i]
-		if {[file pathtype $cmd] ne "absolute"} {
+		if {[llength [file split $cmd]] < 2} {
 			set fullpath [_which $cmd]
 			if {$fullpath eq ""} {
 				throw {NOT-FOUND} "$cmd not found in PATH"
-- 
2.41.0.99.19

