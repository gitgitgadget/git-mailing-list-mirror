From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 01:41:18 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0803310137090.18259@racer.site>
References: <20080330231408.GR11666@genesis>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:42:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7A5-0004Su-5p
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbYC3XlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 19:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYC3XlV
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:41:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:40747 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751742AbYC3XlU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 19:41:20 -0400
Received: (qmail invoked by alias); 30 Mar 2008 23:41:18 -0000
Received: from host86-139-218-102.range86-139.btcentralplus.com (EHLO racer.home) [86.139.218.102]
  by mail.gmx.net (mp012) with SMTP; 31 Mar 2008 01:41:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2rjJ8FW62/ve974NiNcS/QNNZOQewE8nJDqnF2g
	LUByhvgX1dVyn2
X-X-Sender: gene099@racer.site
In-Reply-To: <20080330231408.GR11666@genesis>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78527>

Hi,

On Mon, 31 Mar 2008, Miklos Vajna wrote:

> +	if ((fp = fopen("/proc/apm", "r"))) {
> +		if (fscanf(fp, "%s %s %s %x", buf, buf, buf, &ac) != 4)
> +			ac = 1;
> +		fclose(fp);
> +		return ac != 1;
> +	}

If /proc/apm could be opened, should you still try to open 
/proc/acpi/ac_adapter?

And what about system dependency?  I mean, if at all, this stuff belongs 
to compat/.  Definitely not into builtin-gc.c.  And yes, that means that 
you should not call the function is_on_battery() blindly, but _only_ if 
defer_on_battery is set.

Ciao,
Dscho
> @@ -176,6 +220,11 @@ static int need_to_gc(void)
>  		append_option(argv_repack, "-A", MAX_ADD);
>  	else if (!too_many_loose_objects())
>  		return 0;
> +
> +	if(is_on_battery()) {

Style.  As can be seen 3 lines earlier, we put a space after the "if".

Ciao,
Dscho
