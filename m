From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] Make the git metapackage require the same version of the
	subpackages.
Date: Sun, 6 Jan 2008 12:35:02 -0500
Message-ID: <20080106173501.GB9349@spitfire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 06 18:40:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBZUV-00084E-2F
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 18:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522AbYAFRk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 12:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755450AbYAFRk3
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 12:40:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51493 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078AbYAFRk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 12:40:28 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m06HZ6CS006480;
	Sun, 6 Jan 2008 12:35:07 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m06HZ6ar006109;
	Sun, 6 Jan 2008 12:35:06 -0500
Received: from spitfire (vpn-6-14.fab.redhat.com [10.33.6.14])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m06HZ4vv011424;
	Sun, 6 Jan 2008 12:35:05 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69737>

Without explicit version deps in the rpm spec file, 'yum update git'
effectively does nothing. Require explicit versions of the subpackages, so that
they get pulled in on an update.

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 git.spec.in |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 3e5bebb..7f1bd5a 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -10,7 +10,15 @@ URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
 BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
-Requires:	git-core, git-svn, git-cvs, git-arch, git-email, gitk, git-gui, perl-Git
+
+Requires:	git-core = %{version}-%{release}
+Requires:	git-svn = %{version}-%{release}
+Requires:	git-cvs = %{version}-%{release}
+Requires:	git-arch = %{version}-%{release}
+Requires:	git-email = %{version}-%{release}
+Requires:	gitk = %{version}-%{release}
+Requires:	git-gui = %{version}-%{release}
+Requires:	perl-Git = %{version}-%{release}
 
 %description
 Git is a fast, scalable, distributed revision control system with an
@@ -172,6 +180,9 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %doc Documentation/technical}
 
 %changelog
+* Sun Jan 06 2008 James Bowes <jbowes@dangerouslyinc.com>
+- Make the metapackage require the same version of the subpackages.
+
 * Wed Dec 12 2007 Junio C Hamano <gitster@pobox.com>
 - Adjust htmldir to point at /usr/share/doc/git-core-$version/
 
-- 
1.5.4.rc2.1141.g437b09
