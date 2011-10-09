From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] git-difftool: allow skipping file by typing 'n' at prompt
Date: Sun, 9 Oct 2011 12:26:23 +0100
Message-ID: <20111009112623.GA30585@hashpling.org>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
 <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
 <CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
 <7vty7oblpu.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gssgpy7nF46c1roJUCN5yvQaOYfVE_-ZrvMfHGWKvk0w@mail.gmail.com>
 <20111006125658.GB18709@sita-lt.atc.tcs.com>
 <7v62k210pj.fsf@alter.siamese.dyndns.org>
 <20111006181522.GA2936@sita-lt.atc.tcs.com>
 <7vwrcgtvh4.fsf@alter.siamese.dyndns.org>
 <20111008131015.GA28213@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 13:36:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCrg0-0008G6-Pb
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 13:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab1JILgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 07:36:12 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:36861 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903Ab1JILgK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Oct 2011 07:36:10 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Oct 2011 07:36:10 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAAKEkU5UXeb0/2dsb2JhbABDqCCBBYFTAQEFOj8QCxgcEhQoIYgTtWuGYmEEjlcBikiMKQ
Received: from outmx03.plus.net ([84.93.230.244])
  by relay.ptn-ipout02.plus.net with ESMTP; 09 Oct 2011 12:26:25 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by outmx03.plus.net with esmtp (Exim) id 1RCrWS-00033s-UV; Sun, 09 Oct 2011 12:26:25 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1RCrWR-0008BF-GF; Sun, 09 Oct 2011 12:26:23 +0100
Content-Disposition: inline
In-Reply-To: <20111008131015.GA28213@sita-lt.atc.tcs.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183198>

On Sat, Oct 08, 2011 at 06:40:15PM +0530, Sitaram Chamarty wrote:
> 
>  git-difftool--helper.sh |    9 +++++----
>  t/t7800-difftool.sh     |   44 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 8452890..0468446 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -38,15 +38,16 @@ launch_merge_tool () {
>  
>  	# $LOCAL and $REMOTE are temporary files so prompt
>  	# the user with the real $MERGED name before launching $merge_tool.
> +	ans=y
>  	if should_prompt
>  	then
>  		printf "\nViewing: '$MERGED'\n"
>  		if use_ext_cmd
>  		then
> -			printf "Hit return to launch '%s': " \
> +			printf "Launch '%s' [Y/n]: " \
>  				"$GIT_DIFFTOOL_EXTCMD"
>  		else
> -			printf "Hit return to launch '%s': " "$merge_tool"
> +			printf "Launch '%s' [Y/n]: " "$merge_tool"
>  		fi
>  		read ans
>  	fi
> @@ -54,9 +55,9 @@ launch_merge_tool () {
>  	if use_ext_cmd
>  	then
>  		export BASE
> -		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
> +		test "$ans" != "n" && eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
>  	else
> -		run_merge_tool "$merge_tool"
> +		test "$ans" != "n" && run_merge_tool "$merge_tool"
>  	fi
>  }

It's a minor point but for me, this looks a little more difficult to
follow than it needs to be.

Why do we need to hold on to 'ans' for so long? With the new prompt,
if we ever 'read ans' we always want to return from the
launch_merge_tool without doing anything else if we read "n". I think
it's easier to follow if we just change 'read ans' and leave the 'if
use_ext_cmd' clauses alone. Perhaps some people don't like the early
return, though?

Charles.


E.g. (for discussion, untested):

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 8452890..b668a12 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -43,12 +43,16 @@ launch_merge_tool () {
                printf "\nViewing: '$MERGED'\n"
                if use_ext_cmd
                then
-                       printf "Hit return to launch '%s': " \
+                       printf "Launch '%s' [Y/n]: " \
                                "$GIT_DIFFTOOL_EXTCMD"
                else
-                       printf "Hit return to launch '%s': " "$merge_tool"
+                       printf "Launch '%s' [Y/n]: " "$merge_tool"
+               fi
+
+               if read ans && test "$ans" = "n"
+               then
+                       return
                fi
-               read ans
        fi

        if use_ext_cmd
