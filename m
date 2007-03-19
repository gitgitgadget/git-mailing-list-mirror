From: Theodore Tso <tytso@mit.edu>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 23:21:30 -0400
Message-ID: <20070319032130.GF11371@thunk.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org> <20070319024744.GD11371@thunk.org> <20070319025603.GG20658@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:21:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8RE-0001Zc-Dq
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933801AbXCSDVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933783AbXCSDVf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:21:35 -0400
Received: from THUNK.ORG ([69.25.196.29]:33226 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933801AbXCSDVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:21:34 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HT8Wz-0001Zh-8q; Sun, 18 Mar 2007 23:27:33 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HT8R8-0006a1-Nv; Sun, 18 Mar 2007 23:21:30 -0400
Content-Disposition: inline
In-Reply-To: <20070319025603.GG20658@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42575>

On Sun, Mar 18, 2007 at 10:56:03PM -0400, Shawn O. Pearce wrote:
> The reflog does update if the log file exists during a push (err,
> actually during receive-pack).  Or if core.logAllRefUpdates is set
> to true.  Now this isn't the default in a bare repository, but it
> should be the default in a repository with a working directory.
> So the case we are talking about should be seeing the reflog update.

So I dug a little more deeply, and the problem is that the reflog for
master was getting updated, but not the reflog for HEAD, and that's
what "git reflog" was showing --- hence my confusion.

What are the rules for when HEAD's reflog should get updated, and is
this documented anywhere in the man pages?

						- Ted

Script started on Sun 18 Mar 2007 11:11:59 PM EDT
Top-level shell (parent script)
Using ssh-agent pid 7679
<tytso@candygram> {/home/tytso/talks/dscm/git}  
1% cp -r test1 test2 ; cd test2
<tytso@candygram> {/home/tytso/talks/dscm/git/test2}  
2% (cd r2; git-config core.logallrefupdates)
true
<tytso@candygram> {/home/tytso/talks/dscm/git/test2}  
3% cat r2/.git/refs/heads/master
f2e3cc0bb64c8c94b89ba07bfbdd1653584586f2
<tytso@candygram> {/home/tytso/talks/dscm/git/test2}  
4% cat r2/.git/logs/HEAD
0000000000000000000000000000000000000000 f2e3cc0bb64c8c94b89ba07bfbdd1653584586f2 Theodore Ts'o <tytso@mit.edu> 1174266825 -0400
<tytso@candygram> {/home/tytso/talks/dscm/git/test2}  
5% cat r2/.git/logs/refs/heads/master
0000000000000000000000000000000000000000 f2e3cc0bb64c8c94b89ba07bfbdd1653584586f2 Theodore Ts'o <tytso@mit.edu> 1174266825 -0400
<tytso@candygram> {/home/tytso/talks/dscm/git/test2}  
6% (cd r1 ; git push ../r2)
updating 'refs/heads/master'
  from f2e3cc0bb64c8c94b89ba07bfbdd1653584586f2
  to   37508dc11dbe274d021124057fd2d027f6ce9d17
Generating pack...
Done counting 5 objects.
Result has 3 objects.
Deltifying 3 objects.
 100% (3/3) done
Writing 3 objects.
 100% (3/3) done
Total 3 (delta 2), reused 0 (delta 0)
Unpacking 3 objects
  100% (3/3) done
refs/heads/master: f2e3cc0bb64c8c94b89ba07bfbdd1653584586f2 -> 37508dc11dbe274d021124057fd2d027f6ce9d17
<tytso@candygram> {/home/tytso/talks/dscm/git/test2}  
7% cd r2
<tytso@candygram> {/home/tytso/talks/dscm/git/test2/r2}  [master]
8% cat .git/refs/heads/master
37508dc11dbe274d021124057fd2d027f6ce9d17
<tytso@candygram> {/home/tytso/talks/dscm/git/test2/r2}  [master]
9% cat .git/logs/HEAD
0000000000000000000000000000000000000000 f2e3cc0bb64c8c94b89ba07bfbdd1653584586f2 Theodore Ts'o <tytso@mit.edu> 1174266825 -0400
<tytso@candygram> {/home/tytso/talks/dscm/git/test2/r2}  [master]
10% cat .git/logs/refs/heads/master
0000000000000000000000000000000000000000 f2e3cc0bb64c8c94b89ba07bfbdd1653584586f2 Theodore Ts'o <tytso@mit.edu> 1174266825 -0400
f2e3cc0bb64c8c94b89ba07bfbdd1653584586f2 37508dc11dbe274d021124057fd2d027f6ce9d17 Theodore Ts'o <tytso@mit.edu> 1174274004 -0400	push
<tytso@candygram> {/home/tytso/talks/dscm/git/test2/r2}  [master]
11% git reflog
37508dc... HEAD@{0}: 
<tytso@candygram> {/home/tytso/talks/dscm/git/test2/r2}  [master]
13% git version
git version 1.5.0.5.425.g9cec6-dirty
<tytso@candygram> {/home/tytso/talks/dscm/git/test2/r2}  [master]
14% exit

Script done on Sun 18 Mar 2007 11:14:28 PM EDT
