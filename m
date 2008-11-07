From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: absurdly slow git-diff
Date: Fri, 7 Nov 2008 15:42:24 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811071540340.3468@nehalem.linux-foundation.org>
References: <20081107200126.GA20284@toroid.org> <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org> <alpine.DEB.1.10.0811071503120.8736@alien.or.mcafeemobile.com> <alpine.DEB.1.10.0811071517280.8736@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Abhijit Menon-Sen <ams@toroid.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 00:44:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyazo-0005Tj-0Y
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 00:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbYKGXmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 18:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYKGXmx
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 18:42:53 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34406 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751311AbYKGXmw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2008 18:42:52 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA7NgOUl013323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Nov 2008 15:42:25 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA7NgOaX002658;
	Fri, 7 Nov 2008 15:42:24 -0800
In-Reply-To: <alpine.DEB.1.10.0811071517280.8736@alien.or.mcafeemobile.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.436 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100363>



On Fri, 7 Nov 2008, Davide Libenzi wrote:
> 
> With +/- 100 lines (200 lines window):
> 
> davide@alien:~$ time ./xdiff_test --diff 1 2 > /dev/null 
> 
> real    0m1.534s
> user    0m1.466s
> sys     0m0.040s

I assume the patch is something like the appended?

		Linus

---
 xdiff/xprepare.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index e87ab57..4bebd76 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -318,7 +318,7 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	 * Note that we always call this function with dis[i] > 1, so the
 	 * current line (i) is already a multimatch line.
 	 */
-	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
+	for (r = 1, rdis0 = 0, rpdis0 = 1; r < 100 && (i - r) >= s; r++) {
 		if (!dis[i - r])
 			rdis0++;
 		else if (dis[i - r] == 2)
@@ -334,7 +334,7 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	 */
 	if (rdis0 == 0)
 		return 0;
-	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
+	for (r = 1, rdis1 = 0, rpdis1 = 1; r < 100 && (i + r) <= e; r++) {
 		if (!dis[i + r])
 			rdis1++;
 		else if (dis[i + r] == 2)
