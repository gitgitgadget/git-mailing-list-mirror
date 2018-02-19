Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C521F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeBSL3e (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:29:34 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:37361 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752651AbeBSL3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:29:25 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njdCe9qQuoNnDnjdMeU69X; Mon, 19 Feb 2018 11:29:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519039764;
        bh=FbeVRTIGxk+n8NtD9SilyIdopibp/9kBXabhmkTh6hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=RGbAITrPRe0t6IyNAUFtIZyOqCpECeimsVrn8DHIs6/HXgOWewsPawQoYmtuAq9hd
         ywZ9gC8rLp1DodWvwypy0FGfygn0rgWALPfxWAzJnMiIt4r41j+vzVKZy0DKC8xJGa
         E0twSQFCdi5q9HvuU8bp75ilL5vjFX615IS3qzE4=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=kkUEi7dfBpwlOXnPvS8A:9
 a=z2bXthiuOIam2nBN:21 a=hEE-zIYjV4AsxFf3:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 9/9] add -p: don't rely on apply's '--recount' option
Date:   Mon, 19 Feb 2018 11:29:10 +0000
Message-Id: <20180219112910.24471-10-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180219112910.24471-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGntb76DMRoFAubR+Z+KHc9x6WKiKggqClgHjTj9cAIl9IDm1oo6ahXdlrCgHXvy0aTlqKunhDw92wjOpzLg008Bpzt+W5AT0ibiajLJkVzQbb0DqPI9
 yDkwlazJrmHpFO4sYya8dRoJjPl0AsmgR6U+eS607MgTMLvhLEELbN7Ftx/qxSEgLWR9l0AA6Wu7hd6CaIT1oPpeJSQNLgpmb2yTidKM9oMWE8fJXJIzNaxU
 3z51crKSM6Mr4/YkFR9NehNhNC59kASnF5e1Ex16U7O/udHVDu1mrQPz6RVLCKhn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that add -p counts patches properly it should be possible to turn
off the '--recount' option when invoking 'git apply'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    I can't think of a reason why this shouldn't be OK but I can't help
    feeling slightly nervous about it. I've made it a separate patch so it
    can be easily dropped or reverted if I've missed something.

 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3226c2c4f02d5f8679d77b8eede984fc727b422d..a64c0db57d62ab02ef718b8c8f821105132d9920 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -677,7 +677,7 @@ sub add_untracked_cmd {
 sub run_git_apply {
 	my $cmd = shift;
 	my $fh;
-	open $fh, '| git ' . $cmd . " --recount --allow-overlap";
+	open $fh, '| git ' . $cmd . " --allow-overlap";
 	print $fh @_;
 	return close $fh;
 }
-- 
2.16.1

