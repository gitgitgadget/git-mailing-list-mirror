From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Splitting a rev list into 2 sets
Date: Tue, 25 Jun 2013 10:09:45 +0200
Message-ID: <CAC9WiBiEtygQGB7JAo5mWuetFE_WTZOYDaTTKv_bkbWQs8xe8A@mail.gmail.com>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
	<8761x87wc8.fsf@linux-k42r.v.cablecom.net>
	<CAC9WiBgb18ZX0vr8V79tCEUStrDRhRiSh44nH6+3B_Kf8rypYg@mail.gmail.com>
	<87mwqf3k3n.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 25 10:09:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrOK1-0000D8-FF
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 10:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab3FYIJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 04:09:49 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:46984 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab3FYIJq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jun 2013 04:09:46 -0400
Received: by mail-ve0-f178.google.com with SMTP id pb11so9866377veb.9
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 01:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TUetryV57eKiEeER1mBaYBiISmPVfykpom/gXOftz8Y=;
        b=amFXb0SQwblqn47FqXrAlqe5E0o7rMOjf1K1zrLusHrEsTkV+7KSpgYSR16M1dZeyw
         spf7hD2H92HbMf1gKPsnmlefoeWJtPmONe6r5gjQtB+oLVM8YjT3sq3e6OL3pYkFZTXt
         ax0Nh4LfV38xkELbkpT34MZ+5gZQu0jhPitFMlCfTq6RyjFZVyaFWQtDzM84bomehRHi
         BdBr1Z9SUVBjOHcAjrt6zCOG9Ce+2o2X88jVBnJ2jLm7l0v77klhiFrIs2593tY1cCGE
         ERkYSLHa9j65GQbbvlGU2RCRw3RLoz0JQLqAIm0fA1yfIWnfC6Z58q4a2ScCM2tHTpM0
         yB6w==
X-Received: by 10.58.127.202 with SMTP id ni10mr13234640veb.27.1372147785920;
 Tue, 25 Jun 2013 01:09:45 -0700 (PDT)
Received: by 10.58.154.5 with HTTP; Tue, 25 Jun 2013 01:09:45 -0700 (PDT)
In-Reply-To: <87mwqf3k3n.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228946>

Hello Thomas,

On Mon, Jun 24, 2013 at 11:59 AM, Thomas Rast <trast@inf.ethz.ch> wrote=
:
> Francis Moreau <francis.moro@gmail.com> writes:
>
>> On Thu, Jun 20, 2013 at 3:20 PM, Thomas Rast <trast@inf.ethz.ch> wro=
te:
>>>   positive=3D$(git rev-parse "$@" | grep -v '^\^')
>>>   negative=3D$(git rev-parse "$@" | grep '^\^')
>>>   boundary=3D$(git rev-list --boundary $positive ^master | sed -n '=
s/^-//p')
>>>   # the intersection is
>>>   git rev-list $boundary $negative
>>
>> I think there's a minor issue here, when boundary is empty. Please
>> correct me if I'm wrong but I think it can only happen if positive i=
s
>> simply master or a subset of master. In that case I think the soluti=
on
>> is just make boundary equal to positive:
>>
>>      # the intersection is
>>      git rev-list ${boundary:-$positive} $negative
>>
>> Now I'm going to see if that solution is faster than the initial one=
=2E
>
> Jan "jast" Kr=FCger pointed out on #git that
>
>   git log $(git merge-base --all A B)
>
> is exactly the set of commits reachable from both A and B; so there's
> your intersection operator :-)

nice :)

>
> So it would seem that a much simpler approach is
>
>   git rev-list $(git merge-base --all master $positive) --not $negati=
ve
>
> avoiding the boundary handling and special-case.  It relies on the
> (weird?) property that $(git merge-base --all A B1 B2 ...) shows the
> merge bases of A with a hypothetical merge of B1, B2, ..., which is j=
ust
> what you need here.

Thank you Thomas, that's exactly what I was asking for :)

--
=46rancis
