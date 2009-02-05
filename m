From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Print revision while searching for earliest
	use of path
Date: Wed, 4 Feb 2009 22:42:40 -0800
Message-ID: <20090205064240.GA22926@dcvr.yhbt.net>
References: <1233810570-30765-1-git-send-email-deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu Feb 05 07:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUxy7-0007sW-HV
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 07:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbZBEGmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 01:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbZBEGmo
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 01:42:44 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48401 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbZBEGmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 01:42:42 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7364F1F449;
	Thu,  5 Feb 2009 06:42:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233810570-30765-1-git-send-email-deskinm@umich.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108504>

Deskin Miller <deskinm@umich.edu> wrote:
> When initializing a git-svn repository from a Subversion repository, it
> is common to be interested in a path which did not exist in the initial
> commit to Subversion.  In a large repository like e.g. Apache, this may
> take some time while the user receives no additional feedback.  Print
> the highest revision number scanned thus far to let the user know
> something is still happening.
> 
> Signed-off-by: Deskin Miller <deskinm@umich.edu>
> ---
> This came about on account of patmaddox asking on #git why git-svn
> seemed to be hung on clone.  Despite the admonition that this might take
> a long time, I also like to have some indication that progress is being
> made.  My first version of this printed using '\rChecked through
> r$revision' but the subsequent output line when the path is found ends
> up clobbered on the same line, and I'm not skilled enough at the
> terminal or Perl to address this cleanly.  If the current version is
> felt to be too verbose since it is printing a new line, I'd be up for
> squelching the output to e.g. every 1000 revisions or so.

This is definitely useful on slow/large repositories.  The current
output with newlines is fine by me.

> Anecdotally, it looks like Subversion looks for the path in blocks of
> 100 revisions, so we get the nice whole revision number for free.  I
> couldn't find any documentation on the proper format of the error
> message, so I just came up with the regular expressions to parse the
> revision myself; if they need to be more explicit to avoid really
> egregious path names, I can make an effort.
> 
> I tested on both http:// and file:// transport, to come up with the
> different error strings; since the error number for file is the same as
> svn:// I'm hoping that the error string is the same too.  If someone can
> bounce this off a svn:// repo I'd appreciate it, otherwise I'll dig out
> the documentation and set up a network-served svn repository myself
> (which is really my job as the patch author anyway).

Couldn't we avoid the trouble of parsing the inconsistent error
messages by printing this status message after the get_log() calls
in gs_fetch_loop_common() ?

-- 
Eric Wong
