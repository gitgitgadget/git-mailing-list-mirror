Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6129C20A17
	for <e@80x24.org>; Sun, 22 Jan 2017 19:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbdAVTaf (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 14:30:35 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:33821 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdAVTae (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 14:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1485113432;
        l=1136; s=domk; d=benjaminfuchs.de;
        h=Date:Subject:Cc:To:From;
        bh=ycpZnARi2ReZbwTkKh7HpS+cnomlLUKGXvxm5YK8Hmw=;
        b=W1972RIYhGD4855n5GUXtYVxmj4rZJmnElXMBiVTsYJo+u9viMDD7S4Y1tlnefoE04
        JyaXvrDSYf1LnYDAeDvQmjDW926gFUBW6pP0+NJHtKZ2MjxauKst187gxkslDa3xPBDr
        7rxQ7HD8K9fKo9csaawcuWSwSwLfpbQmNycEg=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCeXqAJxZfrWfVMhxHI84=
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.poststrasse57.local (p4FF7640E.dip0.t-ipconnect.de [79.247.100.14])
        by smtp.strato.de (RZmta 39.11 DYNA|AUTH)
        with ESMTPSA id V096c3t0MJUTHRT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 22 Jan 2017 20:30:29 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, sbeller@google.com, email@benjaminfuchs.de
Subject: [PATCH 3/3] git-prompt.sh: fix for submodule 'dirty' indicator
Date:   Sun, 22 Jan 2017 20:30:21 +0100
Message-Id: <1485113421-22264-1-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixing wrong git diff line.
---
 contrib/completion/git-prompt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c44b9a2..43b28e9 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -306,9 +306,9 @@ __git_ps1_submodule ()
 	local submodule_name="$(basename "$git_dir")"
 	if [ "$submodule_name" != ".git" ] && [ "$submodule_name" != "." ]; then
 		local parent_top="${git_dir%.git*}"
-		local submodule_top="${git_dir#*modules}"
+		local submodule_top="${git_dir#*modules/}"
 		local status=""
-		git diff -C "$parent_top" --no-ext-diff --ignore-submodules=dirty --quiet -- "$submodule_top" 2>/dev/null || status="+"
+		git -C "$parent_top" diff --no-ext-diff --ignore-submodules=dirty --quiet -- "$submodule_top" 2>/dev/null || status="+"
 		printf "$status$submodule_name:"
 	fi
 }
@@ -544,7 +544,7 @@ __git_ps1 ()
 
 	local sub=""
 	if [ -n "${GIT_PS1_SHOWSUBMODULE}" ]; then
-		sub="$(__git_ps1_submodule $g)"
+		sub="$(__git_ps1_submodule "$g")"
 	fi
 
 	local f="$w$i$s$u"
-- 
2.7.4

