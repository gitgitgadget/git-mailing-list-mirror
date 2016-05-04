From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 4 May 2016 14:21:31 +0200
Message-ID: <CAP8UFD11h4rbLWsx52mze64HANVyXRHDnj_5F9F4FHW63pM5aA@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
	<CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
	<alpine.DEB.2.20.1605041309430.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 14:21:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axvo9-0005Hx-CB
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 14:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbcEDMVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 08:21:33 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38468 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbcEDMVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 08:21:32 -0400
Received: by mail-wm0-f50.google.com with SMTP id g17so90752629wme.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=jZTqqEa8MrXcMc0w4Aj8cAF8sIKG8ni3tUSYNUkDri4=;
        b=zfXkCfW1C8FHsqfGT6nW9u1fboy+n+2jdK7EFlqJfxk50238o0QMBO/meB2/lw4wOb
         Z9REYfTjC5aj5hBMAAQ1x10Tv5ICoU5vOzs749gDsm8vkHrfK6XvNPa7VJLlMkfuWObO
         xPEmFwcJqNGbV2fObl221n9xyx9+wO7QygB2Qd+InDNIOeb+LMmxbZofeaFJkYkcD5pn
         3iH0xfpC8PzEEks7orjTBPxtoXHR1Hl3XaJP1OwgExcWn/JEA/4L96flV/AhiHvEepgg
         aHZ8ERuElJk33YxMDDsxmjwJdvGc1I6PnC0CVB5uBtwASZ0dL3S7RqScXlLP8pOaRCbB
         wY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jZTqqEa8MrXcMc0w4Aj8cAF8sIKG8ni3tUSYNUkDri4=;
        b=ZNCafo4Y/l8QMzT3Uc5TG/5Na39nBZTmcLQ2cy3CzTTf4ikOaznyJplFdnnz+WT+kf
         YxaBxB4s1sakRlJr//KhVF7Z1Si5EwCZOXVLB2FddbejPs3C5MVmnWx/R3jwT3rh/dUn
         jrCEvUEims5s5WYF5ePTK5R+5DB/W2EoDQCvu0uOW5NYhM3GM6FfTpgj4MtnIo9j707b
         E3cg/QO3ApWQiH3hxGLr0GWiHvvAlrxTSLuHsVUR+wWusDiiF5pYnV4wF6KRYOs9pQct
         Zja8U/5nydFaZDbch75o4gvRoB2JDfHy5twbqwdW7hQlNnND0/+uw3Fxq+hFaB0I5dBl
         fS/A==
X-Gm-Message-State: AOPr4FXFuwOImC3Dcgs18XjS+QB2UQs6G+EG34GvZYwUENSQNqj86uJVIyiQWMWwXIoz8tOi5jwS9scdnaVL2w==
X-Received: by 10.195.17.166 with SMTP id gf6mr8269888wjd.124.1462364491484;
 Wed, 04 May 2016 05:21:31 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Wed, 4 May 2016 05:21:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605041309430.9313@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293546>

On Wed, May 4, 2016 at 1:13 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
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

Yeah or maybe:

                    while ((match = va_arg(matches, const char *)) != NULL)
                            if (!strcmp(term, match)) {
                                    res = 1
                                    break;
                            }

>                 va_end(matches);
>
>                 return res;
>         }
