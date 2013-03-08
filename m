From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Fri, 8 Mar 2013 17:53:56 +0700
Message-ID: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <20130210112205.GA28434@lanh>
 <7vhaljudos.fsf@alter.siamese.dyndns.org> <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com>
 <513911B3.7010903@web.de> <7vr4jqkb9g.fsf@alter.siamese.dyndns.org>
 <51398CD5.1070603@web.de> <7v7glijoiy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 11:55:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDux3-0002Pl-4v
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 11:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110Ab3CHKy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 05:54:28 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:56289 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab3CHKy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 05:54:27 -0500
Received: by mail-oa0-f47.google.com with SMTP id o17so1845487oag.34
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 02:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sCgKM1zKmvkljNBMwsIY7XrPSgocHJK4Kr0Fl0YcDYs=;
        b=UJFpTcmXwGIA3FjkGHSTqWqBelXIdanUQwbQvZPpJdq/s0JFUZ6lii2D0b1z2Nd+dc
         SliMrIOFbOs5wWklNoiEKF2+79eONK0Vi4wzvZrKaHu4HMiOBhVALQs9lMFL1Au9l4MR
         oKM8/14N2sfEMhZt0awbS1grM5AerCsv4vvohR9ePy4Ulshh1YfoUjJUOB+w4dJhUr8y
         4y7ngUQOY4B2FlUmKnJ8qtYMjAl0JH9/RNbJXSVnAnwk2mIUG+drtegzPu/aIYBzO8Tx
         d1HMKhlRzl3hP/Wavw/8icfLXhNgyRqplZHuHLqFHofjXNzpzt9/c/4rRpFAHyuOeJDo
         9MCA==
X-Received: by 10.60.29.72 with SMTP id i8mr1123766oeh.93.1362740066566; Fri,
 08 Mar 2013 02:54:26 -0800 (PST)
Received: by 10.76.27.200 with HTTP; Fri, 8 Mar 2013 02:53:56 -0800 (PST)
In-Reply-To: <7v7glijoiy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217659>

On Fri, Mar 8, 2013 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  The possible options are:
>>  +
>> -       - 'no'     - Show no untracked files
>> +       - 'no'     - Show no untracked files (this is fastest)
>
> There is a trade-off around the use of -uno between safety and
> performance.  The default is not to use -uno so that you will not
> forget to add a file you newly created (i.e safety).  You would pay
> for the safety with the cost to find such untracked files (i.e.
> performance).
>
> I suspect that the documentation was written with the assumption
> that at least for the people who are reading this part of the
> documentation, the trade-off is obvious.  In order to find more
> information, you naturally need to spend more cycles.
>
> If the trade-off is not so obvious, however, I do not object at all
> to describing it. But if we are to do so, I do object to mentioning
> only one side of the trade-off.  People who choose "fastest" needs
> to be made very aware that they are disabling "safety".

On the topic of trading off, I was thinking about new -uauto as
default that is like -uall if it takes less than a certan amount of
time (e.g. 0.5 seconds), if it exceeds that limit, the operation is
aborted (i.e. it turns to -uno). The safety net is still there, "git
status" advices to use -u to show full information.

Or a less intrusive approach: measure the time and advice the user to
(read doc and) use -uno.

But it's probably worth waiting for the first cut of inotify support
from Ram. It's better with inotify anyway.
-- 
Duy
