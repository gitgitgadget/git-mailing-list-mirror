From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/3] archive: specfile syntax change: "$Format:%PLCHLDR$"
 instead of just "%PLCHLDR"
Date: Thu, 6 Sep 2007 18:11:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061803590.28586@racer.site>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
 <46DCF0EF.9020604@op5.se> <Pine.LNX.4.64.0709041139140.28586@racer.site>
 <46DDE69C.1080908@lsrfire.ath.cx> <7vzm02klip.fsf@gitster.siamese.dyndns.org>
 <46E028B9.2090908@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1789802963-1189098664=:28586"
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:11:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKt3-00080y-NT
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbXIFRLU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbXIFRLT
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:11:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:35260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751826AbXIFRLT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 13:11:19 -0400
Received: (qmail invoked by alias); 06 Sep 2007 17:11:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 06 Sep 2007 19:11:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fQjho2FefpgOgquzqWIOhLx+8aTxqnh/nd8cmy7
	tC6Gqu32SVxDIm
X-X-Sender: gene099@racer.site
In-Reply-To: <46E028B9.2090908@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57908>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1789802963-1189098664=:28586
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 6 Sep 2007, René Scharfe wrote:

> As suggested by Johannes, --pretty=format: placeholders in specfiles 
> need to be wrapped in $Format:...$ now.

Thanks.

> diff --git a/builtin-archive.c b/builtin-archive.c
> index faccce3..a8a0f01 100644
> --- a/builtin-archive.c
> +++ b/builtin-archive.c
> @@ -81,14 +81,58 @@ static int run_remote_archiver(const char *remote, int argc,
>  	return !!rv;
>  }
>  
> +static void *format_specfile(const struct commit *commit, const char *format,
> +                             unsigned long *sizep)

Should this not be "char *buffer" instead of "const char *format"?  Or 
even better: a "struct strbuf *"?

> +{
> +	unsigned long len = *sizep, result_len = 0;
> +	const char *a = format;
> +	char *result = NULL;
> +
> +	for (;;) {
> +		const char *b, *c;
> +		char *fmt, *formatted = NULL;
> +		unsigned long a_len, fmt_len, formatted_len, allocated = 0;

Maybe initialise formatted_len, just to be on the safe side?

> +
> +		b = memchr(a, '$', len);
> +		if (!b || a + len < b + 9 || memcmp(b + 1, "Format:", 7))
> +			break;

Wouldn't memmem(buffer, len, "$Format:", 8) be better here?

A general comment: since you plan to output the result into a file anyway, 
it should be even easier to avoid realloc(), and do a 
print_formatted_specfile() instead of a format_specfile(), no?

Ciao,
Dscho

--8323584-1789802963-1189098664=:28586--
