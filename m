From: Eric Curtin <ericcurtin17@gmail.com>
Subject: Re: Initial git clone behaviour
Date: Wed, 6 Jan 2016 23:24:32 +0000
Message-ID: <CANpvso4NZZcAYfQZPt0i2G+MWD4ppga0XQZwYDhq1syA2f1GJw@mail.gmail.com>
References: <CANpvso58uPtMcz_L0D=WBcCj+mSLLYZ5LpfO1i5yLo-jrb6bsA@mail.gmail.com>
	<CAPc5daXeNay1uF=qQ=G82kyu37uHhy-uEOWU6tz_bPYfFam=rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 00:24:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGxRV-0003fe-DA
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 00:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbcAFXYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 18:24:34 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35745 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbcAFXYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 18:24:33 -0500
Received: by mail-wm0-f47.google.com with SMTP id f206so77381597wmf.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 15:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s+I2ip2Yn2lPz6KHfK1oNdWh6AQJrMNsppqsl+LNhYo=;
        b=YYUBn4+q+R4BNg12Bp1K2+0E7tpw+xKOczN6J0XmTP+A/Z3UgZZVD5nHmfTVqedgbM
         MKdOQRHAM/AJhsUlh1Woft2KzK5+pRl3N7Hgm8LwCPwRG6EVGQ1mbubMmDV8vL0P8Typ
         X3OwX/EvMPD556cLh4W/e5JGgr66jYEsDbsWQv39APsBVymo1QTRIvzY0sI5fdqkvWtJ
         dq8NBGQAAriQoAh8u1pOuojKmsRXbwQQGqGdZtA3onYAJhA9AOWERPls9tDrsI9Dyz9X
         TmsU7akPH17QbY5L6kPJ/yEq0wEQ62M8Y+MM6P/ZIQ0OoDdNlpWK7BwATHqsZvIMO8C+
         iNwg==
X-Received: by 10.194.161.166 with SMTP id xt6mr71127888wjb.98.1452122672046;
 Wed, 06 Jan 2016 15:24:32 -0800 (PST)
Received: by 10.27.217.211 with HTTP; Wed, 6 Jan 2016 15:24:31 -0800 (PST)
In-Reply-To: <CAPc5daXeNay1uF=qQ=G82kyu37uHhy-uEOWU6tz_bPYfFam=rA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283457>

On 6 January 2016 at 23:14, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Jan 6, 2016 at 2:26 PM, Eric Curtin <ericcurtin17@gmail.com> wrote:
>>
>> Often I do a standard git clone:
>>
>> git clone (name of repo)
>>
>> Followed by a depth=1 clone in parallel, so I can get building and
>> working with the code asap:
>>
>> git clone --depth=1 (name of repo)
>>
>> Could we change the default behavior of git so that we initially get
>> all the current files quickly so that we can start working them and
>> then getting the rest of the data? At least a user could get to work
>> quicker this way. Any disadvantages of this approach?
>
> It would put more burden on a shared and limited resource (i.e.
> the server side).
>
> For example, I just tried a depth=1 clone of Linus's repository from
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> which transferred ~150MB pack data to check out 52k files in 90 seconds.
>
> On the other hand, a full clone transferred ~980MB pack data and it took
> 170 seconds to complete. You can already see that a full clone is highly
> optimized--it does not take even twice the time of getting the most recent
> checkout to grab 10 years worth of development (562k of commits).
>
> This efficiency comes from some tradeoffs, and one of them is that not
> all the data necessary to check out the latest tree contents can be stored
> near the beginning of the pack data. So "we'll checkout the tip while the
> remainder of the data is still incoming" would not be a workable, unless
> you are willing to destroy the full-clone performance.

Ok, my internet connection at home is pretty terrible then! I don't get
nowhere near these timings. It takes over an hour to do a full clone
from my house. And approx 30 mins for the depth=1 (approx, did not time
it).

That all makes sense I guess, probably not a good idea to regress the
full time performance for the sake of this use case. Was just a query
really!
