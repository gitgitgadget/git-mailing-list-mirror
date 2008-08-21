From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] test-lib: do not remove trash_directory if called with
 --debug
Date: Thu, 21 Aug 2008 09:49:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808210946280.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7vabf7mcpz.fsf@gitster.siamese.dyndns.org> <20080821011811.GA13915@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 09:45:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW4rD-0003vM-5G
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 09:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbYHUHoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 03:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758200AbYHUHoU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 03:44:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:42887 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758138AbYHUHoT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 03:44:19 -0400
Received: (qmail invoked by alias); 21 Aug 2008 07:44:17 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 21 Aug 2008 09:44:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+g0DEypAOgvJMJ74qRSgnUEri19bbDYGec4+P3qZ
	fWMsyVvETVZMpI
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080821011811.GA13915@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93117>


Sometimes you want to keep the trash directory, even if all tests
passed.  For example, when extending tests, it comes it quite handy.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 20 Aug 2008, Jeff King wrote:

	> On Wed, Aug 20, 2008 at 05:30:16PM -0700, Junio C Hamano wrote:
	> 
	> > * js/parallel-test (Mon Aug 18 12:25:40 2008 -0400) 4 commits
	> >  + Update t/.gitignore to ignore all trash directories
	> >  + Enable parallel tests
	> >  + tests: Clarify dependencies between tests, 'aggregate-results' and
	> >    'clean'
	> >  + t9700: remove useless check
	> 
	> I really liked this the first time I ran "make -j4 test". 
	> However, it now cleans up the trash directory automagically after a 
	> successful run. This bit me today when I added a test that should
	> have failed but accidentally passed. I wanted to look at the 
	> output, but it was gone.
	> 
	> Probably it's not worth worrying about, since that is certainly 
	> the less common case, and I can work around it by editing the passing 
	> test script to provoke failure. And I can't think of a more sane 
	> behavior. But I wanted to register my slight "this new thing annoyed 
	> me" feeling.

	My original patch tried to be clever and _not_ do the automagical 
	cleanup when run without -j.

	However, this was not liked.

	So I have this in my personal git fork.  Maybe it is good enough 
	for you?

	(Usage: run sh t0000-bla.sh -i -v -d)

 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6212c46..e2b106c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -491,7 +491,7 @@ fi
 
 # Test repository
 test="trash directory.$(basename "$0" .sh)"
-remove_trash="$TEST_DIRECTORY/$test"
+test ! -z "$debug" || remove_trash="$TEST_DIRECTORY/$test"
 rm -fr "$test" || {
 	trap - exit
 	echo >&5 "FATAL: Cannot prepare test area"
-- 
1.6.0.172.g459f5
