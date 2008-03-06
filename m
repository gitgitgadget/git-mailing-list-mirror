From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] format-patch: add --reviewed-by=<ident>
Date: Thu, 6 Mar 2008 11:40:32 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061130460.15786@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200803052221.12495.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803052317350.15786@racer.site>
 <7vir00lski.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803052327570.15786@racer.site> <alpine.LSU.1.00.0803060214520.15786@racer.site> <7v8x0wh8x7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 11:41:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDXD-0006tP-BL
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215AbYCFKke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 05:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756191AbYCFKke
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:40:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:49199 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756185AbYCFKkc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 05:40:32 -0500
Received: (qmail invoked by alias); 06 Mar 2008 10:40:31 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp031) with SMTP; 06 Mar 2008 11:40:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/KoVgytN/Nthnpq04MdjMg3kQhcbE1havOsqNDs
	cxXSogOn1wlErF
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x0wh8x7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76363>

Hi,

On Wed, 5 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >  'git-format-patch' [-k] [-o <dir> | --stdout] [--thread]
> >  		   [--attach[=<boundary>] | --inline[=<boundary>]]
> > +		   [--reviewed-by=<ident>]
> >  		   [-s | --signoff] [<common diff options>]
> >  		   [-n | --numbered | -N | --no-numbered]
> >  		   [--start-number <n>] [--numbered-files]
> 
> What's the expected workflow this patch intends to help?
> 
> [...]
>
> I am trying to come up with a plausible workflow that wants to add 
> somebody else's reviewed-by.
> 
>  - You send out your patch to the list.  People give comments, you 
>    reroll, you get more comments, eventually people say "Ah, that's 
>    good, Ack."  and/or "I am not the primary person who knows this area, 
>    but I reviewed it and I know my reviewed-by would count, so here is 
>    my Ok".
> 
>  - You format-patch the final version, with Acked-by and Reviewed-by 
>    adding other people's names.
> 
> Then I think it makes sense to take names of other people if that is the
> case.

Yes, exactly.  That was the usage I had in mind.

The problem with the two others you suggested (basically that the reviewer 
herself sends out another patch series) is a little fragile, since a 
malicous reviewer could add/modify code, but for nice reviewers, it is 
better in that you know which code was reviewed.

So I'd rather have it not resent by the reviewer as a patch series, but I 
think that pulling it is fine, since it is much easier to verify (with log 
--cherry-pick) that no code was tampered with by the reviewer.

> You probably meant that that is the expected workflow, as you can give 
> more than one of these options.
> 
> But people who read the documentation should not have to guess.

Frankly, I did not make up my mind on the other workflows, I only wanted 
to make the maintainer's life (yours) easier.

I have no problem posting several revisions of this patch, or scrap it 
altogether... as somebody recently said, we even joke around here via 
patches ;-)

> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index b2b7a8d..e2ff94f 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -230,4 +230,30 @@ test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
> >  
> >  '
> >  
> > +cat > expect << EOF
> > +
> > +Reviewed-by: Ken Robinson
> > +
> > +Reviewed-by: Sergey Rachmaninov
> > +
> > +Reviewed-by: Ronny O Sullivan
> > +Reviewed-by: Mickey Mouse
> > +Reviewed-by: Mahatma Gandhi
> > +EOF
> > +
> > +test_expect_success '--reviewed-by' '
> > +
> > +	echo reviewed > foo &&
> > +	test_tick &&
> > +	git commit -m "Reviewed" -m "Reviewed-by: Ken Robinson" \
> > +		-m "Reviewed-by: Sergey Rachmaninov" \
> > +		-m "Reviewed-by: Ronny O Sullivan" foo &&
> > +	git format-patch --reviewed-by="Mickey Mouse" \
> > +		--reviewed-by="Sergey Rachmaninov" \
> > +		--reviewed-by="Mahatma Gandhi" -1 HEAD &&
> > +	sed -e "1,/^Cc: /d" -e "/^---/,\$d" < 0001-Reviewed.patch > output &&
> > +	git diff expect output
> > +
> > +'
> 
> Why not use a single -m for the first three reviewed-bys, instead of
> making them into separate paragraphs using multiple -m?

I am always unsure how to embed newlines in strings in a shell script 
(except with single-ticks), and besides, I do not like breaking the 
indentation.  But I could make it a temporary file... Hmm?

Ciao,
Dscho

