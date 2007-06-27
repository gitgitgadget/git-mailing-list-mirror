From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 17:57:27 +0200
Message-ID: <81b0412b0706270857w175f2b2ey4c30bac9c0836929@mail.gmail.com>
References: <87wsxpobf0.fsf@rho.meyering.net>
	 <81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
	 <87r6nxo8iq.fsf_-_@rho.meyering.net>
	 <81b0412b0706270618p850df2dy41b2b797d82e3276@mail.gmail.com>
	 <87d4zho74h.fsf@rho.meyering.net>
	 <81b0412b0706270704y58c9e05bh6ec10118d7ee406c@mail.gmail.com>
	 <87tzstmqmi.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jim Meyering" <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 17:57:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Ztc-0007l7-3d
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 17:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbXF0P5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 11:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756240AbXF0P5a
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 11:57:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:54091 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721AbXF0P53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 11:57:29 -0400
Received: by ug-out-1314.google.com with SMTP id j3so357669ugf
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 08:57:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cXwL94PRtO3lj4Xyi92uVzROfivaNSkcUlzzL4vuhghMw/4HdKC4crJh09RSnHR3qmTDqpBhp80fjw0w+7KlnRHs3rDBPX+ZubXu8Q3hflb7Qu7Eb4sNzv8mUmNqV1RSVcmklmJzxCkJxaDFpVnVGWKpEumcZOWCermBfUofpJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vl3e1hby12lvI+MAEnE1hyjBRvyT8AQmcF1hQWpv9NJyv/8ZCpQL23RDhUwjwZGNG820hZnoYjfADOAOz8d3jfDIS4/G+XlIgy/BQMJoK5pxA/IbPYnlO315SwnEB3hhoA2BH92OJW0SKeRrp7pbeASeBdaf7KYIUjueTO0/bfY=
Received: by 10.78.183.15 with SMTP id g15mr357453huf.1182959847282;
        Wed, 27 Jun 2007 08:57:27 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 27 Jun 2007 08:57:27 -0700 (PDT)
In-Reply-To: <87tzstmqmi.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51053>

On 6/27/07, Jim Meyering <jim@meyering.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> wrote:
>
> > On 6/27/07, Jim Meyering <jim@meyering.net> wrote:
> >> "Alex Riesen" <raa.lkml@gmail.com> wrote:
> >> > Check if this works in some exotic but common
> >> > environments (like MacOSX, Cygwin or HP-UX).
> >>
> >> What do you mean?
> >> I know that dup and fdopen work in those environments.
> >
> > Exactly as you described?
>
> No, but why does that matter?
>

Your code will need additional tweaking on this
systems.

> > Are you sure fdopen on Cygwin
> > sets ENOMEM?
>
> Are you suggesting not to use errno because
> it won't contain useful information on Mingw32?

Yes. Mingw32 is just one example.

> >> It's ok, but for the fact that when dup fails, all you get
> >> is the uninformative EINVAL from fdopen.
> >
> > EBADF on Cygwin, 0 on Mingw32. Can't even imagine what msvc
>
> EBADF is fine.  Setting errno to 0 upon error is a bug.
> Don't cater to buggy systems.

It is my system at work. What should I do, throw it out of window?

> >
> > Then put file name and the line number in!
>
> Surely you're playing devil's advocate, now...

No, I'm just thinking aloud about whether I should start preparing
a reverting commit for your changes just to be able to continue
using Git on that mismanaged, stupid, slow and very real
system I have to work with. It is a Win2k laptop, in a Novell
network and with Cygwin on (actually 2 cygwins at least, which
cygwin does not support), and without a chance to _EVER_ use
anything else. And I happen to depend on Git, because the
alternative is, as someone noted, "badly mismanaged" Perforce.
And I believe I am not that bad off, there are other systems on
which you didn't test either. "Silly", as you say.
