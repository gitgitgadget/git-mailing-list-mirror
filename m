From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] handle empty notes gracefully
Date: Fri, 6 Feb 2009 16:38:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902061636320.7377@intel-tinevez-2-302>
References: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net> <1233933543-28407-2-git-send-email-git@drmicha.warpmail.net> <1233933543-28407-3-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 16:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSnx-0000ms-3A
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbZBFPiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbZBFPiR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:38:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:60903 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752051AbZBFPiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:38:17 -0500
Received: (qmail invoked by alias); 06 Feb 2009 15:38:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp051) with SMTP; 06 Feb 2009 16:38:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0Aztu/US0X8gWwLlGhVfXMoJzXZt9qU1dUUxZvL
	sOqN4lGPTznJOF
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1233933543-28407-3-git-send-email-git@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108738>

Hi,

On Fri, 6 Feb 2009, Michael J Gruber wrote:

> Currently, git-notes barfs when asked to show an empty (i.e.
> non-existing) note. Change this to explicitely say there is none.
> ---
>  git-notes.sh     |    2 ++
>  t/t3301-notes.sh |    2 +-
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/git-notes.sh b/git-notes.sh
> index bfdbaa8..9cbad02 100755
> --- a/git-notes.sh
> +++ b/git-notes.sh
> @@ -58,6 +58,8 @@ edit)
>  		"$GIT_NOTES_REF" $NEW_HEAD $CURRENT_HEAD
>  ;;
>  show)
> +	git rev-parse -q --verify "$GIT_NOTES_REF":$COMMIT > /dev/null ||
> +		die "No note for commit $COMMIT."

This looks good.

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 4900dca..81d5028 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -36,7 +36,7 @@ test_expect_success 'need valid notes ref' '
>  '
>  
>  # 1 indicates caught gracefully by die, 128 means git-show barfed
> -test_expect_failure 'handle empty notes gracefully' '
> +test_expect_success 'handle empty notes gracefully' '
>  	git notes show || test 1 = $?

Completely forgot to mention that I think you want to use test_must_fail 
here.  And maybe you want to be more explicit, by specifying which 
commit's notes are expected not to be there.

We would not want the test to succeed for all the wrong reasons, would we?

Ciao,
Dscho
