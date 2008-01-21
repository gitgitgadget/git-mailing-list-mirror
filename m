From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Mon, 21 Jan 2008 19:26:48 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801211925580.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org> <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org>
 <7vtzl71x1c.fsf@gitster.siamese.dyndns.org> <7vprvv1wnu.fsf@gitster.siamese.dyndns.org> <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org> <7vhch71vvb.fsf@gitster.siamese.dyndns.org> <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211120350.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:27:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH2Ij-0008Qc-HZ
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbYAUT0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbYAUT0w
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:26:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:46270 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751558AbYAUT0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 14:26:51 -0500
Received: (qmail invoked by alias); 21 Jan 2008 19:26:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 21 Jan 2008 20:26:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bV7w77BibS5DmBfdlB3HHsw/6aB1+nX+SFiMfLq
	qdQs78aBIGuFtH
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801211120350.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71315>

Hi,

On Mon, 21 Jan 2008, Linus Torvalds wrote:

> diff --git a/read-cache.c b/read-cache.c
> index f5f9c3d..58a9b95 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -124,6 +124,9 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>  {
>  	unsigned int changed = 0;
>  
> +	if (ce->ce_flags & CE_REMOVE)
> +		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
> +
>  	switch (ce->ce_mode & S_IFMT) {
>  	case S_IFREG:
>  		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
> @@ -145,8 +149,6 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>  		else if (ce_compare_gitlink(ce))
>  			changed |= DATA_CHANGED;
>  		return changed;
> -	case 0: /* Special case: unmerged file in index */
> -		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;

Not that I understand what is _really_ going on, but shouldn't the comment 
be actually moved, not be deleted?

Ciao,
Dscho
