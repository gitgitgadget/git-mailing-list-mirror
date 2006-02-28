From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git pull cannot find remote refs.
Date: Mon, 27 Feb 2006 17:13:22 -0800
Message-ID: <7vlkvwuvyl.fsf@assigned-by-dhcp.cox.net>
References: <20060227214936.GA7205@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 02:13:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDtQn-0006k0-Un
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 02:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWB1BN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 20:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWB1BN0
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 20:13:26 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:28414 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751875AbWB1BNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 20:13:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228011026.DBHZ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Feb 2006 20:10:26 -0500
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16903>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

> Tracking it down, I found a gap between how git-ls-remote prints out the tags
> and git-fetch scans them with sed. Looking at the code of git-ls-remote the
> there is an tab character between the sha1 and the refname, while there is a
> space and a tab character in the regular expression for th sed command.
>
> As a result the while where all is piped in cannot read the two values.

Sorry.

I do not understand the above comment, nor the following code.

>  		git-ls-remote $upload_pack --tags "$remote" |
> -		sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
> +		sed -ne 's|^\([0-9a-f]*\)[\t]\(refs/tags/.*\)^{}$|\1 \2|p' |

ls-remote shows "SHA1\tPATH".  The original says "hexadecimal
followed by [either a single space or a single tab] followed by
a refpath", while yours says "hexadecimal followed by a single tab
followed by a refpath".  I do not see how that would make any
difference.  Puzzled...

I've seen two servers DNS round-robin and one of them fail to
respond.  The first "fetch" goes to the good one and the second
ls-remote goes to the bad one, then you would see "Oops, we
cannot peek tags".  But this patch does not have anything to do
with that problem..
