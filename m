From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v7 4/4] notes: teach git-notes about notes.<ref>.mergestrategy
 option
Date: Fri, 14 Aug 2015 15:50:36 -0700
Message-ID: <CA+P7+xofitJ2tTxqtRyWitcSKt4sKZCH5tygJxXScuW8wkW=SA@mail.gmail.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
 <1439586835-15712-5-git-send-email-jacob.e.keller@intel.com>
 <xmqq8u9dh6lq.fsf@gitster.dls.corp.google.com> <CAPig+cTxmFCRChzahQZVpMeJ=3N0PjHAcamFBm394OgTR8LnLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:51:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQNoS-0006WA-Nl
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 00:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbbHNWu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 18:50:56 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34889 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbHNWu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 18:50:56 -0400
Received: by iodt126 with SMTP id t126so100045388iod.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+ozrTZ8UaLJCYA31VIx/49rr59tPhMub+UhjZtVfXu0=;
        b=DpOU1UDDDei6igigs7r4WGa7cELKqjUUksP7PCbFsx8yRTHJoEE9NH16lCYmPmGf4e
         nbXIMLKRirw8br5OcwTZOIImIbsTP7ip4mbwJow3xRYWfljIPFPmEDBjRcu2lYWUJQ1b
         xrm8VbyfeBnNcKRtTt9dNjUYtXIK3P2YmKF0dUM004nCaJfdNp5N3AZQUt47fyWfaj7j
         DzE9Z/nEOvYg6TYsP9sfmjgkCNjOQ3Av9WBaUONR9rN6wsr4phHqg4sCH9N5eAQwUqNU
         aD2O149ryByLGBRHuIDgGJfsGtNcUYJTztqwkiV8rfR2mr5GX8lSEyUJQ5W7dHjWTlLO
         9XUA==
X-Received: by 10.107.154.67 with SMTP id c64mr3757042ioe.0.1439592655694;
 Fri, 14 Aug 2015 15:50:55 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Fri, 14 Aug 2015 15:50:36 -0700 (PDT)
In-Reply-To: <CAPig+cTxmFCRChzahQZVpMeJ=3N0PjHAcamFBm394OgTR8LnLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275972>

On Fri, Aug 14, 2015 at 3:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Aug 14, 2015 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>> diff --git a/builtin/notes.c b/builtin/notes.c
>>> index 12a42b583f98..bdfd9c7d29b4 100644
>>> --- a/builtin/notes.c
>>> +++ b/builtin/notes.c
>>> +             strbuf_addf(&merge_key, "notes.%s.mergestrategy", short_ref);
>>> +
>>> +             if (git_config_get_notes_strategy(merge_key.buf, &o.strategy))
>>> +                     git_config_get_notes_strategy("notes.mergestrategy", &o.strategy);
>>>       }
>>
>> I think you are leaking merge_key after you are done using it.
>
> In addition to fixing the leak, since 'merge_key' is only used within
> this block, it might also make sense to declare it in this block
> rather than at the top of the function.

I can do that.

How do you feel about having the duplicate check for the short_ref? We
*already* check this inside init_notes_check() which is called right
after this.

I think that we should keep it but can't find a consistent way to
avoid the duplication.

In addition, we already provide the tests for merging into and from
non-notes refs.

Regards,
Jake
