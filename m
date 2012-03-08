From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH] fast-import: fix ls command with empty path
Date: Thu, 8 Mar 2012 23:33:10 +0600
Message-ID: <CA+gfSn8bh-tV+uduM7xsuwqXQW2a57yvVmRXjXjp9JaO779bUg@mail.gmail.com>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
	<1331184656-98629-1-git-send-email-davidbarr@google.com>
	<20120308070951.GA2181@burratino>
	<7vty1zdp2b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:33:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5hDQ-0006gr-5x
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 18:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab2CHRdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 12:33:14 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59026 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751113Ab2CHRdM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 12:33:12 -0500
Received: by lahj13 with SMTP id j13so736532lah.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 09:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=V7WC/SvKLGP53L0j8NyB+KvHedEqqboj0Ntmp6fVCWw=;
        b=PD69JdeGKbL+DSf7aZypda7+1DQLi0FmUcVyjHNmdsvD4//TKPh91yhF5UE0sQC00R
         UvkMxuWq1S/WD2M9S0T17cyyyQq3ezWZpnRvSd7vIitd5rQo5OA3qF7tGt0yvT8TltYA
         kHP3CTg4q6nqbq2lMlWXfRkh9At0/D7k/euNsx4eX9wjDSXw/Q0T6lDKtipIGuqiWMnW
         29GFlzDq1UH2sws65gy6ah0BYLg24TMX1hZQfqytsAbs97ubPCcylCwzC2pfe+BIRp/B
         nDtjIcV65hcBev/gCTURqay6g3+5yVYaIZpIeTyJtQIu6t9oUB1pqYDPoqC6eKGkzrze
         ovFQ==
Received: by 10.152.128.38 with SMTP id nl6mr5086978lab.15.1331227990537; Thu,
 08 Mar 2012 09:33:10 -0800 (PST)
Received: by 10.152.127.74 with HTTP; Thu, 8 Mar 2012 09:33:10 -0800 (PST)
In-Reply-To: <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192620>

Don't quite have the time to run tests, but maybe the issue is solved
 in a stalled series [1]. At least [1] is worth looking at with regard
 to this bug.

 One more quick thought. "force the root mode to S_IFDIR" part doesn't
 look obviously good for me. First, isn't it already ensured that the
 root is a directory? Second, if it is allowed to be a file I'm not
 sure it's ok to silently make it a directory on a root-to-subtree
 operation, do we do it for subtree-to-subsubtree?

 P.S. looking at [1] now I'd say the commit messages could be improved =
there

 [1] http://thread.gmane.org/gmane.comp.version-control.git/179426

On Thu, Mar 8, 2012 at 10:39 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> For what it's worth,
>> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>>
>> Thanks very much for taking care of it.
>>
>>> [Subject: fast-import: fix ls command with empty path]
>>
>> I would s/fix/accept/ to be more precise about the nature of the
>> breakage. =A0(In other words: rather than mishandling ls with an emp=
ty
>> path, fast-import was not handling it at all.)
>>
>> ...
>> (good). =A0What do you think?
>>
>> -- >8 --
>> Subject: fast-import: allow filecopy to copy from root
>
> So what do you guys want to do with topic? =A0My gut feeling is that
> this is not a new regression and can wait until the next cycle. =A0I
> could certainly carry David's patch in 'pu' if doing so helps the
> discussion to come up with the right solution, though.
>
>
