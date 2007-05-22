From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/3] Added generic string handling code.
Date: Tue, 22 May 2007 15:40:07 +0200
Message-ID: <20070522134007.GK4489@pasky.or.cz>
References: <1179627869.32181.1284.camel@hurina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Tue May 22 15:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqUbG-0005a9-Pa
	for gcvg-git@gmane.org; Tue, 22 May 2007 15:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408AbXEVNkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 09:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757007AbXEVNkL
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 09:40:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59034 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756408AbXEVNkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 09:40:10 -0400
Received: (qmail 844 invoked by uid 2001); 22 May 2007 15:40:07 +0200
Content-Disposition: inline
In-Reply-To: <1179627869.32181.1284.camel@hurina>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48107>

On Sun, May 20, 2007 at 04:24:29AM CEST, Timo Sirainen wrote:
> diff --git a/str.c b/str.c
> new file mode 100644
> index 0000000..d46e7f4
> --- /dev/null
> +++ b/str.c
> @@ -0,0 +1,40 @@
> +#include "str.h"
> +
> +void _str_append(struct string *str, const char *cstr)

_ is reserved namespace.

> +{
> +	unsigned int avail = str->size - str->len;
> +	unsigned int len = strlen(cstr);
> +
> +	if (len >= avail) {
> +		len = avail - 1;
> +		str->overflowed = 1;
> +	}
> +	memcpy(str->buf + str->len, cstr, len);
> +	str->len += len;
> +	str->buf[str->len] = '\0';

You can copy len + 1 and avoid this assignment.

> +}
> +
> +void _str_printfa(struct string *str, const char *fmt, ...)

printfA?

> +{
> +	unsigned int avail = str->size - str->len;
> +	va_list va;
> +	int ret;
> +
> +	va_start(va, fmt);
> +	ret = vsnprintf(str->buf + str->len, avail, fmt, va);
> +	if (ret < avail)
> +		str->len += ret;
> +	else {
> +		str->len += avail - 1;
> +		str->overflowed = 1;
> +	}
> +	va_end(va);
> +}

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
