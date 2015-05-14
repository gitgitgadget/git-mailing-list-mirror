From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Thu, 14 May 2015 10:44:51 -0700
Message-ID: <xmqq4mnf8358.fsf@gitster.dls.corp.google.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-2-git-send-email-pyokagan@gmail.com>
	<xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
	<xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
	<CAO2U3QgD0-tAwGnMeeMR5aqbUuqDsdWy0Sw8dQBPUpUNwJZpHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 19:45:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsxBr-0001uJ-PE
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933455AbbENRoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:44:54 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36763 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011AbbENRox (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:44:53 -0400
Received: by igbpi8 with SMTP id pi8so173555323igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ohy+w/s0vza+JHnKk8tT2JuXpuut/CCakmyw3rDITEM=;
        b=FsUpM4MNtHGI2zJCJDZS6w5Z3L5cirEQEFo19aV0eFWlTe8UeecYgtjrJGsty8aLBO
         Ily9Jj8Tx8SfZB91Z4pv25QXcQo6P7T2OTsbABPIY+nq98U68iGJ4IKKYX0C0Eirt2o+
         GLQpcyeZGISa9+owlnRUiTRnUx07yoje7WL+PG+uTYDD8R4PSFCfoZajFipab7c/rig8
         9XhGW9DMEiivPiCel7piS3rgtDKA711DTWjlgR4+iBKHUzmhvFPo3TKgqcGTUX8qhIUN
         qWPaEQ0+4PifW0DqJe98NLvqw2D78LnqEopbsFMxPrGLF7w0V7icamAtBuIrwhaL+/Fu
         N+tg==
X-Received: by 10.50.78.199 with SMTP id d7mr19300237igx.18.1431625493124;
        Thu, 14 May 2015 10:44:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id d15sm6310323igo.8.2015.05.14.10.44.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 10:44:52 -0700 (PDT)
In-Reply-To: <CAO2U3QgD0-tAwGnMeeMR5aqbUuqDsdWy0Sw8dQBPUpUNwJZpHg@mail.gmail.com>
	(Michael Blume's message of "Thu, 14 May 2015 10:29:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269056>

Michael Blume <blume.mike@gmail.com> writes:

> On Wed, May 13, 2015 at 7:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Paul Tan <pyokagan@gmail.com> writes:
>>>
>>>> Replace the above 2 forms with:
>>>>
>>>>      verbose test "$(cat file)" = expected
>>>
>>> Quoting is very much a good idea, but I am not enthused by the
>>> vision of having to write verbose everywhere in our script.
>>> 
>>> After seeing a script fail, you can run it again with -i -x options;
>>> wouldn't it be sufficient?
>> ...
>
> My build starts breaking from this commit, I'm on a mac.
>
>
> expecting success:
>     (cd dst &&
>      test_must_fail git pull --rebase &&
>      verbose test 1 = "$(find .git/rebase-apply -name "000*" | wc -l)"
>     )
>
> First, rewinding head to replay your work on top of it...
> ...
> To check out the original branch and stop rebasing, run "git rebase --abort".
>
> command failed:  'test' '1' '=' '       1'
> not ok 33 - git pull --rebase does not reapply old patches

Change that 'verbose test' line to

	verbose test 1 = $(find .git/rebase-apply -name "000*" | wc -l)

i.e. losing the double-quotes around $().

By the way, thanks for a fine demonstration that the 'verbose test'
is not very useful.

This output

> command failed:  'test' '1' '=' '       1'

and that you said "on a mac", _I_ can immediately guess that there
is "wc -l" involved, because it has been a frequent source of
portability headache.

But "verbose" is not helping very much to show there is "wc -l";
unless the person debugging the output has a pretty good idea what
can go wrong, that is.
