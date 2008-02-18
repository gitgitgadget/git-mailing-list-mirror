From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Mon, 18 Feb 2008 08:14:46 +0000
Message-ID: <20080218081446.GB12008@hashpling.org>
References: <20080216185349.GA29177@hashpling.org> <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de> <20080217002029.GA504@hashpling.org> <alpine.LSU.1.00.0802170045210.30505@racer.site> <20080217005620.GB504@hashpling.org> <7vbq6g758h.fsf@gitster.siamese.dyndns.org> <FBA2E61E-5CAF-49E3-A917-ACDD10586928@zib.de> <20080217214942.GJ8905@mit.edu> <7vir0nxg0c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 09:16:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR1AW-0000dE-Lo
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 09:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbYBRIPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 03:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbYBRIPd
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 03:15:33 -0500
Received: from ptb-relay01.plus.net ([212.159.14.212]:58429 "EHLO
	ptb-relay01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbYBRIPc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 03:15:32 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1JR19V-0003i7-1D; Mon, 18 Feb 2008 08:15:05 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1I8EkJf012422;
	Mon, 18 Feb 2008 08:14:46 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1I8Ek1B012421;
	Mon, 18 Feb 2008 08:14:46 GMT
Content-Disposition: inline
In-Reply-To: <7vir0nxg0c.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: b50a172760be2a39ef757964f9c860b8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74241>

On Sun, Feb 17, 2008 at 04:30:43PM -0800, Junio C Hamano wrote:
> Theodore Tso <tytso@MIT.EDU> writes:
> 
> > I have no objection to a generic mechanism, but I don't see the value
> > of Charles suggestion to rip out support for the existing tools
> > supported by git-mergetool.
> 
> I missed that suggestion but I agree removing existing support
> would not make much sense.

As I said in an earlier reply this was really more of a thought
exercise about my patch than a serious suggestion for integration.

> > I think it *would* be better to use %(foo) extrapolation that
> > environment variables, so that it's not required for users to write
> > shell scripts unless absolutely necessary.
> 
> Hmm, although I do not have strong opinions either way, I think
> the necessary interface is narrow enough that we could use
> environment variables here.  Charles's implementation does
> "eval" but it is easy to replace it to run the custom command
> after exporting the necessary variables, isn't it?

Do you mean instead of:

( eval $tool )

something like:
BASE="$BASE" LOCAL="$LOCAL" REMOTE="$REMOTE" MERGED="$MERGED" $tool

In this case we can skip the whole s/path/MERGED/ patch as it is
unnecessary, and should we now GIT_ prefix the variables as they will
intrude on the environment of the spawned command (not just a specific
sub-shell)? 

Let me know what you think and I can integrate it into my next patch
version.

Charles.
