From: "jdow" <jdow@earthlink.net>
Subject: Re: [PATCH] Really *do* nothing in while loop
Date: Sun, 8 May 2005 04:33:32 -0700
Message-ID: <12e801c553c1$c454ea20$1225a8c0@kittycat>
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de> <427DE086.40307@tls.msk.ru> <1115551204.3085.0.camel@kryten>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Thomas Glanzmann" <sithglan@stud.uni-erlangen.de>,
	"LKML" <linux-kernel@vger.kernel.org>, "GIT" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 13:27:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUjwJ-0007l0-JF
	for gcvg-git@gmane.org; Sun, 08 May 2005 13:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVEHLd6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 07:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVEHLd6
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 07:33:58 -0400
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:13999 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S262848AbVEHLdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 07:33:53 -0400
Received: from [4.16.241.254] (helo=kittycat)
	by smtpauth01.mail.atl.earthlink.net with asmtp (Exim 4.34)
	id 1DUk2Y-0001ug-Dm; Sun, 08 May 2005 07:33:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple;
  s=test1; d=earthlink.net;
  h=Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE;
  b=Pm6XpWlcauPPQHBk9sF7HmitC1DOPS8Lq3x0afeCvI9s8X65vxhwIqIyzM9Ivpw2;
To: "James Purser" <purserj@ksit.dynalias.com>,
	"Michael Tokarev" <mjt@tls.msk.ru>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120c73c103b50c9d9f17c7629a5d77f7b0ecf2db02f6bc5f712350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 4.16.241.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: "James Purser" <purserj@ksit.dynalias.com>

> On Sun, 2005-05-08 at 19:48, Michael Tokarev wrote:
> > Thomas Glanzmann wrote:
> > > [PATCH] Really *do* nothing in while loop
> > > 
> > > Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
> > > 
> > > --- a/sha1_file.c
> > > +++ b/sha1_file.c
> > > @@ -335,7 +335,7 @@
> > >  stream.next_in = hdr;
> > >  stream.avail_in = hdrlen;
> > >  while (deflate(&stream, 0) == Z_OK)
> > > - /* nothing */
> > > + /* nothing */;
> > >  
> > >  /* Then the data itself.. */
> > >  stream.next_in = buf;
> > 
> > Well, the lack of semicolon is wrong really (and funny).

You guys REALLY do not see the changed semantics here? You are
changing:
  while (deflate(&stream, 0) == Z_OK)
      stream.next_in = buf;

into

  while (deflate(&stream, 0) == Z_OK)
    ;
  /* Then the data itself.. */
  stream.next_in = buf;

I suspect the results of that tiny bit of code would be slightly
different, especially if "stream.next_in" is volatile, "buf"
is volatile, or if the assignment to next_in has an effect on
the "deflate" operation.

{^_^}



