From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 13 Dec 2010 19:09:04 +0000 (UTC)
Message-ID: <loom.20101213T194818-377@post.gmane.org>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org> <7vlk01hqzz.fsf@gitster.siamese.dyndns.org> <20080718175040.6117@nanako3.lavabit.com> <20080718182010.6117@nanako3.lavabit.com> <20080718094404.GB32184@machine.or.cz> <7vtzen7bul.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 20:15:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSDri-0001Kb-WC
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 20:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0LMTPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 14:15:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:49026 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab0LMTPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 14:15:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PSDrW-0001EO-Rw
	for git@vger.kernel.org; Mon, 13 Dec 2010 20:15:07 +0100
Received: from novo.Kiewit.dartmouth.edu ([novo.Kiewit.dartmouth.edu])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 20:15:06 +0100
Received: from debian by novo.Kiewit.dartmouth.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 20:15:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 129.170.31.69 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101028 Iceweasel/3.5.15 (like Firefox/3.5.15))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163582>

Dear Everyone,

> I tried not to sound too negative when describing -Xours and -Xtheirs
> there, but actually I think "-s theirs" is even worse.  It is how you
> would discard what you did (perhaps because the other side has much better
> solution than your hack)

or perhaps this is very well intended, e.g. if you are tracking other project's
development and just need to carry a limited portion of the source tree.

Sorry for reincarnating this old thread, but  since I have filed Debian
wishlist bug against GIT for '-s theirs':

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=581680

and this thread is linked to it as the ultimate source 'why not (yet)', I want
to describe a usecase when/why I wanted to have -s theirs:

For debian packaging, we often need to clean up the upstream source tree so it
does not contain non-free material (binary blobs, components under non-free
licenses, etc).  If I want to setup all packaging within GIT, I would follow
natively following setup:

git checkout -b dfsg 0.1
git rm non-free-1 non-free-2 ...
git commit -m "DFSG-compliant 0.1"
git tag -a -m 0.1.dfsg

and base my packaging off dfsg branch (in a separate branch, e.g. debian).

Upon release 0.2 of upstream work, in the simplest case, I can do now

git checkout dfsg
git merge 0.2

and there things could get hairy -- if files were modified upstream, I get
conflicts, so I would need to git rm files again, and only then commit the
merge:

git rm 

Moreover, 0.2 might not follow 0.1 -- upstream might release off
"release-branches", then I simply *must not* do "git merge" with recursive 
strategy.

Moreover, if some material finally became free, I would need to re-add it
somehow into dfsg branch from 0.2 branch.


*All* those complications could easily be avoided if I only had '-s theirs'.
Then I simply

git checkout dfsg
git merge --no-commit -s theirs 0.2
# after all I do not, and must not have my modifications
git rm -rf non-free-1 ... # probably would be scripted
git commit

With -s theirs now I would be able manage all tricky cases above without hassle
in a unified way.

Would it be possible to have GIT people reconsider addition of '-s theirs'?

Thank you in advance for your time!
