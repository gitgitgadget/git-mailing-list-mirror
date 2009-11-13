From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 0/3] gitweb: Refactor common parts of log-like views
Date: Fri, 13 Nov 2009 02:02:11 +0100
Message-ID: <1258074134-27011-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 02:01:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8kXy-000865-Rs
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 02:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbZKMBBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 20:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbZKMBBn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 20:01:43 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:32820 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbZKMBBm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 20:01:42 -0500
Received: by fxm21 with SMTP id 21so2929461fxm.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=pnsNy+dHwDyyuJ8Q7N4cj1pqvGkHBl5/FsEYVsXQ/rU=;
        b=oFoNyI8J15GwZLGTNiktBZP/tiCITzbJV47H/RZOfC9hjk7r6UVOCSPsKQA2qVb9FZ
         litYB/ZQFYCBBjuSG2RGmsamZSQxiWg1eO0MIl1YrqEvSFaB7HsYuo9UrIKsxga0kLNK
         H0pcHGKCtUoOqEp+iQSvijoKC9e0MlLLa4mqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=P+f2/FPDBEY3i6JJe70TGBw/8j3TpW+vYhYmVMQr6ouc17jeVWJpJC5Me1U1CpVCDw
         Fxc2GyCXJVMf1re/l8AAcsZWzzsl59ErfvK//vpwNfMCDMPoaeZKsplPd6jeKRapJ1/X
         frFV6UmVR3E+wfdRuHrTv5sGeo90haDKMCGeI=
Received: by 10.204.16.203 with SMTP id p11mr4120957bka.185.1258074107256;
        Thu, 12 Nov 2009 17:01:47 -0800 (PST)
Received: from localhost.localdomain (abvv30.neoplus.adsl.tpnet.pl [83.8.219.30])
        by mx.google.com with ESMTPS id 14sm1111530fxm.3.2009.11.12.17.01.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 17:01:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAD12J8h027043;
	Fri, 13 Nov 2009 02:02:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAD12IqS027042;
	Fri, 13 Nov 2009 02:02:18 +0100
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132808>

This series extracts common parts of log-like views: 'log', 'shortlog'
and 'history' view, into git_log_generic() subroutine.  This
unification of code reduces code duplication, and brings features such
as limiting the list of commits displayed using $hash_parent{,_base}
from 'shortlog' view (added in ec3e97b (gitweb: shortlog now also
obeys $hash_parent, 2008-08-08)).

I have tested this series a bit (it passes both t9500 and t9501 test),
but I didn't test all the corner cases.

This series is preparation for even more refactoring planned, to make
it easier to introduce new log-like action (new log formats).  It
doesn't include (for now) the 'search' view, neither in message search
not in pickaxe search form.

Jakub Narebski (3):
  gitweb: Refactor 'log' action generation, adding git_log_body()
  gitweb: Refactor common parts of 'log' and 'shortlog' views
  gitweb: Make 'history' view (re)use git_log_generic()

 gitweb/gitweb.perl |  269 +++++++++++++++++++++-------------------------------
 1 files changed, 110 insertions(+), 159 deletions(-)

-- 
Jakub Narebski
