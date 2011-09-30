From: Cord Seele <cowose@googlemail.com>
Subject: [PATCH 2/2] use new Git::config_path() for aliasesfile
Date: Fri, 30 Sep 2011 12:52:25 +0200
Message-ID: <1317379945-9355-3-git-send-email-cowose@gmail.com>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <1317379945-9355-1-git-send-email-cowose@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 30 12:53:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9aib-0000KO-JK
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 12:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758240Ab1I3KxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 06:53:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64021 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758197Ab1I3KxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 06:53:20 -0400
Received: by mail-fx0-f46.google.com with SMTP id 4so2767989fxe.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wzWvl0ttEoaZJnaYBa1iewyZu7Ma2NsSB3GIACc5Qts=;
        b=G2nY93MqPhT3dGkagdXD9tzE1xpsbpIUWTZiAKfYLpyPO7E8DWiaburSBSZuQ6m7ek
         xNgilhaSI6kV1LyKUhzJSLExaMvk7uMaVqo0Vbi6nJ0lNobuyx+fKh/GNo5Wk9OpRECh
         38R1JjuvlpWvRPUUCnwYFkp7i76Yg365I2B9w=
Received: by 10.223.10.14 with SMTP id n14mr3233035fan.37.1317379999761;
        Fri, 30 Sep 2011 03:53:19 -0700 (PDT)
Received: from localhost.localdomain (p4FF1B6BF.dip.t-dialin.net. [79.241.182.191])
        by mx.google.com with ESMTPS id u6sm6209486faf.3.2011.09.30.03.53.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Sep 2011 03:53:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.4
In-Reply-To: <1317379945-9355-1-git-send-email-cowose@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182478>

Signed-off-by: Cord Seele <cowose@gmail.com>
---
 git-send-email.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 98ab33a..f17f7b3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -225,7 +225,6 @@ my %config_settings = (
     "cccmd" => \$cc_cmd,
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@bcclist,
-    "aliasesfile" => \@alias_files,
     "suppresscc" => \@suppress_cc,
     "envelopesender" => \$envelope_sender,
     "multiedit" => \$multiedit,
@@ -234,6 +233,10 @@ my %config_settings = (
     "assume8bitencoding" => \$auto_8bit_encoding,
 );
 
+my %config_path_settings = (
+    "aliasesfile" => \@alias_files,
+);
+
 # Help users prepare for 1.7.0
 sub chain_reply_to {
 	if (defined $chain_reply_to &&
@@ -330,6 +333,11 @@ sub read_config {
 		$$target = Git::config_bool(@repo, "$prefix.$setting") unless (defined $$target);
 	}
 
+	foreach my $setting (keys %config_path_settings) {
+		my $target = $config_path_settings{$setting}->[0];
+		$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
+	}
+
 	foreach my $setting (keys %config_settings) {
 		my $target = $config_settings{$setting};
 		next if $setting eq "to" and defined $no_to;
-- 
1.7.6.4
