From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] git-gui: add a .desktop file
Date: Thu, 12 May 2011 05:02:02 -0500
Message-ID: <20110512100202.GF28872@elie>
References: <alpine.DEB.2.02.1105112205450.14343@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@MIT.EDU>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 12:02:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKSil-0003f2-HA
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 12:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757080Ab1ELKCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 06:02:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36517 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab1ELKCI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 06:02:08 -0400
Received: by iwn34 with SMTP id 34so1270376iwn.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 03:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QfsF4l4r6QmLn7Tn6q+gP4rLIFUl5OBOSADFggH4JqY=;
        b=FbAGP1OdZyiv6bt2Thjr4Y3TPZvc2Jymrs0S/cVfXMiu9tAMXLXXjiLLhLr7QPjuDn
         RQuOyLcx0ADiQ7BiH5LjZmea4nsNkonKOwabd0y7VPWSZsvQuACBYntbBTjb8CBn2yNj
         s8n2BMBA9bCf7e545kXZT4Q7B7OmStO4bWBFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qbeLnGWmbSOpN7lJVljboz4Z38tVCsxqVjkaU0q0dQ1nw3X1H0wZOxvJ8XLSlbEd3M
         mI17AweFdEK0NRZdz7zI87aYxr090svgH/2sm3mMfHE3hyM9RQHZIVkGbTQQV6KbN98I
         m10q4qLLT1n8zqYHXcym0FlDELbkQ4dDtYmEQ=
Received: by 10.43.64.9 with SMTP id xg9mr15826icb.102.1305194527853;
        Thu, 12 May 2011 03:02:07 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id ui7sm421159icb.2.2011.05.12.03.02.05
        (version=SSLv3 cipher=OTHER);
        Thu, 12 May 2011 03:02:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1105112205450.14343@dr-wily.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173453>

From: Todd Zullinger <tmz@pobox.com>

Most X desktops use files following the Desktop Entry Specification
for menu entries.  Provide a .desktop file for users and distros to
install in the system menu to make git gui easier to find.

Caveats: this patch does not include Makefile rules to actually
install the .desktop file; they can come later.  Such Makefile rules
would need to change the Icon= line to avoid hardcoding a /usr
prefix.

[jn: removed GenericName and added RevisionControl category]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Anders Kaseorg wrote[1]:

> From https://bugs.launchpad.net/ubuntu/+source/git/+bug/781454 (under, you 
> know, some interpretation):
>
> git-gui could install a /usr/share/applications/git-gui.desktop, like this 
> one: 
> http://pkgs.fedoraproject.org/gitweb/?p=git.git;a=blob;f=git-gui.desktop;hb=HEAD

That's a good idea.  How about something like this, to start?

Installing to /usr/local/share/applications or /usr/share/applications
is not right for a program that is being installed for an individual
user.  I suppose $HOME/.local/share is a good default in that case.
Is a makefile supposed to check ifeq ($(prefix), $(HOME)) to take care
of that?

xdg-utils includes an xdg-desktop-menu helper which supports a --user
/ --system option that will presumably install to the right place, and
it is even nice enough to run update-desktop-database when done.
Unfortunately, it lacks DESTDIR support, so I don't think we can use
it.

The xdg-desktop-menu documentation suggests installing icons in some
centralized place with xdg-icon-resource.  The supported icon formats
are xpm and png.

So this is rough, but I still think including it would be an
improvement in the current state.  Thoughts?  Bugs?  Improvements?

Thanks to Todd for writing the desktop file in the first place.  I
hope I haven't broken it too much.

[1] http://bugs.debian.org/626442

 git-gui.desktop |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)
 create mode 100644 git-gui.desktop

diff --git a/git-gui.desktop b/git-gui.desktop
new file mode 100644
index 0000000..019ee8f
--- /dev/null
+++ b/git-gui.desktop
@@ -0,0 +1,8 @@
+[Desktop Entry]
+Name=Git GUI
+Comment=A graphical interface to Git
+Exec=git gui
+Icon=/usr/share/git-gui/lib/git-gui.ico
+Terminal=false
+Type=Application
+Categories=Development;RevisionControl;
-- 
1.7.5.1
