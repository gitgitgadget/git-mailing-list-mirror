From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 0/3] Enable parallelized tests
Date: Fri, 8 Aug 2008 17:36:24 +0200
Message-ID: <20080808153624.GA28716@neumann>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 17:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRU24-0003Fn-7P
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 17:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYHHPg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 11:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbYHHPg1
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 11:36:27 -0400
Received: from francis.fzi.de ([141.21.7.5]:8398 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752569AbYHHPg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 11:36:26 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 17:36:23 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 08 Aug 2008 15:36:23.0937 (UTC) FILETIME=[83942F10:01C8F96C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91684>


Hi,

On Fri, Aug 08, 2008 at 07:59:08AM +0200, Johannes Schindelin wrote:
> This patch pair enables parallel tests.
Glad to see that others have also picked up this topic.  I have also
written parallel testing patches back in March, but did not send them
out, as there were issues I could not resolve in a satisfactory way -
and your patches doesn't seem to address theim either.

There are a few tests involving http transfers, namely:
  t5540-http-push.sh
  t9115-git-svn-dcommit-funky-renames.sh=20
  t9118-git-svn-funky-branch-names.sh
  t9120-git-svn-clone-with-percent-escapes.sh

These start an apache web server at the beginning of the test and shut
it down after the test finished.  Obviously, if you run tests in
parallel then these tests can also run concurrently.  The problem is
with the svn tests, as all those tests use the same directory and port
for the web server, resulting in failed tests with -jN.

t5540 is not an issue at the moment, as it uses lib-httpd.sh, hence a
different directory and a (possibly) different port than the svn
tests.  However, who knows, in the future we might have other tests
using lib-httpd.sh.

The simplest solution would be to disable parallel testing altogether
if http tests are enabled (GIT_TEST_HTTPD and SVN_HTTPD_PORT).  But
IMHO it would be much better to have only one apache process for the
_whole_ testsuite, and to have different paths for the test repos
under its documentroot.  But yes, it's more difficult to implement; at
least I could not do it.


Regards,
G=E1bor
