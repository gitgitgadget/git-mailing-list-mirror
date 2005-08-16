From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Add merge detection to git-cvsimport
Date: Wed, 17 Aug 2005 09:36:08 +1200
Message-ID: <46a038f9050816143646fa4137@mail.gmail.com>
References: <20050816103527.F420A33010C@ng.eduforge.org>
	 <20050816110725.GL11882MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 16 23:36:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E596T-00089e-HL
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 23:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVHPVgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 17:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVHPVgK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 17:36:10 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:27366 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932434AbVHPVgJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 17:36:09 -0400
Received: by rproxy.gmail.com with SMTP id i8so29057rne
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 14:36:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BvhgkXZviFHeIUzROg5alY2XManz8dyPh2n/cyYC24IcpkNWuOqLaotXVHvLg8ogMD27x6kgCBJ+j9VAPTjgSH0fCc5zsG34RDRC/CUNo5HOsOol5c1nxl9dYWD2DjdT8vXKp30MrxL/LITq5W4A9Fpmqf5hS6lY3gcvigJcVoA=
Received: by 10.39.3.21 with SMTP id f21mr2497570rni;
        Tue, 16 Aug 2005 14:36:09 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Tue, 16 Aug 2005 14:36:08 -0700 (PDT)
To: skimo@liacs.nl, Martin Langhoff <martin@ng.eduforge.org>,
	git@vger.kernel.org
In-Reply-To: <20050816110725.GL11882MdfPADPa@garage.linux.student.kuleuven.ac.be>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/16/05, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Tue, Aug 16, 2005 at 10:35:27PM +1200, Martin Langhoff wrote:
> > +
> > +sub get_headref($$) {
> 
> If you want to check whether a ref is valid, then
> it is better to use git-rev-parse...

We are reading/writing directly to .git/refs/heads/ a lot in this
script. Not changing that for the time being.

> > +    if (open(C,"$git_dir/refs/heads/$name")) {
> > +     chomp($sha = <C>);
> > +     close(C);
> > +     length($sha) == 40
> > +         or die "Cannot get head id for $name ($sha): $!\n";
> 
> ... but if you're just going to die, then why not simply
> let git-commit-tree do the test ?

Because we get the head names from cvsps output, and we want to have a
specific error when cvsps has given us a bogus branch name.
git-commit-tree could fail for a number of reasons, this one is the
most likely one to be from a bug in cvsps or the cvsimport logic.
 
> > +                             if ($mparent eq 'HEAD') { $mparent = 'origin'};
> 
> Please don't hardcode 'origin' here.

Duh! Patch submitted. Juniooooo! 


martin
