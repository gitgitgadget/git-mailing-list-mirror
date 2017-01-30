Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A26C20D11
	for <e@80x24.org>; Mon, 30 Jan 2017 20:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbdA3UpQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 15:45:16 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:20550 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbdA3UpO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 15:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1485809112;
        l=1194; s=domk; d=benjaminfuchs.de;
        h=References:In-Reply-To:Date:Subject:Cc:To:From;
        bh=lxSIXGKhzsXh/w5aOF77t9ExdzzZSw0iliQS+emAdno=;
        b=s8WSDdvZzJRn8eq1QdgqRbekVbCHWAHiw1MOaLHUy5peW+fzS9L5S5lh02/7XupXe7
        rRwUZEmw/r6Fauk+FIuzJO8rLNdzAV6jeyJE3ua7FI+Yy7InHxxW68Q1ompT/e7AJpCA
        HeEcBPabXVsMGcMjWYKZQq8f+57yECRvwU7Mk=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCdlhhPcjKRjsJ00UGWq4=
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.poststrasse57.local (p5499AE19.dip0.t-ipconnect.de [84.153.174.25])
        by smtp.strato.de (RZmta 39.11 DYNA|AUTH)
        with ESMTPSA id x0accft0UKiZLRU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 30 Jan 2017 21:44:35 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, sbeller@google.com,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi,
        Benjamin Fuchs <email@benjaminfuchs.de>
Subject: [PATCH 3/4] git-prompt.sh: fix for submodule 'dirty' indicator
Date:   Mon, 30 Jan 2017 21:44:24 +0100
Message-Id: <1485809065-11978-4-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixing wrong git diff line.

Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>
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

