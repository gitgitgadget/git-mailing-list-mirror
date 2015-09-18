From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 14/14] tag.c: implement '--merged' and '--no-merged' options
Date: Fri, 18 Sep 2015 20:40:35 +0530
Message-ID: <CAOLa=ZQmGD2vo1B2K21-f_2RZRXduFt4VNKq2Pp9B_5bO=8=+w@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <1441902169-9891-3-git-send-email-Karthik.188@gmail.com> <20150917213619.GI17201@serenity.lan>
 <xmqq37ycitps.fsf@gitster.mtv.corp.google.com> <vpqoah0kxtb.fsf@anie.imag.fr> <20150918084208.GJ17201@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Sep 18 17:11:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcxJm-0005PO-MF
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 17:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbbIRPLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 11:11:08 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33202 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbbIRPLF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 11:11:05 -0400
Received: by vkgd64 with SMTP id d64so31787585vkg.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OE9xJYOh3rteLQlcPkL35BKOYzg8bRq5c7XVnDZWZ6M=;
        b=ZuTqHXHmNHj/7qdI6KihW0trvcFRr2BmTV9UOIeB/vRuRR6iqubuVWHh6vf2osXhCb
         IYO2UiwFfCzTbi49xYEjc5TKqsHDJ4aia1kQE37fbk4Gdu0ylc+9Y9IkjNly+/4T2Vf0
         s7FYW+DuQOZLlZvznG8IWou8u2F0iSdjS+7SxsMNeSa25oLPxKlChDWnDRbHz4xD+QCy
         2wz+uSvC/wRsNKm6hMX13kVMQcMsJRYSYsOLbzVYdwBugTV8F8zB5JMLzP+2H29KBWVl
         3MlUeiEOPxRnpAjD1+XngoaogwfpW/RMBiQAhE1fUhmOg4R1WLr0etX8yhVZOMGG8Bn9
         w4ow==
X-Received: by 10.31.50.196 with SMTP id y187mr3833704vky.142.1442589064767;
 Fri, 18 Sep 2015 08:11:04 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Fri, 18 Sep 2015 08:10:35 -0700 (PDT)
In-Reply-To: <20150918084208.GJ17201@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278197>

On Fri, Sep 18, 2015 at 2:12 PM, John Keeping <john@keeping.me.uk> wrote:
> On Fri, Sep 18, 2015 at 09:10:08AM +0200, Matthieu Moy wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > John Keeping <john@keeping.me.uk> writes:
>> >
>> >>> +--[no-]merged [<commit>]::
>> >>
>> >> We prefer to write --[no-]* as:
>> >>
>> >>    --option::
>> >>    --no-option::
>> >>
>> >> although this may be the first instance that we see this combination
>> >> with an argument.
>> >>
>> >> I also found the "[<commit>]" syntax confusing and had to go and figure
>> >> out what PARSE_OPT_LASTARG_DEFAULT does; I wonder if it's worth
>> >> appending something like the following to the help for this option:
>> >>
>> >>    The `commit` may be omitted if this is the final argument.
>> >
>> > "may be omitted" must be followed by a description of what happens
>> > when omitted (i.e. "defaults to ...").
>>
>> Then:
>>
>> The `commit` may be omitted and defaults to HEAD if this is the final
>> argument.
>
> I find that slightly confusing, although that might just be me.  It's
> slightly longer, but I would write:
>
>         The `commit` may be omitted if this is the final argument, in
>         which case it defaults to `HEAD`.
>

This seems good to be included.

> I also had a look at git-branch(1), which has similar `--merged` and
> `--no-merged` options and says:
>
>         Only list branches whose tips are reachable from the specified
>         commit (HEAD if not specified).  Implies `--list`.
>
> The two options are listed separately in that case.

Not sure this is much of a problem with regards to "--[no-]merged"
I mean isn't the square brackets self-explanatory?

-- 
Regards,
Karthik Nayak
