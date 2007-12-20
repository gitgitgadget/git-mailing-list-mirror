From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Thu, 20 Dec 2007 13:34:54 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712201333010.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com> 
 <20071219184457.GC3015@steel.home>  <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
  <4769A7FB.1070904@lsrfire.ath.cx> <57518fd10712200338m19c1def9n747dc9353ae41615@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 13:35:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Kci-0000Gg-0p
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 13:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760322AbXLTMe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 07:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760256AbXLTMe6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 07:34:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:58343 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760201AbXLTMe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 07:34:57 -0500
Received: (qmail invoked by alias); 20 Dec 2007 12:34:55 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp053) with SMTP; 20 Dec 2007 13:34:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7Y11NWo/7V7zJRchl1W+Px0vU0P55Pv7eNKFk32
	guhETgGNFklTAm
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <57518fd10712200338m19c1def9n747dc9353ae41615@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69001>

Hi,

On Thu, 20 Dec 2007, Jonathan del Strother wrote:

> I ended up trying to filter-branch my repository, see if I could come
> up with a version stripped of all our private code, suitable for
> making public.  Disappointingly, filter-branch magically fixes all the
> commits, even when simply run as "git filter-branch HEAD".
> 
> However, looking at the rewritten repository vs the original, they
> share a lot of commits, then diverge halfway through their history.  I
> can't see anything notable about the commit where they diverge, with
> the exception that the rewritten commit has a newline after the
> subject and the original doesn't.  Neither has a commit message body.

I do not see how Rene's patch could _not_ have fixed that problem.

As it is, I cannot even reproduce without that patch.  This is what I was 
trying:

-- snip --
diff --git a/t/t4025-pretty-format.sh b/t/t4025-pretty-format.sh
new file mode 100644
index 0000000..2826bcb
--- /dev/null
+++ b/t/t4025-pretty-format.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='git pretty formats'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	: > file &&
+	git add file &&
+	tree=$(git write-tree) &&
+	commit=$(echo No newlin | tr "\\012" e | git commit-tree $tree) &&
+	git update-ref HEAD $commit
+
+'
+
+test_expect_success 'format:%b' '
+
+	test -z "$(git log -1 --pretty=format:%b)"
+
+'
+
+test_done
-- snap --

Seems I cannot help any more, but at least this is a starting point to 
try to reproduce.

Ciao,
Dscho
