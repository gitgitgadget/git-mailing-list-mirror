From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] var doc: advertise current DEFAULT_PAGER and
 DEFAULT_EDITOR settings
Date: Sat, 31 Mar 2012 03:44:53 -0500
Message-ID: <20120331084453.GE4119@burratino>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino>
 <7v398qq1ei.fsf@alter.siamese.dyndns.org>
 <20120331084015.GC4119@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rodrigo Silva (MestreLion)" <linux@rodrigosilva.com>,
	git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 10:45:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDtvn-0004FR-3x
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 10:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919Ab2CaIpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 04:45:01 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59328 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab2CaIo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 04:44:57 -0400
Received: by iagz16 with SMTP id z16so1965452iag.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DwTe73vtG5rrKyTPzKc0XOHyCcH2gxpdxlMvNMQzF3Y=;
        b=dwNk1nz+Z6jzdDsqoAkLd5u2oRxhDebti3x5ZJ9VE3ddtHX2WPuE6EOkCO6ErLSm3l
         Wn9f9bCZr5WGSrumtPAQaeyhOjwC7+e/41bhk1xZuCPTBkvcOAiv3wsmqYLV2rd0/+C7
         jlsH+MzJk5tbhhF88hYX/6NE9wwmy+VJURKa15ZeqxlChu05FQjM9oMkvCZuGTBsCn4D
         377Gw0+hr/7YEtp1AtIK+Aile3hyfjpLEqvxf/vKnlIOGo3q9HkzXwCdZn1zTo5XH3mH
         yK7Lhp8hROcY5OMO0rVQzeeGttzFELHpg+ALPMPBkEEbGr4BE8X3WZeHSWxh/A4k7OYL
         9tdQ==
Received: by 10.50.156.229 with SMTP id wh5mr1017538igb.28.1333183497430;
        Sat, 31 Mar 2012 01:44:57 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hq3sm13145747igc.0.2012.03.31.01.44.56
        (version=SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 01:44:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120331084015.GC4119@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194440>

Document the default pager and editor chosen at compile time in the
git-var(1) manpage so users curious about what command _this_ copy of
git will fall back to when EDITOR, VISUAL, and PAGER are unset can
find the answer quickly.

In builds leaving those settings uncustomized, this patch makes the
manpage continue to say "usually vi" and "usually less" so the
formatted documentation is usable for a wide audience including users
of custom builds that change those settings.  If you would like your
copy of the docs to be less noncommittal, you will need to set
DEFAULT_PAGER=less and DEFAULT_EDITOR=vi explicitly.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 Documentation/Makefile    |   10 ++++++++++
 Documentation/git-var.txt |   10 ++++++++++
 Makefile                  |    2 ++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d40e211f..9fee0b92 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -124,6 +124,16 @@ SHELL_PATH ?= $(SHELL)
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
+ifdef DEFAULT_PAGER
+DEFAULT_PAGER_SQ = $(subst ','\'',$(DEFAULT_PAGER))
+ASCIIDOC_EXTRA += -a 'git-default-pager=$(DEFAULT_PAGER_SQ)'
+endif
+
+ifdef DEFAULT_EDITOR
+DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
+ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
+endif
+
 #
 # Please note that there is a minor bug in asciidoc.
 # The version after 6.0.3 _will_ include the patch found here:
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index beef9e28..44a5e356 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -44,14 +44,24 @@ GIT_EDITOR::
     --nofork`.  The order of preference is the `$GIT_EDITOR`
     environment variable, then `core.editor` configuration, then
     `$VISUAL`, then `$EDITOR`, and then the default chosen at compile
+ifndef::git-default-editor[]
     time, which is usually 'vi'.
+endif::git-default-editor[]
+ifdef::git-default-editor[]
+    time ('{git-default-editor}').
+endif::git-default-editor[]
 
 GIT_PAGER::
     Text viewer for use by git commands (e.g., 'less').  The value
     is meant to be interpreted by the shell.  The order of preference
     is the `$GIT_PAGER` environment variable, then `core.pager`
     configuration, then `$PAGER`, and then the default chosen at
+ifndef::git-default-pager[]
     compile time (usually 'less').
+endif::git-default-pager[]
+ifdef::git-default-pager[]
+    compile time ('{git-default-pager}').
+endif::git-default-pager[]
 
 Diagnostics
 -----------
diff --git a/Makefile b/Makefile
index be1957a5..adc48b0d 100644
--- a/Makefile
+++ b/Makefile
@@ -2258,6 +2258,8 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
 
+export DEFAULT_EDITOR DEFAULT_PAGER
+
 doc:
 	$(MAKE) -C Documentation all
 
-- 
1.7.10.rc3
