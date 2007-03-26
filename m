From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] contrib/workdir: add a simple script to create a working directory
Date: Mon, 26 Mar 2007 16:42:12 -0700
Message-ID: <7vtzw7tvvv.fsf@assigned-by-dhcp.cox.net>
References: <20070326232751.2647.19279.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVypO-0005VP-6A
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933805AbXCZXmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933786AbXCZXmO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:42:14 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39825 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933805AbXCZXmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 19:42:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326234212.TWYR22511.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 19:42:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fbiC1W0041kojtg0000000; Mon, 26 Mar 2007 19:42:12 -0400
In-Reply-To: <20070326232751.2647.19279.julian@quantumfyre.co.uk> (Julian
	Phillips's message of "Tue, 27 Mar 2007 00:15:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43208>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> Add a simple script to create a working directory that uses symlinks
> to point at an exisiting repository.  This allows having different
> branches in different working directories but all from the same
> repository.  A poor-man's .gitlink if you will.

I would not call it poor-man's.  It is 'without complexity' and
that is a good thing, especially when you are not doing any
submodule stuff.

> +# create the links to the original repo
> +for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache
> +do
> +	case ${x} in
> +	*/*)
> +		mkdir -p $(dirname ${new_workdir}/.git/${x});
> +		;;
> +	esac
> +	ln -s ${orig_git}/.git/${x} ${new_workdir}/.git/${x};
> +done

I think the above list "for x" is correct, but probably the code
wants to comment on why it specifically excludes logs/HEAD from
the symlinked set ;-).

> +# now setup the workdir
> +cd ${new_workdir};
> +# create a fake HEAD, to stop checkout complaining
> +echo "ref: refs/heads/master" > .git/HEAD;
> +# now checkout the branch that was asked for
> +git checkout ${branch};

If ${branch} was 'master', does this do a checkout?  I think -f
might be needed.
