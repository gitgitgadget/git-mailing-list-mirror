From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Make section_name_match start on '[', and return
 the length on success
Date: Sat, 25 Jul 2009 16:09:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907251605240.8306@pacific.mpi-cbg.de>
References: <1248470504-16326-1-git-send-email-alex@chmrr.net> <1248470504-16326-2-git-send-email-alex@chmrr.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUhwr-0007tm-MQ
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbZGYOJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbZGYOJz
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:09:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:57184 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750796AbZGYOJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:09:54 -0400
Received: (qmail invoked by alias); 25 Jul 2009 14:09:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 25 Jul 2009 16:09:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18B6H4ghAABSOpczr/lAx4XhPuBiQ+jaXGDi9fwpw
	bV+mv7eXmDmQMB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1248470504-16326-2-git-send-email-alex@chmrr.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124007>

Hi,

On Fri, 24 Jul 2009, Alex Vandiver wrote:

> diff --git a/config.c b/config.c
> index 04380bb..7d6f6f6 100644
> --- a/config.c
> +++ b/config.c
> @@ -1194,7 +1194,9 @@ write_err_out:
>  static int section_name_match (const char *buf, const char *name)
>  {
>  	int i = 0, j = 0, dot = 0;
> -	for (; buf[i] && buf[i] != ']'; i++) {
> +	if (buf[i] != '[')
> +		return 0;

Is this not unnecessary, given that we  only call that function when we 
know that buf[0] == '[':

> @@ -1249,7 +1261,8 @@ int git_config_rename_section(const char *old_name, const char *new_name)
>  			; /* do nothing */
>  		if (buf[i] == '[') {
>  			/* it's a section */
> -			if (section_name_match (&buf[i+1], old_name)) {
> +			int offset = section_name_match (&buf[i], old_name);
> +			if (offset > 0) {
>  				ret++;
>  				if (new_name == NULL) {
>  					remove = 1;

I was a bit surprised that "offset" is not used further in your patch, but 
I saw that 2/2 uses it.

So except for the unnecessary test, I like your patches (read: ACK).

Ciao,
Dscho
