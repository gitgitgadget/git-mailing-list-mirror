From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-remote - Unset remotes.default when deleting the default remote
Date: Thu, 10 Jan 2008 22:29:47 -0500
Message-ID: <1200022189-2400-3-git-send-email-mlevedahl@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
 <1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 11 04:30:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDAbA-0004bC-Jq
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 04:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbYAKD37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 22:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbYAKD37
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 22:29:59 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:4592 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbYAKD35 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 22:29:57 -0500
Received: by wx-out-0506.google.com with SMTP id h31so643452wxd.4
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 19:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pfcVVF0B1Cuk1GRSbLGqix7sBo8ff5fDhWPbWxhJuIM=;
        b=qfSuwONMImWwjemIAPZ4QD2/DBsWiBbE/kQVIpXK32PObzS8l77gCXq8my2Km2ypKOktmBqRkAadhEo049BRVdI1jL2ThNqzKpt/rDkEUecihVEDUD9cWKNP45HUo750Fji4xu7EGch4LEAgYoyROpLZyfgWR1jNBYcf9KBU7rg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QWGmLsIM3zKa1X5u8OMtSHeOstpXfptntwV7bXAcTXPks+AWz/bDLPIaXUpcAUgujT727yaWIC8aYZVUDo5Wn529zlnsIvoODyrLKoYXpQEWt7+fLnTAjO9oRR7JkcZWu3SFnYrQifUhSJR0UPOThnFrZ/UlAxiyZ4KVeD+/8As=
Received: by 10.150.138.8 with SMTP id l8mr1108373ybd.141.1200022196501;
        Thu, 10 Jan 2008 19:29:56 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id h8sm4363197wxd.39.2008.01.10.19.29.54
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Jan 2008 19:29:55 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.99.g3ef7-dirty
In-Reply-To: <1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70116>

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-remote.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index d13e4c1..2469b59 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -328,6 +328,11 @@ sub rm_remote {
 
 	$git->command('config', '--remove-section', "remote.$name");
 
+	my $defremote = $git->config("remotes.default");
+	if (defined $defremote && $defremote eq $name) {
+	       $git->command("config", "--unset", "remotes.default");
+	}
+
 	eval {
 	    my @trackers = $git->command('config', '--get-regexp',
 			'branch.*.remote', $name);
-- 
1.5.4.rc2.99.g3ef7-dirty
