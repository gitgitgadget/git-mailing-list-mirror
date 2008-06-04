From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: log --graph --first-parent weirdness
Date: Wed, 4 Jun 2008 11:04:33 -0700
Message-ID: <20080604180432.GA31437@adamsimpkins.net>
References: <20080604150042.GA3038@mithlond.arda.local> <7vmym1xgy4.fsf@gitster.siamese.dyndns.org> <20080604173820.GA3038@mithlond.arda.local>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3xMr-0005sd-7L
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 20:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbYFDSEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 14:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbYFDSEp
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 14:04:45 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:38206 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbYFDSEo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 14:04:44 -0400
Received: from relay3.r3.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay3.r3.iad.emailsrvr.com (SMTP Server) with ESMTP id 258A944C3A9;
	Wed,  4 Jun 2008 14:04:40 -0400 (EDT)
Received: by relay3.r3.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 1B05C44C3B4;
	Wed,  4 Jun 2008 14:04:38 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id B940514100CC; Wed,  4 Jun 2008 11:04:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080604173820.GA3038@mithlond.arda.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83803>

On Wed, Jun 04, 2008 at 08:38:20PM +0300, Teemu Likonen wrote:
> Junio C Hamano wrote (2008-06-04 10:12 -0700):
> 
> > Teemu Likonen <tlikonen@iki.fi> writes:
> > 
> > > The output of "git log --graph --first-parent" seems weird.
> 
> <snip>
> 
> > We could turn --graph automatically off if --first-parent is given,
> > but I tend to agree with you that the right behaviour is to show the
> > same "everything prefixed with '| ', wasting two columns without good
> > reason" output as you would see on a true linear history.
> 
> To me it's perfectly fine to turn off --graph when used with
> --first-parent, but yes, generally users might expect to see a line of
> M's, *'s and |'s there. At least it would clearly show which commits are
> merges and which are not.

It should be pretty simple to fix this as suggested.  There are two
places in graph.c where we loop over the current commit's parents.
Changing those to break out after the first commit when
revs->first_parent_only is set should result in the desired behavior.

I'll try to get some time this evening or tomorrow to create a patch.

-- 
Adam Simpkins
adam@adamsimpkins.net
