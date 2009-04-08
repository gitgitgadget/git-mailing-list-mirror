From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Fix buffer overflow in config parser
Date: Thu, 9 Apr 2009 01:15:17 +0200
Message-ID: <200904090115.17609.markus.heidelberg@web.de>
References: <49DD21A0.3040505@intra2net.com> <200904090058.42751.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 01:16:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrh0R-0008VE-4B
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 01:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbZDHXO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 19:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbZDHXO4
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 19:14:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45938 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbZDHXO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 19:14:56 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id B64E6FA2AF80;
	Thu,  9 Apr 2009 01:14:54 +0200 (CEST)
Received: from [89.59.73.185] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lrgys-00066Z-00; Thu, 09 Apr 2009 01:14:54 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200904090058.42751.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19CQKS6RdlRgVx57iav5MfM7O3kSdwQAIDHZ8ej
	Ze38X4NTecrlPwbWvrPFupYy6eKAirCl6RliCeUKfI63Q2t9kW
	c7pxzf56cnrxHqhxIwsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116131>

Markus Heidelberg, 09.04.2009:
> Thomas Jarosch, 09.04.2009:
> > Hello together,
> > 
> > attached is a small patch to fix a buffer overflow in config.c.
> > Patch is against git master's HEAD.
> > 
> > I didn't send this one inline as I wanted to
> > preserve the 1024+ byte long line.
> 
> You could send the patch inline and attach the example config.
> 
> > diff --git a/config.c b/config.c
> > index b76fe4c..a9c67e8 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -72,7 +72,7 @@ static char *parse_value(void)
> >                         }
> >                 }
> >                 if (space) {
> > -                       if (len)
> > +                       if (len && len < sizeof(value)-1)
> >                                 value[len++] = ' ';
> >                         space = 0;

Eh, or maybe better add a "continue;" here, so that only one char per
loop is read.

> >                 }
