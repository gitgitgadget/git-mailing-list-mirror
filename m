From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: git-1.7.3 breakage: "git stash show xxx" doesn't show anything
Date: Fri, 24 Sep 2010 15:01:31 -0500
Message-ID: <iET3wn06TheqzndLNXxSuZJHDP5RwU5NWenjr2MQJI96tqWxE3MYjw@cipher.nrlssc.navy.mil>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, jon.seymour@gmail.com
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 22:02:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzETY-0003KS-JX
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757787Ab0IXUBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 16:01:49 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59908 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257Ab0IXUBr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 16:01:47 -0400
Received: by mail.nrlssc.navy.mil id o8OK1Vof015494; Fri, 24 Sep 2010 15:01:31 -0500
In-Reply-To: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
X-OriginalArrivalTime: 24 Sep 2010 20:01:31.0776 (UTC) FILETIME=[485B8800:01CB5C23]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157050>

On 09/24/2010 02:19 PM, Robin H. Johnson wrote:
> Downstream bug: http://bugs.gentoo.org/338586
> 
> telling git-stash to show a specific stash no longer works with git-1.7.3:
>   git stash show stash@{0}
>   <no output!?>
> 
> Downgrading to dev-vcs/git-1.7.2.3 and it works fine.
> Noticed on two stable amd64 systems.
> 
> Reproduction:
> $ rm -rf foo && mkdir foo && cd foo
> $ git init
> Initialized empty Git repository in /home/vapier/foo/.git/
> $ echo f > f && git add f && git commit -qmm
> $ > f
> $ git stash
> Saved working directory and index state WIP on master: d287dea m
> HEAD is now at d287dea m
> $ git stash list | cat
> stash@{0}: WIP on master: d287dea m
> $ git stash show | cat
>  f |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> $ git stash show stash@{0} | cat
> <nothing!>
>

Probably,

diff --git a/git-stash.sh b/git-stash.sh
index 7ce818b..4fbfb62 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -265,7 +265,7 @@ parse_flags_and_rev()
        i_tree=
 
        REV=$(git rev-parse --no-flags --symbolic "$@" 2>/dev/null)
-       FLAGS=$(git rev-parse --no-revs -- "$@" 2>/dev/null)
+       FLAGS=$(git rev-parse --no-revs --flags "$@" 2>/dev/null)
 
        set -- $FLAGS
 
