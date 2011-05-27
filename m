From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Improving blame_incremental.js
Date: Fri, 27 May 2011 15:49:58 +0200
Message-ID: <1306504201-18014-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 15:50:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPxQw-0005MN-2E
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 15:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732Ab1E0NuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 09:50:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60815 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab1E0NuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 09:50:24 -0400
Received: by fxm17 with SMTP id 17so1341410fxm.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=8W1XZBnKftPCMd+JDz10XRKbXf0P2KosWq0zPwNFwaU=;
        b=UPP2qRvrcr1ACLJBep5OSTKShrDriplhyxg8njv/tU5FpcIccXepES+08V1yzcZxRA
         iHbjRa8AFnjaX3/6v0qldxc9U9Ghjf0RyDj8Q7VFDsacvOs7+DKqmpzLje7Nkx3OOOGb
         ysEu+FvX75OoSMODE6pvesffOQnYiN6YIP578=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RhUJmetwtNScmkFFRYdfAAKgG0PvBB7kjczmWKT8sbXKbl7eb/9yehbtOMa95OAgS9
         IsZ4aE2KVSP9N5IUGqI6CDihxOjC/faJfD5Yy08oSJC6CTDQOodatEZzP2ekaWlyfcN2
         DwIY90vSKuU5G8DPhndKQYvWlxUw8+dKVy5Bw=
Received: by 10.223.127.213 with SMTP id h21mr2348300fas.45.1306504223212;
        Fri, 27 May 2011 06:50:23 -0700 (PDT)
Received: from localhost.localdomain (abvw13.neoplus.adsl.tpnet.pl [83.8.220.13])
        by mx.google.com with ESMTPS id l26sm687778fah.38.2011.05.27.06.50.20
        (version=SSLv3 cipher=OTHER);
        Fri, 27 May 2011 06:50:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174616>

Two first patches remove unnecessary code from JavaScript-side of
blame_incremental code.  Namely JavaScript is single-threaded (events
wait for interpreter), so there is no need for code that tried to
handle re-entrancy (concurent access) to blame_incremental.js
functions.

So those two are pure simplification.


The third (last) patch replaces setInterval (where events might
accumulate if browser is very busy) to recommended re-enabled
setTimeout.  Thanks to this change we are now able to detect if timer
is not necessary, and in that case disable it.  This means extra code
checking if there is timer to disable (perhaps unnecessary).

This one adds more code than it removes, and could be split into two
patches: one simply moving from setInterval to setTimer, second adding
those new features.


P.S. Does anybody knows how to test JavaScript part of gitweb code
     _from commandline_ generating TAP-compatibile output to stdout?


Shortlog:
~~~~~~~~~
Jakub Narebski (3):
  gitweb.js: No need for inProgress in blame_incremental.js
  gitweb.js: No need for loop in blame_incremental's handleResponse()
  gitweb.js: use setTimeout rather than setInterval in
    blame_incremental.js

Diffstat:
~~~~~~~~~
 gitweb/static/js/blame_incremental.js |   79 +++++++++++++++++---------------
 1 files changed, 42 insertions(+), 37 deletions(-)

-- 
1.7.5
