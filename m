From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 22:19:24 +0000
Message-ID: <20120727221924.GA8700@dcvr.yhbt.net>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
 <7vhast3hpb.fsf@alter.siamese.dyndns.org>
 <20120727053800.GC4685@burratino>
 <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
 <20120727200703.GA2034@dcvr.yhbt.net>
 <7vsjcczxgu.fsf@alter.siamese.dyndns.org>
 <20120727220753.GA7378@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 00:20:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SustE-0000YW-Bq
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 00:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab2G0WTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 18:19:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33610 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882Ab2G0WTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 18:19:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF571F5B5;
	Fri, 27 Jul 2012 22:19:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120727220753.GA7378@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202384>

Eric Wong <normalperson@yhbt.net> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> > 
> > > I'll put the following after ms/makefile-pl but before ms/git-svn-pm:
> > 
> > OK, it seems that you haven't pushed out the result yet (which is
> > fine); how do we want to proceed?

> So I'll hold off until we can fix the build regressions (working on it
> now)

OK, all fixed, all I needed was this (squashed in):

--- a/perl/Makefile
+++ b/perl/Makefile
@@ -22,6 +22,8 @@ clean:
 	$(RM) $(makfile).old
 	$(RM) PM.stamp
 
+$(makfile): PM.stamp
+
 ifdef NO_PERL_MAKEMAKER
 instdir_SQ = $(subst ','\'',$(prefix)/lib)

-------------
The redundant dependencies are biting us :<  I agree there presence in
the top-level Makefile needs to be reviewed.

Anyways, you can pull this now from my master:

The following changes since commit cdd159b2f56c9e69e37bbb8f5af301abd93e5407:

  Merge branch 'jc/test-lib-source-build-options-early' (2012-07-25 15:47:08 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn master

for you to fetch changes up to 5c71028fced46d03bf81b8625680d9ac87c8f4f0:

  Move initialization of Git::SVN variables into Git::SVN. (2012-07-27 22:14:54 +0000)

----------------------------------------------------------------
Junio C Hamano (1):
      perl: detect new files in MakeMaker builds

Michael G. Schwern (7):
      Quiet warning if Makefile.PL is run with -w and no --localedir
      Don't lose Error.pm if $@ gets clobbered.
      The Makefile.PL will now find .pm files itself.
      Extract some utilities from git-svn to allow extracting Git::SVN.
      Prepare Git::SVN for extraction into its own file.
      Extract Git::SVN from git-svn into its own .pm file.
      Move initialization of Git::SVN variables into Git::SVN.

 Makefile                       |    7 +
 git-svn.perl                   | 2340 +---------------------------------------
 perl/.gitignore                |    1 +
 perl/Git/SVN.pm                | 2324 +++++++++++++++++++++++++++++++++++++++
 perl/Git/SVN/Utils.pm          |   59 +
 perl/Makefile                  |    5 +
 perl/Makefile.PL               |   35 +-
 t/Git-SVN/00compile.t          |    9 +
 t/Git-SVN/Utils/can_compress.t |   11 +
 t/Git-SVN/Utils/fatal.t        |   34 +
 10 files changed, 2487 insertions(+), 2338 deletions(-)
 create mode 100644 perl/Git/SVN.pm
 create mode 100644 perl/Git/SVN/Utils.pm
 create mode 100644 t/Git-SVN/00compile.t
 create mode 100644 t/Git-SVN/Utils/can_compress.t
 create mode 100644 t/Git-SVN/Utils/fatal.t
