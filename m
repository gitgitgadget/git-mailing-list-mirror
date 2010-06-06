From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash completion: Support "unpushed commits" warnings in __git_ps1
Date: Sun, 6 Jun 2010 20:14:59 +0200
Message-ID: <201006062014.59386.trast@student.ethz.ch>
References: <4C0AE640.3040503@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sun Jun 06 20:15:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLKNW-0004vz-Nm
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 20:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab0FFSPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 14:15:05 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:28893 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab0FFSPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 14:15:04 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 6 Jun
 2010 20:15:01 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 6 Jun
 2010 20:14:59 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <4C0AE640.3040503@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148533>

Andrew Sayers wrote:
> People working in small teams sometimes forget to push their changes, causing
> general confusion.  A gentle reminder in the command prompt should help.

I think this is a good idea but...

> +#       If you would like to see if there're unpushed commits, then
> +#       you can set GIT_PS1_SHOWUNPUSHED to a nonempty value. If
> +#       there're unpushed commits, then a '!' will be shown next to
> +#       the branch name.  Setting GIT_PS1_SHOWUNPUSHED=svn will look
> +#       for unpushed git-svn commits.

At least the svn/git setting should definitely be configurable through
git-config, so that it becomes per-repo configurable.  Also, you could
try to trigger the svn mode by default if a svn-remote.svn.url exists.

> +			      upstream=$( git log | sed -ne "/^    git-svn-id: / { s/^    git-svn-id: $remote_branch\/\([^@]*\).*/\1/p ; q }" )

How about starting with

  git log -1 --first-parent --grep="^git-svn-id: $remote_branch"

which should be faster and is also closer to the truth.  It still
doesn't work if the repo was cloned with --no-metadata.  Doing it
right probably would require a new informational command in git-svn
that reports the branch name.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
