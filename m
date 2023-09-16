Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E7DC2BA12
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 21:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjIPVCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 17:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbjIPVBm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 17:01:42 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C716DCDE
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 14:01:36 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-65649b49ff1so3370296d6.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694898096; x=1695502896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mADQ7QySCCqaLTg8zXRDBd05hcCqaKTmAuAyKbJjH4k=;
        b=bM1tLOCxgScIitHXjuoUWN4fT1G5i0iBwTxuy3ZTFJCnD/fLi1epUIeG6vTMv5i4gW
         jvgYOIPcCQAjdGwC8yxke1tLe4q5df739g7/F8g0ffBBEPAUnnyMsyzSGIvq5zlZHyRk
         ydK0nFXmGsPh0GyyOFOBSbRZ6TEyxBaQOKyABZkOmp2ImefKGjmSAt3J6lYyXBk1dW5d
         XSTuJ/Xu5rCYekdlVTLZTKtNliZEHko0nG2B3m9yspitB/A3w7Vazoz92k1s0SunUkTw
         KS7NBqTXdw/vPdqWMayufFT/89atOpuxcFHJbKvI4AZLHzJEMn56Oy6Ctq/B3Jjx3H/d
         TnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694898096; x=1695502896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mADQ7QySCCqaLTg8zXRDBd05hcCqaKTmAuAyKbJjH4k=;
        b=F6FvHRm5GlZ64z80MWkxia5xe6uewDLHO01YeFCiGrYlUa60PhVseG2qZUlEbdmtfN
         tDghW9mRQMY+TLyM8jB1i9CrPBR8gLVH+PLWI6PRSqYq3ATy9FVHYww3OpoRrE/uglFz
         M5Lor5l5yjKZ304DDIwKOEWt5S8lGNh21d4VUMrs1zG+lFwCz8mcHvNzakThprLBjNcT
         O+K+uQzHuGcEeVUBxUTuOPAsNk9VlSioN6hZQ5N1x02hcZBIH9TXAFzT56KafzbuvOFc
         aEnqzJGsbC9oSnh91Herv9Nq5APcj5QY8Kgu1LZRXB9C/DBT0TW+iQx5wMzqmysXp9AU
         ebvw==
X-Gm-Message-State: AOJu0YzDf9AUnFQLAiAsqFe7MOyIYq6Urbo5XTlv1yntWgNS61qgZ5vD
        53zy4mIaGPw8iYQYXCThh64=
X-Google-Smtp-Source: AGHT+IGvyquvmqxGKRDEUCyRa0xE5CGCdVToHd+A478fT5i+4vD8oAt37otEp5to9YyLK3gWbD0pew==
X-Received: by 2002:a05:6214:9c9:b0:653:5736:c0b4 with SMTP id dp9-20020a05621409c900b006535736c0b4mr5283606qvb.54.1694898095853;
        Sat, 16 Sep 2023 14:01:35 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id k4-20020a0cf584000000b0064f70c57531sm2236741qvm.57.2023.09.16.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 14:01:35 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     gitster@pobox.com, johannes.schindelin@gmx.de,
        me@yadavpratyush.com, git@vger.kernel.org
Cc:     Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2] git-gui - re-enable use of hook scripts
Date:   Sat, 16 Sep 2023 17:01:31 -0400
Message-ID: <20230916210131.78593-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <xmqqy1h6auy7.fsf@gitster.g>
References: <xmqqy1h6auy7.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier, commit aae9560a introduced search in $PATH to find executables
before running them, avoiding an issue where on Windows a same named
file in the current directory can be executed in preference to anything
in a directory in $PATH. This search is intended to find an absolute
path for a bare executable ( e.g, a function "foo") by finding the first
instance of "foo" in a directory given in $PATH, and this search works
correctly.  The search is explicitly avoided for an executable named
with an absolute path (e.g., /bin/sh), and that works as well.

Unfortunately, the search is also applied to commands named with a
relative path. A hook script (or executable) $HOOK is usually located
relative to the project directory as .git/hooks/$HOOK. The search for
this will generally fail as that relative path will (probably) not exist
on any directory in $PATH. This means that git hooks in general now fail
to run. Considerable mayhem could occur should a directory on $PATH be
git controlled. If such a directory includes .git/hooks/$HOOK, that
repository's $HOOK will be substituted for the one in the current
project, with unknown consequences.

This lookup failure also occurs in worktrees linked to a remote .git
directory using git-new-workdir. However, a worktree using a .git file
pointing to a separate git directory apparently avoids this: in that
case the hook command is resolved to an absolute path before being
passed down to the code introduced in aae9560a.

Fix this by replacing the test for an "absolute" pathname to a check for
a command name having more than one pathname component. This limits the
search and absolute pathname resolution to bare commands. The new test
uses tcl's "file split" command. Experiments on Linux and Windows, using
tclsh, show that command names with relative and absolute paths always
give at least two components, while a bare command gives only one.

	  Linux:   puts [file split {foo}]       ==>  foo
	  Linux:   puts [file split {/foo}]      ==>  / foo
	  Linux:   puts [file split {.git/foo}]  ==> .git foo
	  Windows: puts [file split {foo}]       ==>  foo
	  Windows: puts [file split {c:\foo}]    ==>  c:/ foo
	  Windows: puts [file split {.git\foo}]  ==> .git foo

The above results show the new test limits search and replacement
to bare commands on both Linux and Windows.

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

