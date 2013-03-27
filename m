From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 12:27:23 -0700
Message-ID: <CA+55aFypcwbLwPLq++AU9FggCKLYkgkuN6i-gOD9pRioH1Dz2g@mail.gmail.com>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
	<vpqr4j0rccf.fsf@grenoble-inp.fr>
	<CAFT1WNxm0Kx9vHx+NB92_tZV6KsVhefiVXa-K69YbWOkpCXSgA@mail.gmail.com>
	<20130327184657.GP2286@serenity.lan>
	<20130327190425.GA26380@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Jim Kinsman <jakinsman@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 20:27:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKw0n-0001kh-9V
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 20:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114Ab3C0T1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 15:27:25 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:39305 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab3C0T1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 15:27:24 -0400
Received: by mail-ve0-f178.google.com with SMTP id db10so3230843veb.37
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Au6XuurPWjz+Z65fIt5DVRi07qr9mGUmST1rjk1d+Mc=;
        b=0r+L9hjPJm5YrXFLW1cc6IzpVJ7i7SVIpKSUNAq35i9yAfJT3nF8kvVkEY2Toji0j+
         JcHJUclo3yXxygbdV9/GRMvoUR4bWpAwEgUXaiQ7qusNfuN2m1Fg3LFRPi9S8CCzF3FT
         Zfwkp0CXqBR1ZSs31+I+BKP8IloYFgMm0dUxYNyV8bXveDpqUQPpvrScpc6oS0J8x8r8
         pnciaGBLOQxqeLCJfhiCFtFbgC0qhTwjNJTyzjbfs+HMpSS+3h1+BID4SADK5Yxgxd1/
         2hmfdQGs2/fA1I0E6HNM5v4tZetHtw4Z/M6zqoRbpkqka6p2Zt5K07kdrZuX885eV/46
         yKfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Au6XuurPWjz+Z65fIt5DVRi07qr9mGUmST1rjk1d+Mc=;
        b=gGRmCxwCj+vFKL/hfLUCOcyOX4K/cK3JI+i7H0vuIlurN2fhkMzgNweeACzEodoWN4
         lqQ1yV3BPHIqUQZeG/AYhGYOXMVVsKvlGfRfYZkde+Z61qqIVAH90UfW9QjfWWhtG1Qd
         xGrCmV0bYPObbYxyCIzdBhnCPOPi4U33YgK4s=
X-Received: by 10.52.25.99 with SMTP id b3mr20506282vdg.99.1364412443676; Wed,
 27 Mar 2013 12:27:23 -0700 (PDT)
Received: by 10.220.148.211 with HTTP; Wed, 27 Mar 2013 12:27:23 -0700 (PDT)
In-Reply-To: <20130327190425.GA26380@sigill.intra.peff.net>
X-Google-Sender-Auth: YAP1PsPoDwtzpphXdZb6Nogiw4E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219310>

On Wed, Mar 27, 2013 at 12:04 PM, Jeff King <peff@peff.net> wrote:
>
> Yes, I think that's pretty much the case (though most of my
> Git-on-Windows experience is from cygwin long ago, where the stat
> performance was truly horrendous). Have you tried setting
> core.preloadindex, which should run the stats in parallel?

I wonder if preloadindex shouldn't be enabled by default.. It's a huge
deal on NFS, and the only real downside is that it expects threading
to work. It potentially slows things down a tiny bit for single-CPU
cases with everything cached, but that isn't likely to be a relevant
case.

Of course, it can trigger filesystem scalability issues, and as a
result it will often not help very much if you have the bulk of your
files in one (or a few) directories. But anybody who has so many files
that performance is an issue is not likely to have them all in one
place.

And apparently the Windows FS metadata caching sucks, and things fall
out of the cache for large trees. Color me not-very-surprised. It's
probably some size limit on the metadata that you can tweak. So I';m
sure there's some registry setting or other that would make windows
able to cache more than a few thousand filenames, and it would
probably improve performance a lot, but I do think preloadindex has
been around long enough that it could just be the default.

Of course, Jim should verify that preloadindex actually does solve his
problem.  With 20k+ files, it should max out the 20 IO threads for
preloading, and assuming the filesystem IO scales reasonably well, it
should fix the problem. But we do do a number of metadata ops
synchronously even with preloadindex, so things won't scale perfectly.

(In particular: do open each directory and do the readdir stuff and
try to open .gitignore whether it exists or not. So you'll get
synchronous IO for each directory, but at least the per-file IO to
check all the file stat data should scale).

             Linus
