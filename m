From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Wed, 21 Jan 2009 17:04:34 +0000
Message-ID: <20090121170434.GA21727@hashpling.org>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 18:16:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPggP-0005YF-Gm
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 18:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbZAUROl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 12:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZAUROl
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 12:14:41 -0500
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:43516 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752226AbZAUROk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 12:14:40 -0500
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jan 2009 12:14:39 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAJbhdknUnw4U/2dsb2JhbADNcIVz
Received: from pih-relay08.plus.net ([212.159.14.20])
  by relay.pcl-ipout01.plus.net with ESMTP; 21 Jan 2009 17:04:35 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1LPgVH-0003Pn-D4; Wed, 21 Jan 2009 17:04:35 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0LH4ZUJ023427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Jan 2009 17:04:35 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0LH4YMn023426;
	Wed, 21 Jan 2009 17:04:34 GMT
Content-Disposition: inline
In-Reply-To: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 0b8331e7f5a3aa140d4706c426a6c7d8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106630>

On Wed, Jan 21, 2009 at 09:37:20AM -0500, Caleb Cushing wrote:
> ---
>  git-mergetool.sh |   24 ++++++++++++++++++++----
>  1 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 00e1337..43d2a9e 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -177,11 +177,27 @@ merge_file () {
>      describe_file "$local_mode" "local" "$LOCAL"
>      describe_file "$remote_mode" "remote" "$REMOTE"
>      if "$prompt" = true; then
> -       printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
> -       read ans
> -    fi
> +               while true; do
> +               printf "Use (m)erge file or (s)skip file, or (a)bort? (%s): " \
> +               "$merge_tool"
> +               read ans
> +               case "$ans" in
> +                       [mM]*)
> +                       break
> +                       ;;
> +                       [sS]*)
> +                       cleanup_temp_files
> +                       return 0
> +                       ;;
> +                       [aA]*)
> +                       cleanup_temp_files
> +                       exit 0
> +                       ;;
> +               esac
> +               done
> +       fi

This looks to me like no merge will happen if --no-prompt/-y or
mergetool.prompt is set to false. Have you tested with this option or
have I misread?

Also, I think you've lost some tabs. Mergetool does have some
inconsistent tabbing but they way I've been aiming towards (which
matches most, but not all of git-mergetool.sh) is to use tabs == 8
spaces for indents but to indent each level by 4 spaces. e.g. three
levels of indent is one tab plus four spaces.

It might be quite nice to offer the option of directly using an 'ours'
or 'theirs' as an alternative to skip for binary files. A bit like
symlinks are handled in mergetool.

Charles.
