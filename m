From: Johan Herland <johan@herland.net>
Subject: Re: What should "git submodule summary" give before an initial commit?
Date: Thu, 04 Mar 2010 00:10:18 +0100
Message-ID: <201003040010.19061.johan@herland.net>
References: <4B8E5450.3040702@gmail.com>
 <7vzl2phz8e.fsf@alter.siamese.dyndns.org>
 <7vhboxf4nx.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Ping Yin <pkufranky@gmail.com>, Jeff King <peff@peff.net>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 00:10:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmxi0-0004yj-Lw
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 00:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab0CCXKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 18:10:23 -0500
Received: from smtp.getmail.no ([84.208.15.66]:64980 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191Ab0CCXKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 18:10:22 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYQ00G79B182Q90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 04 Mar 2010 00:10:20 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYQ007NJB177W00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 04 Mar 2010 00:10:20 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.3.225724
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <7vhboxf4nx.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141489>

On Wednesday 03 March 2010, Junio C Hamano wrote:
> "git status" collects the changes for both the index (since HEAD) and the
> working tree files (since the index), summarizes and shows them.  When it
> is run before the first commit is made, it uses a logic different from
> the one used in the normal case to gather the information on the index,
> as we don't have HEAD yet, i.e. instead of "diff-index HEAD", we would
> run "diff-index emtpy-tree".
> 
> How should status.submodulesummary integrate into this framework?
> 
> Currently, it blindly runs "git submodule summary", and it gives an extra
> error message about HEAD not being a commit, and people (me included)
> misguidedly have spent time on squelching the message.
> 
> But I think that was _all wrong_.  I do not think "git submodule summary"
> should fail even when you haven't made your first commit.
> 
> If you are before the first commit, we say everything you have in the
> index is a change you are adding with your next commit (which will be
> your initial one).  If you added a submodule commit to the index,
> shouldn't "git submodule summary" say "you'll be committing the addition
> of this subproject"?  IOW, shouldn't we be comparing an empty tree to
> find added submodules, like this, when we haven't made the first commit?
> 
>  git-submodule.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5869c00..0397f9d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -556,10 +556,10 @@ cmd_summary() {
>  	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
>  	then
>  		head=$rev
> -		shift
> +		test $# = 0 || shift
>  	elif test -z "$1" -o "$1" = "HEAD"
>  	then
> -		return
> +		head=4b825dc642cb6eb9a060e54bf8d69288fbee4904
>  	else
>  		head="HEAD"
>  	fi

Acked-by: Johan Herland <johan@herland.net>

If you're planning to revert 3deea89 (although the above patch suggests 
you're not), then please don't revert the t7401 testcases added by that 
commit. The testcase is useful in any case.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
