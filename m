From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 10/11] gitweb: add HEAD to list of shortlog refs if detached
Date: Fri, 14 Nov 2008 00:54:20 +0100
Message-ID: <1226620461-25168-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 00:55:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0m20-0000jn-NU
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 00:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbYKMXyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 18:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753625AbYKMXyA
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 18:54:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:53312 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbYKMXx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 18:53:58 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1512463ugf.37
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 15:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2u9EP5V9F/6OX0ocRboEB2ad3GzvoFn5pPzYB8nJZQ4=;
        b=jbndDv80sQxmdE7f6opUxtAKPut2n+TcjxIMjnB2mJNMDm6e0uFaQ2tha9HTJQefNz
         iA6jgLbu5KbexpYIX0JZx88aAuLEjb5j8yNlU8ND0rGYlcIO90BBbausOypF8dtYsmTR
         fqFM8fEpj406r5Du2hZwPIdBj2vF42kXgrccU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gDH+oVguLyR6eUwYjKrqOTjPTcHX8ETBxn5wiLfgJyjGdcXxPofcvJxrAseivL/mW3
         ZO31qGu7/9jkTqrRthRYAQC3fxn8xUnF12KLnzK6AJXM3FO0W06VhnU8JloIEA1GmKi+
         erVvuCqirDDoZDLkR9ma+Y65JsMnMshN7kL10=
Received: by 10.67.28.14 with SMTP id f14mr4459361ugj.79.1226620437149;
        Thu, 13 Nov 2008 15:53:57 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id 6sm10197ugc.39.2008.11.13.15.53.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 15:53:56 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100931>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ceb0271..256c962 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2296,6 +2296,10 @@ sub git_get_last_activity {
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
+	if (git_is_head_detached()) {
+		my $hash = git_get_head_hash($project);
+		$refs{$hash} = [ 'HEAD' ];
+	}
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
 	open my $fd, "-|", git_cmd(), "show-ref", "--dereference",
-- 
1.5.6.5
