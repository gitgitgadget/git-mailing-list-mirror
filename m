From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Sat, 29 Dec 2007 14:31:14 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712291426500.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca> <8763yof9lg.fsf@gollum.intra.norang.ca>
 <Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <20071225044202.GO14735@spearce.org> <7v4pe5nt8m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 14:31:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8bn0-0002oe-2l
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 14:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbXL2NbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 08:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbXL2NbR
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 08:31:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:43650 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753341AbXL2NbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 08:31:16 -0500
Received: (qmail invoked by alias); 29 Dec 2007 13:31:15 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp028) with SMTP; 29 Dec 2007 14:31:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oUjVqnrCoug+H991MakoRArgi96M2Igqqo6Jdk5
	FVleOfn4uDCy4k
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v4pe5nt8m.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69314>

Hi,

On Wed, 26 Dec 2007, Junio C Hamano wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 090c3e5..d0d83c3 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -215,15 +215,17 @@ make_squash_message () {
>  		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
>  			< "$SQUASH_MSG" | tail -n 1)+1))
>  		echo "# This is a combination of $COUNT commits."
> -		sed -n "2,\$p" < "$SQUASH_MSG"
> +		sed -e 1d -e '2,/^./{
> +			/^$/d
> +		}' <"$SQUASH_MSG"

If I read this correctly (haven't tested), then _all_ empty lines are 
removed from the SQUASH_MSG, right?  This is not what I want.

I had something like this in mind, rather:

		-e '\$s/\n*$/\n/'

This is completely untested, but should show the idea.  However, the same 
must go into this clause:

>  	else
>  		COUNT=2
>  		echo "# This is a combination of two commits."
>  		echo "# The first commit's message is:"
>  		echo
>  		git cat-file commit HEAD | sed -e '1,/^$/d'

Unfortunately, I am unable to provide a proper patch with proper testing 
right now, since my family threatens me with physical violence, should I 
not leave the keyboard right n.. OUCH!
