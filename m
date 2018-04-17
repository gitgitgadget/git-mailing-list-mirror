Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A131E1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 22:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeDQWCZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 18:02:25 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:38424 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeDQWCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 18:02:24 -0400
Received: by mail-wr0-f181.google.com with SMTP id h3so26868522wrh.5
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 15:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TjpR39p98/TkXUzp8T1ciXAuc/z6qzNbFcj7LX++HtE=;
        b=fRXDKHaSwBcaJTFei9fWGSSUvIHmFs4tNHqjtWfHxr2X1+OkOlARjnhaSvqvW7nYw2
         wmccMvs0Gjrtj+ZzU1s5RP+3mxg14Tj37AeSxY+j/MtWskbxrf+ukBvyEAE+y8i6r6SD
         d8VFTu6VCpLbS1oAWUYc039Iez+WCMsfFTtFMc1vclanldqh6wdTeJljPfr+DP9SHGdG
         i2CAs0H0kWIbhyfJZXvA4qKWgpHCaWO7Z+anNKmr9r9ATVerasx45MX+qSH7iblMGbEp
         ht7+wUpIRmpMEOng5WHVucCEm/SW2jAiVGmUsZwEUFDjQGvnyrqpLdeaO/X96MlKur5J
         QlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TjpR39p98/TkXUzp8T1ciXAuc/z6qzNbFcj7LX++HtE=;
        b=i8WBbpvw1Cynj70I6hw4BUh4rcOpauZTszCDevGDEJ283sVthJ6iB49zR61zJXp0rE
         Z7pShelcyXqEH3Q/oI1GkmQrcLex+fTDz5EyLqAiVYpZWk4IJe7Xm3OZTMuu5jyV46AG
         jDlCPnjXe+GvUUD+8cP7GQ5NTUnvzgnLivWvLMJuInuUj06z0BU89GMRgsjvT6F41Rjd
         V5AlOAvjOffveNu84xge4yQTel32QSaO+vxspuWAsNCWZvkAr4cAeYfzg567QnvSfv1d
         DGhx30n93/OianlzRJuVh/LVBZQunof3ZQo7fL01vfL4ZwytYADt2ZKq6R31WppBBL5y
         sQLg==
X-Gm-Message-State: ALQs6tDbEjyMbvwz3ACRdVxhIN8k2jGhzRpagO7U7bk99nR1U78/2s0c
        zRnsE7pi6sYbYcxDufnDn+w=
X-Google-Smtp-Source: AIpwx4/+hlA6jMXGIJ760GROm+1Y7lphgpxo76PVJ3kEE8DxbCJWB0/hu9gQZkEWXe8qCE6N9NSpbw==
X-Received: by 10.223.196.182 with SMTP id m51mr2943907wrf.126.1524002543422;
        Tue, 17 Apr 2018 15:02:23 -0700 (PDT)
Received: from localhost.localdomain (x4db1b530.dyn.telefonica.de. [77.177.181.48])
        by smtp.gmail.com with ESMTPSA id b185sm10255618wmb.48.2018.04.17.15.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Apr 2018 15:02:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] completion: reduce overhead of clearing cached --options
Date:   Wed, 18 Apr 2018 00:02:19 +0200
Message-Id: <20180417220219.30445-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
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
and in ZSH, but has a higher than necessary overhead with the extra
processes.

In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
builtin command, which lists the same variables, but without a
pipeline and 'sed' it can do so with lower overhead.
ZSH will still continue to run that pipeline.

This change also happens to work around an issue in the default Bash
version shipped in macOS (3.2.57), reported by users of the Powerline
shell prompt, which was triggered by the same commit 8b0eaa41f2 as
well.  Powerline uses several Unicode Private Use Area code points to
represent some of its pretty text UI elements (arrows and what not),
and these are stored in the $PS1 variable.  Apparently the 'set'
builtin of said Bash version on macOS has issues with these code
points, and produces garbled output where Powerline's special symbols
should be in the $PS1 variable.  This, in turn, triggers the following
error message in the downstream 'sed' process:

  sed: RE error: illegal byte sequence

Other Bash versions, notably 4.4.19 on macOS via homebrew (i.e. a
newer version on the same platform) and 3.2.25 on CentOS (i.e. a
slightly earlier version, though on a different platform) are not
affected.  ZSH in macOS (the versions shipped by default or installed
via homebrew) or on other platforms isn't affected either.

With this patch neither the 'set' builtin is invoked to print garbage,
nor 'sed' to choke on it.

Issue-on-macOS-reported-by: Stephon Harris <theonestep4@gmail.com>
Issue-on-macOS-explained-by: Matthew Coleman <matt@1eanda.com>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Updated the commit message to explicitly mention that ZSH is
unaffected.  The patch is the same.

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

