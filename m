Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492092023D
	for <e@80x24.org>; Thu, 18 May 2017 11:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933627AbdERLfx (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 07:35:53 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33315 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933605AbdERLfo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 07:35:44 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so22597684pfh.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=r3+MjlTCZMv83A/RZnwiaK/W0x5t0f9KCTvxmtN1UJA=;
        b=DI3xFV9sPHygMpTodhp5wudLZ1685JTZlPFiyEBkxGsAi2HnT9Je5qCUKeDw+r7PRf
         FqzmjBxQyYAXjUqWGBKf/bzky4hpj3RQS/nSQJ+MElRq4WMFZjjr7yChLD7FppCPI0eq
         jpY8u4dhmNqKG1GpDMOT/mUJLUCvfZJXGEZx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r3+MjlTCZMv83A/RZnwiaK/W0x5t0f9KCTvxmtN1UJA=;
        b=oP++4P13RNrK1AVmzuWcPIboPYAbHuKcUZBSCyMHofbKKTCfJslAiEWBBjQVx1oGSk
         4c9+4PYmft877vf7Bzwgd321gPY/hhnXVWUBRuXJyBnJilQYwUpOsIpeXOxIhERIBylv
         xHa+H7xwa+0pHEZ/SB9byp/tf9S7Usf52vmLhQf1GQDzB+26CXIpG6Zh4LW2eB11TF/p
         6mP1yj3sm1a/OaewVGCKHUaGWBGV/ZUnciKREyBjjO7aF7VZNJ2TKariC9W0cIbSr/L6
         9dhFoz5wUGUz4w49hK2LLbINsTyyomQK1gSiAXoRvswT4HsWO3p2E8mmH8Yl/Pq9TD5h
         RMfg==
X-Gm-Message-State: AODbwcCtijniKhR+kIibdGRsGtoMMXBt8gZZpJDTBVyeQgZQX5HuGe+w
        8AvGFjQ+Y8jgdtsy
X-Received: by 10.99.160.17 with SMTP id r17mr416918pge.37.1495107338901;
        Thu, 18 May 2017 04:35:38 -0700 (PDT)
Received: from localhost ([122.172.129.253])
        by smtp.gmail.com with ESMTPSA id q27sm9823294pfk.4.2017.05.18.04.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 04:35:38 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] send-email: Add tocmd option to suppress-cc
Date:   Thu, 18 May 2017 17:05:33 +0530
Message-Id: <6367777092d93a62cc83c444061dde853ba3369e.1495107179.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.13.0.70.g6367777092d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds tocmd option to suppress-cc command which already supports
cccmd and others.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/git-send-email.txt | 1 +
 git-send-email.perl              | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9d66166f69d9..f1634f7db3df 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -307,6 +307,7 @@ Automating
   patch body (commit message) except for self (use 'self' for that).
 - 'sob' will avoid including anyone mentioned in Signed-off-by lines except
    for self (use 'self' for that).
+- 'tocmd' will avoid running the --to-cmd.
 - 'cccmd' will avoid running the --cc-cmd.
 - 'body' is equivalent to 'sob' + 'bodycc'
 - 'all' will suppress all auto cc values.
diff --git a/git-send-email.perl b/git-send-email.perl
index eea0a517f71b..cc3cd984aee4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -85,7 +85,7 @@ git send-email --dump-aliases
     --identity              <str>  * Use the sendemail.<id> options.
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
+    --suppress-cc           <str>  * author, self, sob, cc, tocmd, cccmd, body, bodycc, all.
     --[no-]cc-cover                * Email Cc: addresses in the cover letter.
     --[no-]to-cover                * Email To: addresses in the cover letter.
     --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
@@ -435,13 +435,13 @@ my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
 		die sprintf(__("Unknown --suppress-cc field: '%s'\n"), $entry)
-			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/;
+			unless $entry =~ /^(?:all|tocmd|cccmd|cc|author|self|sob|body|bodycc)$/;
 		$suppress_cc{$entry} = 1;
 	}
 }
 
 if ($suppress_cc{'all'}) {
-	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
+	foreach my $entry (qw (tocmd cccmd cc author self sob body bodycc)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'all'};
@@ -1582,7 +1582,7 @@ foreach my $t (@files) {
 	close $fh;
 
 	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
-		if defined $to_cmd;
+		if defined $to_cmd && !$suppress_cc{'tocmd'};
 	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
 		if defined $cc_cmd && !$suppress_cc{'cccmd'};
 
-- 
2.13.0.70.g6367777092d9

