From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] gitweb: Provide RSS feeds for file history
Date: Thu, 2 Aug 2007 22:05:55 -0400
Message-ID: <20070803020555.GB8593@dervierte>
Reply-To: stevenrwalter@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 04:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGmYV-0006sk-Dz
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 04:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759342AbXHCCGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 22:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759189AbXHCCGB
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 22:06:01 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:16130 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758741AbXHCCGA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 22:06:00 -0400
Received: by py-out-1112.google.com with SMTP id d32so1186869pye
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 19:05:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:x-mimetrack:user-agent;
        b=HVR05JFN524EYUXX6unfEJtgUo/Xjfpqg01VLsE8mCSjLDhvo1/KnQdTWVGTKynBmVSXV0gmvYe584E39HiLq4wCKV7cworHEOpGnkUb/xiRz8Y+siJ4TLthfnuKBq7Xp29Hr55ncSiaEPLc+RJplXpBMjxAg2YXmwa2xj4i+gk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:x-mimetrack:user-agent;
        b=NPR/kr3pWGhZCkqB1HnW5d5aFsnDVDP/8/dwI8rBD1N0F5yRJX+0WMuqL4sXeoj6jqP1xuVKfRQDxUIhBI4gamfRkPoA2M6bYjVGJJpImg0Kgrmjygi1NPA2qbvbELZR+FknmgL5dAj3Ya1nQgub4QV9YI/3n2YxhAu2Ui7UrXc=
Received: by 10.35.117.5 with SMTP id u5mr3878941pym.1186106759146;
        Thu, 02 Aug 2007 19:05:59 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [74.140.216.190])
        by mx.google.com with ESMTPS id 18sm9785744nzo.2007.08.02.19.05.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 19:05:57 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id C1FB1BBF587; Thu,  2 Aug 2007 22:05:55 -0400 (EDT)
Content-Disposition: inline
X-MIMETrack: Itemize by SMTP Server on smtp5b/Lex/Lexmark (Release 6.5.5|November 30, 2005) at 08/02/2007 13:17:14, Serialize by Router on smtp5b/Lex/Lexmark (Release 6.5.5|November 30, 2005) at 08/02/2007 13:30:32, Serialize complete at 08/02/2007 13:30:32
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54660>

If git_feed is provided a file name, it ought to show only the history
affecting that file.  The title was already being set correctly, but all
commits from history were being shown anyway.
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 498b936..26932a4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -611,6 +611,7 @@ sub href(%) {
 	my %mapping = @mapping;
 
 	$params{'project'} = $project unless exists $params{'project'};
+	$params{'file_name'} = $file_name unless exists $params{'file_name'};
 
 	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
 	if ($use_pathinfo) {
@@ -5365,7 +5366,7 @@ sub git_feed {
 
 	# log/feed of current (HEAD) branch, log of given branch, history of file/directory
 	my $head = $hash || 'HEAD';
-	my @commitlist = parse_commits($head, 150);
+	my @commitlist = parse_commits($head, 150, 0, "--full-history", $file_name);
 
 	my %latest_commit;
 	my %latest_date;
-- 
1.5.2.3


-- 
-Steven Walter <swalter@lexmark.com>
