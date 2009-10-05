From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option 
  family
Date: Mon, 5 Oct 2009 11:00:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910051057350.4985@pacific.mpi-cbg.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <4AC98FC8.3090202@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 11:00:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MujQj-0000q0-Vb
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 11:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbZJEI7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 04:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbZJEI7F
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 04:59:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:35816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932206AbZJEI7E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 04:59:04 -0400
Received: (qmail invoked by alias); 05 Oct 2009 08:58:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 05 Oct 2009 10:58:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0+OADcuC0nDR1zzsJUIKPptFP4kR8syDOXMBOxN
	hoQiR66TTZvVFk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4AC98FC8.3090202@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129538>

Hi,

On Mon, 5 Oct 2009, Johannes Sixt wrote:

> Junio C Hamano schrieb:
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> +	fwrite(sb.buf, sb.len, 1, f);
> >> +
> >> +	if (!message) {
> >> +		while ((commit = get_revision(&rev))) {
> >> +			strbuf_setlen(&sb, 0);
> >> +			if (del)
> >> +				strbuf_addstr(&sb, commit->object.flags &
> >> +						SYMMETRIC_LEFT ? del : add);
> >> +			format_commit_message(commit, format, &sb,
> >> +					rev.date_mode);
> >> +			if (del)
> >> +				strbuf_addstr(&sb, reset);
> > 
> >  - In the "ANSI-terminal only" world view, adding colors to strbuf and
> >    writing it out together with the actual strings is an easy thing to do.
> >    Don't Windows folks have trouble converting this kind of code to their
> >    color control call that is separate from writing strings out?  If it is
> >    not a problem, I do not have any objection to it, but otherwise I'd
> >    suggest not to add any more code that stores color escape sequence in
> >    strbuf, so that we would not make later conversion by Windows folks
> >    harder than necessary.
> 
> Thanks for noticing this! To store color escapes in strbuf is not a
> problem as long as the string is finally written using printf, fprintf, or
> fputs.
> 
> >> +			strbuf_addch(&sb, '\n');
> >> +			fwrite(sb.buf, sb.len, 1, f);
> 
> Outch! fwrite doesn't interpret color escapes. AFAICS, this sequence is
> easy to change such that it uses fprintf().

Good point.  I changed it to

                        fprintf(f, "%s", sb.buf);

BTW we probably need to remove the "TODO: write" from compat/winansi.c...

Ciao,
Dscho
