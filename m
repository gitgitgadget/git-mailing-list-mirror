From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 05/12] completion: add missing global options
Date: Sun, 8 Apr 2012 11:22:41 +0100
Message-ID: <20120408102230.GA22648@river.lan>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 12:23:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGpHE-0001BH-6N
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 12:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab2DHKWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 06:22:46 -0400
Received: from honeysuckle.london.02.net ([87.194.255.144]:47023 "EHLO
	honeysuckle.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab2DHKWp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 06:22:45 -0400
Received: from river.lan (78.86.105.148) by honeysuckle.london.02.net (8.5.140)
        id 4F58EC1A00D4178A; Sun, 8 Apr 2012 11:22:42 +0100
Content-Disposition: inline
In-Reply-To: <1333854479-23260-6-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194987>

On Sun, Apr 08, 2012 at 06:07:52AM +0300, Felipe Contreras wrote:
> @@ -2621,7 +2621,10 @@ _git ()
>  		case "$i" in
>  		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
>  		--bare)      __git_dir="." ;;
> -		--version|-p|--paginate) ;;
> +		--version) ;;
> +		-p|--paginate|--no-pager) ;;
> +		--exec-path=*|--html-path|--info-path) ;;

Since exec-path's argument is optional, shouldn't this be:

  +		--exec-path*|--html-path|--info-path) ;;

> +		--work-tree=*|--namespace=*|--no-replace-objects) ;;

It would be nice to accept options with argument with and without the
equals sign, as the git command does, so both:
    git --git-dir=/foo/bar
and
    git --git-dir /foo/bar

I guess this looks like (adding in -c as well):

		--git-dir)  ((c++)) ; __git_dir="${words[c]}" ;;
                --work-tree|--namespacei|-c) ((c++)) ;;


>  		--help) command="help"; break ;;
>  		*) command="$i"; break ;;
>  		esac
> @@ -2636,10 +2639,12 @@ _git ()
>  			--git-dir=
>  			--bare
>  			--version
> -			--exec-path
> +			--exec-path=

I think this change is incorrect since giving --exec-path without an
argument is perfectly fine and has a defined meaning.

>  			--html-path
> +			--info-path
>  			--work-tree=
>  			--namespace=
> +			--no-replace-objects
>  			--help

Should "-c" be in this list as well?

>  			"
>  			;;

-- 
John
