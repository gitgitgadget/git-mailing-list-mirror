From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-tag.c: remove global variable to use the callback
 data of git-config.
Date: Tue, 17 Mar 2009 16:47:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903171646140.6393@intel-tinevez-2-302>
References: <1237301031.10001.13.camel@equipo-loli>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 16:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjbXa-0000ol-US
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 16:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbZCQPru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 11:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZCQPru
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 11:47:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:44876 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752465AbZCQPrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 11:47:49 -0400
Received: (qmail invoked by alias); 17 Mar 2009 15:47:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp050) with SMTP; 17 Mar 2009 16:47:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+24xhV6TW2X3euhnF1Z40nVoaw2GymtumNJbr4GP
	ArROn3J9Sib7Zv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1237301031.10001.13.camel@equipo-loli>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113484>

Hi,

On Tue, 17 Mar 2009, Carlos Rica wrote:

> By using strbuf to save the signing-key id, it also imposes no limit
> to the length of the string obtained from the config or command-line.
> This string is then passed to gpg to sign the tag, when appropriate.
> 
> Signed-off-by: Carlos Rica <jasampler@gmail.com>
> ---
> 
> 
> QUESTION: Is it safe to remove this limit?

I think so.  GPG should return an error if it thinks it is too large.

> @@ -164,11 +162,10 @@ static int do_sign(struct strbuf *buffer)
>  	int len;
>  	int i, j;
>  
> -	if (!*signingkey) {
> -		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
> -				sizeof(signingkey)) > sizeof(signingkey) - 1)
> -			return error("committer info too long.");
> -		bracket = strchr(signingkey, '>');
> +	if (!signingkey->buf[0]) {

It is probably better to ask for !signingkey->len (think of trying to 
understand the code in 6 months from now).

Other than that, very nice!

Ciao,
Dscho
