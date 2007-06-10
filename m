From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/21] Refactor tag name verification loop to use index
 'i' instead of incrementing pointer 'tag_line'
Date: Sun, 10 Jun 2007 10:01:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100959420.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090215.05318.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:04:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJM3-0007uk-Cz
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbXFJJE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 05:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbXFJJE5
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:04:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:48938 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751581AbXFJJE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:04:57 -0400
Received: (qmail invoked by alias); 10 Jun 2007 09:04:55 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp010) with SMTP; 10 Jun 2007 11:04:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bVGIIQmObMDrb7jVm4nRRfq/kQ/jnSYdMX7Btfq
	5/Q379s7hcLDLL
X-X-Sender: gene099@racer.site
In-Reply-To: <200706090215.05318.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49692>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> diff --git a/mktag.c b/mktag.c
> index 4dbefab..2e70504 100644
> --- a/mktag.c
> +++ b/mktag.c
> @@ -81,19 +81,22 @@ static int verify_tag(char *data, unsigned long size)
>  	memcpy(type, type_line + 5, type_len);
>  	type[type_len] = '\0';
>  
> -	/* Verify that the object matches */
> -	if (verify_object(sha1, type))
> -		return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
> -
> -	/* Verify the tag-name: we don't allow control characters or spaces in it */
> -	tag_line += 4;
> -	for (;;) {
> -		unsigned char c = *tag_line++;
> -		if (c == '\n')
> -			break;
> -		if (c > ' ')
> -			continue;
> -		return error("char" PD_FMT ": could not verify tag name", tag_line - data);
> +	{
> +		unsigned long i;

Do you realize that half of your diff consists of reindenting, just 
because you introduced this ugly construct, instead of being a good boy 
and put the declarations where they belong -- at the beginning of the 
function (or if it exists, block)?

> +		/* Verify the tag-name: we don't allow control characters or spaces in it */
> +		for (i = 4;;) {

Yes, you can write this construct. That does not change the fact that it 
gives me eye cancer.

Ciao,
Dscho
