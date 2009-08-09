From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] Use a clearer style to issue commands to remote
 helpers
Date: Sun, 9 Aug 2009 22:17:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908092211030.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908091526350.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 22:17:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaEpO-0003Xk-JZ
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 22:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbZHIUQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 16:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbZHIUQy
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 16:16:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:45199 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752637AbZHIUQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 16:16:53 -0400
Received: (qmail invoked by alias); 09 Aug 2009 20:16:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 09 Aug 2009 22:16:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+epwJW2BmeByABrCWWQqqYvRFD7VhQh9UbIB3Oer
	XZvBsDqBy8smG1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908091526350.27553@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125376>

Hi,

On Sun, 9 Aug 2009, Daniel Barkalow wrote:

> This style is overkill for some commands, but it's worthwhile to use
> the same style to issue all commands, and it's useful to avoid
> open-coding string lengths.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---

Thanks.  I am positively surprised that you did this patch in spite of the 
basis already being in 'next'.

> +	strbuf_addstr(&buf, "capabilities\n");
> +	write_in_full(helper->in, buf.buf, buf.len);
> +	strbuf_reset(&buf);

Hmm.  I think you use the same paradigm three times.  Maybe it is time to 
heed the DRY principle and introduce a helper function?

Maybe something like

void fprintf_in_full(struct strbuf *buf, int fd, const char *format, ...)
{
	va_list ap;

	va_start(ap, format);
	strbuf_reset(buf);
	strbuf_vaddf(buf, format, ap);
	write_in_full(fd, buf->buf, buf->len);
	va_end(ap);
}

But I keep forgetting that there is no strbuf_vaddf() in 'next'... maybe 
it is high time that I forget my promise and re-submit that series?

Ciao,
Dscho
