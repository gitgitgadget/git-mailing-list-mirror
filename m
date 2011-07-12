From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 07/14] revert: Introduce struct to keep command-line options
Date: Tue, 12 Jul 2011 11:44:53 +0530
Message-ID: <CALkWK0mnhsCZoz0PLBAEL_Z9MOSfGDYTWj6ToNqyutxvfkfNCA@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-8-git-send-email-artagnon@gmail.com> <20110706090915.GD15682@elie>
 <CALkWK0=gm-y3CB83TsSiWWF4qyS5hOJDhOYCz4HTWyT7iHP6MA@mail.gmail.com> <20110706120616.GQ15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:15:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWFe-00059y-29
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab1GLGPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jul 2011 02:15:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38918 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab1GLGPO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2011 02:15:14 -0400
Received: by wwe5 with SMTP id 5so4593391wwe.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 23:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=P2wRdq5EQCQwSDsm3YCOoFDl2gtZIIJ69dNaBGNGx/4=;
        b=XweLISY7ANfrqGNzyf0UP5ZrFADxjX9cGZpK/KJjYAiQNBwcxIj15ROfUXT7pC660E
         p1GtgflMkkIn6CkXQiv+/ubut0fsI/atEfZwMwK+XOPNx+4diw/isdkrEIjGD7hoIBi8
         dfoa8kzQBKfD2byJF98oyituqNJqHNKlYkKOg=
Received: by 10.216.137.92 with SMTP id x70mr2632523wei.62.1310451313090; Mon,
 11 Jul 2011 23:15:13 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Mon, 11 Jul 2011 23:14:53 -0700 (PDT)
In-Reply-To: <20110706120616.GQ15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176925>

Hi Jonathan,

Sorry about the delayed replay -- I intended to reply to this earlier;
I'm not sure why I didn't.

Jonathan Nieder writes:
>> My justification: in later steps, we'd want to be able to mix
>> "pick" and "revert" instructions in the same instruction sheet. =C2=A0=
This
>> will essentially require the parser to return a commit + a replay_op=
ts
>> struct (which will contain the action information).
>
> Side note: is it intended to support insns like
>
> =C2=A0pick A..B
>
> ?

I wouldn't point to that instruction specifically, but yes- I plan to
support complex instructions in future.

> Anyway, the above explanation about the intended use for "struct
> replay_opts" (it needs to be small, I guess?) would be a good thing
> to add to the commit message, too. =C2=A0Basically, whatever informat=
ion a
> person needs in order to understand the design is a useful thing to
> add.

I'm not yet sure about this.  On a related note, I'd like to ask: will
we encounter two commands like "am" and "revert" which have the same
command-line option name for two different functionality?  If not, I'd
probably like to stick to the per-session opts for as long as possible
(ie. until someone finds a good usecase + implementation for
per-action command-line options).

>> Yes, I'm definitely considering exposing parse_args in the future,
>> especially since I want to support command-line options in my
>> instruction sheet.
>
> Hm, I am not sure what to think about this direction (is the git
> sequencer actually just a fast git shell? =C2=A0in that case, why is =
pick
> spelled "pick" instead of "cherry-pick"?). =C2=A0Maybe it's a good th=
ing.

This is a very important question.  Yes, it's intentionally named
"pick" and not "cherry-pick" because I don't want the Sequencer to
merely be a fast git shell.  That's part of the reason I don't want
arbitrary command-line options on the insn sheet.  I want the
possibility of accommodating complex instructions in the insn sheet
(single instructions that might even involve talking to more than one
git command).  For the same reason, I also felt that "action" is the
most appropriate name for the first word in each line in the insn
sheet.  What I'd call an "instruction" is an action + the relevant
option(s) picked up from the opts sheet.

-- Ram
