From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug: build from tarball uses git-describe
Date: Wed, 14 Feb 2007 02:00:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702140159440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eqtfso$7mo$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Feb 14 02:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH8Vj-0006uP-DL
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 02:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbXBNBAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 20:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbXBNBAd
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 20:00:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:50833 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932207AbXBNBAc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 20:00:32 -0500
Received: (qmail invoked by alias); 14 Feb 2007 01:00:31 -0000
X-Provags-ID: V01U2FsdGVkX1+alNgOGviafBm0oMhBQLrsQiNymlc7Wooj+imNXb
	n8jw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <eqtfso$7mo$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39603>

Hi,

On Tue, 13 Feb 2007, Han-Wen Nienhuys wrote:

> apparently, the makefile blindly uses the output of 
> 
>   git describe 
> 
> without checking whether there is a .git directory.

Does this (totally untested) patch help?

--

 GIT-VERSION-GEN |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 7a10b60..e6f89cb 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -8,7 +8,7 @@ LF='
 
 # First try git-describe, then see if there is a version file
 # (included in release tarballs), then default
-if VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
+if test -d .git && VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
    case "$VN" in
    *$LF*) (exit 1) ;;
    v[0-9]*) : happy ;;
