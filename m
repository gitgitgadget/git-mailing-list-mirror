From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] git: add optional support for full pattern in fetch refspecs
Date: Tue, 7 Jul 2015 21:47:46 -0700
Message-ID: <CA+P7+xpBrZPXFWpmzhkmHH7aAWiY-ews63_eex68kKc=ViHC3A@mail.gmail.com>
References: <1436309869-19609-1-git-send-email-jacob.e.keller@intel.com> <xmqq615v1dlr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 06:48:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZChHQ-0002Zg-Bm
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 06:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbbGHEsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 00:48:08 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35871 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbbGHEsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 00:48:06 -0400
Received: by obdbs4 with SMTP id bs4so143188491obd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 21:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bleDJo61tE8tTgVlkMyt8kPubkpaCokFO2j41jVlDOo=;
        b=wkYPHx6oxJluxhZ9tR4uUrtjjam590CrAYpLZufd8eG+s2/v+K2Xqrl1fxXJZNvxyO
         Yhd6Yadq2CIde+ZqUZf2D/VJIBd3uiGKwxCESegpifQptq6sDLX4Hv6YszD8AStMOYKX
         yY6uUrCVIqV7wmx0EchuXMhYYrpAIwdm6m/vqYIun+r9cOVSAAKRKKRH9CNvmNIKmE1l
         NP1tWoXKsn/V+mnVY5TTG3RNmXa6McHjopbrwYtDur9PchrvS7qaD4AGCCxRW2M/Z45q
         xxJE9VyZ+QG1MSpwj5Ht0Skuf2kXmGSQR+nf4MN9h+mj7tfTl40txXZJnMx/3oR9Hh2Y
         bSEQ==
X-Received: by 10.202.190.11 with SMTP id o11mr7274157oif.20.1436330885777;
 Tue, 07 Jul 2015 21:48:05 -0700 (PDT)
Received: by 10.76.174.8 with HTTP; Tue, 7 Jul 2015 21:47:46 -0700 (PDT)
In-Reply-To: <xmqq615v1dlr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273636>

On Tue, Jul 7, 2015 at 9:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> +remote.<name>.arbitrarypattern::
>> +     When set to true, fetching from this remote will allow arbitrary complex
>> +     patterns for the fetch refspecs. For example,
>> +     refs/tags/prefix-*:refs/tags/prefix-* will work as expected. Care should be
>> +     taken as you could fetch refs into names that don't exist on the remote and
>> +     may end up pushing them again later by accident.
>
> Bad name and explanation, unless you truly mean "arbitrary", like
> taking something like "refs/ta*/prefix-*-*-foo:refs/*".
>

I couldn't figure out what to use, and the original intent was to add
an option.. but see below,

> More importantly, this is not "pattern"; you are talking about
> refspec, I think.
>

In this case the option was an additional modifier to the
refspec_patterns, and I was talking about how the pattern could be
slightly more arbitrary. I do agree it is a bad name, but i couldn't
actually come up with anything better.

> But that probably does not matter.  I do not think this even needs
> to exist as an option.
>

Yes, I agree especially as I look at it more. I'll work up a patch
version which does this without the option.

> People's existing settings would not have anything other than an
> asterisk as a whole path component on each side (or no asterisk
> anywhere), and if they had an asterisk anywhere else they would have
> gotten an error and wouldn't have made any progress until they fixed
> it.  So if you loosen the current rule sligntly and tell them "If
> your refspec has an asterisk in it, then you must have one asterisk
> on each side of it. That rule hasn't changed. But your asterisks no
> longer have to be a whole path component", such a change would not
> hurt them.  Their existing setting that work would not notice, and
> existing users would not be relying on a refspec with an asterisk as
> part of a path component to error out.
>

Right. We aren't breaking anyones current functionality, just adding
new functionality. We already check for a * in both sides, and my code
will ensure only 1 star total. It will then work for the new somewhat
more expanded patterns and we don't need an option.

I'll work up a v2.

Regards,
Jake
