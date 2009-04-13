From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 06/13] send-email: Handle "GIT:" rather than "GIT: " during --compose
Date: Mon, 13 Apr 2009 13:23:50 -0500
Message-ID: <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:33:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQxM-0001hq-0i
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbZDMSa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbZDMSa0
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:30:26 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:38019 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbZDMSaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:30:25 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1131585wah.21
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kEMPFslSuj/shesdeaBtjtYG3mDILDk82KOuf4cvf38=;
        b=BBIAD4Y4mA6IkoC3zvzV+hEK6RFmjamajX0FjVqucll5KLm0v/QRr7zL3qaruQCcGc
         xzNKIw0BtAup1ags5JudiQ5ER02a1KjuZXZxQLSJz76wcYdu6nH24HYPB92GAVhlmosh
         a640AjY9GILDswYzoaVXEXBCjYLhQeMnxdWm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oVr9W8WFA9jAgsbl/soXdY/+qHqVaMuntJViw32L9Al+WmT6P8A/wItjIOd7zdYsXC
         G6c1VaQzdHJ4vr587hharzTuAEXBzUAMcMena1as87OgncQ/daSoul67hwxJdrukulju
         0yZFZ31DCSbTVYT58v0S1wf3F2ACdJIsTfzbE=
Received: by 10.114.178.13 with SMTP id a13mr3286084waf.130.1239647424566;
        Mon, 13 Apr 2009 11:30:24 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.30.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:30:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116467>

This should make things a little more robust in terms of user input;
before, even the program got it wrong by outputting a line with only
"GIT:", which was left in place as a header, because there would be
no following space character.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5f01ad2..5bd818e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -534,7 +534,7 @@ if ($compose) {
 
 	print C <<EOT;
 From $tpl_sender # This line is ignored.
-GIT: Lines beginning in "GIT: " will be removed.
+GIT: Lines beginning in "GIT:" will be removed.
 GIT: Consider including an overall diffstat or table of contents
 GIT: for the patch you are writing.
 GIT:
@@ -567,7 +567,7 @@ EOT
 	my $in_body = 0;
 	my $summary_empty = 1;
 	while(<C>) {
-		next if m/^GIT: /;
+		next if m/^GIT:/;
 		if ($in_body) {
 			$summary_empty = 0 unless (/^\n$/);
 		} elsif (/^\n$/) {
-- 
1.6.2.2.479.g2aec
