From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] bash completion: complete refs for git-grep
Date: Wed, 7 Oct 2009 17:27:49 +0200
Message-ID: <200910071727.50770.trast@student.ethz.ch>
References: <14ac499280c9b17f862ab13201b48c64b4827713.1254823328.git.trast@student.ethz.ch> <20091006154555.GN9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 07 17:35:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvYY2-00022w-Ve
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 17:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbZJGPaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 11:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbZJGPaE
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 11:30:04 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:15698 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932361AbZJGPaD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 11:30:03 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 7 Oct
 2009 17:29:14 +0200
Received: from thomas.localnet (129.132.210.172) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 7 Oct
 2009 17:29:29 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091006154555.GN9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129647>

Shawn O. Pearce wrote:
> 
> Thomas Rast <trast@student.ethz.ch> wrote:
> > +	local i c=1 have_regex=""
> > +	while [ $c -lt $COMP_CWORD ]; do
> > +		i="${COMP_WORDS[c]}"
> > +		case "$i" in
> > +		-e) ;;
> > +		-e*) have_regex="$c" ; break ;;
> > +		-*) ;;
> > +		*) have_regex="$c"; break ;;
> > +		esac
> > +		c=$((++c))
> > +	done
> 
> What happens with `git grep -e a -e b`?  Do we trigger into ref
> completion too early when we should still be doing the regex
> completion?

Hmm, true, I would also have to check for the last argument (before
completion) being -e.

However, that is kind of moot because we currently complete filenames
anyway, and you said I can't stop that:

> > This is still RFC because, as you can see in the code below, I tried
> > to avoid completing at all while the user still needs to supply a
> > regex.  Sadly, bash turns the COMPREPLY=() into filename completion
> > anyway.  Is there a way to prevent this?
> 
> Not that I know of.  You can turn off default filename completion
> when you register the completion function, but that then breaks
> like every other git command for completion support because a lot
> of them do want to complete filenames.

So I'll roll a simpler patch that just always (before --) completes
refs instead, if that's ok.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
