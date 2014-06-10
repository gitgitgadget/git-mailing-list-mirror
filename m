From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 15/20] t/t5000-tar-tree.sh: avoid "test <cond> -a/-o
 <cond>"
Date: Tue, 10 Jun 2014 12:21:11 -0700
Message-ID: <20140610192110.GA72977@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
 <1402066563-28519-16-git-send-email-gitter.spiros@gmail.com>
 <20140610184913.GD72751@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 10 21:21:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuRbq-0007Ph-OE
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 21:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbaFJTVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 15:21:23 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:53152 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaFJTVW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 15:21:22 -0400
Received: by mail-pa0-f41.google.com with SMTP id kq14so1017378pab.14
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n4OmIYf478y/nBIHf+GM+jFEUH3roflMTZrqkDRNFuw=;
        b=VF8IgNd24XiTCjU/3++79UzWKQA0RAu7556Rq0H7jUmwEC/89p8U1l0wcY+D6MRwIQ
         jH0dP0RTD/7LDtiPiXvX/QbrUkCKBqfujJiP0H3WSrJYvZ3gFDsjztbDGIlWb09CY4Hu
         EoxskZTKcEa/Z5cmiBVJzfomv43GPFgDIyfZUK+A9ilqGTxM+KNaiDJOptXC1YRPNUz9
         +19jvcsqSg6+KjEYkgcNSUdAxcfS7B4C+G1N7+jhnpxeXaSQjaT7i6reiPatPgz9rdG2
         QJ4Urj2U5G8QdQjuyaUNKUFW7UCezDjbLBnko7wr6tOu8oiSxGCcwXwAG7A7xYvq98E7
         EctQ==
X-Received: by 10.66.188.5 with SMTP id fw5mr7400281pac.63.1402428081871;
        Tue, 10 Jun 2014 12:21:21 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id kj1sm70917833pbd.20.2014.06.10.12.21.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 12:21:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140610184913.GD72751@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251220>

On Tue, Jun 10, 2014 at 11:49:15AM -0700, David Aguilar wrote:
> On Fri, Jun 06, 2014 at 07:55:58AM -0700, Elia Pinto wrote:
> > The construct is error-prone; "test" being built-in in most modern
> > shells, the reason to avoid "test <cond> && test <cond>" spawning
> > one extra process by using a single "test <cond> -a <cond>" no
> > longer exists.
> >=20
> > Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> > ---
> >  t/t5000-tar-tree.sh |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> > index 74fc5a8..ad6fa0d 100755
> > --- a/t/t5000-tar-tree.sh
> > +++ b/t/t5000-tar-tree.sh
> > @@ -72,7 +72,7 @@ check_tar() {
> >  			for header in *.paxheader
> >  			do
> >  				data=3D${header%.paxheader}.data &&
> > -				if test -h $data -o -e $data
> > +				if test -h $data || test -e $data
> >  				then
>=20
> This looks okay, but it raises a question for the original author
> (Ren=C3=A9, I think that's you so I've added you to the To: line).

Just following up -- I got a bounce from Ren=C3=A9's email address.

>=20
> Should that be "test -f" instead of "test -e"?

It does seem like this should be "test -f" nonetheless.
Sorry for the noise.

> This is a very minor note and should not block this patch.
--=20
David
