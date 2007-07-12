From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Add functions for parsing integers with size suffixes
Date: Thu, 12 Jul 2007 14:07:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707121404450.4516@racer.site>
References: <1184244952554-git-send-email-bdowning@lavos.net>
 <1184244952173-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 15:07:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yOa-00084q-Ok
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 15:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763743AbXGLNHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 09:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763767AbXGLNHq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 09:07:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:36931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763743AbXGLNHp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 09:07:45 -0400
Received: (qmail invoked by alias); 12 Jul 2007 13:07:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 12 Jul 2007 15:07:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/plL8fSu/prGGK+fcDTbkunb/BVmwdUQhDrbk4GL
	/ytCNUZzdeN7zU
X-X-Sender: gene099@racer.site
In-Reply-To: <1184244952173-git-send-email-bdowning@lavos.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52284>

Hi,

On Thu, 12 Jul 2007, Brian Downing wrote:

> Split out the nnn{k,m,g} parsing code from git_config_int into 
> git_parse_long, so command-line parameters can enjoy the same 
> functionality.  Also add get_parse_ulong for unsigned values.

Nice!

> +		if (!*end)
> +			*ret = val;
> +		else if (!strcasecmp(end, "k"))
> +			*ret = val * 1024;
> +		else if (!strcasecmp(end, "m"))
> +			*ret = val * 1024 * 1024;
> +		else if (!strcasecmp(end, "g"))
> +			*ret = val * 1024 * 1024 * 1024;
> +		else
> +			return 0;

This could be an own static function, like this:

unsigned long get_unit_factor(const char *end)
{
	if (!*end)
		return 1;
	if (!strcasecmp(end, "k"))
		return 1024;
	...
	error("Unknown unit: %s", end);
	return 1;
}

to avoid duplicated code.

Ciao,
Dscho
