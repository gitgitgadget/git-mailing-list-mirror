Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0EC2035F
	for <e@80x24.org>; Fri, 11 Nov 2016 12:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756598AbcKKMqF (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 07:46:05 -0500
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:46111 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756262AbcKKMqD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 07:46:03 -0500
Received: (qmail 25989 invoked from network); 11 Nov 2016 12:46:01 -0000
Received: (qmail 4506 invoked from network); 11 Nov 2016 12:46:01 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 11 Nov 2016 12:46:01 -0000
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
Subject: [PATCH v6 15/16] i18n: send-email: mark composing message for translation
Date:   Fri, 11 Nov 2016 11:45:40 -0100
Message-Id: <20161111124541.8216-16-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.rc0.33.gec17dab
In-Reply-To: <20161111124541.8216-1-vascomalmeida@sapo.pt>
References: <20161111124541.8216-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When composing an e-mail, there is a message for the user whose lines
are beginning in "GIT:" that can be marked for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-send-email.perl | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 7f3297cdf..068d60b3e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -672,18 +672,20 @@ if ($compose) {
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
 
-	print $c <<EOT;
+	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
 From $tpl_sender # This line is ignored.
-GIT: Lines beginning in "GIT:" will be removed.
-GIT: Consider including an overall diffstat or table of contents
-GIT: for the patch you are writing.
-GIT:
-GIT: Clear the body content if you don't wish to send a summary.
+EOT1
+Lines beginning in "GIT:" will be removed.
+Consider including an overall diffstat or table of contents
+for the patch you are writing.
+
+Clear the body content if you don't wish to send a summary.
+EOT2
 From: $tpl_sender
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
 
-EOT
+EOT3
 	for my $f (@files) {
 		print $c get_patch_subject($f);
 	}
-- 
2.11.0.rc0.33.gec17dab

