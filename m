From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/2] Teach git-blame --gui how to start git-gui blame
Date: Wed, 20 Jun 2007 23:19:03 -0700
Message-ID: <7vtzt13k4o.fsf@assigned-by-dhcp.pobox.com>
References: <20070621045333.GB13977@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 08:19:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1G0i-0006A9-PG
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 08:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbXFUGTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 02:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbXFUGTG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 02:19:06 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49419 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbXFUGTF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 02:19:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621061904.URMK2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 02:19:04 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E6K41X0031kojtg0000000; Thu, 21 Jun 2007 02:19:04 -0400
In-Reply-To: <20070621045333.GB13977@spearce.org> (Shawn O. Pearce's message
	of "Thu, 21 Jun 2007 00:53:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50598>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> To keep things really simple in git-blame we require that the new
> --gui option be the first argument on the command line, and cannot
> be combined with any other option.  If it is the first argument
> then we punt our entire command line as-is into `git gui blame`,
> where that program's option parser will handle selecting out the
> revision and path, if present.
>
>  Its simple and not very intrusive, but has the odd behavior that
>  no option (like --contents) can be used along with it, because
>  git-gui's own blame subcommand doesn't recognize them.  On the
>  other hand it is a useful DWIMery for `git gui blame`.

Hmm.  Now, how does "git-blame" tell if there is usable git-gui
installed with it?  Will we have "git-gui --list-features"?

In either case, I think this description is far less than optimum:

> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index 66f1203..96ff02d 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  [verse]
>  'git-blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [--incremental] [-L n,m]
>              [-S <revs-file>] [-M] [-C] [-C] [--since=<date>]
> +            [--gui]
>              [<rev> | --contents <file>] [--] <file>


It essentially is two commands with different calling
conventions.  I would probably do this instead if I were doing
this:

SYNOPSIS
--------
[verse]
'git-blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [--incremental] [-L n,m]
            [-S <revs-file>] [-M] [-C] [-C] [--since=<date>]
            [<rev> | --contents <file>] [--] <file>
'git-blame' --gui [<rev>] [--] <file>
