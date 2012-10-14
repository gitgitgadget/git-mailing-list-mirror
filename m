From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: A design for subrepositories
Date: Sun, 14 Oct 2012 18:25:23 +0200
Message-ID: <507AE773.1010301@web.de>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi> <7vd30m2sbr.fsf@alter.siamese.dyndns.org> <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi> <7vzk3p1xh3.fsf@alter.siamese.dyndns.org> <20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi> <507ABDF3.4040106@web.de> <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lauri Alanko <la@iki.fi>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:25:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNR0Z-0007OC-Pn
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 18:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab2JNQZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 12:25:32 -0400
Received: from mout.web.de ([212.227.17.12]:60435 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603Ab2JNQZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 12:25:31 -0400
Received: from [192.168.178.41] ([79.193.81.106]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M8i11-1TaAOX19ud-00vcSy; Sun, 14 Oct 2012 18:25:30
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi>
X-Provags-ID: V02:K0:cfJzb2voym6V56qNwoJPEniz2zTln/sIzMrc1TONlBi
 mTVhTQzonz0X6CFEPjaXul3uWWriS60XnCdk0uG/Bz2/M1d9xy
 Pr7BCgACxsKxsyzEEChcE9ZQ7yVgdi9gOVGFr5MwWDMoI55CMx
 y+drw0iiXbSiORdCOjvQyzk0c9k132dm6lIvvlTqb6xpRloPS6
 ypw4MQxfeTlTbT/AgOF5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207675>

Am 14.10.2012 17:27, schrieb Lauri Alanko:
> Quoting "Jens Lehmann" <Jens.Lehmann@web.de>:
>> Did you notice that "git fetch" fetches all those submodules too which
>> have been updated in the commits fetched for the superproject, no matter
>> on what branch they are on?
> 
> No. This would be great, but this is what I get:
> 
> la@bq:~/tmp$ git init super
> Initialized empty Git repository in /home/la/tmp/super/.git/
> la@bq:~/tmp$ cd super
> la@bq:~/tmp/super$ echo foo > foo
> la@bq:~/tmp/super$ git add foo
> la@bq:~/tmp/super$ git ci -m foo
> [master (root-commit) 0f207c9] foo
>  1 file changed, 1 insertion(+)
>  create mode 100644 foo
> la@bq:~/tmp/super$ git branch nosubs
> la@bq:~/tmp/super$ git init sub
> Initialized empty Git repository in /home/la/tmp/super/sub/.git/
> la@bq:~/tmp/super$ cd sub
> la@bq:~/tmp/super/sub$ echo bar > bar
> la@bq:~/tmp/super/sub$ git add bar
> la@bq:~/tmp/super/sub$ git ci -m bar
> [master (root-commit) 180c6c9] bar
>  1 file changed, 1 insertion(+)
>  create mode 100644 bar
> la@bq:~/tmp/super/sub$ cd ..
> la@bq:~/tmp/super$ git submodule add ./sub
> Adding existing repo at 'sub' to the index
> la@bq:~/tmp/super$ git ci -m sub
> [master 16cff18] sub
>  2 files changed, 4 insertions(+)
>  create mode 100644 .gitmodules
>  create mode 160000 sub
> la@bq:~/tmp/super$ cd ..
> la@bq:~/tmp$ git clone super superc
> Cloning into 'superc'...
> done.
> la@bq:~/tmp$ cd superc
> la@bq:~/tmp/superc$ git submodule update --init
> Submodule 'sub' (/home/la/tmp/super/sub) registered for path 'sub'
> Cloning into 'sub'...
> done.
> Submodule path 'sub': checked out '180c6c979289f4e25525003673e51d0e39dab8f6'
> la@bq:~/tmp/superc$ cd ../super/sub
> la@bq:~/tmp/super/sub$ echo baz >> bar
> la@bq:~/tmp/super/sub$ git ci -am baz
> [master 652c8b3] baz
>  1 file changed, 1 insertion(+)
> la@bq:~/tmp/super/sub$ cd ..
> la@bq:~/tmp/super$ git ci -am subbaz
> [master c7c3bfc] subbaz
>  1 file changed, 1 insertion(+), 1 deletion(-)
> la@bq:~/tmp/super$ cd ../superc
> la@bq:~/tmp/superc$ git co nosubs
> warning: unable to rmdir sub: Directory not empty
> Branch nosubs set up to track remote branch nosubs from origin.
> Switched to a new branch 'nosubs'
> la@bq:~/tmp/superc$ git fetch --recurse-submodules=yes
> remote: Counting objects: 3, done.
> remote: Compressing objects: 100% (2/2), done.
> remote: Total 2 (delta 1), reused 0 (delta 0)
> Unpacking objects: 100% (2/2), done.
> From /home/la/tmp/super
>    16cff18..c7c3bfc  master     -> origin/master
> la@bq:~/tmp/superc$ git co master
> Switched to branch 'master'
> Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
> la@bq:~/tmp/superc$ git fetch --recurse-submodules=yes
> Fetching submodule sub
> remote: Counting objects: 5, done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> From /home/la/tmp/super/sub
>    180c6c9..652c8b3  master     -> origin/master
> 
> So I had to checkout master in order to fetch the updates to the submodule used by master.

Yes, when you switch to a branch which hasn't got that submodule at all
that is the case (as currently the .gitmodules found in the work tree is
used to do the path -> name mapping). The culprit is the "git fetch" does
not yet examine the .gitmodules file of the commit it finds a submodule
change in, but uses the one currently found inside the work tree. But I'll
have to tackle too soon, as that also poses a problem when the submodule
was moved. So "no matter what branch they are on" is not always correct
at the moment ;-)

Again, the user experience is currently suboptimal.
