From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUG] "git checkout branch" on full disk doesn't recover from errors
Date: Thu, 14 Jun 2007 01:33:41 +0200
Message-ID: <200706140133.42513.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 01:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HycGC-0007hX-Cx
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 01:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670AbXFMX2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 19:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321AbXFMX2J
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 19:28:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:56092 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbXFMX2G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 19:28:06 -0400
Received: by ug-out-1314.google.com with SMTP id j3so534970ugf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 16:28:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=O8sCFZv/5xs+lkqLiI++74mkbopZzUTrIUkt4mP9tHRm3dtR4t1BWuRkfWEwKm9mFqaIveiCtLyUOGxQ3SweQtBuG9oPmn8OsbICwmhDcjtZD2h34ar2SqzuiGAVrKHCb+ZvP1TvXE5UEMNkXHeOsROiQH6ZLsKknggG29InRZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kUD8sc1XLV5c7dbacz4hV2rww9eVhSuN37dc6aDQdOgOzPHdLqQPNQPOqTERfLLf4CsHoX4rxTS5r/7eimn8tUy2hBzqdGmDaVzrP4giv8larhOq2UdYgaOBi2r8YrJp5BS5vWb7LlA9H3H+Bg2wIz623lLcO8dVcJwCpMH6diU=
Received: by 10.82.183.19 with SMTP id g19mr2207401buf.1181777285196;
        Wed, 13 Jun 2007 16:28:05 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id k9sm2071644nfh.2007.06.13.16.28.04
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jun 2007 16:28:04 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50147>

I have accidentally (errorneous program running in parallel) run 
"git checkout gitweb/web" (where 'gitweb/web' is a branch) on a full 
disk. Git correctly notices error, but doesn't recover fully from it.

  $ git checkout gitweb/web
  fatal: unable to write new index file

It would be nice if git has shown also the error message from filesystem 
(from OS), for example if it was full disk, read-only filesystem (for 
example wrong mount options, or running from CD), or incorrect 
permissions.

  $ <free disk space>
  $ git checkout gitweb/web
  fatal: Entry '.gitignore' not uptodate. Cannot merge.

The '.gitignore' was last file changed in last commit on the page I was 
on (namely 'master'). It looks like git didn't recover fully from 
attempted branch change. "git diff" and "git status" shows many 
modified files, not only '.gitignore'.

What is a bit strange that mixed reset ("git reset HEAD") is not enough

  $ git reset HEAD
  <multitude of "needs update" messages>

Fortunately, it is easy to recover using "git reset --hard HEAD", 
although beginner user could have some problems with this.

-- 
Jakub Narebski
Poland
