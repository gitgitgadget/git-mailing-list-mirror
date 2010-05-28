From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] git-instaweb: Support for 'plackup' and improvements
Date: Fri, 28 May 2010 21:11:22 +0200
Message-ID: <1275073885-26537-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 28 21:09:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI4wA-0000YE-8W
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 21:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab0E1TJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 15:09:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab0E1TJd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 15:09:33 -0400
Received: by fxm10 with SMTP id 10so1005565fxm.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=8oUP9ps+qqsWuyxb2QP3A2GaXwqKb5Hnvw+VYyv4qVs=;
        b=ZFOXlONN7JXWgRS32X/fFI3ZCPte3S8TbFCfu0jFIxMGNVwTI4hr1FHGV8jKYNhk+F
         QZiA7tFjnSTrCWbTZj7SOJQHyg+hnKbE7Ey/juHaBcSf2R9eaCHvA2GniI5+7b71qqLZ
         Pou1w8koWFJT7iIGY+Lghd6oiWqn8viGDOk9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=n7e1Jk5746N/sGf0AG71E2uYqYfAmBSWrFXloVGHB1R77g42Xyke+wUKKczXSfkouP
         RJYRR4EBC7vzzV3Ra03Q8BWKD3/wyz+by4dVtQRF6pGs/a1d7vD8Hz64hvjuscO+6BwQ
         wBsBUd4S1l0h/r3uUk6G5YSKZi+cbZkkmzRv8=
Received: by 10.223.98.5 with SMTP id o5mr767012fan.64.1275073769673;
        Fri, 28 May 2010 12:09:29 -0700 (PDT)
Received: from localhost.localdomain (abwk209.neoplus.adsl.tpnet.pl [83.8.234.209])
        by mx.google.com with ESMTPS id 13sm13023723fad.7.2010.05.28.12.09.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 28 May 2010 12:09:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147932>

This series is based on latest GSoC 2010 work by Pavan Kumar Sunkara,
on commit 72855f7 
  (git-instaweb: Configure it to work with new gitweb structure, 2010-05-21)
in the 'master' branch of git://repo.or.cz/git/gsoc2010-gitweb.git

The relevant patches were lately send to git mailing list as 4-patch
series:
 [PATCH GSoC 1/4] gitweb: Move static files into seperate subdirectory
 [PATCH GSoC 2/4] gitweb: Set default destination directory for
                  installing gitweb in Makefile
 [PATCH GSoC 3/4] git-instaweb: Put httpd logs in a "$httpd_only"
                  subdirectory
 [PATCH GSoC 4/4] git-instaweb: Configure it to work with new gitweb
                  structure
The first patch series is available as
  Message-Id: <1275027952-5057-4-git-send-email-pavan.sss1991@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/147913

The following patches were send as non-chained reply to the first
patch (without cover letter).


This series adds support for 'plackup' web server (PSGI/Plack based
server script) to git-instaweb.  Because the web server (by default
pure-Perl HTTP::Server::PSGI aka PLACK_SERVER=Standalone) can take a
while to start, it required adding waiting for web server to be ready
before starting web browser.

This series also contains somewhat unrelated fixup, namely that
git-instaweb removes pidfile after stopping web server.  This is
probably important only to web servers which do not have daemon mode,
and are "daemonized" (which includes generating pidfile) by
git-instaweb itself.

Shortlog:
~~~~~~~~~
Jakub Narebski (3):
  git-instaweb: Remove pidfile after stopping web server
  git-instaweb: Wait for server to start before running web browser
  git-instaweb: Add support for running gitweb via 'plackup'

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCH 1/3] git-instaweb: Remove pidfile after stopping web server
 [PATCH 2/3] git-instaweb: Wait for server to start before running web browser
 [PATCH 3/3] git-instaweb: Add support for running gitweb via 'plackup'

Diffstat:
~~~~~~~~~
 Documentation/git-instaweb.txt |    2 +-
 git-instaweb.sh                |  177 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 174 insertions(+), 5 deletions(-)

-- 
Jakub Narebski
