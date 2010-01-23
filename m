From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 00/10] gitweb: Simple file based output caching
Date: Sat, 23 Jan 2010 01:27:23 +0100
Message-ID: <cover.1264198194.git.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:30:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTte-000356-C6
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756426Ab0AWA1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756418Ab0AWA1l
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:27:41 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:44838 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439Ab0AWA1f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:27:35 -0500
Received: by fxm20 with SMTP id 20so1932419fxm.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lJzQhkdT+Ck8x5cfrmqI/HmfT7Xr/doUseBa+CzUO5I=;
        b=xMUMKyDTWlwzVJVyrlDa1tmDRcTt88mqK1zaw6dikTuCxxKE/3YpPVJEstZ1maT0pZ
         e6ouzxH6Z8ovmmuott8O/USX/dgmj2gmdUEKVjoWvcSEmpd7NKAbmLQsjvvCJXm8z83i
         E21FCtY+7Bx0rmwEYCNlZNaDpcYBbqjCiWUGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ef1Bh0ZnlHSPDt86vihJDiwQkYxh19NKd0/4RdxCAWB8VQuJxa5SlKZgg96YG8sZmB
         uIes6xK0lS6DJ8Pgzx39Dc4PJRZEwc030NsFE18lm+TD7+gqtfvl3V+AlYoUfQbkENlR
         pcLDF86gQ64KijRHqHwkOb7pEa0e5ggGfAeTk=
Received: by 10.103.126.29 with SMTP id d29mr1902944mun.28.1264206453702;
        Fri, 22 Jan 2010 16:27:33 -0800 (PST)
Received: from localhost.localdomain (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id s11sm11094697mue.19.2010.01.22.16.27.32
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:27:32 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137805>

This 10 patches long patch series is intended as proof of concept
for splitting large 'gitweb: File based caching layer (from git.kernel.org)'
mega-patch by John 'Warthog9' Hawley aka J.H., by starting small and
adding features piece by piece.

This patch is meant as replacement for last two patches:
* [PATCH 8/9] gitweb: Convert output to using indirect file handle
  Message-ID: <1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
* [PATCH 9/9] gitweb: File based caching layer (from git.kernel.org)
  Message-ID: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>

in the long patch series by J.H.
* [PATCH 0/9] Gitweb caching v5
  http://thread.gmane.org/gmane.comp.version-control.git/136913

Note that this patch series is part of 'gitweb/cache-kernel' branch of
http://repo.or.cz/w/git/jnareb-git.git repository (gitweb link), built
on top of modified patches from 'Gitweb caching v2' series (from
'gitweb-ml-v2' branch of http://git.kernel.org/?p=git/warthog9/gitweb.git
repository).  Therefore they might not apply as straight replacements
on top of early parts of 'gitweb-ml-v5' branch.

This is work in progress (showing how I see introducing output caching
to gitweb), it lacks proper documentation (POD for gitweb/cache.pm,
new configuration variables in gitweb/README, perhaps "Gitweb caching"
section in gitweb/README and gitweb/cache.pm mentioned in gitweb/INSTALL),
and commits/patches marked '(WIP)' lacks proper commit message.

Just food for thought...

Table of contents:
~~~~~~~~~~~~~~~~~~
 [RFC PATCH 01/10] gitweb: Print to explicit filehandle (preparing
                   for caching)
 [RFC PATCH 02/10] gitweb: href(..., -path_info => 0|1)
 [RFC PATCH 03/10] gitweb/cache.pm - Very simple file based caching
 [RFC PATCH 04/10] gitweb/cache.pm - Stat-based cache expiration
 [RFC PATCH 05/10] gitweb: Use Cache::Cache compatibile (get, set)
                   output caching (WIP)
 [RFC PATCH 06/10] gitweb/cache.pm - Adaptive cache expiration time (WIP)
 [RFC PATCH 07/10] gitweb: Use CHI compatibile (compute method) caching (WIP)
 [RFC PATCH 08/10] gitweb/cache.pm - Use locking to avoid 'stampeding herd'
                   problem (WIP)
 [RFC PATCH 09/10] gitweb/cache.pm - Serve stale data when waiting for
                   filling cache (WIP)
 [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
                   regenerating cache (WIP)


Diffstat:
~~~~~~~~~

 gitweb/cache.pm                        |  566 ++++++++++
 gitweb/gitweb.perl                     | 1923 +++++++++++++++++---------------
 t/gitweb-lib.sh                        |    2 +
 t/t9500-gitweb-standalone-no-errors.sh |   13 +
 t/t9503-gitweb-caching.sh              |   32 +
 t/t9503/test_cache_interface.pl        |  195 ++++
 t/test-lib.sh                          |    3 +
 7 files changed, 1836 insertions(+), 898 deletions(-)
 create mode 100644 gitweb/cache.pm
 create mode 100755 t/t9503-gitweb-caching.sh
 create mode 100755 t/t9503/test_cache_interface.pl
