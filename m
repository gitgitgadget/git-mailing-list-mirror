Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0CBCD4844
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 16:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjIVQoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 12:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjIVQoV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 12:44:21 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E185BA1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 09:44:15 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d77ad095f13so2786457276.2
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695401055; x=1696005855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5U+PrwaKUNQ232kHEiR0b/YEG0wS6UMiBCI6a7cQM8=;
        b=VonAqzS4uqMDUvHAC+cPesAhVKaOjbIPB4oNjTjDpJe1L8xXEvQZE0MGwVvs/2KwE8
         atLKiJ62PmXqbfOHNiU+4NJI1/GfqQ4cNkEBj0WZ6YTvdIR7qI0OeBKJHE2OqfR0cj1+
         P+hmwhhHYyej/NR4suLtcxo3zMOo20VZzMjM1xdbWkgT/3v6Dq3pB+r44lKoPeMN9h98
         5GSozgr50a+Qv/ZQXr/Pj8Arxg3cNl9iuK0oqKslmREzRmVhZ5EOPgM+dldLuCF4IP1Z
         epT8CTSvBSFiYpf4fPCcR7byjqF/4rHPm001lxWkctzUMApPvhTF9diMAanPpr+et4pN
         BULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695401055; x=1696005855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5U+PrwaKUNQ232kHEiR0b/YEG0wS6UMiBCI6a7cQM8=;
        b=an/LfTkSJF3p8Cms1h9i9t8n4qhUc/IyqXF8OOf1h9qBm2tzS/cA4zNRXB0h1wZ9M8
         1gpPu+pgv/HXA9UyvxstaTY00sABHKyTjT8yRo5INVMRqyHluL6h1dZ3LHlSjEMy6WKS
         noFIgI9A60pu0H15vmUX5tzdriSVIjdZE+Q1Mwu8ro2Rr/kdR0JKTUUA94yhVRXLehK2
         lqj7ylRPrF3Wf5S1ypyUg7JjIwa6Ub/Q/s0dFWWYLVW1gl0OQ0C6zfClEYiFxY/o56rv
         cp+UjcfAzVIUsfLqMh2ZmXu/cRnXjFtQ73AiMEy9N+VaJUGLHwC5RisM375r42dOsKFY
         YM7g==
X-Gm-Message-State: AOJu0YwQ5V2xhqrBU9WUKJUR6Pd6jE0hgIakfPDfj2MC77VvELdDT6UG
        cBP6nOHqklMUk74r4N0B83ZDT4x1qYs=
X-Google-Smtp-Source: AGHT+IHHgUo7D4kreUBa5GRiCD+2mdJY7imn8x0NHkmA+wZLOxsNDXh6J4vEjHD0q60/yVVbtVvj7g==
X-Received: by 2002:a5b:b0e:0:b0:d7e:8603:abc6 with SMTP id z14-20020a5b0b0e000000b00d7e8603abc6mr9065818ybp.5.1695401054970;
        Fri, 22 Sep 2023 09:44:14 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id fc11-20020ad44f2b000000b0065ae23ef077sm591198qvb.126.2023.09.22.09.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:44:14 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com,
        "Mark Levedahl Date: Tue, 19 Sep 2023" <mlevedahl@gmail.com>
Subject: [PATCH] git-gui - simplify _open_stdout_stderr
Date:   Fri, 22 Sep 2023 12:44:12 -0400
Message-ID: <20230922164412.130504-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Mark Levedahl Date: Tue, 19 Sep 2023" <mlevedahl@gmail.com>

Since b792230 ("git-gui: Show a progress meter for checking out files",
2007-07-08), git-gui includes a workaround for Tcl that does not support
using 2>@1 to redirect stderr to stdout. Tcl added such support in
8.4.7, released in 2004, while the later 8.4.14 still predated git-gui.
But, Cygwin was stuck on an 8.4.1 Tcl variant until 2011, hence the need
for this workaround. Commit 7145c65 recently removed much other specific
code for that obsolete Cygwin Tcl/Tk, but missed this piece.

Also, Tcl since 8.5 explicitly supports 2>@1 across all platforms, and
git-gui requires Tcl >= 8.5, further evidence the workaround is
obsolete.  (I did test that 2>@1 works as-expected on current Linux,
Cygwin, and Git For Windows Tcl packages).

Remove the workaround and exploit concat's documented capability to
handle both scalar and list arguments, leaving a much simpler function.
This eliminates any question that cmd might be executed twice.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8bc8892..a5d008d 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -583,25 +583,8 @@ proc git {args} {
 
 proc _open_stdout_stderr {cmd} {
 	_trace_exec $cmd
-	if {[catch {
-			set fd [open [concat [list | ] $cmd] r]
-		} err]} {
-		if {   [lindex $cmd end] eq {2>@1}
-		    && $err eq {can not find channel named "1"}
-			} {
-			# Older versions of Tcl 8.4 don't have this 2>@1 IO
-			# redirect operator.  Fallback to |& cat for those.
-			# The command was not actually started, so its safe
-			# to try to start it a second time.
-			#
-			set fd [open [concat \
-				[list | ] \
-				[lrange $cmd 0 end-1] \
-				[list |& cat] \
-				] r]
-		} else {
-			error $err
-		}
+	if {[catch {set fd [open [concat | $cmd] r]} err]} {
+		error $err
 	}
 	fconfigure $fd -eofchar {}
 	return $fd
-- 
2.41.0.99.19

