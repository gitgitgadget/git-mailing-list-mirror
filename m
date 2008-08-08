From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: shortlog now also obeys $hash_parent
Date: Fri,  8 Aug 2008 16:12:11 +0200
Message-ID: <1218204731-9931-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 16:13:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRSic-0002CX-Ov
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbYHHOMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 10:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbYHHOMX
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:12:23 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:53066 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbYHHOMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:12:22 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1461231mue.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NFAlIZa1HOVRdCQ1bmm8GR2ERbgS/NgbslPPht4cWRE=;
        b=LOxX3younlNVTb0Uoa9Ubd/jEvrHIHfDOf1vTwQytvYCAFkjXfc5Dm/OkENVLzZvdL
         xvS+tSkAiHTxeQ1AhEem1V+O2XXILzqYcJitj3mL0gX9Vbvoa7vJRdQmZZKiTU/U+sUk
         FLuehItOhd0ryGHluims/CWiNi6OSlgOikIBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=a224jgll5XU9QGurNEfh8Rkw+f5VwA9S7ZUXueIUbOpbAgxBJefru8U0SBs7X2tNbl
         1fY1FAHfMwUtzoP8Xk8PSvQA5Tztqbx7a/ZgS+tB1karM4wPM2rxwbvlmJV0/OLBGB/p
         K0HtAD22uQ6VgJit2tMYDjbFekf/20sdXmurc=
Received: by 10.103.16.14 with SMTP id t14mr3155718mui.130.1218204740889;
        Fri, 08 Aug 2008 07:12:20 -0700 (PDT)
Received: from localhost ( [78.13.48.196])
        by mx.google.com with ESMTPS id y2sm6365742mug.1.2008.08.08.07.12.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Aug 2008 07:12:19 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91666>

If $hash_parent is defined, shortlog now limits the list of commits at
those between $hash_parent (exclusive) and $hash (inclusive).

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a12ce87..d811dd4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5472,7 +5472,11 @@ sub git_shortlog {
 	}
 	my $refs = git_get_references();
 
-	my @commitlist = parse_commits($hash, 101, (100 * $page));
+	my $commit_hash = $hash;
+	if (defined $hash_parent) {
+		$commit_hash = "$hash_parent..$hash";
+	}
+	my @commitlist = parse_commits($commit_hash, 101, (100 * $page));
 
 	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#commitlist >= 100);
 	my $next_link = '';
-- 
1.5.6.3
