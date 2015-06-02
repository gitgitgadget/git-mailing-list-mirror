From: =?UTF-8?Q?R=C3=A9mi_Lespinet?= <remi.lespinet@gmail.com>
Subject: Re: [PATCH 2/2] send-email: allow multiple emails using --cc, --to
 and --bcc
Date: Tue, 2 Jun 2015 10:26:11 +0200
Message-ID: <CA+V2YBvP89=b5SFbkUVnEzaPT2aCiK9XN1Hd6qsN8HCmxxB+GA@mail.gmail.com>
References: <1433168042-28269-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433168042-28269-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<xmqqiob78nij.fsf@gitster.dls.corp.google.com>
	<xmqqmw0j74mg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 10:26:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzhWt-0004BB-6d
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 10:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbbFBI0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 04:26:24 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32909 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbbFBI0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 04:26:12 -0400
Received: by qkhg32 with SMTP id g32so97181083qkh.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BUPX1TxOeeW4WmgU1zhasfPIwT1nDWUgf/Zv3cfpAQ4=;
        b=LtAaje7SFFu1RoI26z4BshXdpMPfhBpvNrqioijufl9vGEqiHBNcHl2MtcZHcLbcdj
         IkwF9Lt64GHAYrONZ6nTAqgrULH8QhJROq72zoBRjcFmHxZZQIL8/nJFFTZ8TTNQ5sVz
         MN1+VDo17EDsdNzlYJOcOA7DEo85CjYYAZw3HwTw2VSfhdNiP6mkClqbTzY73RxoHemv
         nz6gs18X0uC3bN44uYpPc5n1qzOUp/NJPxuvHkHkLpv/XqZfPsjUfVxaCjVRZfe/rIhl
         aS+8ZYW5DDFkgz+Ypy2hSGl+IEeMND+NGXoFbd3lX0kERi0GXuLovoSlJ3B05SaQwV92
         kD8w==
X-Received: by 10.140.216.18 with SMTP id m18mr29049004qhb.19.1433233571760;
 Tue, 02 Jun 2015 01:26:11 -0700 (PDT)
Received: by 10.96.149.199 with HTTP; Tue, 2 Jun 2015 01:26:11 -0700 (PDT)
In-Reply-To: <xmqqmw0j74mg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270508>

Junio C Hamano <gitster@pobox.com> writes:

> The reason why we have the "verify the input" thing, allow users to
> supply multiple --to/--cc/etc., and do not try to split the
> addresses ourselves is because we want to avoid mistakenly splitting
> a single address like the above into two and producing syntactically
> incorrect addresses.  People have relied on the current behaviour
> for a long time, without manually dropping comma when they send
> their patches with --to='"Jane, Doe" <jdoe@example.com>'.

Yes, but they couldn't send with --to='"Jane, Doe" <jdoe@example.com>'
anyway since 79ee555b (Check and document the options to prevent
mistakes. 2006-06-21).  So I don't think that this part is a
regression. However when the user input is incorrect and contains
comma, the mail will be sent to the syntaxically valid addresses which
have been extracted and this would have failed without sending before
this patch. I agree that this part is not a desirable behavior.
If I fix that, would it be ok for you?

2015-06-01 18:52 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>>
>>> Accept a list of emails separated by commas in flags --cc, --to and
>>> --bcc.  Multiple addresses can already be given by using these options
>>> multiple times, but it is more convenient to allow cutting-and-pasting
>>> a list of addresses from the header of an existing e-mail message,
>>> which already lists them as comma-separated list, as a value to a
>>> single parameter.
>>>
>>> The following format can now be used:
>>>
>>>     $ git send-email --to='Jane <jdoe@example.com>, mike@example.com'
>>>
>>> However format using commas in names doesn't work:
>>>
>>>     $ git send-email --to='"Jane, Doe" <jdoe@example.com>'
>>
>> That looks as if you are doing "Remi, Lespinet", which is not a good
>> example.  I think you want "Doe, Jane", the use of comma is when a
>> name is spelled in the "LastName, FirstName" order.
>
> Having thought about this topic (not how the example should be
> spelled in the log message ;-) a bit more, I do not think the
> implementation of split_address_list_items in this patch is
> acceptable.
>
> The reason why we have the "verify the input" thing, allow users to
> supply multiple --to/--cc/etc., and do not try to split the
> addresses ourselves is because we want to avoid mistakenly splitting
> a single address like the above into two and producing syntactically
> incorrect addresses.  People have relied on the current behaviour
> for a long time, without manually dropping comma when they send
> their patches with --to='"Jane, Doe" <jdoe@example.com>'.
>
> Until we can reliably split the address list, accepting this patch
> will introduce a regression.
>
> Note that I do agree with the goal of this series and appreciate the
> effort.  I am only rejecting the current implementation of
> split_address_list_items().
>
> Thanks.
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
