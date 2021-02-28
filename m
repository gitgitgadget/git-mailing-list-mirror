Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F077FC433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 23:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00C064E56
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 23:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhB1XM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 18:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhB1XM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 18:12:57 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358E1C06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 15:12:17 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u20so15765284iot.9
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 15:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMlKvrT/Nl24yI2aKOUy7V5oR1oXbQnOg/cNEBOuJec=;
        b=GU4QKrrSPJLxbvLFei6pA6sMETuhSmZ9jjmnKAflQOmLgq/gMhQVZeVAe8NdtU/jKH
         7KfEap5Kh8edDM9oRJxNa98BcguIdsucyHcAFDIh59IEIX+2NQTriTPlRC7Tmn2VCvWo
         5px4Fsa4+GzlfxCYOiPm7kX6ke8ZXccxFDzvoVIK5lfhbTI0WrWNOmktULentsr7hKuK
         SN8q0qqIQeXEBSi4QmHeQv6X6vYWhOKHgPu+U1T6ZWJd0pAAtPGRzQ5qVUZbL13lFCAV
         TZ/Rssz4daRpwi3EgGQiJhRCns3wp49vMLP04UDGtQI0forPkt2fwi1lkPWiusA0ykYz
         Ouvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LMlKvrT/Nl24yI2aKOUy7V5oR1oXbQnOg/cNEBOuJec=;
        b=fhxo4gg72f/eh52bEAqx5SNM6Jo1e1k4pv2FcIMmaykeEOis+NYuFz9D2x/oWfK7G0
         FAsudYQ4qk297z0F4TQalsRAQIhU4ZzyPX1rVpL48fTOfzIOpUtMEwC6SEfVIOGDx2Wo
         Oj+1tvfKWgtzr4b/MeGW7ZfEKYtp86iWcbB8+THQxc4r5pkTvpz3EdUTIbyMofgVad3o
         XLJqdEixDB7mEtZnRr4cuPwGhHAXhV7ldQ+jmdLyzhUiPjB1yZqpa1NDg4ZzTp/PX+2i
         /MNh1YpMMj5U19DxSoT1c+FpCri+ix8TieLz/wrqo9IDw5jpQR2jYJx233AtPSbmhwvu
         Zjhw==
X-Gm-Message-State: AOAM531IOJK2FW+RS0AEVzUecGbe07GOfSf+Apc4qBZoL4S6j7u8qqH1
        5fTYZabsUpYxYrzUDASbGEFZgtW17ac=
X-Google-Smtp-Source: ABdhPJz2WgvBa+RKGLkoZW3UOHlWTGu+CA1idhQ3L6MMGhHJp4wANJTZ93aA/vpiQKyOXrbWbZKSFg==
X-Received: by 2002:a02:9349:: with SMTP id e9mr13277376jah.75.1614553936557;
        Sun, 28 Feb 2021 15:12:16 -0800 (PST)
Received: from localhost.localdomain (097-070-162-226.res.spectrum.com. [97.70.162.226])
        by smtp.gmail.com with ESMTPSA id t9sm2068051ioi.27.2021.02.28.15.12.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Feb 2021 15:12:16 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] git-gui: fix commit message comment line removal with older Tcl versions
Date:   Sun, 28 Feb 2021 18:11:10 -0500
Message-Id: <20210228231110.24076-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.31.0.rc0.254.gbdcc3b1a9d
In-Reply-To: <https://lore.kernel.org/git/CAPig+cT-sfgMDi9-6AEKF85NtOiXeqddJjk-pYuhDtTVAE-UEw@mail.gmail.com/>
References: <https://lore.kernel.org/git/CAPig+cT-sfgMDi9-6AEKF85NtOiXeqddJjk-pYuhDtTVAE-UEw@mail.gmail.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-gui was recently enhanced to remove comment lines from the commit
message similar to the way git-commit does so (see `core.commentchar`
and `git-stripspace`). Unfortunately, that change employs features which
are unavailable in older versions of Tcl, such as 8.5.9 which is shipped
with macOS (10.13), with the result that the commit operation errors
out.

There are two problems. First, to add a new informational message to the
main window, it invokes string method `cat` which does not exist in
older Tcl. Fix this by using `append` instead.

Second, when passing the commit message through git-stripspace, it
closes the "write" side of the bidirectional pipe after sending the
commit message to git-stripspace in order to avoid deadlock before
reading back the result, however the ability to close only one end of a
pipe is not present in older Tcl. Fix this by employing a temporary file
to received the output of git-stripspace.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

I'm not a Tcl programmer, so I may have overlooked better or more
idiomatic ways to fix these problems. There might be some reliable and
portable way to write and read a bidirectional pipe in older Tcl
without deadlocking and without using non-blocking I/O and an
event-loop, but I didn't find it, so I went with the simpler approach
of using a temporary file.

 git-gui.sh     |  3 +--
 lib/commit.tcl | 12 +++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 236bc4e61d..c04b37b9ee 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3439,8 +3439,7 @@ proc trace_commit_type {varname args} {
 	}
 
 	set comment_char [get_config core.commentchar]
-	set txt [string cat $txt \
-				 [mc " (Lines starting with '$comment_char' will be ignored)"]]
+	append txt [mc " (Lines starting with '$comment_char' will be ignored)"]
 	$ui_coml conf -text $txt
 }
 trace add variable commit_type write trace_commit_type
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 23d67d4651..3a51e80b8a 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -142,16 +142,18 @@ proc setup_commit_encoding {msg_wt {quiet 0}} {
 }
 
 proc strip_msg {msg} {
-	set cmd [concat [list | ] [_git_cmd stripspace] --strip-comments]
+	set strip_p [gitdir GITGUI_EDITMSG_STRIP]
+	set cmd [concat [list | ] [_git_cmd stripspace] --strip-comments [list >$strip_p]]
 	_trace_exec $cmd
-	set fd [open $cmd r+]
+	set fd [open $cmd w]
 	fconfigure $fd -translation binary -encoding utf-8
-
 	puts -nonewline $fd $msg
-	close $fd w
-	set result [read $fd]
 	close $fd
 
+	set fd [open $strip_p r]
+	set result [read $fd]
+	close $fd
+	file delete $strip_p
 	return $result
 }
 
-- 
2.31.0.rc0.1.g37593106bf
