From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitk: try to set program icon
Date: Sun, 16 Nov 2008 00:45:45 +0100
Message-ID: <1226792745-18408-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 00:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Uqo-0007W6-PL
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 00:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbYKOXpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 18:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYKOXpg
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 18:45:36 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:4401 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYKOXpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 18:45:35 -0500
Received: by ey-out-2122.google.com with SMTP id 6so778007eyi.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 15:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=I8uZzmDFJZtML7UpXaXmsp1rjJO9LQwmNzVoCXO6olk=;
        b=UmUStD+DV17edNiWjckZN5V86zdr32rba/zQKrxygh8DYVodDrU5DRgFWhddGxfhBK
         Dz4/zi9YVahD6IEd5Kmfh5G0xFf2W+q+dwLhoObYsbf/sSJf0Wpbeat1rNDEqH0YkCNi
         uaJzjn2qjGuCQDk5W5fzxGsXnIPRsmXosxOf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=a+Ec2YHvNV0ekyJ/CBt/LvU6QYRNKMEcuXHp+P96H5nyTxtmMm1sjFj59N30suisnZ
         Y2Q0PesQCCysIlpzoIps4nLkpSTlLvzNgAgt+7RRbWgtJ8LD8L4ruCA73MESbB14GsTA
         fK5CfZhmOkjLXsJuN0loD8pjF3o9VplmN1DxE=
Received: by 10.210.17.2 with SMTP id 2mr2525742ebq.157.1226792733421;
        Sat, 15 Nov 2008 15:45:33 -0800 (PST)
Received: from localhost ([94.37.6.2])
        by mx.google.com with ESMTPS id 7sm1640003eyg.9.2008.11.15.15.45.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 15:45:33 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101098>

We add the git icon in three formats (.xbm, .ico, .ppm), which we try to
set as window icon.
---

Ugh. This rather simple patch cost me _way_ more time than I expected to
dedicate to it. Making those pesky iconbitmap and iconphoto commands do what
they were supposed to do is not as trivial as it seems. Thanks the people on
Freenode/#tcl for giving me a hand in understading they very restricted way in
which they could work.

Also, I'm not really sure the gitk program path itself is the best place to put
the icon files in, but I couldn't think of a better place so feel free to
suggest alternatives (it's a real pity that you can't embed the icon data in
the program itself).

 gitk-git/Makefile |    3 +++
 gitk-git/gitk     |    9 +++++++++
 gitk-git/gitk.ico |  Bin 0 -> 318 bytes
 gitk-git/gitk.ppm |  Bin 0 -> 781 bytes
 gitk-git/gitk.xbm |    6 ++++++
 5 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100644 gitk-git/gitk.ico
 create mode 100644 gitk-git/gitk.ppm
 create mode 100644 gitk-git/gitk.xbm

diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1b6045..a55f905 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -31,6 +31,7 @@ endif
 PO_TEMPLATE = po/gitk.pot
 ALL_POFILES = $(wildcard po/*.po)
 ALL_MSGFILES = $(subst .po,.msg,$(ALL_POFILES))
+LOGO_FILES = gitk.ico gitk.xbm gitk.ppm
 
 ifndef V
 	QUIET          = @
@@ -43,8 +44,10 @@ install:: all
 	$(INSTALL) -m 755 gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
 	$(foreach p,$(ALL_MSGFILES), $(INSTALL) -m 644 $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
+	$(foreach p,$(LOGO_FILES), $(INSTALL) -m 644 $p '$(DESTDIR_SQ)$(bindir_SQ)' &&) true
 
 uninstall::
+	$(foreach p,$(LOGO_FILES), $(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/$(notdir $p) &&) true
 	$(foreach p,$(ALL_MSGFILES), $(RM) '$(DESTDIR_SQ)$(msgsdir_SQ)'/$(notdir $p) &&) true
 	$(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
 
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 3353f4a..25cf627 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -10797,6 +10797,15 @@ set lserial 0
 set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
 setcoords
 makewindow
+# try to set the window icon, testing the logos from the worst to the best
+# quality. XBM is likely to fail on Windows, ICO is likely to fail on other
+# systems, and PPM with iconphoto only works for 8.4.9 or later
+catch { wm iconbitmap . @[file join [file dirname [file normalize $argv0]] gitk.xbm] }
+catch { wm iconbitmap . @[file join [file dirname [file normalize $argv0]] gitk.ico] }
+catch {
+	image create photo gitlogo -file [file join [file dirname [file normalize $argv0]] gitk.ppm]
+	wm iconphoto . -default gitlogo
+}
 # wait for the window to become visible
 tkwait visibility .
 wm title . "[file tail $argv0]: [file tail [pwd]]"
diff --git a/gitk-git/gitk.ico b/gitk-git/gitk.ico
new file mode 100644
index 0000000000000000000000000000000000000000..db349141ec3f510d98751fc117ff63eb4fc465c0
GIT binary patch
literal 318
zcmb7;u?~PB5JL-bbGgIB8JYM@Kg~bGR>MNVK*{Tc_J#ujpPA7&)Bv0SDlw9Ya_J_=
p{-aI+&sVh8AXZgo@^Ym@^W;wJQ<3sf8Bxc^KF5CcU%hwSe*yPC7a#xt

literal 0
HcmV?d00001

diff --git a/gitk-git/gitk.ppm b/gitk-git/gitk.ppm
new file mode 100644
index 0000000000000000000000000000000000000000..b6ea231fc8eb12827dced0cee8390bd0a2a424d1
GIT binary patch
literal 781
zcmWGA<1#c;Ff`*bGBxG;Kk~o<1_n3+`X0^(GBCNAA_UdbAw(G(7=Q?F5iwl28VCay
X7icDa1!%GmH^5CJh6{K0U|;|M>w9nk

literal 0
HcmV?d00001

diff --git a/gitk-git/gitk.xbm b/gitk-git/gitk.xbm
new file mode 100644
index 0000000..ce5871d
--- /dev/null
+++ b/gitk-git/gitk.xbm
@@ -0,0 +1,6 @@
+#define gitk_width 16
+#define gitk_height 16
+static char gitk_bits[] = {
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xDE, 0x7B, 
+  0xDE, 0x7B, 0x00, 0x00, 0x00, 0x00, 0x8C, 0x31, 0xDE, 0x7B, 0xDE, 0x7B, 
+  0x8C, 0x31, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, };
-- 
1.5.6.5
