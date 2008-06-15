From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/3 v2] The "curl" executable is no longer required
Date: Sun, 15 Jun 2008 13:40:50 +0200
Message-ID: <200806151340.50694.johan@herland.net>
References: <200806120920.31161.johan@herland.net>
 <200806151255.41055.johan@herland.net> <vpqmylnkkm4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 13:42:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7qdL-00022y-Ce
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 13:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbYFOLle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 07:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757247AbYFOLle
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 07:41:34 -0400
Received: from smtp.getmail.no ([84.208.20.33]:43060 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbYFOLld (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 07:41:33 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I00G0F5T8AE00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 13:41:32 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00IJG5S219A0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 13:40:51 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I006HT5S2WH70@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 13:40:50 +0200 (CEST)
In-reply-to: <vpqmylnkkm4.fsf@bauges.imag.fr>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85081>

git-clone.sh was the last user of the "curl" executable. Relevant git
commands now use libcurl instead. This should be reflected in the
install requirements.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Sunday 15 June 2008, Matthieu Moy wrote:
> I don't understand how that answers the question. Unless curl is
> statically linked, you need the library both at build time and at run
> time. For example, zlib-devel is needed here at build time, and zlib
> (without devel) is still in "Requires:". So, what's the difference
> between zlib and libcurl here?

You're probably right. What about this?

 INSTALL     |    8 ++++----
 git.spec.in |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index 9888f25..4a4e13f 100644
--- a/INSTALL
+++ b/INSTALL
@@ -67,10 +67,10 @@ Issues of note:
 	  that come with git (git includes the one from Mozilla, and has
 	  its own PowerPC and ARM optimized ones too - see the Makefile).
 
-	- "libcurl" and "curl" executable.  git-http-fetch and
-	  git-fetch use them.  If you do not use http
-	  transfer, you are probably OK if you do not have
-	  them.
+	- libcurl library; git-http-fetch and git-fetch use them.  You
+	  might also want the "curl" executable for debugging purposes.
+	  If you do not use http transfer, you are probably OK if you
+	  do not have them.
 
 	- expat library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional.
diff --git a/git.spec.in b/git.spec.in
index 97a26be..fb8da85 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -12,7 +12,7 @@ BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel, gettex
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 
 Requires:	perl-Git = %{version}-%{release}
-Requires:	zlib >= 1.2, rsync, curl, less, openssh-clients, expat
+Requires:	zlib >= 1.2, rsync, libcurl, less, openssh-clients, expat
 Provides:	git-core = %{version}-%{release}
 Obsoletes:	git-core <= 1.5.4.2
 Obsoletes:	git-p4
-- 
1.5.6.rc2.128.gf64ae
