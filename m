From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] builtin-commit: Include the diff in the commit message
 when verbose.
Date: Thu, 22 Nov 2007 10:52:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221049350.27959@racer.site>
References: <1195700089-8326-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-689189565-1195728724=:27959"
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9fY-0006jn-1G
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbXKVKwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 05:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbXKVKwJ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:52:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:55237 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750696AbXKVKwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 05:52:08 -0500
Received: (qmail invoked by alias); 22 Nov 2007 10:52:06 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp045) with SMTP; 22 Nov 2007 11:52:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RVpxhrbcRiixVarQbLcpdCfA/keFWgh37z49uj1
	dopiMJEv8DDotx
X-X-Sender: gene099@racer.site
In-Reply-To: <1195700089-8326-1-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65781>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-689189565-1195728724=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 21 Nov 2007, Kristian Høgsberg wrote:

> @@ -758,6 +758,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		rollback_index_files();
>  		exit(1);
>  	}
> +
> +	/* Truncate the message just before the diff, if any. */
> +	p = strstr(sb.buf, "\ndiff --git a/");
> +	if (p != NULL)
> +		strbuf_setlen(&sb, p - sb.buf);
> +

Is this related to the change in wt_status?  If so, wouldn't we want to 
suppress the diff, instead of generating it, and then killing it later?

Besides, you'd want to leave the \n there: strbuf_setlen(&sb, p + 1 - 
sb.buf);

> +	/* Sigh, the entire diff machinery is hardcoded to output to
> +	 * stdout.  Do the dup-dance...*/

I wonder how much effort it would be to change that.  Not that it would 
help too much, since we want the output in a strbuf anyway.

Ciao,
Dscho
---1463811741-689189565-1195728724=:27959--
