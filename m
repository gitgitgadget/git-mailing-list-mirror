From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] add -p: do not attempt to coalesce mode changes
Date: Sat, 15 Aug 2009 16:35:23 +0200
Message-ID: <200908151635.24341.trast@student.ethz.ch>
References: <1250339209-27962-1-git-send-email-kirr@mns.spb.ru> <770693df8f416615f57423141fb59f3d6eccc915.1250344341.git.trast@student.ethz.ch> <20090815141710.GA15978@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <gitster@pobox.com>, Kirill Smelkov <kirr@mns.spb.ru>,
	<git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 16:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McKMb-0001CX-LS
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 16:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbZHOOgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 10:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbZHOOgA
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 10:36:00 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:1391 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbZHOOgA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 10:36:00 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 15 Aug
 2009 16:36:00 +0200
Received: from thomas.localnet (77.56.221.170) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 15 Aug
 2009 16:35:38 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090815141710.GA15978@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126008>

Jeff King wrote:
> 
> > --- a/git-add--interactive.perl
> > +++ b/git-add--interactive.perl
> > @@ -841,6 +841,10 @@
> >  	my ($last_o_ctx, $last_was_dirty);
> >  
> >  	for (grep { $_->{USE} } @in) {
> > +		if ($_->{TYPE} ne 'hunk') {
> > +			push @out, $_;
> > +			next;
> > +		}
> >  		my $text = $_->{TEXT};
> >  		my ($o_ofs) = parse_hunk_header($text->[0]);
> >  		if (defined $last_o_ctx &&
> 
> Hmm. I am not too familiar with the coalesce_overlapping_hunks code, but
> it looks like we peek at $out[-1] based on $last_o_ctx, assuming that
> $last_o_ctx comes from the last hunk pushed (either because we just
> pushed it, or we merged into it).  So a non-hunk in the middle of some
> coalescing hunks is going to violate that assumption.
> 
> As it is now, I think we always put the 'mode' hunk at the very
> beginning, so that shouldn't happen (and IIRC, that order is preserved
> throughout). So maybe it is not worth worrying about. But an alternate
> patch is below.

Hmm.  I briefly considered worrying about futureproofing, but then
decided it wasn't worth it since we also rely on
coalesce_overlapping_hunks only being run over the hunks of a single
file.  But since you already went to the lengths of doing it, feel
free to take the explanation in my commit message and add my Acked-by
:-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
