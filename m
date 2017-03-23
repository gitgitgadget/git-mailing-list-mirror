Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95CB720958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935167AbdCWPiv (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:38:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36320 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934412AbdCWPis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:38:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id x124so17361857wmf.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xh5wg3JrEkkRgIROnVt69y/5VZD+JUfOo2QWf6Jw4GY=;
        b=JCPtlXpkKje5FvQnayZbTMskkZjCL3JoR9PJVpirIszHNukhc6fD9aU8GO4qbV30SZ
         GR89swmAtnl7YsYAv67pKodE+qyR+DXEZbKzA7HKACaaxN0zR6x8yVbdKTAKBejnC7WB
         eqZGrEuBJ6b5F/mo01sxHrtaeEnNQ30L0XvjFUtGPjtUo1smqV+9Nw51+A4Iq+4ptsiv
         DRMmEIq+upMzJRowrNE6z0mEKiiFCZ3AgHtWceUy61CRiujUlCjZGcVXGAE+y3lcyhGa
         aGNcVvaJylXi3OEZ94CmsLRgkeaAZbqWHySI36IK9oiw37dsTk3Bi/rDle47M345wn3f
         x2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xh5wg3JrEkkRgIROnVt69y/5VZD+JUfOo2QWf6Jw4GY=;
        b=P9c0zXaDvn+n91KLvWX1p2zXm77mr0n1mB4LopOVxzCPwPIOM2l0ZBjMsQvcNF7iGr
         RzkPJ5mSabBp0qr9rPTQlibdYeDQLT497w8iW9RhrWTkZNHx6AG8R2xCCRynbM77oVll
         MqkKUNwPNKNGlsx8nZcniI/e8dlv7A8FGV1bXOqUC3eQwOY/8nH/Jy3CuROTQ891IT7F
         w+JFP5EpBi43+gwhN5IyWU5+DMwE2Q38yW6LEmCrUCEf7hh6l4viaaYLtu8QCIw+hNLq
         cIuqeyHqSAbvypdmiEpF3gKCAO2+K2zkD1v4sDVDxrcZRMIR4olYhWTLyZbhzOMQYnrN
         p9iA==
X-Gm-Message-State: AFeK/H1Ww8EkmFMTEZvR1oLUE4vdtxyBLieS54HvHW5ndFY2yA3Jhv3axh3PO9X6q7BrjQ==
X-Received: by 10.28.26.3 with SMTP id a3mr3295690wma.26.1490283526923;
        Thu, 23 Mar 2017 08:38:46 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id b13sm4793766wmf.6.2017.03.23.08.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:38:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] completion: put matching ctags symbol names directly into COMPREPLY
Date:   Thu, 23 Mar 2017 16:38:37 +0100
Message-Id: <20170323153839.24283-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323153839.24283-1-szeder.dev@gmail.com>
References: <20170323153839.24283-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The one-liner awk script in __git_match_ctag() listing ctags symbol
names for 'git grep <TAB>' is already smart enough to list only symbol
names matching the current word to be completed.

Extend this helper function to accept prefix and suffix parameters to
be prepended and appended, respectively, to each listed symbol name in
the awk script, so its output won't require any additional processing
or filtering in the completion script before being handed over to
Bash.  Use the faster __gitcomp_direct() helper instead of
__gitcomp_nl() to fill the fully processed matching symbol names into
Bash's COMPREPLY array.

Right after 'git grep <TAB>' in current git.git with 14k+ symbol names
in the tag file, best of five:

  Before:

    $ time __gitcomp_nl "$(__git_match_ctag "" tags)"

    real    0m0.178s
    user    0m0.176s
    sys     0m0.000s

  After:

    $ time __gitcomp_direct "$(__git_match_ctag "" tags "" " ")"

    real    0m0.058s
    user    0m0.048s
    sys     0m0.008s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    It's still just a simple linear search through the tags file, so there
    are no miracles: it's still hopelessly, unusably slow e.g. in the
    Linux repository.

 contrib/completion/git-completion.bash | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 69eabc2bc..5cacb0e2e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1518,8 +1518,15 @@ _git_gitk ()
 	_gitk
 }
 
-__git_match_ctag() {
-	awk "/^${1//\//\\/}/ { print \$1 }" "$2"
+# Lists matching symbol names from a tag (as in ctags) file.
+# 1: List symbol names matching this word.
+# 2: The tag file to list symbol names from.
+# 3: A prefix to be added to each listed symbol name (optional).
+# 4: A suffix to be appended to each listed symbol name (optional).
+__git_match_ctag () {
+	awk -v pfx="${3-}" -v sfx="${4-}" "
+		/^${1//\//\\/}/ { print pfx \$1 sfx }
+		" "$2"
 }
 
 _git_grep ()
@@ -1548,7 +1555,7 @@ _git_grep ()
 	case "$cword,$prev" in
 	2,*|*,-*)
 		if test -r tags; then
-			__gitcomp_nl "$(__git_match_ctag "$cur" tags)"
+			__gitcomp_direct "$(__git_match_ctag "$cur" tags "" " ")"
 			return
 		fi
 		;;
-- 
2.12.1.498.gded7ead47

