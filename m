From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 06/10] gitweb: allow action specialization in page header
Date: Sun, 24 Oct 2010 12:45:32 +0200
Message-ID: <1287917136-26103-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5x-0004rf-Qz
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474Ab0JXKqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:46:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45935 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab0JXKqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:46:11 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so2370311wyf.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hX/oE0jsW8VTqxfJsy/L52oQogxEZuWxNb6wQyhyoeg=;
        b=gFKOZbr0ezTeIFVrjGcw1R1lCH67MB1NNItoC6lSQBPesCQfuOILrMzsrXVTh7y1oV
         lT/my9aeiZrjje07S3yRaSzL3PXigRSw91aYJWYb2YEGQIrqq9NNR1Aq5fgVFD4Ef6Fn
         6A7Bcr/2MNBPIz3ofyhSkqVZ2vQ38ScQgS+oE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OgXa+CuX6M/YzBtKeHqA04URyVRpzZkX3k0VchcMbvLPkIX5SEtgSBCmZoXMfORxoI
         habInOvenmklukp1GHYZTx4TWDeoH7mdcWo40AuHyP24U+UvQLsvCqRHYVvInDkFVQhd
         bR/tlXReGY5b3V1Ua15N0/76mhglQzIkFKKrY=
Received: by 10.227.135.9 with SMTP id l9mr3169893wbt.49.1287917170357;
        Sun, 24 Oct 2010 03:46:10 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id i19sm4509876wbe.23.2010.10.24.03.46.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:46:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159851>

An optional -action_extra parameter is given to git_header_html() to
identify a variant of the action that is being displayed. For example,
this can be used to specify that the remotes view is being used for a
specific remote and not to display all remotes.

When -action_extra is provided, the action name in the header will be
turned into a link to the action without any arguments or parameters, to
provide a quick link to the non-specific variant of the action.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a381892..3612e63 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3529,7 +3529,15 @@ EOF
 	if (defined $project) {
 		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
 		if (defined $action) {
-			print " / $action";
+			my $action_print = $action ;
+			if (defined $opts{-action_extra}) {
+				$action_print = $cgi->a({-href => href(action=>$action)},
+					$action);
+			}
+			print " / $action_print";
+		}
+		if (defined $opts{-action_extra}) {
+			print " / $opts{-action_extra}";
 		}
 		print "\n";
 	}
-- 
1.7.3.68.g6ec8
