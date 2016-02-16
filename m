From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Subject: Re: [PULL] svn pathnameencoding for git svn dcommit
Date: Tue, 16 Feb 2016 12:29:45 +0900
Message-ID: <56C297A9.2080705@f2.dion.ne.jp>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
 <20160208225806.GA3487@dcvr.yhbt.net> <20160215005210.GA31141@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, alex.crezoff@gmail.com
To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 04:31:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVWMD-0005zZ-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 04:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbcBPDbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 22:31:18 -0500
Received: from mail-ae2-f139.auone-net.jp ([111.87.219.139]:52938 "EHLO
	dmta02.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752759AbcBPDbR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 22:31:17 -0500
Received: from amlmta053.auone-net.jp (amlmta053-MM [10.188.23.128])
	by dmta02.auone-net.jp (au one net mail) with ESMTP id 059EE400676
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 12:31:15 +0900 (JST)
Received: from [0.0.0.0] ([80.255.3.122])
	by amlmta053.auone-net.jp id 56c297fd00034b7b000033a40000775e3000098deda2;
	Tue, 16 Feb 2016 12:31:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160215005210.GA31141@dcvr.yhbt.net>
X-MXM-DELIVERY-TYPE: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286312>

On 2016/02/15 9:52 +0900, Eric Wong wrote:
> I've amended tests to both commits, but the URL encoding one
> requires an HTTP server to test effectively.

Thank you for the tests. But, on my environment, both of them failed
unexpectedly. (Windows 7 SP1, x86_64 Cygwin, LANG=ja_JP.UTF-8)

For now, I don't have enough time to investigate this further. Let me
just share the result.

> $ ./t9115-git-svn-dcommit-funky-renames.sh -x --run='11-12'
(snip)
> expecting success:
>         neq=$(printf "\201\202") &&
>         git config svn.pathnameencoding cp932 &&
>         echo neq >"$neq" &&
>         git add "$neq" &&
>         git commit -m "neq" &&
>         git svn dcommit
>
> +++ printf '\201\202'
> ++ neq=$'\201\202'
> ++ git config svn.pathnameencoding cp932
> ++ echo neq
> ++ git add $'\201\202'
> ++ git commit -m neq
> On branch master
>
> Initial commit
>
> Untracked files:
>         svnrepo/
>         "\357\202\201\357\202\202"
>
> nothing added to commit but untracked files present
> error: last command exited with $?=1
> not ok 11 - svn.pathnameencoding=cp932 new file on dcommit
> #
> #               neq=$(printf "\201\202") &&
> #               git config svn.pathnameencoding cp932 &&
> #               echo neq >"$neq" &&
> #               git add "$neq" &&
> #               git commit -m "neq" &&
> #               git svn dcommit
> #
>
> expecting success:
>         inf=$(printf "\201\207") &&
>         git config svn.pathnameencoding cp932 &&
>         echo inf >"$inf" &&
>         git add "$inf" &&
>         git commit -m "inf" &&
>         git svn dcommit &&
>         git mv "$inf" inf &&
>         git commit -m "inf rename" &&
>         git svn dcommit
>
> +++ printf '\201\207'
> ++ inf=$'\201\207'
> ++ git config svn.pathnameencoding cp932
> ++ echo inf
> ++ git add $'\201\207'
> ++ git commit -m inf
> On branch master
>
> Initial commit
>
> Untracked files:
>         svnrepo/
>         "\357\202\201\357\202\202"
>         "\357\202\201\357\202\207"
>
> nothing added to commit but untracked files present
> error: last command exited with $?=1
> not ok 12 - svn.pathnameencoding=cp932 rename on dcommit
> #
> #               inf=$(printf "\201\207") &&
> #               git config svn.pathnameencoding cp932 &&
> #               echo inf >"$inf" &&
> #               git add "$inf" &&
> #               git commit -m "inf" &&
> #               git svn dcommit &&
> #               git mv "$inf" inf &&
> #               git commit -m "inf rename" &&
> #               git svn dcommit
> #

Strangely, after the test failure, "git status" in the trash directory
reports different status.
> $ cd 'trash directory.t9115-git-svn-dcommit-funky-renames'
> $ git status
> On branch master
>
> Initial commit
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         svnrepo/
>         "\201\202"
>         "\201\207"
>
> nothing added to commit but untracked files present (use "git add" to track)

I can manually add and commit them.
> $ neq=$(printf "\201\202")
> $ git add "$neq"
> $ git commit -m "neq"
> [master (root-commit) 3fd464f] neq
>  1 file changed, 1 insertion(+)
>  create mode 100644 "\201\202"

I can't see how "\357\202\201\357\202\202" came as output in the test.

-- 
k_satoda
