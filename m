From: Brian Hetro <whee@smaertness.net>
Subject: Re: [PATCH] When nothing to git-commit, honor the git-status color
	setting.
Date: Mon, 27 Aug 2007 12:15:17 -0400
Message-ID: <20070827161517.GA25484@ruiner>
References: <20070826183526.GA16359@ruiner> <20070827082550.GC17373@coredump.intra.peff.net> <20070827094543.GA8014@ruiner> <20070827101509.GB23248@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 18:22:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPhFl-0008B9-K0
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 18:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760523AbXH0QP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 12:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761259AbXH0QP0
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 12:15:26 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:22944 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761092AbXH0QPW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 12:15:22 -0400
Received: by an-out-0708.google.com with SMTP id d31so213232and
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 09:15:21 -0700 (PDT)
Received: by 10.100.37.4 with SMTP id k4mr1819440ank.1188231320807;
        Mon, 27 Aug 2007 09:15:20 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id d35sm5067523and.2007.08.27.09.15.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Aug 2007 09:15:19 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Mon, 27 Aug 2007 12:15:18 -0400 (EDT)
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070827101509.GB23248@coredump.intra.peff.net>
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56856>

On Mon, Aug 27, 2007 at 06:15:09 -0400, Jeff King wrote:
> On Mon, Aug 27, 2007 at 05:45:43AM -0400, Brian Hetro wrote:
> 
> > I was thinking more along the lines of "use color as if you had run
> > git-status" when I decided on $use_status_color.  Perhaps there is a
> > better name.
> 
> I wonder if the implementation below is slightly more readable.

I do prefer your implementation.  There is no need to depend on
status_only here.

> I am starting a queue of such patches that I care about and will
> re-send after the release.

Please do.

> ---
> diff --git a/git-commit.sh b/git-commit.sh
> index d7e7028..96cec04 100755
> --- a/git-commit.sh
> +++ b/git-commit.sh
> @@ -13,6 +13,7 @@ git rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=t
>  case "$0" in
>  *status)
>  	status_only=t
> +	no_override_color=t
>  	;;
>  *commit)
>  	status_only=
> @@ -49,7 +50,7 @@ run_status () {
>  		export GIT_INDEX_FILE
>  	fi
>  
> -	case "$status_only" in
> +	case "$no_override_color" in
>  	t) color= ;;
>  	*) color=--nocolor ;;
>  	esac
> @@ -556,7 +557,7 @@ fi
>  if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" -a -z "$amend" ]
>  then
>  	rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
> -	run_status
> +	no_override_color=t run_status
>  	exit 1
>  fi
