Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C1F1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 09:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFGJao (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 05:30:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44858 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfFGJao (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 05:30:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so592849pll.11
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdFSrPBK/HQzPi3E2A5x4e5wz+eMdQkSc7Myd0d6fyY=;
        b=gQFaDCY6W/a+7kRZJ+ytZGFK4s7m6keFbahzB1Id01bZdWCVoSRLQ9DQ8ZV7nD7GVE
         6nuiPxSazzTL5wtmtQgYlvOquLlgMEO5EkdZsCH90nnEij02C11SJZGjrsndUOunHCWG
         g6jUgAmmk58DS874DcA0Hiw+73IsLmVY/IWL61eb/nYba0ADyOdugMel4c5vGwrOCJtU
         dKMV1ZDW6O/PmCuZ4QR7vPRadkiMiX/UPK2vjUia2cw5mfGabHVScWuoUHXEsNonzYO6
         zqtEdS75ZwPoE3XineekVFAH/aAY5CxlpqvNk0Awg74QtnOJTLp8tFMz8NzFu3p/Zkmp
         eQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdFSrPBK/HQzPi3E2A5x4e5wz+eMdQkSc7Myd0d6fyY=;
        b=tRzlJjiXHGSFRfOZBwUSZ2WA49S/6zCfuIN0Tv1BooHIpeoi8QdC1DSN9eUgXAlZ1k
         qzjwdlvoroF6um1r81WjeihTuhRLIIE7hcBA6HDBxWgzw/XsR85161iVGo5AHsB8qkj8
         EO5I90NyRcsaj9xlDXOWHj83WRbb+3pRnv5OATn97zqDIX7ro8wJCIIGOhudVrvoYd40
         teyUnJKa+DFoHU7HcP2UzM85KadveDOK0lyfIJ0JteIhj0kHNkAud6czopHPAd9FIiGu
         kzGtMD1h08/MJ+jv9QW+W10n8GNc9tZ85xsgJYSxBYSziRsunwK+FuGcfzeO1dRqj+Pb
         svqg==
X-Gm-Message-State: APjAAAXSRqwx1to3dtGx5+D6EGygT313PdsHGJtTgrF0iU3pjIkNgXJ/
        sMMG/UrJojkMEEn8qxA0K9A=
X-Google-Smtp-Source: APXvYqy+zHMgBnoik8CQitL4XoguGnmRzQnqm8sKWt1v/WZDhU4C7bhhpQx6+AY1/9JqJ+EnGME39A==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr47209053plr.73.1559899843286;
        Fri, 07 Jun 2019 02:30:43 -0700 (PDT)
Received: from ash ([115.76.191.0])
        by smtp.gmail.com with ESMTPSA id j20sm1883939pff.183.2019.06.07.02.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 02:30:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 07 Jun 2019 16:30:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     felipe.contreras@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        szeder.dev@gmail.com
Subject: [PATCH] completion: do not cache if --git-completion-helper fails
Date:   Fri,  7 Jun 2019 16:30:34 +0700
Message-Id: <20190607093034.816-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190607022443.5706-1-felipe.contreras@gmail.com>
References: <20190607022443.5706-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git <cmd> --git-completion-helper" could fail if the command checks for
a repo before parse_options(). If the result is cached, later on when
the user moves to a worktree with repo, tab completion will still fail.

Avoid this by detecting errors and not cache the completion output. We
can try again and hopefully succeed next time (e.g. when a repo is
found).

Of course if --git-completion-helper fails permanently because of other
reasons (*), this will slow down completion. But I don't see any better
option to handle that case.

(*) one of those cases is if __gitcomp_builtin is called on a command
  that does not support --git-completion-helper. And we do have a
  generic call

    __git_complete_common "$command"

  but this case is protected with __git_support_parseopt_helper so we're
  good.

Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f71bcde96..a515de8501 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -398,13 +398,15 @@ __gitcomp_builtin ()
 	eval "options=\$$var"
 
 	if [ -z "$options" ]; then
+		local nocache=
 		# leading and trailing spaces are significant to make
 		# option removal work correctly.
-		options=" $incl $(__git ${cmd/_/ } --git-completion-helper) "
+		options=" $incl $(__git ${cmd/_/ } --git-completion-helper) " || nocache=t
+
 		for i in $excl; do
 			options="${options/ $i / }"
 		done
-		eval "$var=\"$options\""
+		test -n "$nocache" || eval "$var=\"$options\""
 	fi
 
 	__gitcomp "$options"
-- 
2.22.0.rc0.322.g2b0371e29a

