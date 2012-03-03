From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 0/5] gitweb: Proof of concept of PSGI interface
Date: Sat,  3 Mar 2012 18:56:58 +0100
Message-ID: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 18:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3tCw-00031I-6X
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 18:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab2CCR5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 12:57:12 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49491 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab2CCR5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 12:57:11 -0500
Received: by eaaq12 with SMTP id q12so945738eaa.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 09:57:10 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.114.9 as permitted sender) client-ip=10.213.114.9;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.114.9 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.114.9])
        by 10.213.114.9 with SMTP id c9mr1985808ebq.56.1330797430313 (num_hops = 1);
        Sat, 03 Mar 2012 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=HhrVoCBSW2Y+Twm5fr/tbX5MPzcuNMUF9JVsY5z88eM=;
        b=ZtEgopp9q3MEXoMsH7V8vkA40KNqw2f0doXNcpbrfr4F0c25QuLPnNjayUAkYReu78
         BClfaQn9sDFHrhi1eaDyIFxReyg/mygGJhtJAPpq97DXAponr+fPBnE8apuSLBXzoA2d
         r4F02GTo33tvwrgSNFGuWS1S0pZ4IFNWnUtheiqhF8CbXjIVEZZdh4/yPzr5j1nuRsqC
         xrUeqrA1ta/p5/4etoHl0Crg06TDgneAaoIQqHJF/3qY22QnJzOzI4Vmy2yVMWnHbQvI
         Hi1Z8dihozo/mxksgDTYi7IHYYGL8Z3SN8+Pp2DuwoSarRa095IHpo7Q26wA8KmLhXOl
         VuMw==
Received: by 10.213.114.9 with SMTP id c9mr1518226ebq.56.1330797429895;
        Sat, 03 Mar 2012 09:57:09 -0800 (PST)
Received: from localhost.localdomain (abwo91.neoplus.adsl.tpnet.pl. [83.8.238.91])
        by mx.google.com with ESMTPS id s48sm36973616eem.0.2012.03.03.09.57.08
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 09:57:09 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192122>

The major goal of this series is to make it possible for gitweb to run
as PSGI application, even if non-native (emulated).

PSGI[1][2] is an interface between Perl web applications and web servers.
It is accompanied by Plack, a Perl module and toolkit that contains PSGI
middleware (e.g. for serving static files), helpers (e.g. 'plackup'
command line launcher) and adapters to web servers (e.g. to CGI, FastCGI,
or mod_perl).  PSGI and Plack are inspired by Python's WSGI and Ruby's Rack.

[1]: http://plackperl.org
[2]: http://search.cpan.org/perldoc?PSGI
[3]: http://advent.plackperl.org


First two patches are independent improvements, and make sense even
outside this patch series.  Last patch is making use of gitweb as PSGI
in "git instaweb --httpd=plackup".


Jakub Narebski (5):
  gitweb: Jump do DONE_REQUEST not DONE_GITWEB on error
  gitweb: Prepare for splitting gitweb
  gitweb: Enable running gitweb as PSGI app, via CGI::Emulate::PSGI
  gitweb.psgi: Allow passing arguments to Plack::Runner
  git-instaweb: Use new PSGI interface mode of gitweb

 Documentation/gitweb.txt |   16 +++++++
 git-instaweb.sh          |   33 +++------------
 gitweb/INSTALL           |    3 +
 gitweb/Makefile          |   14 ++++++-
 gitweb/README            |   13 +++++-
 gitweb/gitweb.perl       |   98 +++++++++++++++++++++++++++++++++++++++++++---
 6 files changed, 141 insertions(+), 36 deletions(-)

-- 
1.7.9
