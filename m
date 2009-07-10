From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: 'blame' view improvements
Date: Fri, 10 Jul 2009 23:54:42 +0200
Message-ID: <200907102354.43232.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 00:01:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPOAA-0003QR-0f
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 00:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342AbZGJWBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 18:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757335AbZGJWBk
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 18:01:40 -0400
Received: from ey-out-1920.google.com ([74.125.78.144]:29106 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756070AbZGJWBk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 18:01:40 -0400
Received: by ey-out-1920.google.com with SMTP id 3so238069eyh.36
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=QtAkgZ8Hl/sLDRlUBv+sla28JuINsV0xp9vOm3Mca84=;
        b=lVCgJlTmYLOS9OQKj7ocU55CBJbLfqePke+VX88Zqy3hm0/T3T2KS7AUTVvPEPiyR1
         +ShBLJf9Tb+unN132UtIuPoCedF2ZHzKuFeAyX5JBmf4fy7zzvQgimo4QucCbzYKZMDw
         Dhkf60XWKUoC76YLtk4eCrzoMFH8G557ps+6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=I8lZgH7vqiXf+mE/EN0xwYkr/07TcDXSzkmXJEyGBG0FtZeM/d6khR+0UsEuboOR4v
         1W3GIzB1TzY/izMlUxerfnjS7Mdwnq2fdE2E6O/AnQ4Gv5GI+S16UsumFI9zrSSN0Ubn
         z9HWunj08KYjjPLDUv8/JvsF1zbzWS3Mq2Rxw=
Received: by 10.210.16.10 with SMTP id 10mr551722ebp.76.1247263298617;
        Fri, 10 Jul 2009 15:01:38 -0700 (PDT)
Received: from ?192.168.1.13? (abwp104.neoplus.adsl.tpnet.pl [83.8.239.104])
        by mx.google.com with ESMTPS id 7sm1977058eyg.59.2009.07.10.15.01.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 15:01:38 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123085>

This patch series was inspired by the study before sending proposal
for git-blame improvements; I have noticed that "previous"/"parent"
blame header was already implemented, just not documented:
  Subject: git-blame: Documenting "previous" header
  Message-ID: <200907071423.40938.jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/122837

Therefore proposal got cut down to tree blame:
  Subject: [RFC] Tree blame (git blame <directory>)
  Message-ID: <200907071058.39390.jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/122830


Using "previous" header should improve gitweb performance and (as
I have noticed during implementing it) allow to follow 'linenr'
links correctly through rename in a blamed commit.

Marking "boundary" somewhat was required to make it possible to
distinguish which 'linenr' links would lead to parent of a blame
commit (to previous version of a file), and which would elad to blamed
commit.  Current styling is up to debate.

After implementing using "previous" header in 'blame' view (which
would allow to do the same for proposed 'blame_incremental' view)
I remembered that last version of implementing 'blame_incremental'
added author initials a'la "git gui blame".  So I did the same for
non-incremental 'blame' view.  Exact formatting is up to debate.

Table of contents:
==================
 [PATCH 1/3] gitweb: Mark boundary commits in 'blame' view
 [PATCH 2/3] gitweb: Use "previous" header of git-blame -p in 'blame' view
 [PATCH 3/3] gitweb: Add author initials in 'blame' view, a la "git gui blame"

Jakub Narebski (3):
  gitweb: Mark boundary commits in 'blame' view
  gitweb: Use "previous" header of git-blame -p in 'blame' view
  gitweb: Add author initials in 'blame' view, a la "git gui blame"


 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |   51 ++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 15 deletions(-)

-- 
Jakub Narebski
Poland
