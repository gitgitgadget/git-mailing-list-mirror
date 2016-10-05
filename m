Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358DC1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754751AbcJERWO (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:22:14 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:37780 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754738AbcJERWN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:22:13 -0400
Received: (qmail 2333 invoked from network); 5 Oct 2016 17:22:11 -0000
Received: (qmail 11642 invoked from network); 5 Oct 2016 17:22:11 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 5 Oct 2016 17:22:06 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/14] i18n: add--interactive: mark edit_hunk_manually message for translation
Date:   Wed,  5 Oct 2016 17:21:04 +0000
Message-Id: <20161005172110.30801-9-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.366.g8a57a7a
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark message of edit_hunk_manually displayed in the editing file when
user chooses 'e' option.  The message had to be unfolded to allow
translation of the $participle verb.

Some messages end up being exactly the same for some uses cases, but
left it for easier change in the future, e.g., wanting to change wording
of one particular use case.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 35967fe..5356d5a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1058,6 +1058,30 @@ sub color_diff {
 	} @_;
 }
 
+my %edit_hunk_manually_modes = (
+	stage => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for staging."),
+	stash => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for stashing."),
+	reset_head => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for unstaging."),
+	reset_nothead => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for applying."),
+	checkout_index => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for discarding"),
+	checkout_head => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for discarding."),
+	checkout_nothead => __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for applying."),
+);
+
 sub edit_hunk_manually {
 	my ($oldtext) = @_;
 
@@ -1065,22 +1089,21 @@ sub edit_hunk_manually {
 	my $fh;
 	open $fh, '>', $hunkfile
 		or die sprintf(__("failed to open hunk edit file for writing: %s"), $!);
-	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
+	print $fh __("# Manual hunk edit mode -- see bottom for a quick guide\n");
 	print $fh @$oldtext;
-	my $participle = $patch_mode_flavour{PARTICIPLE};
 	my $is_reverse = $patch_mode_flavour{IS_REVERSE};
 	my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') : ('+', '-');
-	print $fh <<EOF;
-# ---
-# To remove '$remove_minus' lines, make them ' ' lines (context).
-# To remove '$remove_plus' lines, delete them.
+	print $fh sprintf(__(
+"# ---
+# To remove '%s' lines, make them ' ' lines (context).
+# To remove '%s' lines, delete them.
 # Lines starting with # will be removed.
-#
-# If the patch applies cleanly, the edited hunk will immediately be
-# marked for $participle. If it does not apply cleanly, you will be given
+#\n"), $remove_minus, $remove_plus),
+$edit_hunk_manually_modes{$patch_mode}, __(
+# TRANSLATORS: 'it' refers to the patch mentioned in the previous messages.
+" If it does not apply cleanly, you will be given
 # an opportunity to edit again. If all lines of the hunk are removed,
-# then the edit is aborted and the hunk is left unchanged.
-EOF
+# then the edit is aborted and the hunk is left unchanged.\n");
 	close $fh;
 
 	chomp(my $editor = run_cmd_pipe(qw(git var GIT_EDITOR)));
-- 
2.7.4

