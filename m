From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Mon, 5 Jun 2006 15:49:38 +1200
Message-ID: <46a038f90606042049y3dfb1bbdwc91132ddd9eeaa39@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <447D043D.1020609@gentoo.org>
	 <46a038f90605302305g7a969a62r277af1724b912069@mail.gmail.com>
	 <447DA028.3040606@gentoo.org>
	 <46a038f90605311503o1526c664qe61b0f3f40929b92@mail.gmail.com>
	 <447E4611.7000309@gentoo.org>
	 <46a038f90606010047r676840d2nd91ad2361abbe1c8@mail.gmail.com>
	 <44837BDB.2090601@gentoo.org>
	 <46a038f90606041906k66d85152v6e402c65151d7ab8@mail.gmail.com>
	 <448398BC.5090402@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Donnie Berkholz" <spyderous@gentoo.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 05 05:49:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn664-0006p7-Qc
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 05:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWFEDtl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 23:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWFEDtl
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 23:49:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:10842 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932329AbWFEDtk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 23:49:40 -0400
Received: by wr-out-0506.google.com with SMTP id i22so890383wra
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 20:49:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E03qHrpqXbCnoc81qN/6G9wCLQwCIyf/Bze1GhAUBW6vrEFK/H2mn8p8KQEfKDTvDjTLn0wXBV3eEny/yu2fe5gH5tJHOCJW/Agu6IO4Bn8FM+Hs2b5eQDwP3qchYI97MFapo/Esent/+gCeP8rnRuNfnvO2p0r18AJucxmZgY8=
Received: by 10.54.117.14 with SMTP id p14mr4436465wrc;
        Sun, 04 Jun 2006 20:49:39 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Sun, 4 Jun 2006 20:49:38 -0700 (PDT)
To: antarus@gentoo.org
In-Reply-To: <448398BC.5090402@gentoo.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21310>

On 6/5/06, Alec Warner <antarus@gentoo.org> wrote:
> > I don't think you can do this in parallel. What I would do is remove
> > the -a from the git-repack invocation. It does hurt import times quite
> > a bit -- just do a git-repack -a -d when it's done.
>
> Only repack at the end then? disk space isn't an issue here so I'll give
> that a shot.

Not exactly -- by removing the -a from the git-repack invocation what
you get is cheap "partial" packing rather than a full repack. This is
somewhat inefficient disk-wise, perhaps by 10% or so. But full repacks
get more and more expensive as the repo grows.

So you don't need to run git-repack -a -d at the end, but it will be a
good measure to see how compact the packing gets.

> > And... having said that, there is still a memory leak somehow,
> > somewhere. It's been evading me for 2 weeks now, so I feel an idiot
> > now. Not too bad in general, but it shows clearly in the gentoo and
> > mozilla imports.
>
> 30565 antarus   17   0  470m 456m 1640 S   14 11.6 234:23.38
> git-cvsimport
> 30566 antarus   16   0 6753m 147m  752 S    7  3.7 120:27.06 cvs
>
> I'm on cvs-1.11.12 and the git version of git

Yep, I see roughly the same. It grows slowly and I don't know why :(

> I'll keep chugging on this one; it won't be the final import as I
> haven't used the complete Authors file, so I will try the repacking
> optimization next time I do an import.

Cool. If it dies for any reason, just do

  git-update-ref refs/heads/master refs/heads/origin
  git-update-ref HEAD origin
  git-checkout

You only need to do this the first time -- after that, the core heads
are set. Rerun the script and it will pick up where it left. If it
dies again, just do git-checkout to see the latest files.

(Above, replace origin with your -o option if you are using it. I
normally use -o cvshead.)



martin
