From: prj@po.cwru.edu (Paul Jarc)
Subject: configure clobbers LDFLAGS
Date: Sun, 04 Jan 2009 21:27:41 -0500
Organization: What did you have in mind?  A short, blunt, human pyramid?
Message-ID: <m3tz8e32ru.fsf@multivac.cwru.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 03:36:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJfKF-0001Fg-OZ
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 03:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZAECet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 21:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbZAECes
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 21:34:48 -0500
Received: from mpv4.tis.CWRU.Edu ([129.22.105.34]:2590 "EHLO mpv4.tis.cwru.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbZAECer (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 21:34:47 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Jan 2009 21:34:46 EST
Received: from mpv6.TIS.cwru.edu (mpv6.tis.cwru.edu [129.22.104.221])
	by mpv4.tis.cwru.edu (MOS 3.10.3-GA)
	with ESMTP id CQT70422
	for <git@vger.kernel.org>;
	Sun, 4 Jan 2009 21:28:39 -0500 (EST)
Received: from multivac.cwru.edu (multivac.its.CWRU.Edu [129.22.114.26])
	by mpv6.TIS.cwru.edu (MOS 3.10.3-GA)
	with SMTP id ENZ89206
	for <git@vger.kernel.org>;
	Sun, 4 Jan 2009 21:27:43 -0500 (EST)
Received: (qmail 32754 invoked by uid 500); 5 Jan 2009 02:28:07 -0000
Mail-Followup-To: git@vger.kernel.org, prj@po.cwru.edu
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Junkmail-Status: score=10/49, host=mpv4.tis.cwru.edu
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A010203.49617057.0054,ss=1,fgs=0,
	ip=129.22.104.221,
	so=2008-09-22 23:22:13,
	dmn=5.4.3/2007-10-18,
	mode=single engine
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104558>

--=-=-=

(I'm not subscribed; Mail-Followup-To set.)

In a couple of tests, configure clobbers the LDFLAGS value set by the
caller.  This patch fixes it.


paul

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=git-ldflags.diff

diff --git a/configure.ac b/configure.ac
index 8821b50..0a5fc8c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -127,7 +127,7 @@ else
       SAVE_LDFLAGS="${LDFLAGS}"
       LDFLAGS="${SAVE_LDFLAGS} -Wl,-rpath,/"
       AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_wl_rpath=yes], [ld_wl_rpath=no])
-      LDFLAGS="${SAVE_LD_FLAGS}"
+      LDFLAGS="${SAVE_LDFLAGS}"
    ])
    if test "$ld_wl_rpath" = "yes"; then
       AC_SUBST(CC_LD_DYNPATH, [-Wl,-rpath,])
@@ -136,7 +136,7 @@ else
          SAVE_LDFLAGS="${LDFLAGS}"
          LDFLAGS="${SAVE_LDFLAGS} -rpath /"
          AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_rpath=yes], [ld_rpath=no])
-         LDFLAGS="${SAVE_LD_FLAGS}"
+         LDFLAGS="${SAVE_LDFLAGS}"
       ])
       if test "$ld_rpath" = "yes"; then
          AC_SUBST(CC_LD_DYNPATH, [-rpath])

--=-=-=--
