From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 3 Jul 2013 11:06:26 +0100
Message-ID: <CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
 <CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
 <7vli5ogh8r.fsf@alter.siamese.dyndns.org> <CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 03 13:48:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuLXb-0006ZA-Jp
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 13:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab3GCLsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 07:48:03 -0400
Received: from cybermen.asmallorange.com ([108.165.20.31]:34927 "EHLO
	cybermen.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab3GCLsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 07:48:01 -0400
X-Greylist: delayed 6067 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2013 07:48:01 EDT
Received: from mail-ve0-f173.google.com ([209.85.128.173]:65362)
	by cybermen.asmallorange.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.80.1)
	(envelope-from <maillist@steelskies.com>)
	id 1UuJxW-0006sq-QR
	for git@vger.kernel.org; Wed, 03 Jul 2013 06:06:47 -0400
Received: by mail-ve0-f173.google.com with SMTP id jw11so5729921veb.18
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 03:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g99OUdG/pkiaKHMgSmWur/1+W2rSdQ5jLGmFOIOtMaI=;
        b=HSsyCDxbTY7uldfnPK31ZfvnZckLMdcGqyj9ZgtR60MvqUt6HYJpDs+q+ovdisiRpM
         xgeq7kS3MWa8d10JSGQF/KJlb95Dxhc0uZSwJnjsznVsVsG9+zJSWN18vTh3hRZ/RdhC
         EUtTp8s6P9KosRPq8S99byFEDJPwhqVDnziSyRJbFz7S7bWLAJr1yqOjNpxI26RUxBqt
         8BDdLutOqV2nIxAK2U9Wg5Wgc9z7fa2MV7MgMZFD9DJbBTVLGKd/HkmnCfZKof+AfjEx
         DIKXdmczq90J2rOEWkmIGlV1qE8FR1VzCB0xhYvFTGC+yDAbvtS/bjHuuCduE6EpPNB+
         XsaA==
X-Received: by 10.220.198.133 with SMTP id eo5mr58297vcb.24.1372846006134;
 Wed, 03 Jul 2013 03:06:46 -0700 (PDT)
Received: by 10.58.50.2 with HTTP; Wed, 3 Jul 2013 03:06:26 -0700 (PDT)
In-Reply-To: <CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cybermen.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Get-Message-Sender-Via: cybermen.asmallorange.com: authenticated_id: maillist@steelskies.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229493>

On 3 July 2013 11:00, Johan Herland <johan@herland.net> wrote:
> On Wed, Jul 3, 2013 at 10:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>> Overnight, it occured to me that --force-if-expected could be
>>> simplified by leveraging the existing --force option; for the above
>>> two examples, respectively:
>>>
>>>   $ git push --force --expect
>>>   # validate foo @ origin == @{upstream} before pushing
>>>
>>> and
>>>
>>>   $ git push --force --expect=refs/original/foo my_remote HEAD:foo
>>>   # validate foo @ my_remote == refs/original/foo before pushing
>>
>> First, on the name.
>>
>> I do not think either "--validate" or "--expect" is particularly a
>> good one.  The former lets this feature squat on a good name that
>> covers a much broader spectrum, forbidding people from adding other
>> kinds of validation later.  "--expect" is slightly less bad in that
>> sense; saying "we expect this" does imply "otherwise it is an
>> unexpected situation and we would fail", but the name still does not
>> feel ideal.
>>
>> What is the essense of compare-and-swap?  Perhaps we can find a good
>> word by thinking that question through.
>>
>> To me, it is a way to implement a "lock" on the remote ref without
>> actually taking a lock (which would leave us open for a stale lock),
>> and this "lock"-ness is what we want in order to guarantee safety.
>>
>> So we could perhaps call it "--lockref"?
>>
>> I'll leave the name open but tentatively use this name in the
>> following, primarily to see how well it sits on the command line
>> examples.
>
> I agree that neither --expect nor --validate are very good. I also
> don't like --lockref, mostly because there is no locking involved, and
> I think most users will jump to an incorrect conclusion about what
> this option does, unless they read the documentation.
>
> Some other suggestions:
>
> a) --update-if. I think this reads quite nicely in the fully specified
> variant: --update-if=theirRefName:expectedValue, but it becomes more
> cryptic when defaults are assumed (i.e. --update-if without any
> arguments).
>
> b) --precond. This makes it clear that we're specifying a precondition
> on the push. Again, I think the fully specified version reads nicely,
> but it might seem a little cryptic when no arguments are given.
>
> c) --pre-verify, --pre-check are merely variations on (b), other
> variations include --pre-verify-ref or --pre-check-ref, making things
> more explicit at the cost of option name length.

I'm struggling to think of instances where I wouldn't want this
CAS-like behaviour.  Wouldn't it be better to make it the default when
pushing, and allowing the current behaviour with "git push
--blind-force" or something?
