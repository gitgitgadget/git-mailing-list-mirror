From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH] bash completion: complete refs for git-grep
Date: Tue, 6 Oct 2009 08:45:55 -0700
Message-ID: <20091006154555.GN9261@spearce.org>
References: <14ac499280c9b17f862ab13201b48c64b4827713.1254823328.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 06 17:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvCJv-0008GY-Tn
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 17:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758055AbZJFPqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758051AbZJFPqc
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 11:46:32 -0400
Received: from george.spearce.org ([209.20.77.23]:49012 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbZJFPqb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 11:46:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 74D6B381FE; Tue,  6 Oct 2009 15:45:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <14ac499280c9b17f862ab13201b48c64b4827713.1254823328.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129630>

Thomas Rast <trast@student.ethz.ch> wrote:
> This is still RFC because, as you can see in the code below, I tried
> to avoid completing at all while the user still needs to supply a
> regex.  Sadly, bash turns the COMPREPLY=() into filename completion
> anyway.  Is there a way to prevent this?

Not that I know of.  You can turn off default filename completion
when you register the completion function, but that then breaks
like every other git command for completion support because a lot
of them do want to complete filenames.

> +	local i c=1 have_regex=""
> +	while [ $c -lt $COMP_CWORD ]; do
> +		i="${COMP_WORDS[c]}"
> +		case "$i" in
> +		-e) ;;
> +		-e*) have_regex="$c" ; break ;;
> +		-*) ;;
> +		*) have_regex="$c"; break ;;
> +		esac
> +		c=$((++c))
> +	done

What happens with `git grep -e a -e b`?  Do we trigger into ref
completion too early when we should still be doing the regex
completion?

-- 
Shawn.
