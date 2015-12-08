From: Christian Couder <christian.couder@gmail.com>
Subject: Re: best practices against long git rebase times?
Date: Tue, 8 Dec 2015 18:45:22 +0100
Message-ID: <CAP8UFD3fmNSwSBLifWEsCBCSvY74Wh+9auvqyup4mN4Lx1Pf7g@mail.gmail.com>
References: <20151204150546.GA17210@inner.h.apk.li>
	<20151204153103.GP18913@serenity.lan>
	<20151206164345.GH22288@inner.h.apk.li>
	<20151207210212.GF30203@sigill.intra.peff.net>
	<xmqqmvtllvfi.fsf@gitster.mtv.corp.google.com>
	<20151207225957.GB3785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 18:45:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6MKO-0001ZX-HB
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbbLHRpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 12:45:24 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33237 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbLHRpX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:45:23 -0500
Received: by lbbkw15 with SMTP id kw15so15486790lbb.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 09:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fqCdMF4JBTmXeKaeKnEuT7hut6CGEaBagBHA/Y9OGyQ=;
        b=NdSlSU4ipjC1YC4ETtRVRzPFqXSb8Yl+BVSco5fm/uBSU+wZ6R/YFTazlheGZqxo6q
         7CAnVsNOw22k3ao/U48lQXsBN+YSAR3WWbyzVKbTQfeCUmlxhfLgpG9arVMlDuFhEgRw
         +vt2nKVl0claNE6eEKzHwlWqtp7KAEKsQiRbLSKAJAvnjmUG6lI0s4i63uh1XJb8uN5p
         5PleLWe6pJPkKbvUPyRkzA3P1vFpLtat5bl94ZNLq17H72SNtJLpF4Xz2MCKtlsjAyYK
         Sa14isM6NVtW8IxcXQdiQmIUJ2Z5MHdEdKzldKjXTx+E3UHQkcUunMAshmH5kB2BVP1X
         jrNg==
X-Received: by 10.112.184.45 with SMTP id er13mr464687lbc.133.1449596722079;
 Tue, 08 Dec 2015 09:45:22 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Tue, 8 Dec 2015 09:45:22 -0800 (PST)
In-Reply-To: <20151207225957.GB3785@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282168>

On Mon, Dec 7, 2015 at 11:59 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 07, 2015 at 02:56:33PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > You're computing the patch against the parent for each of those 3000
>> > commits (to get a hash of it to compare against the single hash on the
>> > other side). Twelve minutes sounds long, but if you have a really
>> > gigantic tree, it might not be unreasonable.
>> >
>> > You can also try compiling with "make XDL_FAST_HASH=" (i.e., setting
>> > that option to the empty string). Last year I found there were some
>> > pretty suboptimal corner cases, and you may be hitting one (we should
>> > probably turn that option off by default; I got stuck on trying to find
>> > a hash that would perform faster and never followed up[1].
>> >
>> > I doubt that is your problem, but it's possible).
>> >
>> > -Peff
>> >
>> > [1] http://thread.gmane.org/gmane.comp.version-control.git/261638
>>
>> I vaguely recall having discussed caching the patch-ids somewhere so
>> that this does not have to be done every time.  Would such an
>> extension help here, I wonder?
>
> I think you missed John's earlier response which gave several pointers
> to such caching schemes. :)

Yeah, he also gave very interesting performance numbers. Thanks John!

> I used to run with patch-id-caching in my personal fork (I frequently
> use "git log --cherry-mark" to see what has made it upstream), but I
> haven't for a while. It did make a big difference in speed, but I never
> resolved the corner cases around cache invalidation.

I will see if I can work on that after I am done with untracked cache...
