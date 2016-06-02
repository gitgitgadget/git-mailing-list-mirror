From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 16:41:20 -0700
Message-ID: <CAGZ79kas0EdQd4MJUOVFJYfm0-yaDQhJgCBpKQk5m4UrsjPBwg@mail.gmail.com>
References: <20160602231413.9028-1-sbeller@google.com> <xmqqwpm7qio2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:41:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8cFI-0004mC-O0
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 01:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbcFBXlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 19:41:23 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34322 "EHLO
	mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbcFBXlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 19:41:22 -0400
Received: by mail-qt0-f169.google.com with SMTP id q45so7584719qtq.1
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cat5I1+sNsqj6JP2Uuzy8VHMwFbhJjzhdMgSHcbw4W4=;
        b=FIMe1Y6moS3YVJ6Lz4PMydXTW6J96LZa6b8xpsNketjYDlRPFW00OXBE51M03ENdm7
         HFKy5SOa1Bak3cSBtwSZJ5pZFzy2ijnWWwVSoD+KlbJjd7BE0wedg3MfbPyCC+R8zIIT
         GIogjnptwoVWXfiZydXxFyXb/xjmctgBCG8LnwVg6Vco4Y9YEAzGSTRnbo1WN+qWzwBu
         jTyoEIOuIyhGq8YPT5pYBHq2h/m3UGv+9wGD6IFkCD9Gcd6mp4BJD5RQh3+f9Z+C2S/B
         4Phht/+KadCwD5M6V7qDkr25lZsYYIi9746vzW3db/S2+lk56f+ct8zXeR+PPzODkWJT
         4yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cat5I1+sNsqj6JP2Uuzy8VHMwFbhJjzhdMgSHcbw4W4=;
        b=FtauOTFP5tn7q6QKd+Ki4FhpqB5X4Hng/CaQFiUcmuE7Igx3UxiJsy0d89Fna682/X
         qj2M5PWNCZYQMw7RtTaac0CyCZx8TTYfwT7ioqflff4jGlzdrcQxe8F16n5B5CQFSkSl
         fi4yoFRseqU/aJPNVHql8R74PF6yS0YMYu0TuAOem0M+SohSCwH2HSGkXoK8peBC9pah
         xqrWrVmVmnhwfJmpFlGUsWwnj/ulY0zJ5d0BkPdkY4kI/xEfninJtnYxmd3TJyeFbeNl
         bxHVLgFmViEo393CJCpVo5P9NukECR5EmXltSzd9jA+H7RcFulTmm3Y/g2ZZ5AtkBMN/
         lJgQ==
X-Gm-Message-State: ALyK8tIhwnOLzkdyZhfcFMSbHgdbI0bG4gT4bF3lOo1a30z2IKj9GLDYZjLxMJmiipWGqIRRQlQ5+Ja9H6veNTmJ
X-Received: by 10.200.51.165 with SMTP id c34mr716521qtb.48.1464910881436;
 Thu, 02 Jun 2016 16:41:21 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Thu, 2 Jun 2016 16:41:20 -0700 (PDT)
In-Reply-To: <xmqqwpm7qio2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296263>

On Thu, Jun 2, 2016 at 4:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> However if we add a value restriction here, we need to be as strict in the
>> .gitattributes parsing as well and put a warning there (similar to
>> invalid_attr_name_message) I would think.
>
> Remember, the attribute system is used for many purposes other than
> this new "further limit pathspec".

Right, and in the past we followed a rigid pattern of non-crazy values.
The crazy values will show up once users realize they can
put anything they want into the .gitattributes to query for files.

Before this labeling change, there was no need to put anything
other the officially documented values into the attribute files.

> So I do not think it is necessary or even beneficial to add such a
> warning.

Ok.

>
>> +static char *attr_value_unescape(const char *value)
>> +{
>> +     const char *src;
>> +     char *dst, *ret;
>> +
>> +     ret = xmallocz(strlen(value));
>> +     for (src = value, dst = ret; *src; src++, dst++) {
>> +             if (*src == '\\') {
>> +                     if (!src[1])
>> +                             die(_("Escape character '\\' not allowed as "
>> +                                   "last character in attr value"));
>> +                     src++;
>> +             }
>> +             if (*src && invalid_value_char(*src))
>> +                     die("cannot use '%c' for value matching", *src);
>> +             *dst = *src;
>> +     }
>> +     *dst = '\0';
>> +     return ret;
>> +}
>
> Please sanity-check me.  Just like I said to your original "I doubt
> *i could be NUL here", I now doubt *src could be NUL there where
> invalid_value_char() gets called.
>
> If *src could be NUL there, then *dst gets NUL once, and then after
> loop exits (presumably after incrementing dst), *dst gets another
> NUL, which was the terminating NUL condition being iffy I mentioned,
> but as you said, I do not think it would happen, so we can lose the
> "*src && " before invalid_value_char() is called.

Right, we can lose the *src check before invalid_value_char
as that ought to be caught in  if (!src[1]) die(...) before.

Thanks,
Stefan

>
> Thanks.
