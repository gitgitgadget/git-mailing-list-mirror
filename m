From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 00:29:22 -0500
Message-ID: <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>, gcc@gcc.gnu.org
X-From: git-owner@vger.kernel.org Tue Dec 11 06:29:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1xgk-00066a-6B
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 06:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbXLKF33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 00:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbXLKF33
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 00:29:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:51976 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbXLKF32 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 00:29:28 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3788381wah
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 21:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=N+zqGSLoFLO2PVfd5i8G4dmXJKVFMsI8tJaFjwGc2Ac=;
        b=H9TFlB/j7bbTcLrGI9gBUgeSHUZRxmCZfwjfqiyM8Xt4Yy82zOLYB8ZTvU47u5xpk81teSsuR7dJxnEualrMeqYAGySkzC1ULe7jXgdcQhhE1JHONFxii5S/PD7ZxjvRmNht6j7npNR1RbyThnDdQRIT7zesMUPmx7L6i/r+M3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=yBkVWFXfEAmRADmTOpza5vzCe4EjYcu+iWIJS9/EMqObP3uVfe7jXwtjkZaJWKYgjScJW+nHF5u/mYv/KTmWgBBRmnHiH/c0xkVjBBNzZG5octPSNOo1XUYqmvcUS2FoQHAODkOiqYFEsALQCdqLQQsYVr5/hrOV2V//b1z0Cqo=
Received: by 10.114.171.1 with SMTP id t1mr7654655wae.1197350967605;
        Mon, 10 Dec 2007 21:29:27 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Mon, 10 Dec 2007 21:29:22 -0800 (PST)
In-Reply-To: <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67793>

I added the gcc people to the CC, it's their repository. Maybe they
can help up sort this out.

On 12/11/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 12/10/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 10 Dec 2007, Jon Smirl wrote:
> >
> > > New run using same configuration. With the addition of the more
> > > efficient load balancing patches and delta cache accounting.
> > >
> > > Seconds are wall clock time. They are lower since the patch made
> > > threading better at using all four cores. I am stuck at 380-390% CPU
> > > utilization for the git process.
> > >
> > > complete seconds RAM
> > > 10%   60    900M (includes counting)
> > > 20%   15    900M
> > > 30%   15    900M
> > > 40%   50    1.2G
> > > 50%   80    1.3G
> > > 60%   70    1.7G
> > > 70%   140  1.8G
> > > 80%   180  2.0G
> > > 90%   280  2.2G
> > > 95%   530  2.8G - 1,420 total to here, previous was 1,983
> > > 100% 1390 2.85G
> > > During the writing phase RAM fell to 1.6G
> > > What is being freed in the writing phase??
> >
> > The cached delta results, but you put a cap of 256MB for them.
> >
> > Could you try again with that cache disabled entirely, with
> > pack.deltacachesize = 1 (don't use 0 as that means unbounded).
> >
> > And then, while still keeping the delta cache disabled, could you try
> > with pack.threads = 2, and pack.threads = 1 ?
> >
> > I'm sorry to ask you to do this but I don't have enough ram to even
> > complete a repack with threads=2 so I'm reattempting single threaded at
> > the moment.  But I really wonder if the threading has such an effect on
> > memory usage.
>
> I already have a threads = 1 running with this config. Binary and
> config were same from threads=4 run.
>
> 10% 28min 950M
> 40% 135min 950M
> 50% 157min 900M
> 60% 160min 830M
> 100% 170min 830M
>
> Something is hurting bad with threads. 170 CPU minutes with one
> thread, versus 195 CPU minutes with four threads.
>
> Is there a different memory allocator that can be used when
> multithreaded on gcc? This whole problem may be coming from the memory
> allocation function. git is hardly interacting at all on the thread
> level so it's likely a problem in the C run-time.
>
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> [pack]
>         threads = 1
>         deltacachesize = 256M
>         windowmemory = 256M
>         deltacachelimit = 0
> [remote "origin"]
>         url = git://git.infradead.org/gcc.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "trunk"]
>         remote = origin
>         merge = refs/heads/trunk
>
>
>
>
> >
> >
> >
> > >
> > > I have no explanation for the change in RAM usage. Two guesses come to
> > > mind. Memory fragmentation. Or the change in the way the work was
> > > split up altered RAM usage.
> > >
> > > Total CPU time was 195 minutes in 70 minutes clock time. About 70%
> > > efficient. During the compress phase all four cores were active until
> > > the last 90 seconds. Writing the objects took over 23 minutes CPU
> > > bound on one core.
> > >
> > > New pack file is: 270,594,853
> > > Old one was: 344,543,752
> > > It still has 828,660 objects
> >
> > You mean the pack for the gcc repo is now less than 300MB?  Wow.
> >
> >
> > Nicolas
> >
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
