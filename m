From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 22:08:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901202202370.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901192145.21115.bss@iguanasuicide.net> <7v1vuympie.fsf@gitster.siamese.dyndns.org> <200901201842.24000.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:10:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPNrG-0001pB-Mq
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 22:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761369AbZATVIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 16:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761126AbZATVIf
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 16:08:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:43568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758847AbZATVIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 16:08:34 -0500
Received: (qmail invoked by alias); 20 Jan 2009 21:08:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 20 Jan 2009 22:08:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9StEsm069Wqr13+myGH16zsfb3otmwFWM/pDIZG
	im7KofAXFh4oI3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901201842.24000.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106525>

Hi,

On Tue, 20 Jan 2009, Markus Heidelberg wrote:

> Junio C Hamano, 20.01.2009:
> > "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
> > 
> > > When diff is invoked with --color-words (w/o =regex), use the regular
> > > expression the user has configured as diff.color-words.
> > >
> > > diff drivers configured via attributes take precedence over the
> > > diff.color-words setting.  If the user wants to change them, they have
> > > their own configuration variables.
> > 
> > This needs an entry in Documentation/config.txt
> > 
> > None of the existing configuration variables defined use hyphens in
> > multi-word variable names.
> 
> Except for diff.suppress-blank-empty
> Should it be converted or is it intention to reflect GNU diff's option?

Grumble.  It's in v1.6.1-rc1~348, so we cannot just go ahead and fix it.

My preference would be to convert it _except_ that the old name should 
still work.  But it should not be advertized.

Ciao,
Dscho "who loves consistency, and knows new users appreciate it, too"

-- snipsnap --
[PATCH] Rename diff.suppress-blank-empty to diff.suppressBlankEmpty

All the other config variables use CamelCase.  This config variable should
not be an exception.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt       |    2 +-
 diff.c                         |    4 +++-
 t/t4029-diff-trailing-space.sh |    8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c92e7e6..4f0a0b1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -652,7 +652,7 @@ diff.renames::
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
 
-diff.suppress-blank-empty::
+diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
 
diff --git a/diff.c b/diff.c
index c6a992d..0100b59 100644
--- a/diff.c
+++ b/diff.c
@@ -118,7 +118,9 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	}
 
 	/* like GNU diff's --suppress-blank-empty option  */
-	if (!strcmp(var, "diff.suppress-blank-empty")) {
+	if (!strcmp(var, "diff.suppressblankempty") ||
+			/* for backwards compatibility */
+			!strcmp(var, "diff.suppress-blank-empty")) {
 		diff_suppress_blank_empty = git_config_bool(var, value);
 		return 0;
 	}
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index 4ca65e0..9ddbbcd 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -2,7 +2,7 @@
 #
 # Copyright (c) Jim Meyering
 #
-test_description='diff honors config option, diff.suppress-blank-empty'
+test_description='diff honors config option, diff.suppressBlankEmpty'
 
 . ./test-lib.sh
 
@@ -24,14 +24,14 @@ test_expect_success \
      git add f &&
      git commit -q -m. f &&
      printf "\ny\n" > f &&
-     git config --bool diff.suppress-blank-empty true &&
+     git config --bool diff.suppressBlankEmpty true &&
      git diff f > actual &&
      test_cmp exp actual &&
      perl -i.bak -p -e "s/^\$/ /" exp &&
-     git config --bool diff.suppress-blank-empty false &&
+     git config --bool diff.suppressBlankEmpty false &&
      git diff f > actual &&
      test_cmp exp actual &&
-     git config --bool --unset diff.suppress-blank-empty &&
+     git config --bool --unset diff.suppressBlankEmpty &&
      git diff f > actual &&
      test_cmp exp actual
      '
-- 
1.6.1.439.g22f77c
