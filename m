From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge markers
Date: Sun, 24 Jan 2016 13:26:13 -0500
Message-ID: <CAPig+cT4gQi=OhYT3AwKA=_UER4nC-wOu93U72QcSWtMoVxhMg@mail.gmail.com>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
	<c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de>
	<20160122195015.GA5897@flurp.local>
	<CAPig+cSf_Hac=4+F1bRaFeYdFrjo6SH=vApdUDkhep5BUve+Kw@mail.gmail.com>
	<alpine.DEB.2.20.1601241137260.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 24 19:26:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNPNH-00034y-Ji
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 19:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbcAXS0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 13:26:16 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35917 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbcAXS0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 13:26:14 -0500
Received: by mail-vk0-f68.google.com with SMTP id e64so4978267vkg.3
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 10:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aW1/nNjPv7IigpeWvRl3AvYl+94NtugXe9P2xoiZOo0=;
        b=STdKx/zDij3LFpdgX++SttHbXDffoxzyvNEd+LI+SGbuEcScg3q+/fRJCKIObDuYI4
         OeBsO9AHy00RX0H6QUQ1oOBawWLHOpbFHH1pT2n7EYzYExAq8yKKSZ2OT/ciVs+T6jFO
         1sMFSa2VSrT5d/gcsnoWO14c36MbuVfnZ15/WKxW5aXh+3TvefVYMgtjBvgGH12zrVoq
         kD/oPx//gvzA+5wIevg/13U0cMQOW3CFyoucyk0zEjfAUzm7jEioHDjXcRHnikJ4yzZ5
         uGEz7nerr16mDj4/R6lH2RApv4kwhLTCwMj2pT4gLAyEyzg1gZF0nk4ugavCFVcFub3N
         oKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aW1/nNjPv7IigpeWvRl3AvYl+94NtugXe9P2xoiZOo0=;
        b=ErcL/zNmOXT2r6ebqCTlzp+PosmArfCiyYZnTL9cZFqfMEErWm2DNacN4wXr4auPm7
         RkMaEGQSjrNc0DEJaZGG3BhQW15O6iV+qIXoCBIp1BSAut1WoSE9sN1ntIfm8H3ogdu5
         zzk3rQj6oGQoe18lUrDtd5XhUCDOC5EC0nl2m8a+RHxzRptsDLNhMirNnksepRjwX1qr
         ryUSmd1kh+0fpQyaM2GfYUAtaymOYBbLZFZsc6hltzXfzDg9M0jUCiGqDORZBTly8Psi
         DRkRqHSK3GQtJs5x1maQwJOTpvEZ/6ZvEnHXzlPqJVvABC85kJC0TjK8I+eLHzq5SDI4
         896Q==
X-Gm-Message-State: AG10YORJ0v7FK8Ip4BEGmwZgDH2EqKMxN89E1ws/2KcxeCKP3DTUJkj4KxGcJdYFbFKdAhLE+qaqUvM2JQmVnQ==
X-Received: by 10.31.168.76 with SMTP id r73mr8330876vke.117.1453659973308;
 Sun, 24 Jan 2016 10:26:13 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 24 Jan 2016 10:26:13 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1601241137260.2964@virtualbox>
X-Google-Sender-Auth: -K0HCo-M7EGVzb8kuZ4rADLWeyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284689>

On Sun, Jan 24, 2016 at 5:37 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 22 Jan 2016, Eric Sunshine wrote:
>> On Fri, Jan 22, 2016 at 2:50 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > On Fri, Jan 22, 2016 at 06:01:25PM +0100, Johannes Schindelin wrote:
>> >> +test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
>> >> +     test_must_fail git -c core.eol=crlf merge-file -p \
>> >> +             nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
>> >> +     test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
>> >
>> > The "\r" isn't recognized by 'sed' on Mac OS X or BSD. Perhaps use
>> > instead:
>> >
>> >     test $(cat output.txt | tr "\015" Q | sed -n "/\.txtQ$/p" | wc -l) = 3
>>
>> Or the 'sed' could even become at 'grep' at this point.
>
> Good point, thanks!

And, without the unnecessary 'cat', of course (don't know what I was thinking):

    test $(tr "\015" Q <output.txt | grep "\.txtQ$" | wc -l) = 3
