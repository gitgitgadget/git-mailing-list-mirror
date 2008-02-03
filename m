From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 2/7] git-remote - Unset core.origin when deleting the default remote
Date: Sun,  3 Feb 2008 12:20:44 -0500
Message-ID: <1202059249-3532-3-git-send-email-mlevedahl@gmail.com>
References: <1202059249-3532-1-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-2-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Feb 03 18:22:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLiXW-00062p-BD
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758631AbYBCRVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758594AbYBCRVE
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:21:04 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:26412 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757833AbYBCRVB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:21:01 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1624551fkz.5
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3iQYQdw1Zn94wZDYCSD4lHdBKi7ZlGWBvS0TpS3fcG8=;
        b=Sx1AE467AH/6mrudRAi8owq9d0jbdYhn5hSiXCLecZdEtAp2fZFnbX4SPKtk5klxm083vmZSKktSXT79TewQSkGr48PQVXOKzWak2rF0n10C4NXtvJhjxJiGuF74zg8eeO3HbwqYb+iUx8wBOSTWeQC5MfazcEkqTMQDcrTk4EU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=o1HOxbCIHo7B85gfbhhrTzRLLHEZMl3E6HKdHfyHulEBQwddIgUjcgObmqKJ8BrN08SKN2D2G63jO3z5NrgtZZvrphP3UwG5oFETsjQmThTVd0DCe/8uTzjHvBc4K/B1sCIKTYuoDJl+xwd/bwNP6YQUda8Oz+Uco07PQaMOU/U=
Received: by 10.78.161.4 with SMTP id j4mr10545538hue.49.1202059260472;
        Sun, 03 Feb 2008 09:21:00 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id x6sm4293526gvf.0.2008.02.03.09.20.57
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:20:59 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
In-Reply-To: <1202059249-3532-2-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72375>

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-remote.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index d13e4c1..75d2371 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -328,6 +328,11 @@ sub rm_remote {
 
 	$git->command('config', '--remove-section', "remote.$name");
 
+	my $defremote = $git->config("core.origin");
+	if (defined $defremote && $defremote eq $name) {
+	       $git->command("config", "--unset", "core.origin");
+	}
+
 	eval {
 	    my @trackers = $git->command('config', '--get-regexp',
 			'branch.*.remote', $name);
-- 
1.5.4.18.g43c18
