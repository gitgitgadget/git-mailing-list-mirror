From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 4 May 2016 17:30:10 +0530
Message-ID: <CAFZEwPMM9vg7pAZwqwaC2HUWo+xnq3X6SrTQEUc20bs_nbzMmw@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
	<CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
	<alpine.DEB.2.20.1605041309430.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 14:00:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axvTV-0003Yh-FN
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 14:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbcEDMAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 08:00:13 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34342 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbcEDMAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 08:00:11 -0400
Received: by mail-yw0-f181.google.com with SMTP id j74so74159277ywg.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=IXo9iLhrbzxqmIJ7U1xtCanPl2GuPWFZCr3jKBAUSQI=;
        b=fMpFasSbWYlCMczRP4b+d6wQx9Qsp/44lF7c5nFgcjQnaeSZbF3dPxbuFmy7R9EzMi
         wi98aqwG4vMmqLWzJmyQLIIe9bKXq6fAj6Eyy39KVD9Ad4DsadKeYKcOSJZzaQGFp/r2
         P+KRNIYRQrcYylEOg3a0YD+/HszfzaW7uvblZBYXG+RSs9IqyJTty2cDgezJXdz86BgX
         Ito3l8Yy2am8xUddbxi/8BVLECsKzUZOEfKAIfrRg+u9Hg788u/wX9iuMQW+EMq38ZXt
         Hblkd7xJnq9E16G2+1KICGlNjx++Nsw/AcjUfyQ2dumHW1Ed3OOqS51HSCyuc/esibMa
         0dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IXo9iLhrbzxqmIJ7U1xtCanPl2GuPWFZCr3jKBAUSQI=;
        b=aYJmhZQZYA6w38Wd9/KBiIDNKDoYGiFEI4F8e+2FPxQFH7LZeCy4i18pY8pTaW3nDC
         3WaIB4eaocLXKC+YTjXQBTmNG2oHw+psBLUDXh/qwSSKz5dOH6wTEmt6hWdDZFi8ZAxB
         i05LSdl1c6BpYQyF9nFG3yZY15aiUuklE17AmEOWRD0oM0KOyusbWXGnWmydD/VXhfVO
         Xk0nuqarR5IMcQ6bFnoHkQnbEEuIjZlIbU8W+a84cdETVM7TPXM3XDL+3DicVPktbw0s
         ra/sdQTvtcOZyr0A0IAwBHY1FusiSX2BzHj/Vf5rfbxStyytW3B6813jSkp+NaWP1GMH
         2BnA==
X-Gm-Message-State: AOPr4FWsgyUSa0s6NTeZ3XM/mNslLEQByzM1aubqPd9iZJJjhF1X74+lFwfK7k42ItkeafZzE65WF13JnO2Irg==
X-Received: by 10.37.118.200 with SMTP id r191mr1165135ybc.80.1462363210946;
 Wed, 04 May 2016 05:00:10 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Wed, 4 May 2016 05:00:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605041309430.9313@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293543>

On Wed, May 4, 2016 at 4:43 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Pranit,
>
> On Wed, 4 May 2016, Pranit Bauva wrote:
>
>> On Wed, May 4, 2016 at 12:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> >
>> >> +static int one_of(const char *term, ...)
>> >> +{
>> >> +       va_list matches;
>> >> +       const char *match;
>> >> +
>> >> +       va_start(matches, term);
>> >> +       while ((match = va_arg(matches, const char *)) != NULL)
>> >> +               if (!strcmp(term, match))
>> >> +                       return 1;
>> >
>> > Is it wise to return here without invoking va_end()?
>>
>> I guess since it already checks for NULL, invoking va_end() will make
>> it redundant[3].
>
> Actually, this is my fault (I suggested that form of the one_of()
> function). The man page for va_end() clearly states that every call to
> va_start() needs to be paired with a corresponding va_end(), so it is
> incorrect to return without a call to va_end().
>
> Maybe something like instead?
>
>         static int one_of(const char *term, ...)
>         {
>                 int res = 0;
>                 va_list matches;
>                 const char *match;
>
>                 va_start(matches, term);
>                 while (!res && (match = va_arg(matches, const char *)))
>                         res = !strcmp(term, match);
>                 va_end(matches);
>
>                 return res;
>         }
> Ciao,
> Dscho

Thanks for this. I had little idea about variable arguments before. I
have searched it now. Will use your bits.
