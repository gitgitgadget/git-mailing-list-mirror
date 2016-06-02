From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 15:53:14 -0700
Message-ID: <CAGZ79kYL_47ptjK1S++Z=JUBOQtG1MJS=h0i=9f3fzRmbZDf-g@mail.gmail.com>
References: <20160602213015.21712-1-sbeller@google.com> <xmqqr3cfs1dp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:53:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8bUO-0000Rl-On
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 00:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880AbcFBWxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 18:53:17 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34630 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbcFBWxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 18:53:16 -0400
Received: by mail-qk0-f175.google.com with SMTP id s186so14115565qkc.1
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 15:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8xsqeHJlN+6d3SaAXV1Dicsw8rPOBsLsmymIq5dq5So=;
        b=eKIq28RvHN+ccdew43fOJbXTg3+RPmq9p2bZi9F+xDl+uMbhVTq9OhaNVpn8qsmY0U
         z26flQ+iFNnukBsYGYjkxAeMqDwr4nQHAwHCJSdBO4TQf8fyBaLA1NIgjpMRfSRauCPV
         U2AxTN69GUT1fFujwYf0ElSbe/BQ7M8huw0zMjmzKIWRp/0tqkhJgG98N8Z81GH7nxc+
         0rgjnsGr6Ft7d7DGtSNlK0tGI09eB0JAsZa2k65jj4C9lzfvpppvBsrBuNcqI9kH2Xwl
         D2YLPEmKASoVRUXWsoNuSX+X6/diD2rHttoS2SdoMbPLUNZl+ytbTR+t7w1tHcxbYBK3
         ZC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8xsqeHJlN+6d3SaAXV1Dicsw8rPOBsLsmymIq5dq5So=;
        b=DWBCJq/wAW2WUxjzCJ7NREUvhdZWj/Ym0q7NmhkTvDAALEkk7unmWRiFurxcAvuu3C
         VKyckK7/GD92lymOzEBuRNqQCAiCfIQPhAe+iAfCiBGauKQWGxxWw82R5h5lBHEMGjf4
         fl9IqybQWx/2MkUOqdt/Qj8JG5LMUaVzoBvwQ3so3ms0EMFyYco3ZlYau0csLWArVU7i
         5/m4lQkVikUkVl90ewLhZ1rlm4luD/SjXPnCV40BeXjXthtGbTVqTW2D77ejGxCSDZ6K
         y/93eTqD9SYDXNtdDwWiAyXCogrRCQjlletBXhmsuOq7SLBBF+COL4js7lEcFYcLacVY
         /XJw==
X-Gm-Message-State: ALyK8tIwsZpAD6OcmRgj0lH+IRPPz+VjUdf5ndogBhNGcW325ZLn8dcTFLrPbQAwIClX0EPNZ335hrHULMQDDI9o
X-Received: by 10.233.237.14 with SMTP id c14mr564319qkg.88.1464907995401;
 Thu, 02 Jun 2016 15:53:15 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Thu, 2 Jun 2016 15:53:14 -0700 (PDT)
In-Reply-To: <xmqqr3cfs1dp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296252>

On Thu, Jun 2, 2016 at 2:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In our own .gitattributes file we have attributes such as:
>>
>>     *.[ch] whitespace=indent,trail,space
>>
>> When querying for attributes we want to be able to ask for the exact
>> value, i.e.
>>
>>     git ls-files :(attr:whitespace=indent,trail,space)
>>
>> should work, but the commas are used in the attr magic to introduce
>> the next attr, ...
>> ...
>> So here is the "escaping only, but escaping done right" version.
>> (It goes on top of sb/pathspec-label)
>
> The phrase "should work" is probably a bit too strong (I'd have said
> "it would be nice if this worked"), as we do not have to even
> support comma for our immediately expected use cases.  Allowing it
> merely makes a casual test using our own .gitattributes easier.
>
>> +static size_t strcspn_escaped(const char *s, const char *reject)
>
> Perhaps s/reject/stop/?
>
>> +{
>> +     const char *i, *j;
>> +
>> +     for (i = s; *i; i++) {
>> +             /* skip escaped the character */
>> +             if (i[0] == '\\' && i[1]) {
>> +                     i++;
>> +                     continue;
>> +             }
>> +             /* see if any of the chars matches the current character */
>> +             for (j = reject; *j; j++)
>> +                     if (!*i || *i == *j)
>> +                             return i - s;
>
> I somehow doubt that *i can be NUL here.  In any case, this looks
> more like
>
>         /* is *i is one of the stop codon? */
>         if (strchr(stop, *i))
>                 break;
>
>> +     }
>> +     return i - s;
>> +}
>
>> +static char *attr_value_unescape(const char *value)
>> +{
>> +     char *i, *ret = xstrdup(value);
>> +
>> +     for (i = ret; *i; i++) {
>> +             if (i[0] == '\\') {
>> +                     if (!i[1])
>> +                             die(_("Escape character '\\' not allowed as "
>> +                                   "last character in attr value"));
>> +
>> +                     /* remove the backslash */
>> +                     memmove(i, i + 1, strlen(i));
>> +                     /* and ignore the character after that */
>> +                     i++;
>> +             }
>> +     }
>> +     return ret;
>> +}
>> +
>
> Repeated memmove() and strlen() somehow bothers me.  Would there be
> a more efficient and straight-forward way to do this, perhaps along
> the lines of this instead?

Thinking about efficiency, I have the believe that memmove can be faster
than a `*src=*dst` thing we do ourselves as it may have access to specialized
assembly instructions to move larger chunks of memory or such.

So I think ideally we would do a block copy between the escape characters
(sketched as:)

    last = input
    while input not ended:
        current = find next escape character in input
        memcpy from input value in the range of last to current
        last = current + 1
    copy remaining parts if no further escape is found

It doesn't seem worth the effort to get it right though.

>
>         const char *src;
>         char *dst, *ret;
>
>         ret = xmalloc(strlen(value));

xmallocz at least?

>         for (src = value, dst = ret; *src; src++, dst++) {
>                 if (*src == '\\') {
>                         if (!src[1])
>                                 die();
>                         src++;
>                 }
>                 if (*src && invalid_value_char(*src))
>                         die("cannot use '%c' for value matching", *src)
>                 *dst = *src;
>         }
>         *dst = '\0'
>         return ret;
>

Thanks,
Stefan
