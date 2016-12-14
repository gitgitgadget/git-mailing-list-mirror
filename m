Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9CA1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 12:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755634AbcLNMzo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 07:55:44 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:56598 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755604AbcLNMzn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 07:55:43 -0500
Received: (qmail 2061 invoked from network); 14 Dec 2016 12:55:38 -0000
Received: (qmail 26050 invoked from network); 14 Dec 2016 12:55:38 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 14 Dec 2016 12:55:38 -0000
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
Subject: [PATCH v7 01/16] Git.pm: add subroutines for commenting lines
Date:   Wed, 14 Dec 2016 11:54:24 -0100
Message-Id: <20161214125439.8822-2-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.44.g7d42c6c
In-Reply-To: <20161214125439.8822-1-vascomalmeida@sapo.pt>
References: <20161214125439.8822-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add subroutines prefix_lines and comment_lines.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 perl/Git.pm | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index b2732822a..bfce1f795 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1438,6 +1438,44 @@ sub END {
 
 } # %TEMP_* Lexical Context
 
+=item prefix_lines ( PREFIX, STRING [, STRING... ])
+
+Prefixes lines in C<STRING> with C<PREFIX>.
+
+=cut
+
+sub prefix_lines {
+	my $prefix = shift;
+	my $string = join("\n", @_);
+	$string =~ s/^/$prefix/mg;
+	return $string;
+}
+
+=item get_comment_line_char ( )
+
+Gets the core.commentchar configuration value.
+The value falls-back to '#' if core.commentchar is set to 'auto'.
+
+=cut
+
+sub get_comment_line_char {
+	my $comment_line_char = config("core.commentchar") || '#';
+	$comment_line_char = '#' if ($comment_line_char eq 'auto');
+	$comment_line_char = '#' if (length($comment_line_char) != 1);
+	return $comment_line_char;
+}
+
+=item comment_lines ( STRING [, STRING... ])
+
+Comments lines following core.commentchar configuration.
+
+=cut
+
+sub comment_lines {
+	my $comment_line_char = get_comment_line_char;
+	return prefix_lines("$comment_line_char ", @_);
+}
+
 =back
 
 =head1 ERROR HANDLING
-- 
2.11.0.44.g7d42c6c

