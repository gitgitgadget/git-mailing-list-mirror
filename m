From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 10:38:54 -0700
Message-ID: <CAGZ79kaJmy4EijFuLCXOzPbi3EoqSwarFj3_3r+ghUwVA+88Mg@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-3-git-send-email-sbeller@google.com>
	<CAPig+cQKOEYYR3j-uEeFzF3-qAfqq4SdQrH8LPmSP0VmAOCtzw@mail.gmail.com>
	<xmqqh9mm5tus.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 22 19:39:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeRX7-0000Tq-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 19:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758553AbbIVRjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 13:39:08 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34024 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbbIVRjH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 13:39:07 -0400
Received: by ykdg206 with SMTP id g206so16897643ykd.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1yVb2d9yxwCC5KCH9ltQ6Uw2DJWU8yOyxTcFFSaoUyE=;
        b=otJizDery8wodb/TfwkL/dzJnOFta01WS6GTBuZhioP90mQFEV6s3OOBPT4e/I/uNN
         NKuQ+M5nf7jkofhkiTfUv7rhEfsqoQayqIQUXWDftzEA/6/musie3Bq2SMEshCWkO9qu
         u9D2DbBMbEPVKePy3HpWcxT0S6x8uIs/VvjlOhtpgL/edq7vcGsum3/qzC+BU1dU8iNp
         LgMVkQwdbPccFi78lsFMX0i//AvUTwKOr0I2gVsJo9JsBcnngvSukuIG7xOIorxsBoKo
         yZCcoPUbFn08cJpMxG1nTsK2JippoZcx2zMJlvL+A/WI3vY0TXh52mh9Rztd1GJ9XeCY
         jB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1yVb2d9yxwCC5KCH9ltQ6Uw2DJWU8yOyxTcFFSaoUyE=;
        b=f0JaQgEH/OvX1S9LEJPmsuKKF8rLAxZLdm00B2+sQa1XwnZUsdVYPt4TPHMJZcyeVl
         Hj7pGfRrBzW2X+/zPmvezvflMb2XYqAfEohjuFw8OU7P3B6hOK0NOFUZYweE1mrtZU7K
         phxaRYarjHrWyRQ8syc0WHX0Tou9k1KSgwcBwN1xExs/tZ6rAn4zXUbrVuCLcHEiWMKx
         u6F6OygZeTb5+DEVyGsts3j4fBb7HByaM3C1syYfprGhcVkxtbgG8BFBAs2riATRZxXY
         8xO6OubLOo+u0PwmT4zoXLytQrMLTFYPGIdSTJf2aljCXCSrVe1NnmGkVWQnwtERX1bg
         UTdA==
X-Gm-Message-State: ALoCoQlOzrUyg47sW0Sgv09UW3ePyH7JtX0FBiqMAld43Cf301SI04YCzh0sOAPQsQ+m07eD15J2
X-Received: by 10.170.210.65 with SMTP id b62mr20952388ykf.10.1442943534996;
 Tue, 22 Sep 2015 10:38:54 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 22 Sep 2015 10:38:54 -0700 (PDT)
In-Reply-To: <xmqqh9mm5tus.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278404>

On Tue, Sep 22, 2015 at 8:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>>         while (1) {
>>>                 nr = read(fd, buf, len);
>>> -               if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
>>> -                       continue;
>>> +               if (nr < 0) {
>>> +                       if (errno == EINTR)
>>> +                               continue;
>>> +                       if (errno == EAGAIN || errno == EWOULDBLOCK) {
>>> +                               struct pollfd pfd;
>>> +                               int i;
>>> +                               pfd.events = POLLIN;
>>> +                               pfd.fd = fd;
>>> +                               i = poll(&pfd, 1, 100);
>>
>> Why is this poll() using a timeout? Isn't that still a busy wait of
>> sorts (even if less aggressive)?
>

True. Maybe we could have just a warning for now?

    if (errno == EAGAIN) {
        warning("Using xread with a non blocking fd");
        continue; /* preserve previous behavior */
    }

I think I am going to drop this patch off the main series and spin it out
as an extra patch as the discussion is a bit unclear to me at the moment
where we're heading.

> Good point.  If we _were_ to have this kind of "hiding issues under
> the rug and continuing without issues" approach, I do not think we
> would need timeout for this poll(2).  The caller accepted that it is
> willing to wait until we read up to len (which is capped, though) by
> not calling the nonblocking variant.
