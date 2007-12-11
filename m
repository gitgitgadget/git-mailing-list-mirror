From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 00:25:55 -0500
Message-ID: <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 06:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1xdP-0005Kr-9b
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 06:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXLKF0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 00:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbXLKF0A
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 00:26:00 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:43310 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbXLKFZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 00:25:59 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3786933wah
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 21:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MBphj48yRVZI74Z38sZVu4OIwMl+FO5tM4bLxV0/ffg=;
        b=LqF0iHUJu2hajJgdNCQwI3YKLj/pC1uaA768BrDw9L3OU6th0Q74QuiwFLENHbuC0ZN1Hgkc53FnAd33DNVi3uZZNylb2fCkxvo8v5KAyDbIiZNdcjqGkFLc1PtukT4KzANalZkB8N6cAet/9VDAcdPHutyUmpJaVpnhkDr1DWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PMNxB/gdsqHiZ/OSV6rrS5AuVIqXAtruxHurd1wZw4ekugrYN2+PH265Ohrg+I1nT8z9T5Kq6oyW5iOosIH5uyEV+4qhljtdlXTJ6I9VK2nIKOPTsCn95YYWYeMEAEOoKmdBtrYGXOtpL3r64G8X5E4YfijPHXOHKAd+X7GE+Vs=
Received: by 10.114.168.1 with SMTP id q1mr8270910wae.1197350755894;
        Mon, 10 Dec 2007 21:25:55 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Mon, 10 Dec 2007 21:25:55 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67791>

On 12/10/07, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 10 Dec 2007, Jon Smirl wrote:
>
> > New run using same configuration. With the addition of the more
> > efficient load balancing patches and delta cache accounting.
> >
> > Seconds are wall clock time. They are lower since the patch made
> > threading better at using all four cores. I am stuck at 380-390% CPU
> > utilization for the git process.
> >
> > complete seconds RAM
> > 10%   60    900M (includes counting)
> > 20%   15    900M
> > 30%   15    900M
> > 40%   50    1.2G
> > 50%   80    1.3G
> > 60%   70    1.7G
> > 70%   140  1.8G
> > 80%   180  2.0G
> > 90%   280  2.2G
> > 95%   530  2.8G - 1,420 total to here, previous was 1,983
> > 100% 1390 2.85G
> > During the writing phase RAM fell to 1.6G
> > What is being freed in the writing phase??
>
> The cached delta results, but you put a cap of 256MB for them.
>
> Could you try again with that cache disabled entirely, with
> pack.deltacachesize = 1 (don't use 0 as that means unbounded).
>
> And then, while still keeping the delta cache disabled, could you try
> with pack.threads = 2, and pack.threads = 1 ?
>
> I'm sorry to ask you to do this but I don't have enough ram to even
> complete a repack with threads=2 so I'm reattempting single threaded at
> the moment.  But I really wonder if the threading has such an effect on
> memory usage.

I already have a threads = 1 running with this config. Binary and
config were same from threads=4 run.

10% 28min 950M
40% 135min 950M
50% 157min 900M
60% 160min 830M
100% 170min 830M

Something is hurting bad with threads. 170 CPU minutes with one
thread, versus 195 CPU minutes with four threads.

Is there a different memory allocator that can be used when
multithreaded on gcc? This whole problem may be coming from the memory
allocation function. git is hardly interacting at all on the thread
level so it's likely a problem in the C run-time.

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[pack]
        threads = 1
        deltacachesize = 256M
        windowmemory = 256M
        deltacachelimit = 0
[remote "origin"]
        url = git://git.infradead.org/gcc.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "trunk"]
        remote = origin
        merge = refs/heads/trunk




>
>
>
> >
> > I have no explanation for the change in RAM usage. Two guesses come to
> > mind. Memory fragmentation. Or the change in the way the work was
> > split up altered RAM usage.
> >
> > Total CPU time was 195 minutes in 70 minutes clock time. About 70%
> > efficient. During the compress phase all four cores were active until
> > the last 90 seconds. Writing the objects took over 23 minutes CPU
> > bound on one core.
> >
> > New pack file is: 270,594,853
> > Old one was: 344,543,752
> > It still has 828,660 objects
>
> You mean the pack for the gcc repo is now less than 300MB?  Wow.
>
>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
