From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] gitk: use symbolic font names "sans" and "monospace" when
 available
Date: Thu, 8 Mar 2012 06:30:11 -0600
Message-ID: <20120308123011.GA4355@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Mark Hills <mark@pogo.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 13:30:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5cUE-0000ZA-L4
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425Ab2CHMaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 07:30:22 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:41821 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756684Ab2CHMaU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 07:30:20 -0500
Received: by obbuo6 with SMTP id uo6so596207obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 04:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=wfUcufuOZXDTSLdkz8flqz2TMTNOfZzgsMR4AFUd654=;
        b=HAYeV11HPQCb8bWLiLkjNnuLU2XHX+6722gUzw1dHEyeukODnXhPIUDgkWoeHOHhQf
         t7ze46ybZU8FkMbsEcd9qxOPfH+pVwK6F4pDTdtu/i5o4RiaD0/4ludfLCHKgatlvCXL
         O/rMTrZfhcMe+9GNWvfkTNrPEGzZDjvXJjpRD2CkdhEixff1UooN9Wsbah1xQYgzqmTe
         Hv8lE9+2n7DZXBYMGaf70cORj6vzfwqmnMQO3PDkW0IIVzbOBS4lSK7wtLy8+mwvjT0c
         baF2T7lC6fGNYqiZCuh6zAL+p/oU6ZUk/FmnAzcjgD5AU74IRcqdmdEbDaKV7Wl8pFIl
         LyHw==
Received: by 10.182.14.97 with SMTP id o1mr2207538obc.57.1331209820466;
        Thu, 08 Mar 2012 04:30:20 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vy18sm2388257obc.8.2012.03.08.04.30.19
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 04:30:20 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192584>

The following only concerns systems using X and the client-side font
rendering framework from freedesktop.org.  Windows and Mac OS X are
not affected.

Starting with version 8.5, Tk uses freetype and fontconfig by default
to render fonts on platforms that support it.  Gitk currently defaults
to the font Helvetica for the interface and Courier for diffs, and
both unfortunately look rather bad on screen in the default
configuration on many Linux distros with anti-aliasing and poor
hinting.

It is better to default to "sans" and "monospace", which are mapped by
fontconfig to some appropriate font of the sysadmin and user's
choosing (typically Bitstream Vera Sans and Mono).  The result looks
more sensible and it makes gitk feel like a well-behaved software
citizen since its fonts match other native apps.

This patch does not change the appearance of gitk for users that have
already run it, since gitk uses the remembered UI and diff font names
from ~/.gitk

Requested-by: Michael Biebl <biebl@debian.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

A variant of this patch that just unconditionally set the fonts has
been in Debian for more than a year, but just now I finally got around
to making it conditional.  Tested with tk 8.5 (where fontconfig is
used) and tk 8.4 (where it isn't) and the autodetection seems to work.

Sensible?

Jonathan

 gitk-git/gitk |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 64ef3c40..6981cb20 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11426,6 +11426,11 @@ if {[tk windowingsystem] eq "aqua"} {
     set mainfont {{Lucida Grande} 9}
     set textfont {Monaco 9}
     set uifont {{Lucida Grande} 9 bold}
+} elseif {![catch {::tk::pkgconfig get fontsystem} xft] && $xft eq "xft"} {
+    # fontconfig!
+    set mainfont {sans 9}
+    set textfont {monospace 9}
+    set uifont {sans 9 bold}
 } else {
     set mainfont {Helvetica 9}
     set textfont {Courier 9}
-- 
1.7.9.2
