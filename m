From: Jean-Marc Valin <jean-marc.valin@csiro.au>
Subject: git-kompare
Date: Fri, 24 Aug 2007 15:40:38 +1000
Message-ID: <46CE6F56.70803@csiro.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040201070204040708070108"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 08:16:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOSTT-0003Kq-HJ
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 08:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760120AbXHXGQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 02:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbXHXGQS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 02:16:18 -0400
Received: from panoramix.CeNTIE.NET.au ([202.9.6.85]:42938 "HELO
	panoramix.centie.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760120AbXHXGQO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 02:16:14 -0400
X-Greylist: delayed 1952 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2007 02:16:03 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by panoramix.centie.net.au (Postfix) with ESMTP id 8FBBBCFA15
	for <git@vger.kernel.org>; Fri, 24 Aug 2007 15:40:38 +1000 (EST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56549>

This is a multi-part message in MIME format.
--------------040201070204040708070108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I just wrote this tiny git-kompare script that I thought some may be
interested in. It basically does a visual diff using kompare. If it
weren't for bugs in kompare, the script would basically do:

git diff --unified=99999 $* | kompare -

As you can see, I really suck at shell programming, so this isn't
intended for being merged, although probably anyone with a clue about
shell can probably rewrite it in a slightly cleaner way. At the moment,
the only case it doesn't handle is when a file gets added and the
initial source is /dev/null.

Bugs it works around are:
- Unrecognised git syntax
(http://mail.kde.org/pipermail/kompare-devel/2006-August/000141.html
which is fixed in some later version of kompare I think)
- Kompare doesn't know about /dev/null as a file (fixed only for removal)
- Kompare doesn't like it when the first file in the diff isn't in the
root of the repository.

Hope it's useful for someone (I really like it).

Cheers,

	Jean-Marc

--------------040201070204040708070108
Content-Type: text/plain;
 name="git-kompare"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-kompare"

#!/bin/sh
(echo "Index: a\n--- a\n+++ a\n@@ -1,1 +1,1 @@\n-\n+\n"; git diff --unified=99999 $* | perl -ne 's/\/dev\/null/toto/; if (/^\+\+\+/) {s/^\+\+\+ b\/(.*)$/+++ $1\t(old version)/;} if (/^---/) {s/^--- a\/(.*)$/--- $1\t(new version)/;} print;') | kompare -

--------------040201070204040708070108--
