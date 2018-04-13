Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EEEC1F424
	for <e@80x24.org>; Fri, 13 Apr 2018 10:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeDMKaW (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 06:30:22 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39707 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbeDMKaT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 06:30:19 -0400
Received: by mail-wm0-f41.google.com with SMTP id b21so3307930wme.4
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUc4z6Ox2/CW36gzUCtH1XNT4YGy3cmw3cWZ5LAbt14=;
        b=Uj34uxlcYfKDw5I9PxDHvD9oibq8IVm0+8yRbd5WWhLCh+jwryZHz7KRbldEZxRxFu
         NftUF0uQIz/xDSR8xa1chNsh48pIk6WM3NbeKfIi7osewmO9OlJZY6md6JROxEXK36bl
         wa71ej3rDLkDyrSZBsSy7PnwEyilSswYELOunEZvZ1ELV5upHjH/IEaQxf62VzIeI/YX
         4NjZXlc+EcJkaw+/Gaf5xw0hIO2L4auE0QdszftSwQmfA0uq5kBtlPzj068tcHYdm2FC
         0DJ5bvSdksEnOQ5SK6x4sJGuSVwty66IQlF2RlbJ9sR7UVLOJyz6SV2me4XBD7GGO7fs
         Oi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUc4z6Ox2/CW36gzUCtH1XNT4YGy3cmw3cWZ5LAbt14=;
        b=gSsdCUr5WTEPlPzD58y8xfTwIV7aiXZ+u9LNOfGVbBthE8CWb0lKS1eB4R+Y6oEmg0
         ayhICGq9T6lfpGO/PB3AOrI6juYLNyCr9c2PuaK4hXr/TlnNkl6p992zxlyrkEVdKbm2
         ZRt/2hIb2AuNLOwM4rbOrtgNEBaMBs2jb95otpaYrQoFq0/a5cnC4uPl2lWk8VXZ8HEa
         3HuwORpi4kLtjzco+msCFrCZzxL3jubWhKjhI4DxMfBwP4bj+2zOCxsvnzYHSRAV0v1+
         8ckuE1j8Qm9extvE+PqUywfPV19qk8Bk34bAio1vd/wI6jbeFKAOevt1tBhsKKwYNtYM
         /43A==
X-Gm-Message-State: ALQs6tB4NX5zQqN0Msyf79r87Tu6qhXJoeNKygK4s/tDgywzaPSrAlLJ
        jl8Y08zM/5BLk7lBbv9zYKF/pg==
X-Google-Smtp-Source: AIpwx4/0CJPYKvg9SiVlvMuW0gv1Jx9Wsd3rCKYLOw+wPQmt0zqpYHCQggZ/wkX14hl4flH+k0tkng==
X-Received: by 10.28.45.9 with SMTP id t9mr3050425wmt.161.1523615418393;
        Fri, 13 Apr 2018 03:30:18 -0700 (PDT)
Received: from localhost.localdomain (x4db27fa3.dyn.telefonica.de. [77.178.127.163])
        by smtp.gmail.com with ESMTPSA id j21sm7325551wrb.49.2018.04.13.03.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Apr 2018 03:30:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] completion: reduce overhead of clearing cached --options
Date:   Fri, 13 Apr 2018 12:30:05 +0200
Message-Id: <20180413103005.671-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
References: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To get the names of all '$__git_builtin_*' variables caching --options
of builtin commands in order to unset them, 8b0eaa41f2 (completion:
clear cached --options when sourcing the completion script,
2018-03-22) runs a 'set |sed s///' pipeline.  This works both in Bash
and in ZSH, but has a higher than necessasry overhead with the extra
processes.

In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
builtin command, which lists the same variables, but without a
pipeline and 'sed' it can do so with lower overhead.

This change also happens to work around an issue reported by users of
the Powerline shell prompt on macOS, which was triggered by the same
commit 8b0eaa41f2 as well.  Powerline uses several Unicode Private Use
Area code points to represent some of its pretty text UI elements
(arrows and what not), and these are stored in the $PS1 variable.
Apparently the 'set' builtin command of the default Bash version shipped
in macOS (3.2.57) has issues with these code points, and produces
garbled output where Powerline's special symbols should be in the $PS1
variable.  This, in turn, triggers the following error message in the
downstream 'sed' process:

  sed: RE error: illegal byte sequence

Other Bash versions, notably 4.4.19 on macOS (via homebrew) and 3.2.25
on CentOS don't seem to be affected.

With this patch neither the 'set' builtin is invoked to print garbage,
nor 'sed' to choke on it.

Issue-on-macOS-reported-by: Stephon Harris <theonestep4@gmail.com>
Issue-on-macOS-explained-by: Matthew Coleman <matt@1eanda.com>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b09c8a2362..4ef59a51be 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -282,7 +282,11 @@ __gitcomp ()
 
 # Clear the variables caching builtins' options when (re-)sourcing
 # the completion script.
-unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
+if [[ -n ${ZSH_VERSION-} ]]; then
+	unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
+else
+	unset $(compgen -v __gitcomp_builtin_)
+fi
 
 # This function is equivalent to
 #
-- 
2.17.0.366.gbe216a3084

