Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A1EC433EF
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 17:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358896AbhK1R7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 12:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353027AbhK1R5e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 12:57:34 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7A1C061574
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 09:54:18 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id i9so20365243qki.3
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 09:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VinXOHulJ6ciaScHzD+UTj2vJdN4EsiiCnXwyjm0OTw=;
        b=bEWg6KkIu6p/2NN61M8qtxlQj5LOGcuS4dcEmM0iasuHxz2/fb7Z8noxSO7TrCMQRy
         CcxNSswPhSHShk+zMtaZIk8v5JiNTAY33q9FNXqUqUyPMIQbLJrYupq0KvRjLB+U6+n8
         xjFVcHvuBSyXw9cpTkzO8gz7LmpA3TcNZwnQ2inIshMpQddaXy8DwQ6XBeWjj+QfMYQZ
         TziETOQShUpPrWcWjFgbv4U6WqRKD39nWGORGpV8QnbDOXBVCMilSv6vmKxKrAHxbA5R
         o75nH77VaSSaALolxrWzQVXdQCbj+tyYvqUNqQoPREOl7GoDRhpEXkS8OBrXKDOwoplt
         t32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VinXOHulJ6ciaScHzD+UTj2vJdN4EsiiCnXwyjm0OTw=;
        b=OOYiG697TTxkPIMicVkudZoO8CrOnPzBqJ6JVFcrwc/ijkGQBxt0+gUMcDRs1nXIvE
         kSgX8xr72dpp1g0kAp/+xzwBdPLRLbV0o8aeLfobfMoD2xx82liT3Futn8MJyi7Xo0iZ
         PE1moPGE1TaLCLGDuxtFgR/KfAaxG+iAY3VaM3+T5XcN3sNNvhQ7Z/rNwXkMyCuDxWt1
         MYWAVdxQ2FalWB30DsB1fHsZCiqACpzYNMh5pbieDNlq90rGzcUfG5mfiNAMxPibxwIv
         MQs+2ciDhKNbgokxF3Nlquw5Tz9lIQ6Oq/zYlYWG94t4+DzwZGib7spP4udldnne6t9l
         jpPQ==
X-Gm-Message-State: AOAM530ewsZ3eSOguGW022aSSLBwJzjwgBC//Hh3pYADnDm8p4eDVUfd
        nLrXjDUND80aFbsJDxgASY8Om/3NfM4=
X-Google-Smtp-Source: ABdhPJwmMPpuIcUhnjGPLveXDCWxYODDwWosxtSdm7SeOldezMHb9HRdzcyvPT2hEEKIJvflPQ8Ypg==
X-Received: by 2002:a05:620a:25c8:: with SMTP id y8mr34647505qko.42.1638122057611;
        Sun, 28 Nov 2021 09:54:17 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o17sm6690064qkp.89.2021.11.28.09.54.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Nov 2021 09:54:17 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     tr@thomasrast.ch,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] add -p: avoid use of undefined $key when ReadKey -> EOF
Date:   Sun, 28 Nov 2021 09:49:03 -0800
Message-Id: <20211128174903.5623-1-carenas@gmail.com>
X-Mailer: git-send-email 2.34.0.352.g07dee3c5e1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b5cc003253 (add -i: ignore terminal escape sequences, 2011-05-17)
add an additional check to the original code to better handle keys
for escape sequences, but failed to account for the possibility
the first ReadKey call returned undef (ex: stdin closes) and that
was being handled fine by the original code in ca6ac7f135 (add -p:
prompt for single characters, 2009-02-05)

Add a test for undefined and encapsulate the loop and the original
print that relied on it within it.

After this, the following command (in a suitable repository state)
wouldn't print any error:

  $ git -c interactive.singleKey add -p </dev/null

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-add--interactive.perl | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index bc3a1e8eff..95887fd8e5 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1175,15 +1175,17 @@ sub prompt_single_character {
 		ReadMode 'cbreak';
 		my $key = ReadKey 0;
 		ReadMode 'restore';
-		if ($use_termcap and $key eq "\e") {
-			while (!defined $term_escapes{$key}) {
-				my $next = ReadKey 0.5;
-				last if (!defined $next);
-				$key .= $next;
+		if (defined $key) {
+			if ($use_termcap and $key eq "\e") {
+				while (!defined $term_escapes{$key}) {
+					my $next = ReadKey 0.5;
+					last if (!defined $next);
+					$key .= $next;
+				}
+				$key =~ s/\e/^[/;
 			}
-			$key =~ s/\e/^[/;
+			print "$key";
 		}
-		print "$key" if defined $key;
 		print "\n";
 		return $key;
 	} else {
-- 
2.34.0.352.g07dee3c5e1

