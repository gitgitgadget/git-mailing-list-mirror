From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/8] Use a clearer style to issue commands to remote
 helpers
Date: Sun, 9 Aug 2009 17:14:04 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908091617310.27553@iabervon.org>
References: <alpine.LNX.2.00.0908091526350.27553@iabervon.org> <alpine.DEB.1.00.0908092211030.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 09 23:14:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaFiZ-00043T-LG
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 23:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbZHIVOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 17:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbZHIVOF
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 17:14:05 -0400
Received: from iabervon.org ([66.92.72.58]:57749 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbZHIVOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 17:14:04 -0400
Received: (qmail 26534 invoked by uid 1000); 9 Aug 2009 21:14:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2009 21:14:04 -0000
In-Reply-To: <alpine.DEB.1.00.0908092211030.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125381>

On Sun, 9 Aug 2009, Johannes Schindelin wrote:

> > +	strbuf_addstr(&buf, "capabilities\n");
> > +	write_in_full(helper->in, buf.buf, buf.len);
> > +	strbuf_reset(&buf);
> 
> Hmm.  I think you use the same paradigm three times.  Maybe it is time to 
> heed the DRY principle and introduce a helper function?
> 
> Maybe something like
> 
> void fprintf_in_full(struct strbuf *buf, int fd, const char *format, ...)
> {
> 	va_list ap;
> 
> 	va_start(ap, format);
> 	strbuf_reset(buf);
> 	strbuf_vaddf(buf, format, ap);
> 	write_in_full(fd, buf->buf, buf->len);
> 	va_end(ap);
> }
> 
> But I keep forgetting that there is no strbuf_vaddf() in 'next'... maybe 
> it is high time that I forget my promise and re-submit that series?

Yup, that's exactly what I started writing, until I ran into the lack of 
strbuf_vaddf() and remembered that there were portability issues I don't 
understand with copying va_lists.

	-Daniel
*This .sig left intentionally blank*
