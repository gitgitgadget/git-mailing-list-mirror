From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: [PATCH] Fix buffer overflow in config parser
Date: Thu, 9 Apr 2009 09:59:28 +0200
Organization: Intra2net AG
Message-ID: <200904090959.28646.thomas.jarosch@intra2net.com>
References: <49DD21A0.3040505@intra2net.com> <200904090058.42751.markus.heidelberg@web.de> <200904090115.17609.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Thu Apr 09 10:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrpC6-00053d-VU
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759871AbZDIH7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 03:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758934AbZDIH7e
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 03:59:34 -0400
Received: from rs02.intra2net.com ([81.169.173.116]:51794 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbZDIH7d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 03:59:33 -0400
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 392114D88;
	Thu,  9 Apr 2009 09:59:30 +0200 (CEST)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id D3D762AC4B;
	Thu,  9 Apr 2009 09:59:29 +0200 (CEST)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 16D002AC4A;
	Thu,  9 Apr 2009 09:59:29 +0200 (CEST)
User-Agent: KMail/1.11.0 (Linux/2.6.27.19-78.2.30.fc9.i686; KDE/4.2.1; i686; ; )
In-Reply-To: <200904090115.17609.markus.heidelberg@web.de>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intra2net.com) with AMaViS and F-Secure AntiVirus (fsavdb 2009-04-09_07)
X-Spam-Status: hits=-4.1 tests=[ALL_TRUSTED=-1.8,BAYES_00=-2.312]
X-Spam-Level: 959
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116145>

On Thursday, 9. April 2009 01:15:17 Markus Heidelberg wrote:
> > > diff --git a/config.c b/config.c
> > > index b76fe4c..a9c67e8 100644
> > > --- a/config.c
> > > +++ b/config.c
> > > @@ -72,7 +72,7 @@ static char *parse_value(void)
> > >                         }
> > >                 }
> > >                 if (space) {
> > > -                       if (len)
> > > +                       if (len && len < sizeof(value)-1)
> > >                                 value[len++] = ' ';
> > >                         space = 0;
>
> Eh, or maybe better add a "continue;" here, so that only one char per
> loop is read.

Thanks for the review.

If I understand the intention of the complete code correctly, the idea was
to read in 1+ spaces and put -one- space in the buffer as soon as the first
non-space character is encountered (if not inside quotes).

Adding a "continue" statement would eat up the first non-space character.

I guess it's ok to modify the first size check or keep to problem local and 
check the size before putting the space in the buffer. Guess that's up to
the maintainer which method he prefers.

Cheers,
Thomas
