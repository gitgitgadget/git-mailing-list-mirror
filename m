From: Dave Jones <davej@redhat.com>
Subject: Re: nightly tarballs of git
Date: Thu, 14 Sep 2006 15:36:16 -0400
Message-ID: <20060914193616.GA32735@redhat.com>
References: <20060914172754.GF8013@us.ibm.com> <20060914175116.GB22279@redhat.com> <7v1wqe45vs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>
X-From: git-owner@vger.kernel.org Thu Sep 14 21:36:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNx0e-0008Rd-9Y
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 21:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWINTgX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 15:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWINTgX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 15:36:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750773AbWINTgW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 15:36:22 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8EJaInR004760;
	Thu, 14 Sep 2006 15:36:18 -0400
Received: from pressure.kernelslacker.org (vpn-248-2.boston.redhat.com [10.13.248.2])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8EJaHlD004800;
	Thu, 14 Sep 2006 15:36:18 -0400
Received: from pressure.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by pressure.kernelslacker.org (8.13.8/8.13.8) with ESMTP id k8EJaHKY002353;
	Thu, 14 Sep 2006 15:36:17 -0400
Received: (from davej@localhost)
	by pressure.kernelslacker.org (8.13.8/8.13.8/Submit) id k8EJaGw3002352;
	Thu, 14 Sep 2006 15:36:16 -0400
X-Authentication-Warning: pressure.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wqe45vs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27031>

On Thu, Sep 14, 2006 at 12:15:03PM -0700, Junio C Hamano wrote:
 > Dave Jones <davej@redhat.com> writes:
 
 > > The original clone of the repo was just a straight clone of git://git.kernel.org/pub/scm/git/git.git
 > 
 > When the build procesure assigns the version to the generated
 > git binary, it does these checks and takes the first one:
 > 
 >  - Run "git describe" at the top of the source tree.  If it
 >    returns some version (not an error message), use it.  This
 >    case should not apply here since we are talking about a
 >    tarball of a working tree, and it does not have a repository.

On the server this is running on, the returns v1.3.3-g7f7e6ea

 >  - See if 'version' file exists at the top of the source tree,
 >    and uses what is recorded there.  This file is placed in the
 >    resulting tarball by the "make dist" target of the toplevel
 >    Makefile.
 >  - Otherwise use DEF_VER hardcoded in GIT-VERSION-GEN script.
 >    The 1.4.2 series is shipped with DEF_VER set to v1.4.2.GIT,
 >    so this does not explain why Nashanth sees "1.3.GIT" (or
 >    "v1.3.GIT", if the original report did not copy it right).
 > 
 > I just snarfed your snapshot tarball from a few days ago, and I
 > do not see any version file there (which indicates that it is
 > not a product of "make dist").  Interestingly enough DEF_VER is
 > set to v1.3.GIT in GIT-VERSION-GEN.  This line was changed from
 > v1.3.GIT to v1.4.GIT with commit 41292dd on June 10th and then
 > updated to v1.4.2.GIT with commit 5a71682 on August 3rd.
 > 
 > So a short conclusion is that the directory you are tarring up
 > does not have snapshot of my tree.
 > 
 > I would like to understand why.  If an automated 'pull' is
 > failing, that is somewhat worrysome, because I presume you do
 > not do any development of your own in your snapshot directory
 > and in that case everything should fast forward.  Even if 'pull'
 > failed somehow, if it is not reporting its failure, it is even
 > more worrysome.

I don't recall ever having done anything at all in the dir that
is being snapshotted. So the only thing that should be happening
is the side-effects of the script.  Here it is in its entirity..

DATE=`date +%Y-%m-%d`

PROJ="git"
cd ~/git-trees
if [ -d $PROJ ]; then
  cd $PROJ
  git pull -n
else
  git clone -q git://git.kernel.org/pub/scm/git/git.git
  cd $PROJ
fi
snap=git-snapshot-$(date +"%Y%m%d")
git-tar-tree HEAD $snap | gzip -9 > $PROJ-$DATE.tar.gz
mv $PROJ-$DATE.tar.gz ~/sites/www.codemonkey.org.uk/htdocs/projects/git-snapshots/$PROJ/
rm -f ~/sites/www.codemonkey.org.uk/htdocs/projects/git-snapshots/$PROJ/$PROJ-`date +%Y-%m-%d --date="7 days ago"`.tar.gz
ln -sf ~/sites/www.codemonkey.org.uk/htdocs/projects/git-snapshots/$PROJ/$PROJ-$DATE.tar.gz ~/sites/www.codemonkey.org.uk/htdocs/projects/git-snapshots/$PROJ/$PROJ-latest.tar.gz
#git-fsck-objects --full


I'll save that broken dir away somewhere, and rerun the script
(which as you can see above will make it reclone from scratch).
If you want a copy of the .git of the broken tree I can put that up somewhere too.

Hmm, I just checked the mail cron sent out recently (sadly I don't
have an archive of older mails).  It does look a bit strange..

got 49be764e948668341034e121fad5cf07ab079bff
got 415c09ba10a391cec60c939da1722c83df7cd906
* refs/heads/origin: fast forward to branch 'master' of http://www.kernel.org/pub/scm/git/git
  from 8a5dbef8ac24bc5a28409d646cf3ff6db0cccb3f to 38529e28a4f465ad5d5f2fa249ca17da680bac5f
Failed to fetch refs/heads/gb/diffdelta from http://www.kernel.org/pub/scm/git/git.git

Interesting. It looks like my original clone was over http.
Another reason to reclone over git: I guess.

	Dave
