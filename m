Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7061F211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 16:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbeLZQI7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 11:08:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38529 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeLZQI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 11:08:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so8007918pfi.5
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 08:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n9HGIRMvW66uGr5/81nE6DisSixT7/+NHe6kKUwAnek=;
        b=P+rd5saKu887no1pgdHcqvATftt/Xj34+wH3chb+hoGuzB0oSM0JPtikv7VlkLro+N
         TCsW3UCaC92/C8lcifQuB/6lbk12V8Fk0wd6bm2Ue8NWKVlieX4LXxAFRLaCfRV2O8B+
         01PDfdFV/oPCFXWWzbSesVGmmqDU2BiUgBQLzbAwx5zn/hkng1JcelGN/mXJOlI9g8dy
         1OfeOpARtH93TwUJ2lzeyip5Npb8t/OBQ3RCqOZeXV3+IAPG66c0JQQUJG8frKDah7L8
         PtAzETReRnSI+n7M9p3pLL7ulVhqEGiYl3TerNzkBIzPDxf9aKOm125YRzccabW/cLKH
         pG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n9HGIRMvW66uGr5/81nE6DisSixT7/+NHe6kKUwAnek=;
        b=qEoBnDudqbZsrkEOx0bjxl05LCugv69lmDvMs285rgAw0NXZPKwypd9tzoOdXqnKWe
         cAd/ray1BQYxuTt+/ENpj/DSf1aRiCE6SwXiMzCi9/iOETpjeL3CN7qj2XK6SDNMUrL7
         PjyPoPh6MZ3cX8OKSxp7EoITmi5IqJ0i5sgc70jfmcVJA2J9u6X0l3BSIKb73hz+xbPN
         Cvyva0OZke7FU8p0wmzy1LsXMgipknXc7krnGn+3K4M+WA6lH6XbYyYR0UtNc69fI3wY
         7DKLtHcWGr3/CQ/4ndadVML2fIqlmfdr0P4WqZyv8Hp/jeSYzL/yx0mO1wOsvCb1jVk0
         Ny1Q==
X-Gm-Message-State: AJcUukdUxGhF3PkdymNxnPCIETVhk/NcbqqFkfTBX0S0+dqid88QEDX0
        sm4ighrbHnNhuvDnrvL/A9bPlxRq
X-Google-Smtp-Source: ALg8bN4DK3MEZjG1z+/RXE6s2zeHsEsBjt7OqWOJWKjg/PaY/E0OgVNmRqMfeGcNrifrlbO/kx8XIQ==
X-Received: by 2002:a63:f65:: with SMTP id 37mr19352556pgp.238.1545840537575;
        Wed, 26 Dec 2018 08:08:57 -0800 (PST)
Received: from localhost.localdomain ([39.119.71.29])
        by smtp.gmail.com with ESMTPSA id p2sm51614773pgc.94.2018.12.26.08.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 08:08:56 -0800 (PST)
From:   Chayoung You <yousbe@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] completion: escape metacharacters when completing paths
Date:   Thu, 27 Dec 2018 01:08:35 +0900
Message-Id: <20181226160835.66342-1-yousbe@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following is the description of -Q flag of zsh compadd [1]:

  This flag instructs the completion code not to quote any
  metacharacters in the words when inserting them into the command line.

Let's say there is a file named 'foo bar.txt' in repository, but it's
not yet added to the repository. Then the following command triggers a
completion:

  git add fo<Tab>
  git add 'fo<Tab>
  git add "fo<Tab>

The completion results in bash:

  git add foo\ bar.txt
  git add 'foo bar.txt'
  git add "foo bar.txt"

While them in zsh:

  git add foo bar.txt
  git add 'foo bar.txt'
  git add "foo bar.txt"

The main cause of this behavior is __gitcomp_file_direct(). The both
implementions of bash and zsh are called with an argument 'foo bar.txt',
but only bash adds a backslash before a space on command line.

[1]: http://zsh.sourceforge.net/Doc/Release/Completion-Widgets.html

Signed-off-by: Chayoung You <yousbe@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 contrib/completion/git-completion.zsh  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9e8ec95c3..816ee3280 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2993,7 +2993,7 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 
 		local IFS=$'\n'
 		compset -P '*[=:]'
-		compadd -Q -f -- ${=1} && _ret=0
+		compadd -f -- ${=1} && _ret=0
 	}
 
 	__gitcomp_file ()
@@ -3002,7 +3002,7 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 
 		local IFS=$'\n'
 		compset -P '*[=:]'
-		compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
+		compadd -p "${2-}" -f -- ${=1} && _ret=0
 	}
 
 	_git ()
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 049d6b80f..886bf95d1 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -99,7 +99,7 @@ __gitcomp_file_direct ()
 
 	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -f -- ${=1} && _ret=0
+	compadd -f -- ${=1} && _ret=0
 }
 
 __gitcomp_file ()
@@ -108,7 +108,7 @@ __gitcomp_file ()
 
 	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
+	compadd -p "${2-}" -f -- ${=1} && _ret=0
 }
 
 __git_zsh_bash_func ()
-- 
2.20.1

