From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn and u-boot broken.
Date: Sun, 15 Oct 2006 01:54:04 +0200
Message-ID: <00f901c6efec$07fdc630$1267a8c0@Jocke>
References: <20061014224636.GA12565@soma>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 01:56:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYtMZ-0005pl-CI
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 01:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbWJNX4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 19:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbWJNX4Q
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 19:56:16 -0400
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:35356
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1752270AbWJNX4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 19:56:15 -0400
Received: from Jocke ([84.217.9.178]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sun, 15 Oct 2006 01:56:10 +0200
To: "'Eric Wong'" <normalperson@yhbt.net>
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: Acbv4qQD4zn1yAERTIGc4M+8QDmHMwABvjhA
In-Reply-To: <20061014224636.GA12565@soma>
X-OriginalArrivalTime: 14 Oct 2006 23:56:10.0690 (UTC) FILETIME=[52C99220:01C6EFEC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28896>

> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > 
> > > -----Original Message-----
> > > From: Eric Wong [mailto:normalperson@yhbt.net] 
> > > Sent: den 14 oktober 2006 08:28
> > > To: Joakim Tjernlund
> > > Cc: 'Randal L. Schwartz'; git@vger.kernel.org
> > > Subject: Re: git-svn and u-boot broken.
> > > 
> > > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > >  
> > > > 
> > > > > -----Original Message-----
> > > > > From: Randal L. Schwartz [mailto:merlyn@stonehenge.com] 
> > > > > Sent: den 13 oktober 2006 21:40
> > > > > To: Joakim Tjernlund
> > > > > Cc: git@vger.kernel.org
> > > > > Subject: Re: git-svn and u-boot broken.
> > > > > 
> > > > > >>>>> "Joakim" == Joakim Tjernlund 
> > > > > <joakim.tjernlund@transmode.se> writes:
> > > > > 
> > > > > Joakim> First, I had to change this (from memory) in git-svn:
> > > > > Joakim>   my $got = SVN::TxDelta::send_stream($fh, @$atd, 
> > > > > $self->{pool});
> > > > > Joakim> to
> > > > > Joakim>   my $got;
> > > > > Joakim>   if ( $got ) {
> > > > > Joakim>     $got = SVN::TxDelta::send_stream($fh, @$atd, 
> > > > > $self->{pool});
> > > > > Joakim>   } else {
> > > > > Joakim>     $got = $exp
> > > > > Joakim>   }
> > > > > Joakim> I am no perl programmer so please change as 
> you se fit.
> > > 
> > > With your correction following merlyn's comments, it could 
> > > work[1].  I'm
> > > curious as to what change git-svn printed right before 
> > > hitting an error
> > 
> > from memory:
> > Usage: svn_txdelta_send_stream(x,y,z,m)
>  
> > > here, and would like to see the files (before and after) that were
> > > printed by git-svn.
> > 
> > Sorry, don't have that hande ATM
> 
> Could you publish your git repository for u-boot and also the
> exact commands (if you have them) you used to attempt the import
> into SVN?  Thanks.

The git repo is a bit complicated as I don't have have anywhere
to put it. However I don't think you need it, just clone DENX u-boot repo
at git://www.denx.de/git/u-boot.git, it bails out before it gets to my
changes.

Here is the script I use to test with

REPO="file:///tmp/SVNuboot"
REPO_PATH="/tmp/SVNuboot"
GIT_REPO="/tmp/mygituboot"
ORG_REPO="/usr/local/src/u-boot"
rm -rf "$REPO_PATH"
rm -rf "$GIT_REPO"
svnadmin create "$REPO_PATH"
svn mkdir -m "initial repo layout" "$REPO"/trunk "$REPO"/branches "$REPO"/tags
mkdir -p "$GIT_REPO"
cd "$GIT_REPO"
git-svn init "$REPO"/trunk
echo  [user] >> .git/config
echo  name="jocke" >> .git/config
echo  email="Joakim.Tjernlund@transmode.se" >> .git/config
git-svn fetch
git checkout -b svn-branch remotes/git-svn
git-fetch "$ORG_REPO" tmcu2:tmcu
git-branch initial-uboot f5e0d03970409feb3c77ab0107d5dece6b7d45c9
git pull . initial-uboot
# --squash makes one large commit.
#git pull --squash . initial-uboot
#cg-commit -m "merge up to f5e0d03970409feb3c77ab0107d5dece6b7d45c9"


# without --squash one gets a SVN repo with lots of small commits(2)
git pull . initial-uboot
git-svn commit -q remotes/git-svn..svn-branch


(2)
 This fails currently with 
 git-svn commit -q remotes/git-svn..svn-branch
diff-tree 9030f4be0b324cb312cfecd86d4a7da04ffa99ee 8e9655f863246db60c51140153186acc2afdc855
Inappropriate ioctl for device at /usr/bin/git-svn line 1462
6400 at /usr/bin/git-svn line 1462
6400 at /usr/bin/git-svn line 547
        main::commit_lib('8e9655f863246db60c51140153186acc2afdc855', 'ef04a0aa2676738847bd69914cadac0b96d6e731',
'4d03a21f2329bb13a9661a23742ac0b77a7a76d5', 'f190c11b1f22ff766e046588e5a7bb55f28ae305', '182e10691f378987b53c64ee0347d542e4924ef6',
'527b5a511c804074eebfc08c9ae7860b6717da85', 'ea339205a94706d8b9170bbd89e8c1373df9a92f', '3ada834e30a0742991209140049035c626ccea85',
'feaedfcf84c92599c0b805f66cc8a628d82411f0', ...) called at /usr/bin/git-svn line 457
        main::commit('remotes/git-svn..svn-branch') called at /usr/bin/git-svn line 149
> 
> > > I'm not sure what change would show up in git but cause 
> > > apply_textdelta
> > > to return undef...
> > > 
> > > [1] - I am tempted to apply a change based on yours, but this 
> > > could just
> > > be working around another bug somewhere else (either in git-svn or
> > > subversion).
> > > 
> > > > > That doesn't make any sense.  You'll never run the if-true 
> > > > > branch there.
> > > > > The value of $got immediately following "my $got;" is 
> > > always undef.
> > > > 
> > > > git-pull --squash seems to do what I want but know I 
> get this when
> > > > committing to svn: 
> > > > git-svn commit remotes/git-svn..svn-branch
> > > > ...
> > > >         A       cpu/mpc824x/drivers/i2c_export.h
> > > >         A       cpu/mpc824x/drivers/i2o.h
> > > >         A       cpu/mpc824x/drivers/i2o/Makefile
> > > >         A       cpu/mpc824x/drivers/i2o/Makefile_pc
> > > > Cannot allocate memory at /usr/bin/git-svn line 1462
> > > > 3072 at /usr/bin/git-svn line 547
> > > >         
> > > main::commit_lib('2ff9bcb7908d2752f643695ab3a28f9ababfafab') 
> > > called at /usr/bin/git-svn line 457
> > > >         main::commit('remotes/git-svn..svn-branch') called 
> > > at /usr/bin/git-svn line 149
> > > 
> > > How large is the changeset you're committing?
> > > (git show --stat 2ff9bcb7908d2752f643695ab3a28f9ababfafab)
> > 
> > That gives me a huge listing that ends in:
> >  4306 files changed, 1194819 insertions(+), 0 deletions(-)
> 
> Yikes, that's a huge commit.  git-svn memory usage was bounded
> for the size of each changeset, so yes, this could get nasty.
> Patch coming in a reply to this message.

Thanks, will try that patch next.

  Jocke
