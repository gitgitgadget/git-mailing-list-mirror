From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in C
Date: Mon, 16 May 2016 11:42:01 -0400
Message-ID: <CAPig+cQ=Gche_uO840wF6qE4WD-ZNZj1HFzNNgaBi_UjG1sjEg@mail.gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-4-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
	<alpine.DEB.2.20.1605161508230.3303@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 16 17:42:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Ken-0005VB-Hd
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 17:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbcEPPmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 11:42:05 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34420 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbcEPPmD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 11:42:03 -0400
Received: by mail-io0-f193.google.com with SMTP id d62so15603679iof.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=4aXw6gNSD5AxhVTo4CSrn33q7cmx5mVCoyhUpzNZSsQ=;
        b=a72F6DnsrEq93+Zdk4ApyobK+qXky/3gVzvX/5UUhsIjuNH0MJMb0mouPQnaY+tWEy
         Wbi014DOz8B0SGplpkABI8FyY5fpcrsIk4RvlI3mQFYndbqwHrmHXwonEFOFKUVzFFg+
         CX1hT5NlSZsKdIHhWtjnmmR7exEJuDxo7rN2H5OmSbMlO9fOK4KlaZcU3VSZW0Fk4nxb
         /Jh8VZ+rr+lmbUZg5evVxar9jo7QaEvI9YP72tSDFS9g76UrGOe1O0wpZ0VpEYMq3TXm
         LvxlCKFi6EYyJG8unfo6wWcGR8brbyXniinRDBrlkJhfLhVmzOUABV64Yn9GAO4tFtCz
         Fwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4aXw6gNSD5AxhVTo4CSrn33q7cmx5mVCoyhUpzNZSsQ=;
        b=HtWfipNqFETWlt7pCeAVMOujLxbX90zU38tiK0CriPyFJTiAJjqpC7A9xV5ZbeJj5O
         712I8UWVZqCHsIZfLTIHX1QcrjwmFW3JEl+NdzhoU1ztNChBxFzxfKcb4uo024HkAwxj
         EgK+QUHneDZuL+4ZFlgqR2qdtL+IByOkCVoP6xhaQgdPiLwUSTs2wIvFF9bqPddg3mrE
         78xPBfo4ZDHIY8IfmBF6Saz8REGPLLZNuwChEP/KYT1vwLdZfT9JOLwRyNWge/hcrGfC
         pot8hrsHuFFcRfBYLnuPA5rWu72ouVeYxHfa7FY6u+5eJ+CpjEw5NPPoC0chNl3ZPrtx
         rl2Q==
X-Gm-Message-State: AOPr4FWGHOEg2o97L4niY00phF/EnJtghfB2gteDNcgJEEHaD1GD9vma3goW1NwJBch28t83zj1gZHTYFBTKhw==
X-Received: by 10.107.132.66 with SMTP id g63mr22046418iod.34.1463413321911;
 Mon, 16 May 2016 08:42:01 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 16 May 2016 08:42:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605161508230.3303@virtualbox>
X-Google-Sender-Auth: 4nxiZmBzVrfutR6X4VvPwpKHskk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294742>

On Mon, May 16, 2016 at 9:16 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 16 May 2016, Eric Sunshine wrote:
>> On Thu, May 12, 2016 at 1:32 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> > +       fp = fopen(".git/BISECT_TERMS", "w");
>>
>> Hardcoding ".git/" is wrong for a variety of reasons: It won't be correct
>> with linked worktrees, or when GIT_DIR is pointing elsewhere, or when ".git"
>> is a symbolic link, etc. Check out the get_git_dir(), get_git_common_dir(),
>> etc. functions in cache.h instead.
>
> Maybe in this case, `git_path("BISECT_TERMS")` would be a good idea. Or even
> better: follow the example of bisect.c and use
> `GIT_PATH_FUNC(bisect_terms_path, "BISECT_TERMS")`.

Thanks for pointing this out. My review time is severely limited these
days so I didn't go the distance of re-studying and re-digesting which
function was the correct one to use.

>> > +               strbuf_release(&content);
>> > +               die_errno(_("could not open the file to read terms"));
>>
>> Is dying here correct? I thought we established previously that you
>> should be reporting failure via normal -1 return value rather than
>> dying. Indeed, you're doing so below when strbuf_write() fails.
>
> The rule of thumb seems to be that die()ing is okay in builtin/*.c, but not
> in *.c. So technically, it would be okay here, too. However, I think that
> this code should be written with libification in mind, so I would also
> prefer it to error() and return, to give the caller a chance to do other
> things after an error occurred.

Agreed. Specific to the "established previously" I wrote above, I was
referring to [1] from just a few days ago which explained why 'return
-1' was preferable to die() in a similar case that had an odd mix of
'return -1' and die() in the same function.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/289476/focus=293556
