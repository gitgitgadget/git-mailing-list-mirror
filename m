From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 11:41:33 -0700
Message-ID: <CAGZ79kbWVgWg54rTVSV3MeLHzqC2maJKz14y_tPTdkU5SWtF=w@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-3-git-send-email-sbeller@google.com>
	<CAPig+cQKOEYYR3j-uEeFzF3-qAfqq4SdQrH8LPmSP0VmAOCtzw@mail.gmail.com>
	<xmqqh9mm5tus.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaJmy4EijFuLCXOzPbi3EoqSwarFj3_3r+ghUwVA+88Mg@mail.gmail.com>
	<xmqqeghq48nl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 20:41:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeSVh-0007h9-R4
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934167AbbIVSlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 14:41:46 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34950 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933490AbbIVSlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:41:44 -0400
Received: by ykdz138 with SMTP id z138so18712600ykd.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 11:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7Y4MgpWSe1MY/KgR86HH5jyBleROBoymwfuUWX6G4KM=;
        b=kRDVDz2cvaCE9W5BuXj/uywJ4TSfON10x46ksodndduDzZaE/J6NcMmrwsI5lhzVnO
         3OerwCpITZwrOibMGM90vw+aINmblXtH5NrN9IpuB+mTnfGJ781xYsP+p1Ci85feSmT8
         ZUKb4qDxeiWJtyxURZOEn9J13uHE4CqMSidTu8IWZtXLcKpGiJnXMCAz1ZCr+cCaJzdK
         nheh6FIvGqoGYFgxBwt3knkhnitMPTRPJF4edRoubaYegldeIjjGWU3AO2hlWDvDcxNc
         fKeksOdYe9rnub3tsfetD2nBUFJ/1X5sra9+BoVQoK0RWHwE9U/gbKpSfGwVUpA3LWMJ
         hvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7Y4MgpWSe1MY/KgR86HH5jyBleROBoymwfuUWX6G4KM=;
        b=l+6axw3dfXaLe4Vl3YgvnfTp0aAf9faNhkM2Z0oc70KQiXN7/rzI0lEbwmiEMeKGdq
         StKZi2XDjkfjuuHpua0BsLuSOUQclt29mkyJMDHJqTSfwFlcnYw30ZO6Sh41MSAXz+il
         YzlNUIDCC7oX7jIc+2RKZIfbNbA3eLueVW6euLgVjiY9ETs1Sw7zpJ9h4qeI2mdQY5Xu
         3F9xB3688dDrL7mJz6LD7IAHk1GSBr+EIIicIEYGfiM+2ygfddt0mjA9BtiKMy+0+y/r
         Lz9GqWWsKQc7g/0nTmfhK6ZogSfFUnGJku2WBbUlTBb57oKI5gMBSTeO62f2vOPne+V+
         XOHg==
X-Gm-Message-State: ALoCoQlTf5ZyI9JjgEOFnPt+GkGW4hxvVWP0oAaUZK22JXzwNIKMqyuiO5UEOTH6HUZbh5wfglrA
X-Received: by 10.170.190.133 with SMTP id h127mr22773541yke.115.1442947293246;
 Tue, 22 Sep 2015 11:41:33 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 22 Sep 2015 11:41:33 -0700 (PDT)
In-Reply-To: <xmqqeghq48nl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278414>

On Tue, Sep 22, 2015 at 11:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Sep 22, 2015 at 8:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>
>>>>>         while (1) {
>>>>>                 nr = read(fd, buf, len);
>>>>> -               if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
>>>>> -                       continue;
>>>>> +               if (nr < 0) {
>>>>> +                       if (errno == EINTR)
>>>>> +                               continue;
>>>>> +                       if (errno == EAGAIN || errno == EWOULDBLOCK) {
>>>>> +                               struct pollfd pfd;
>>>>> +                               int i;
>>>>> +                               pfd.events = POLLIN;
>>>>> +                               pfd.fd = fd;
>>>>> +                               i = poll(&pfd, 1, 100);
>>>>
>>>> Why is this poll() using a timeout? Isn't that still a busy wait of
>>>> sorts (even if less aggressive)?
>>
>> True. Maybe we could have just a warning for now?
>>
>>     if (errno == EAGAIN) {
>>         warning("Using xread with a non blocking fd");
>>         continue; /* preserve previous behavior */
>>     }
>
> It is very likely that you will hit the same EAGAIN immediately by
> continuing and end up spewing tons of the same warning, no?

Right.

>
> We may want to slow down and think before sending a knee-jerk
> response (this applies to both of us).

Earlier this year I was doing lots of work in Gerrit, which somehow
prevented crossing emails even though I was knee-jerking all the time.
Maybe I picked up habits in Gerrit land which are only positive in Gerrit
land, while rather harming in a mailing list base workflow such as here
in Git land.

>
> I actually think a blocking poll(2) here would not be such a bad
> idea.  It would preserves the previous behaviour for callers who
> unknowingly inherited a O_NONBLOCK file descriptor from its
> environment without forcing them to waste CPU cycles.

So rather a combination of both, with the warning only spewing every
5 seconds or such?

I mean we identified this as a potential bug which we want to fix eventually
by having the caller make sure they only pass in blocking fds.

I feel like this is similar to the && call chain detection Jeff made a few
months back. At first there were bugreports coming in left and right about
broken test scripts, now it's all fixed hopefully. The difference is
this is not in
the test suite though, so maybe we can rollout this patch early next cycle
and get all the bugs fixed before we get serious with a release again?

It's risky though. Maybe there is a legit use case for "I have a non blocking fd
for $REASONS and I know it, but I still want to read it now until it's done"
Actually I thought about doing that exactly myself as part of the cleanup in the
asynchronous paralllel processing. We'd collect progress information using
this strbuf_read_once and polling. Once a process is done, we would need to get
all its output (i.e. up to EOF), so then we could just call
strbuf_read as we know the
child has already terminated, so all we want is getting the last bytes
out of the pipe.
