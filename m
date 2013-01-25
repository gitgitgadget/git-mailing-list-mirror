From: Jeff King <peff@peff.net>
Subject: Re: [regression] Re: [PATCHv2 10/15] drop length limitations on
 gecos-derived names and emails
Date: Fri, 25 Jan 2013 17:10:30 -0500
Message-ID: <20130125221030.GC23626@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
 <20120521231017.GJ10981@sigill.intra.peff.net>
 <20130124232146.GA17458@google.com>
 <20130125010559.GA27657@sigill.intra.peff.net>
 <7vtxq53xt3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org,
	Mihai Rusu <dizzy@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 23:10:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyrU6-0000AS-9S
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 23:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145Ab3AYWKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 17:10:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51096 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab3AYWKc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 17:10:32 -0500
Received: (qmail 17069 invoked by uid 107); 25 Jan 2013 22:11:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Jan 2013 17:11:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Jan 2013 17:10:30 -0500
Content-Disposition: inline
In-Reply-To: <7vtxq53xt3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214591>

On Fri, Jan 25, 2013 at 10:46:48AM -0800, Junio C Hamano wrote:

> Will queue this one, to be merged to 'maint' and 'master'.
> 
> -- >8 --
> From: Jonathan Nieder <jrnieder@gmail.com>
> Date: Thu, 24 Jan 2013 15:21:46 -0800
> Subject: [PATCH] ident: do not drop username when reading from /etc/mailname

Thanks, looks fine to me (and thanks to Jonathan). One nit:

> -	if (strbuf_getline(buf, mailname, '\n') == EOF) {
> +	if (strbuf_getline(&mailnamebuf, mailname, '\n') == EOF) {
>  		if (ferror(mailname))
>  			warning("cannot read /etc/mailname: %s",
>  				strerror(errno));
> +		strbuf_release(&mailnamebuf);
>  		fclose(mailname);
>  		return -1;
>  	}

This strbuf_release is unnecessary, as an EOF return by definition means
we did not read anything. I don't mind it as a defensive measure,
though, in case the strbuf implementation changes to pre-allocate.

-Peff
