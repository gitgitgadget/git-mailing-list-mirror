From: Michael Smith <msmith@cbnco.com>
Subject: Re: [PATCH] git-submodule - allow a relative path as the subproject url
Date: Mon, 24 Sep 2007 00:21:24 +0000 (UTC)
Message-ID: <loom.20070924T002011-331@post.gmane.org>
References: <11904936042891-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 02:40:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZbzt-0006Vh-Nu
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 02:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbXIXAkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 20:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbXIXAkQ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 20:40:16 -0400
Received: from main.gmane.org ([80.91.229.2]:46233 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997AbXIXAkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 20:40:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IZbug-0005ir-As
	for git@vger.kernel.org; Mon, 24 Sep 2007 00:35:02 +0000
Received: from CPE00045a927e3e-CM001225463986.cpe.net.cable.rogers.com ([74.122.211.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 00:35:02 +0000
Received: from msmith by CPE00045a927e3e-CM001225463986.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 00:35:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 74.122.211.221 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20070801 BonEcho/2.0.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59011>

Mark Levedahl <mdl123 <at> verizon.net> writes:

> This allows a subproject's location to be specified and stored as relative
> to the parent project's location (e.g., ./foo, or ../foo). This url is
> stored in .gitmodules as given. 

> This allows cloning of the project to work "as expected" if the project
> is hosted on a different server than when the subprojects were added.

Hi Mark,

I have a use case where this would be very handy -- two teams geographically
separated. But in the end I think I disagree with it: it's not up to me, as the
person creating a superproject, to decide that anyone who forks or clones it
also has to clone all the submodules.

Instead they can decide themselves by editing .git/config between "git submodule
init" and "git submodule update", or by branching .gitmodules.

By the way:

> +# Get parent project's url
> +get_parent_url ()
> +{
> +	# need to append this on parent project's url
> +	branch="$(git branch --no-color | sed -ne 's/^\* //p')"
> +	test -n "$branch" || die "I do not know what branch you are on: $branch"
> +	upstream="$(git config branch.$branch.remote)"
> +	test -n "$upstream" || die "Cannot find upstream repo for branch $branch"
> +	uprepo="$(git config remote.$upstream.url)"
> +	test -n "$upstream" || die "Cannot find url for repo $uprepo"
> +	echo "$uprepo"
> +}
...
> +	case $repo in
> +	.*)
> +		realrepo="$(get_parent_url)/$repo" ;;

If you source git-parse-remote, you can use

                realrepo="$(get_remote_url "$(get_default_remote)")$repo"

Mike
