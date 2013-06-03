From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Mon, 3 Jun 2013 09:39:21 +0100
Message-ID: <CAJ-05NO2reGkboet1c2kYy0Y7xzkb9K45mTdCLq_AU7dp1OTNw@mail.gmail.com>
References: <CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<20130530193046.GG17475@serenity.lan>
	<CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
	<87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOdg5TvjzEMrXaPgogU5z5W6kywZhD-82eTUmvE9Hp=Lw@mail.gmail.com>
	<87y5av4jvj.fsf@linux-k42r.v.cablecom.net>
	<87txlj30n4.fsf@linux-k42r.v.cablecom.net>
	<20130531161710.GB1365@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 03 10:39:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjQIY-0006D1-Lj
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 10:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423Ab3FCIjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 04:39:23 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:46258 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab3FCIjW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 04:39:22 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so6573171obb.8
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 01:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :x-gm-message-state;
        bh=k4O4BtRfaqQRWfZeKk/zyUXdLvy0jjeTVq6oGRl3i+0=;
        b=SqDuNZwvVt75b5T2PxLhqdnfiDe3yf7yxJs6x1MXFpLlw6LK7psQPkwQofyWuz81He
         nFug0QXuhpA6GIqSKktpUH4uuqtqyOkNya4M0mWQajcRPVHzA45nS0rYDPKpJYAZU822
         eZ6SyYjO23Qkh9X4afEmNlhmv0EiyyJCWjDBFWJ8ltFKenvwy3YmVXsbDy4rFaIjuvUH
         uFzf4+djgInOYoEmfD7knEaEHox2VzHgMubH2hBfugFeuR5pUJUbYO/UV+waojM/U8ak
         Zn20aQf62s06hFP9CZyd6vCd/HTOFL3YqM5dxtB+kRwnZk7Sa2INMCLuSaIZrnBpQhJE
         +yEg==
X-Received: by 10.60.133.109 with SMTP id pb13mr2899099oeb.26.1370248761572;
 Mon, 03 Jun 2013 01:39:21 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Mon, 3 Jun 2013 01:39:21 -0700 (PDT)
In-Reply-To: <20130531161710.GB1365@sigill.intra.peff.net>
X-Google-Sender-Auth: lVDSvHz2VBaN8uTFeb4SjB2vBfU
X-Gm-Message-State: ALoCoQnrSayrmmtL8wygmEOyxNoTfiXm6uugWZVyOOHTQwWxafBXa4WtM+l5MfTaVmH/y/WPfDEF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226205>

On 31 May 2013 17:17, Jeff King <peff@peff.net> wrote:
> On Fri, May 31, 2013 at 12:27:11PM +0200, Thomas Rast wrote:
>
>> Thomas Rast <trast@inf.ethz.ch> writes:
>>
>> > However, if that turns out to be the culprit, it's not fixable
>> > currently[1].  Having commits with insanely long messages is just, well,
>> > insane.
>> >
>> > [1]  unless we do a major rework of the loading infrastructure, so that
>> > we can teach it to load only the beginning of a commit as long as we are
>> > only interested in parents and such
>>
>> Actually, Peff, doesn't your commit parent/tree pointer caching give us
>> this for free?
>
> It does. You can test it from the "jk/metapacks" branch at
> git://github.com/peff/git. After building, you'd need to do:
>
>   $ git gc
>   $ git metapack --all --commits
>
> in the target repository. You can check that it's working because "git
> rev-list --all --count" should be an order of magnitude faster. You may
> need to add "save_commit_buffer = 0" in any commands you are checking,
> though, as the optimization can only kick in if parse_commit does not
> want to save the buffer as a side effect.

Is this a command line argument? The tools don't seem to think so.

Anyway it seems to make a marginal difference to my case:

09:08 ajb@sloy/x86_64 [work.git] >time git --no-pager describe --long --tags
ajb-build-test-5225-2-gdc0b771

real    0m14.105s
user    0m12.409s
sys     0m1.660s
09:11 ajb@sloy/x86_64 [work.git] >git gc
Counting objects: 399436, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (110874/110874), done.
Writing objects: 100% (399436/399436), done.
Total 399436 (delta 281538), reused 398357 (delta 280493)
Checking connectivity: 399436, done.
09:12 ajb@sloy/x86_64 [work.git] >git metapack --all --commits
09:13 ajb@sloy/x86_64 [work.git] >time git --no-pager describe --long --tags
ajb-build-test-5225-2-gdc0b771

real    0m12.781s
user    0m11.669s
sys     0m1.080s
09:32 ajb@sloy/x86_64 [work.git] >time git --no-pager describe --long --tags
ajb-build-test-5225-2-gdc0b771

real    0m12.768s
user    0m11.817s
sys     0m0.908s
09:33 ajb@sloy/x86_64 [work.git] >time git --no-pager describe --long --tags
ajb-build-test-5225-2-gdc0b771

real    0m12.642s
user    0m11.705s
sys     0m0.904s


>
> I also looked into trying to just read the beginning part of a commit[1],
> but it turned out not to be all that much of an improvement.
>
> -Peff
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/212301



-- 
Alex, homepage: http://www.bennee.com/~alex/
