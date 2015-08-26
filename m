From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Wed, 26 Aug 2015 07:37:48 -0700
Message-ID: <xmqq6142w1xf.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<vpqzj1hkc5q.fsf@anie.imag.fr>
	<xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
	<xmqqy4h01egr.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZQwW9hpg4p8+DE2oZA28Av7mLrqAhEdcro=esuqHe35Xg@mail.gmail.com>
	<xmqqzj1fxjpj.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZSu7XyZhWUL=25dnkiGm2mNDyFhXwS_JqudyfKPE5sisQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 16:37:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUbpr-0006t1-KW
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 16:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589AbbHZOhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 10:37:51 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33484 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbbHZOhu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 10:37:50 -0400
Received: by pacti10 with SMTP id ti10so90222860pac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yKrTEkOOojeokBweT8IgOKe5tS16ktB1o3fenVJa4CQ=;
        b=UEN31oncScYJL/AvDC+6VNmxokHzvVSDG6MAgMnjxYIKixPgCXnyI2jlnmMdXlfUfm
         u91DTjHt+ZArpLKrZH1BXmU9gw2lJv0Rb11IVmHo+JNfsA+EmcMxIySkH6EyMcMcDIaU
         c+tTkvBxNEmx7iNBVzMmZbtxmkZ3zKphdYPS+N14cOlIfj1b04a4YtIC3DsgtAGpcLD9
         7AjqLLn524xklZ+b9g7ZHxeClm0GPLCOFGzJgV87hPrYEX4bkHolXJcQTqiLfe52YVa6
         Io6cHUKMVkIyj3x830FtARmNIbK9C0cCDu/rczy8h71Hi/nh/Y2lITE8wTpQLsXT7kmT
         n9DQ==
X-Received: by 10.66.243.225 with SMTP id xb1mr70090545pac.78.1440599870034;
        Wed, 26 Aug 2015 07:37:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id u10sm24960527pbs.16.2015.08.26.07.37.48
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 07:37:48 -0700 (PDT)
In-Reply-To: <CAOLa=ZSu7XyZhWUL=25dnkiGm2mNDyFhXwS_JqudyfKPE5sisQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 26 Aug 2015 11:26:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276607>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Aug 26, 2015 at 12:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> I didn't check how wide the original is supposed to be, but perhaps
>> changing builtin/tag.c this way
>>
>>                 if (filter->lines)
>> -                       format = "%(align:16,left)%(refname:short)%(end)";
>> +                       format = "%(align:15,left)%(refname:short)%(end) ";
>>                 else
>>                         format = "%(refname:short)";
>>         }
>>
>> may be one way to fix it.  Check the original "tag -l" output for
>> tags whose names are 14, 15, 16 and 17 display-columns wide and try
>> to match it.
>
> That should be the fix, since it's a space problem.
> ....
> The problem with doing this is, the lines need to be displayed
> immediately after  the refname,
> followed by a newline, what you're suggesting breaks that flow.

That is only because show_ref_array_item() does too much.  The
function is given a placeholder string and a set of data to fill the
placeholder with for an item, and the reason why the caller
repeatedly calls it, once per item it has, is because it wants to
produce a one-line-per-item output.  An alternative valid way to
structure the API is to have it format into a string and leave the
printing to the caller.  You can give a new format_ref_array_item()
that does not print but fills a strbuf to this caller, make
show_ref_array_item() a thin wrapper that calls it and prints it
with the final LF for other callers.

Another alternate approach, if you want to give "tag -l" annotation
available to for-each-ref, would be to do this:

       if (filter->lines)
               format = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) "
                                "%%(contents:lines=%s)", filter->lines);
       else
               format = "%(refname:short)";

and teach a new %(contents:lines=1) atom.  That way, you can lose
the ugly special case call to show_tag_lines() that can only be at
the end of the output.  I somehow think this is a better approach.

Of course you can (and probably would want to) do both, giving a
bit lower level "emit to a strbuf" function to the callers _and_
losing hardcoded call to show_tag_lines().
