From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option 
  family
Date: Mon, 5 Oct 2009 11:20:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910051119260.4985@pacific.mpi-cbg.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <4AC98FC8.3090202@viscovery.net> <alpine.DEB.1.00.0910051057350.4985@pacific.mpi-cbg.de>
 <4AC9B7C3.3090302@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 11:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MujpS-0007U7-Ct
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 11:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbZJEJSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 05:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbZJEJSb
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 05:18:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:43917 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932372AbZJEJSb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 05:18:31 -0400
Received: (qmail invoked by alias); 05 Oct 2009 09:17:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 05 Oct 2009 11:17:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hfkgQQtph2iFNsuahJ4I2QWa3HrykdElnYTinmQ
	DA5m26vzsKmtTV
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4AC9B7C3.3090302@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129541>

Hi,

On Mon, 5 Oct 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Mon, 5 Oct 2009, Johannes Sixt wrote:
> >> Junio C Hamano schrieb:
> >>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >>>> +	fwrite(sb.buf, sb.len, 1, f);
> >>>> +
> >>>> +	if (!message) {
> >>>> +		while ((commit = get_revision(&rev))) {
> >>>> +			strbuf_setlen(&sb, 0);
> >>>> +			if (del)
> >>>> +				strbuf_addstr(&sb, commit->object.flags &
> >>>> +						SYMMETRIC_LEFT ? del : add);
> >>>> +			format_commit_message(commit, format, &sb,
> >>>> +					rev.date_mode);
> >>>> +			if (del)
> >>>> +				strbuf_addstr(&sb, reset);
> >>>> +			strbuf_addch(&sb, '\n');
> >>>> +			fwrite(sb.buf, sb.len, 1, f);
> >> Outch! fwrite doesn't interpret color escapes. AFAICS, this sequence is
> >> easy to change such that it uses fprintf().
> > 
> > Good point.  I changed it to
> > 
> >                         fprintf(f, "%s", sb.buf);
> 
> Thanks. But notice how you are constructing the string in sb from pieces.
> I meant to change it to
> 
> 	fprintf(f, "%s%s%s\n",
> 			del ? (commit->object.flags & SYMMETRIC_LEFT
> 					 ? del : add) : "",
> 			format_commit_message(commit, format, &sb,
> 					rev.date_mode),
> 			del ? reset : "");
> 
> or similar. We already use this idiom elsewhere.

And I find it utterly ugly and unreadable there, too. So this is why I did 
not do it.

Ciao,
Dscho
