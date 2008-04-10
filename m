From: Jan Hudec <bulb@ucw.cz>
Subject: Re: MIME headers in introductory message (git send-email --compose)
Date: Thu, 10 Apr 2008 20:47:03 +0200
Message-ID: <20080410184703.GA14912@efreet.light.src>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org> <200803252031.17017.tlikonen@iki.fi> <20080325230649.GA5273@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Samuel Tardieu <sam@rfc1149.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 20:49:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk1ok-0000jC-F0
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 20:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbYDJSrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 14:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbYDJSrW
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 14:47:22 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:56497 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbYDJSrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 14:47:21 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 9E6A157571;
	Thu, 10 Apr 2008 20:47:18 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 8yFif5+p6jF2; Thu, 10 Apr 2008 20:47:12 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 6D02357624;
	Thu, 10 Apr 2008 20:47:09 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1Jk1nb-0003wP-TQ; Thu, 10 Apr 2008 20:47:03 +0200
Content-Disposition: inline
In-Reply-To: <20080325230649.GA5273@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79241>

On Tue, Mar 25, 2008 at 19:06:49 -0400, Jeff King wrote:
> On Tue, Mar 25, 2008 at 08:31:16PM +0200, Teemu Likonen wrote:
> 
> > By the way, 'git send-email --compose' does not add MIME headers to 
> > introductory message. All non-Ascii chars will output something 
> > undefined in receivers' end.
> > 
> > I guess the right way would be to detect user's charset (locale) and add 
> > appropriate MIME headers. Also, the Subject field should be encoded if 
> > it contains non-Ascii characters.
> 
> I just posted some patches to fix this; however, they always encode as
> utf-8. I'm not sure what is the best way to find the user's encoding.
> AIUI, locale environment variables are not enough, since, e.g., "en_US"
> could come in iso8859-1 and utf-8 flavors. Is there a portable way to
> figure this out? Should we be pulling it from .git/config? Neither the
> commitEncoding nor the logOutputEncoding really makes sense to reuse.

The portable way is to use the locale environment variables, but you have to
read them via the libc locale interface. You set the LC_CTYPE locale category
via setlocale (which will consult LC_CTYPE, LC_ALL and LANG environment AND
the locale database) and than ask for charset using nl_langinfo(CODESET).
To do the equivalent from the shell, call `locale charmap`. From perl, either
use langinfo in I18N::Langinfo, or just use the ':locale' IO stream option
provided by encoding pragma to read the file in unicode no matter what the
locale encoding was (this is perl 5.8.<something> -- in older one, you'd have
to use I18N::Langinfo anyway).

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
