From: Robert Zeh <robert.a.zeh@gmail.com>
Subject: git svn fetches the same revision multiple times for non-trunk branches
Date: Fri, 24 Jul 2009 16:53:38 -0500
Message-ID: <CEAA2460-501C-48C1-BC33-B92A68C2161B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 23:53:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUSiC-0007Kr-Fy
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 23:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbZGXVxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 17:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbZGXVxj
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 17:53:39 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:63251 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbZGXVxj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 17:53:39 -0400
Received: by gxk9 with SMTP id 9so3635124gxk.13
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=OJDgJXX4+Ip9k+LCsL3C4Pp5lUffpvenenzbpjAuERc=;
        b=tLUBYCH7h29aa3NffMOYrHfSRo7fhaHjBY5fl5F/n1zLDVPKmyY8fAVmPStBlC6lHX
         9GGrDAKfCjJ/jvO9Xac0u/0lU5nx1bdA90mZZkRmHvUQXEXNDbt75+2iGBySPH61uo67
         Z/U264UU7uieCqRnMGMdkRWFB3n4fGgiRRrzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=ZXaqnx5PksfKP86ayzmbWPHIrq+xSuQwpTaoUc4ctUCxPcVc56eMiBtsSzHkRlFuK3
         A/1+g0DWCd66kLBx9fpv8MYHFACT0JKf0Oh3RCqoGMUf2Y+VA8uapSR8PO68y5eETuEn
         EK6EbtE19SZmfEW7fFI57TPK3v6oim9/UHYAk=
Received: by 10.151.113.2 with SMTP id q2mr6214429ybm.67.1248472418570;
        Fri, 24 Jul 2009 14:53:38 -0700 (PDT)
Received: from ?192.168.15.101? (adsl-70-253-169-77.dsl.stlsmo.swbell.net [70.253.169.77])
        by mx.google.com with ESMTPS id 20sm37794ywh.13.2009.07.24.14.53.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 14:53:38 -0700 (PDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123951>

I am seeing git svn fetch repeatedly retrieve the same Subversion  
revisions when it finds branches in our Subversion repository. We are  
using the standard Subversion repository layout, with top level / 
trunk, /tags, and /branches directories (and the git repository was  
created with 'git svn init -s'). However, the problematic branches are  
often copies made from a subdirectory inside of trunk, instead of trunk.

The git svn fetch output typically looks like:


R2537 = d5b22e956157af036d4112e42e8fb927e45758c8 (trunk)
         M       Enterprise/VC/lib/SymbolVenue.cpp
r2538 = cfed4ca0491da0b732f32bfff72ba678450a0915 (trunk)
Found possible branch point: http://repo/prod_repos/trunk/Enterprise/ 
VC => http://repo/prod_repos/branches/file_conversion, 2523
W: Refspec glob conflict (ref: refs/remotes/scripter@832):
expected path: branches/scripter@832
     real path: trunk/Enterprise/Python
Continuing ahead with trunk/Enterprise/Python
W: Refspec glob conflict (ref: refs/remotes/trunk):
expected path: branches/trunk
     real path: trunk
Continuing ahead with trunk
Initializing parent: file_conversion@2523
         A       gc/QuoteService.cpp
         A       gc/TestSuite.h
         A       gc/quote_svc.pro
         A       gc/QuoteService.h
.....

r1 = d349ed8cb2d76596fe2b83224986275be4600fad (QuoteSvcFix442@2698)
         D       gc/FixMessageLogger.h
.....
r5 =
r19 =
r20 =
.....



And we are back at revision 1. git svn fetch then continues to fetch  
revisions until it reaches the revision that created the branch.

What am I doing wrong? Is there anyway for me to tell git svn fetch to  
not retrieve revisions it has already pulled?  This is converting my  
import time from O(n) to O(n^2).

Robert
