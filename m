From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Fri, 7 Nov 2014 23:10:08 -0800
Message-ID: <CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
References: <20141107081324.GA19845@peff.net>
	<xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
	<20141107191745.GB5695@peff.net>
	<CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 08:10:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn0AA-0005Ao-3S
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 08:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbaKHHKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 02:10:10 -0500
Received: from mail-vc0-f180.google.com ([209.85.220.180]:56529 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbaKHHKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 02:10:09 -0500
Received: by mail-vc0-f180.google.com with SMTP id hy10so2529772vcb.39
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 23:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G+O/BIeM9o9VP4a32vY5oYYu5/LcuMCr2Gegg0Yrh/s=;
        b=tVQEV3WN3xyUyuFaRCrz2Yu2iAt8ztBjU4c7Cus3rsp+k25PM8/lGMQR+9BJOesogi
         PkDQweclVObTwPgq6RwWz1hRQiRQ1pYWMYBz0RZHo/I8Y8N4kUoQL/WqdeOaccpZrx7m
         w/uvyXBiLADUIVd5sXGpb/HyTkE0/3MgLfXGKE7CcyW0Gy61t3VRDrofHeOVd/JrzWqm
         b/hZ5iX4dDrRRkAL0MuP4mYLjuBVwnXakBpglnj3XUeN8Q9uNCWVQ0gT1SKiiam9zpki
         AVxiAafHyeoVx2PcfneOlWCE4fOznjrJFZXxlMu3sL8S/GRDhOquBvrDNw6Rf97C+JOI
         LfHw==
X-Received: by 10.220.87.138 with SMTP id w10mr11085647vcl.4.1415430608526;
 Fri, 07 Nov 2014 23:10:08 -0800 (PST)
Received: by 10.221.37.74 with HTTP; Fri, 7 Nov 2014 23:10:08 -0800 (PST)
In-Reply-To: <CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trying again from plain old gmail which I think does not send a
multipart content.

On Fri, Nov 7, 2014 at 11:06 PM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> Is this also related to "git checkout $rev ." not removing removed files?
> What you say about the difference in implementation between checkout and
> reset sounds vaguely familiar from when I looked at it some years ago.
> Curiously, I just talked to Jonathan about this over lunch yesterday. I
> think we would both be happy to get that oddity of checkout fixed. If what
> you mention here is indeed related to fixing that, it does complicate things
> with regards to backwards compatibility.
>
>
> On Fri Nov 07 2014 at 11:24:09 AM Jeff King <peff@peff.net> wrote:
>>
>> On Fri, Nov 07, 2014 at 09:14:42AM -0800, Junio C Hamano wrote:
>>
>> > Jeff King <peff@peff.net> writes:
>> >
>> > > Is there a reason that we don't use this diff technique for checkout?
>> >
>> > I suspect that the reasons are probably mixture of these:
>> >
>> >  (1) the code path may descend from checkout-index and predates the
>> >      in-core diff machinery;
>> >
>> >  (2) in the context of checkout-index, it was more desirable to be
>> >      able to say "I want the contents on the filesystem, even if you
>> >      think I already have it there, as you as a new software are
>> >      likely to be wrong and I know better"; or
>> >
>> >  (3) it was easier to code that way ;-)
>> >
>> > I do not see there is any reason not to do what you suggest.
>>
>> OK. It's not very much code (and can mostly be lifted from git-reset),
>> so I may take a stab at it.
>>
>> -Peff
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
