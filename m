From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations
 when not needed
Date: Tue, 6 Nov 2007 23:45:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711062343050.4362@racer.site>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
 <Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
 <472F7B2F.4050608@lsrfire.ath.cx> <7vejf4kwry.fsf@gitster.siamese.dyndns.org>
 <4730EB4E.4080903@lsrfire.ath.cx> <4730F5FA.3030705@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-174781150-1194392741=:4362"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Nov 07 00:46:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpY8D-0002Ui-6u
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXKFXqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbXKFXqi
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:46:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:58064 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751019AbXKFXqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 18:46:37 -0500
Received: (qmail invoked by alias); 06 Nov 2007 23:46:36 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp056) with SMTP; 07 Nov 2007 00:46:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EIekwa3/Ebahwj0NhpmcaJpl8Lx8H32z89A35zC
	o6/OEg7/PuiSmt
X-X-Sender: gene099@racer.site
In-Reply-To: <4730F5FA.3030705@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63754>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-174781150-1194392741=:4362
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 7 Nov 2007, René Scharfe wrote:

> By the way, the more intrusive surgery required when using strbuf_expand()
> leads to even faster operation.  Here my measurements of most of Paul's
> test cases (best of three runs):
>
> [...]

impressive timings.  Although I wonder where the time comes from, as the 
other substitutions should not be _that_ expensive.

In any case, your approach seems much more sensible, now that we have 
strbuf.

> diff --git a/strbuf.h b/strbuf.h
> index cd7f295..95071d5 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -102,6 +102,9 @@ static inline void strbuf_addbuf(struct strbuf *sb, struct strbuf *sb2) {
>  	strbuf_add(sb, sb2->buf, sb2->len);
>  }
>  
> +typedef void (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
> +extern void strbuf_expand(struct strbuf *sb, const char *fmt, const char **placeholders, expand_fn_t fn, void *context);

I wonder if it would even faster (but maybe not half as readable) if 
expand_fd_t got the placeholder_index instead of the placeholder.

Ciao,
Dscho
--8323584-174781150-1194392741=:4362--
