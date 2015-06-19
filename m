From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/19] fsck: Report the ID of the error/warning
Date: Fri, 19 Jun 2015 16:26:16 -0700
Message-ID: <CAPc5daUm=h0+itLR-QcL2tMbeQ+oUe5p9Ki8qAsj47OFRX4LTw@mail.gmail.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de> <d0c24a7643acd3a1a17ab3abf0ba54ab352b3e41.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqvbej7b13.fsf@gitster.dls.corp.google.com> <118145527541c82e33599259c8e3e050@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 20 01:26:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z65gW-0004M4-GT
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 01:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133AbbFSX0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 19:26:43 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34086 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbbFSX0h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 19:26:37 -0400
Received: by oigx81 with SMTP id x81so90262503oig.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 16:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3s8OKj06bUp4DuH3IU9B4kOR1gCJRB3zZIJ87CJzrMY=;
        b=IRIkXWrx4kE354tDahwpjpjhwJUB0zZffYQH2WkvgZcZRUzyYvIkd514TOCB9Szna4
         btYrOSSs9v1dJhAOkGuvyuTq0fn6zfLAQizGQNYsfd+omRfWMSbAhU9BTNjMt2qYer4Y
         7W6SMcAyLxZLiFFDPsEKkJnOkrkjUzDIxWvAJ0214biOgRCpJtg5x1KbUQOpXWZU0kbb
         pemUf/gHvovlafA8R512O4Oqu1kPesOLkil/LlCroYLvgJfruWQhp8m69AU9kiz8xCcG
         EKo76+YMnT2GcI8v5N8nGs4uteffrLsetTa1rGtHPP0GYchtsCLPxbM/XumOabkcmfjy
         m2Mg==
X-Received: by 10.182.230.67 with SMTP id sw3mr15756191obc.0.1434756396356;
 Fri, 19 Jun 2015 16:26:36 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Fri, 19 Jun 2015 16:26:16 -0700 (PDT)
In-Reply-To: <118145527541c82e33599259c8e3e050@www.dscho.org>
X-Google-Sender-Auth: 47FdbkYJG_Z-ngBppUUAh_l2K6E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272215>

That "... can be made ..." was not my wish but more like "the way the
code is structured it is possible for somebody to do such a thing
easily, well done" compliment ;-)

The message names will have to be shown somewhere in the
documentation, and in Documentation/ we try to use camelCase to show
the word boundary; it would be better to match that, as this output is
meant to be used there.

On Fri, Jun 19, 2015 at 2:34 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Junio,
>
> On 2015-06-19 21:28, Junio C Hamano wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> Some legacy code has objects with non-fatal fsck issues; To enable the
>>> user to ignore those issues, let's print out the ID (e.g. when
>>> encountering "missingemail", the user might want to call `git config
>>> --add receive.fsck.missingemail=warn`).
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>  fsck.c          | 16 ++++++++++++++++
>>>  t/t1450-fsck.sh |  4 ++--
>>>  2 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fsck.c b/fsck.c
>>> index 8e6faa8..0b3e18f 100644
>>> --- a/fsck.c
>>> +++ b/fsck.c
>>> @@ -190,6 +190,20 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
>>>      }
>>>  }
>>>
>>> +static void append_msg_id(struct strbuf *sb, const char *msg_id)
>>> +{
>>> +    for (;;) {
>>> +            char c = *(msg_id)++;
>>> +
>>> +            if (!c)
>>> +                    break;
>>> +            if (c != '_')
>>> +                    strbuf_addch(sb, tolower(c));
>>> +    }
>>> +
>>> +    strbuf_addstr(sb, ": ");
>>> +}
>>> +
>>>  __attribute__((format (printf, 4, 5)))
>>>  static int report(struct fsck_options *options, struct object *object,
>>>      enum fsck_msg_id id, const char *fmt, ...)
>>> @@ -198,6 +212,8 @@ static int report(struct fsck_options *options, struct object *object,
>>>      struct strbuf sb = STRBUF_INIT;
>>>      int msg_type = fsck_msg_type(id, options), result;
>>>
>>> +    append_msg_id(&sb, msg_id_info[id].id_string);
>>
>>
>> Nice.  The append function can be made a bit more context sensitive
>> to upcase a char immediately after _ to make it easier to cut and
>> paste into "git config" and keep the result readable, I think.
>>
>>       git config --add receive.fsck.missingEmail=warn
>
> Okay. I camelCased the IDs; it is a bit sore on my eyes in the command-line output, and the config variables are case-insensitive, anyway, but your wish is my command... I changed it locally, it will be part of v7.
>
> Ciao,
> Dscho
