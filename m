From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Define 'crlf' attribute.
Date: Sun, 15 Apr 2007 17:54:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704151141090.18846@racer.site>
References: <7vps68d4wf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 17:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd74h-0006n4-Ai
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 17:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbXDOPzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 11:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995AbXDOPzZ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 11:55:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:40412 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752985AbXDOPzY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 11:55:24 -0400
Received: (qmail invoked by alias); 15 Apr 2007 15:55:23 -0000
Received: from 88-110-140-199.dynamic.dsl.as9105.com (EHLO 88-110-140-199.dynamic.dsl.as9105.com) [88.110.140.199]
  by mail.gmx.net (mp027) with SMTP; 15 Apr 2007 17:55:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18G0f5CBrQGgS8GzP5JAS8oGgXwc9w2WUO6hbhAfZ
	RHl43BA2y1NhOI
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps68d4wf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44496>

Hi,

On Fri, 13 Apr 2007, Junio C Hamano wrote:

> diff --git a/attr.c b/attr.c
> index bdbc4a3..d35ae9e 100644
> --- a/attr.c
> +++ b/attr.c
> [...]
> +
> +int git_path_is_binary(const char *path)
> +{
> +	struct git_attr_check attr_binary_check;
> +
> +	setup_binary_check(&attr_binary_check);
> +	return (!git_checkattr(path, 1, &attr_binary_check) &&
> +		(0 < attr_binary_check.isset));
> +}

This function is not declared in a header file, and ...

> diff --git a/convert.c b/convert.c
> index 898bfe3..20c744a 100644
> --- a/convert.c
> +++ b/convert.c
> [...]
> +
> +static int git_path_is_binary(const char *path)
> +{
> +	struct git_attr_check attr_crlf_check;
> +
> +	setup_crlf_check(&attr_crlf_check);
> +
> +	/*
> +	 * If crlf is not mentioned, default to autocrlf;
> +	 * disable autocrlf only when crlf attribute is explicitly
> +	 * unset.
> +	 */
> +	return (!git_checkattr(path, 1, &attr_crlf_check) &&
> +		(0 == attr_crlf_check.isset));
> +}

... here you have a function of the _same_ name, which does something 
subtly different: it checks for "crlf" instead of "binary".

Perhaps you wanted the change to attr.c at a later stage, and the function 
in convert.c should be renamed to "path_wants_crlf()"?

[Reading 3/3 revealed that indeed, the 18 lines in attr.c were unwanted.]

Ciao,
Dscho
