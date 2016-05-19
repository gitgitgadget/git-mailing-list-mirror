From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Thu, 19 May 2016 14:25:52 -0700
Message-ID: <CAGZ79kYx_pX81bmpyXCvJSVsZW=t3VpBizUPQ90Wz9=HdG42UA@mail.gmail.com>
References: <20160519010935.27856-1-sbeller@google.com> <xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZvZQxPUkECupvqk0KRbq-pRK6y=GksOiYn_zz+TM=dBA@mail.gmail.com> <xmqqshxdhi76.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 23:26:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VSB-000201-11
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbcESVZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:25:55 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35670 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbcESVZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:25:54 -0400
Received: by mail-io0-f174.google.com with SMTP id p64so32871303ioi.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C3JFNObZFWCNsHVY5EnK/M3HwpTiNn82BXwjcovs2iE=;
        b=DLyycJUUD1cZG4WUHqW7Nqc21YAJgpXvYyio210+psCGglFT1ETyczDX61I3DCNJDz
         igJF1ooq7FSSjwSrDHyJkCmoxAFYcvkkrcfe9lyWpbiqSy0ZI+H8MlCM5Z7hAv19eEcm
         T3oCO+6ozDOSqnihI9jSTgoyI8yz1QCcYDLB/0MK9bUdx3QymC2lp+1Q2zb81oVsFngF
         fe5c/S75xQvy5XvJ94a69Vqw8AowmL68DVLqzOva1YIWP0QC+rl3nm7ZLnEwnm7wd40t
         5GaoGCUSO1xemP4AlPipMxzz3nXeE1TipTFBVtcS6yBvsUZ8GdcyGItloUlQnbukjaMr
         rgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C3JFNObZFWCNsHVY5EnK/M3HwpTiNn82BXwjcovs2iE=;
        b=RRRwUMN+DyOPh/1C0A87GnEML/8bTanrzKU8DL0M/i26/ZRTwhrgVTI+t2ucKESWup
         9PAUGB6CV6jyTsyn9i0FVIQ1+JCYQ5fIHN3pmWx/d4SJL385J+PzZlQi0t/+SlKbKA+p
         BBoLWLYWUQaVxqdQVOT0gMA7NPCruSCFdkyslKq0LWntUZX3wsjEuVCH+ajElCbdgv99
         IL4A1wo5CfsykFIibWwAx8H62JIbeodHm2iz0VfT39vLxi82dPTW6lFbuzUUZJZIqtZJ
         HfeHUY8vfLTj6ODG4vJjFQjT6Wop7GrCMi2eHAhVU4UtUwDkOGdBjkMct3YAlSEGonp+
         ldaA==
X-Gm-Message-State: AOPr4FXIWIeJnwng3e1ZAFhBfaeXRV+VVQbbGInnE3vP7fMqmLI63v72qdNBSQMXrPjSjUp/MC63eMcGtRG44N+J
X-Received: by 10.36.14.71 with SMTP id 68mr4709487ite.98.1463693153346; Thu,
 19 May 2016 14:25:53 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 19 May 2016 14:25:52 -0700 (PDT)
In-Reply-To: <xmqqshxdhi76.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295103>

On Thu, May 19, 2016 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> (B) requires some thought though. Here is my vision:
>>
>>     1) Allow pathspecs for sparse checkout.
>>
>>       I wonder if we just add support for that in .git/info-sparse-checkout
>>       or if we add a new file that is for pathspecs only, or we have a config
>>       option whether sparse-checkout follows pathspecs or gitignore patterns
>>
>>     2) Teach `git clone` a new option `--sparse-checkout <pathspec>`
>>       When that option is set the pathspec is written into the new file from
>>       (1) and core.sparsecheckout is set to true
>>
>>     3) Advertise to do a `git clone --sparse-checkout
>> :(attr:default_submodules)`
>>
>> Going this way we would help making submodules not different but integrate more
>> into other concepts of Git. As a downside this would require touching
>> sparse checkout which may be more time consuming than just adding a
>> `git clone --init-submodules-by-label` which stores the labels and only upddates
>> those submodules.
>>
>> Or are there other ideas how to go from here?
>
> My take is to pretend sparse checkout does not exist at all and then
> go from there ;-)  It is a poorly designed and implemented "concept"
> that we do not want to spread around.
>
> You were going to add defaultGroup and teach 'clone' (and other
> commands) about it, and have clone find submodules in that Group,
> right?

Right. But upon finding the new name for clone, I wondered why
this has to be submodule specific. The attr pathspecs are also working
with any other files. So if you don't use submodules, I think it would be
pretty cool to have a

    git clone --sparse-checkout=Documentation/ ...

> Isn't the pathspec magic just another way to introduce
> how you express the "defaultGroup", i.e. not with the "label" thing
> in .gitmodules, but with pathspec elements with attribute magic?

Right. So instead I could do a

    git clone --recursive --restrict-submodules-to=<pathspec> --save-restriction

and then later on

    git submodule update --use-restriction-saved-by-clone

I think we'd not want more than that for some first real tests
by some engineers.

However after thinking about this for a while I think it's too
submodule centric? The more special sauce we add for submodules
the harder they will be to maintain/support as they grow into their own
thing down the road.

Using these pathspec attrs are a good example for why we would
want to make it more generic. Imagine a future, where more attributes
can be codified into pathspecs and this is one of the possibilities:

    git clone --sparse=":(exclude,size>5MB,binary)

which would not checkout files that are large binary files. We could
also extend the protocol (v2 with the capabilities in client speaks first)
to transmit such a requirement to the server.

Why is sparseness considered bad?
(I did find only limited resources on the net, those bogs I found are
advertising it as the last remainder Git needed to be superior to svn in
any discipline; I did not find a lot of negative feedback on it. So I guess
usability and confusion?)

If I wanted to just do the submodule only thing, this would be a smaller
series, I would guess.

Thanks,
Stefan
