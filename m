From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: last-modified time should be commiter, not author
Date: Sun, 25 Jan 2009 23:42:49 +0100
Message-ID: <1232923370-4427-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232686121-1800-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 23:44:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDhu-0007Fs-OF
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbZAYWmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbZAYWmf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:42:35 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:33046 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbZAYWmf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:42:35 -0500
Received: by mu-out-0910.google.com with SMTP id g7so3770429muf.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 14:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZNryx9sHNyKtIoHz7LgM+mlVsTBiKxuQIPw6gqOseFc=;
        b=axKBKyzNGy1iOmdr4JR1ekjd+QKxfSPzqdBFiI2jYXrjsI7UAYwasbDvwZK/ekuyRl
         Oh3zuoZeqUCDJSmJWpCzJO/NpMZyvMBd2gTIuta684k+4vnhZ5ts/xnSQf60MzorN06p
         FmK/GqdJB699ptyKHPBN+kMI5AHEX9SDBi8Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TX+m8wYabgMqBSM0fuhxM5LnhWDa1mSjsk10AfiU/arJL8gBqpRouWbUlASJNd7TFB
         LZELvAtP/OZtoV/TMs921wMxeJ7faDl+UzA+W4Fg1irCh8zjehoUvYKx1Pl58hhDi4k/
         Zjg73PIjfzvETd494KX0HAKPUxO9ZbWMUa548=
Received: by 10.103.11.7 with SMTP id o7mr1499245mui.103.1232923353516;
        Sun, 25 Jan 2009 14:42:33 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id s11sm22213199mue.42.2009.01.25.14.42.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jan 2009 14:42:32 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232686121-1800-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107114>

The last-modified time header added by RSS to increase cache hits from
readers should be set to the date the repository was last modified. The
author time in this respect is not a good guess because the last commit
might come from a oldish patch.

Use the committer time for the last-modified header to ensure a more
correct guess of the last time the repository was modified.
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 756868a..8c49c75 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6015,7 +6015,7 @@ sub git_feed {
 	}
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
-		%latest_date   = parse_date($latest_commit{'author_epoch'});
+		%latest_date   = parse_date($latest_commit{'committer_epoch'});
 		print $cgi->header(
 			-type => $content_type,
 			-charset => 'utf-8',
-- 
1.5.6.5
