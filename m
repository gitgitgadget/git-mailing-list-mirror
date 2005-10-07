From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First cut at git port to Cygwin
Date: Fri, 7 Oct 2005 14:44:07 +0200
Message-ID: <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
References: <433B3B10.5050407@zytor.com>
	 <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
	 <434299DB.7020805@zytor.com>
	 <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com>
	 <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com>
	 <20051005155457.GA30303@trixie.casa.cgf.cx>
	 <20051005191741.GA25493@steel.home>
	 <20051005202947.GA6184@trixie.casa.cgf.cx>
	 <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
	 <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Christopher Faylor <me@cgf.cx>, Junio C Hamano <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 14:45:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENra9-0002Ac-N8
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 14:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVJGMoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 08:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVJGMoJ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 08:44:09 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:6856 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932504AbVJGMoI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 08:44:08 -0400
Received: by nproxy.gmail.com with SMTP id n15so270781nfc
        for <git@vger.kernel.org>; Fri, 07 Oct 2005 05:44:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=byanT6PGwctbz588S8Fmrr9H1i9DCdZBZyYLK50zTo3Bi//M45Uv8sO9Xpqy+FJBkRZtPLO+6uUOlZbaCM2ec+nedfqhndNNtpiZxmIOECeioJN62QKWM0afgKxNllkQSwBXaWLvGSBRDVmHtmEObZnTzMhhBC9uDJhS2L1wfEQ=
Received: by 10.48.235.7 with SMTP id i7mr178139nfh;
        Fri, 07 Oct 2005 05:44:07 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Fri, 7 Oct 2005 05:44:07 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9800>

On 10/6/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> > (a bit too intrusive). The patch fixes only update-index.c (the one I had
> > problems with), there probably are other places were the situation is alike.
>
> of course there are "other places". Please, try the attached patch instead.
>
> For the record: the patch is supposed to help people with
> "Unable to write new cachefile" kind of errors.

Just as I thought the situation improved (by closing index.lock and
unmapping index),
it suddenly get worse: now I'm stuck on git-pull.

git-merge-index (called at some point by git-pull) maps the index in, and starts
git-merge-one-file for each (or the given) entry in the index.
git-merge-one-file
calls git-update-index, which wants to update the index. Which doesn't work,
because it's locked by that piece of s$%^.

The only working walkaround for me atm is unlinking indexfile before rename in
commit_index_file :(
