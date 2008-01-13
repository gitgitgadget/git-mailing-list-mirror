From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-remote - Unset core.origin when deleting the default remote
Date: Sun, 13 Jan 2008 11:27:08 -0500
Message-ID: <1200241631-3300-2-git-send-email-mlevedahl@gmail.com>
References: <478A3284.1000102@gmail.com>
 <1200241631-3300-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Jan 13 17:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE5ga-00016Z-TI
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 17:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbYAMQ1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 11:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967AbYAMQ1U
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 11:27:20 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:56281 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbYAMQ1T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 11:27:19 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1501825rvb.1
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 08:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Fh7mijT5Xgacshsnmgen012ffHNQbtn4ha1I9A2gxxc=;
        b=G4ugpNjkccIleaB6748bS6hcysN9bV1awNjlh9jcgO41yE0RTGZ9RYs9FCM1tJh2ZFaAkJs419qDPSmuhwlcu/viTcyTWrDb+hBOYtl+jfqUg8ilreuPANW7ndKR37WApL8/1u3XVpS6eUSNDNxciK8V0sQA/pmmRrgjbVUqlvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vIVcwTqJgmDw3yv6w4e3Mp7w4EsGtmyRPh7eEboYYcxapsqPVCd0RLAfTYG11rFrrTQD/wp4KVtOCiD9RaqHAkhwRNjOUm+itQ7n2sjD9d5zbObtzzo0g+26iUDJicFr9OQlpnsMqgyuDunlM4ASfU66ZpbK3X6UH+NypG2auhk=
Received: by 10.140.158.4 with SMTP id g4mr3240581rve.64.1200241637456;
        Sun, 13 Jan 2008 08:27:17 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id i18sm8324960wxd.0.2008.01.13.08.27.14
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 08:27:15 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc3.14.gc50f
In-Reply-To: <1200241631-3300-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70393>

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
1.5.4.rc3.14.gc50f
