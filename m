From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Thu, 24 Feb 2011 18:47:53 +0100
Message-ID: <AANLkTike1qDGJ-mLsSRYpBk59_evk9x5oFeGt5RSUg3d@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com>
	<AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 24 18:48:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsfIt-000255-LB
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 18:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab1BXRsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 12:48:35 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57236 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab1BXRse convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 12:48:34 -0500
Received: by fxm17 with SMTP id 17so793542fxm.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6JMX5wFL+PWyybuy+nt9vrGqtRHfhnI0TbG+yMFiVUg=;
        b=OUVMiVQfyUvc/zJVAEg/53VVFRl/1XEFrBwFiDhb1aV4xu6bydaSQDYp5avWeDEowU
         pJEW9lCUHKySp/Tp3c2SCDnVjvBLFg3tPl5Fjl6PHl80v0WTqGGRN9YvMQRdIX6fbzRz
         bgDndsuDTFBBu+Z9TIyDBBv8J3lkKeAY0nXCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W3g0TMYozNd+s35qEVCttkx8DKxQ6LFrwgu8z7KOFBosJC/gRZ9vsh8srYnOcgPZWP
         CTr+yRy2GvHsPvAZWEpE1gwRklJT1XOJly5Bh8GODscJzzamjax2hkL2Rf8kXloOtwcN
         v92SHk6aBjECvQbJUif0bhehdXnoM4G3Y0PQ0=
Received: by 10.223.83.201 with SMTP id g9mr1358652fal.140.1298569673537; Thu,
 24 Feb 2011 09:47:53 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Thu, 24 Feb 2011 09:47:53 -0800 (PST)
In-Reply-To: <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167842>

On Thu, Feb 24, 2011 at 10:45, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Thu, Feb 24, 2011 at 1:32 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> And then there's the issue that unlike the C patches these will not =
be
>> a no-op that'll be optimized away by the compiler. We'll be calling =
an
>> external program for displaying messages. While this is a trivial co=
st
>> on Unix (especially in the context we're using it, i.e. not in tight
>> loops) it's more expensive on Windows.
>>
>
> Ouch. I remember this being brought up earlier, but I just assumed it
> had been fixed somehow. The shell-scripts are already pretty slow on
> Windows, and the overhead of starting a new process here is quite
> significant.
>
> It sounds to me like we should revert these patches in msysGit, at
> least until there's some actual translations in place (and that time
> actually goes into something useful)...

IIRC last time this was discussed I asked whether the size of the
binary mattered for execution startup time (i.e. more so than on
Unix). We're only invoking printf(1) and git-sh-i18n--envsubst, both
of which only are (or only need to be) linked to libc.

It would also be interesting to have some real world benchmarks on
Windows with and without this series, maybe it won't be so bad.

I think in the long term we probably want to rewrite the remaining
*.sh programs in C anyway.

>> I don't see any way to deal with that short of implementing some
>> pre-processor, but I think the cost is worth it, but others might
>> disagree of course.
>>
>
> I'm not so sure. This is mostly a problem with the no-op version on
> Windows (due to the slow process-startup there), but I think Git for
> Windows probably wants to have i18n support in it's distribution as i=
t
> strives to be the canonical Git-distribution for Windows. But if we
> do, there's nothing to optimize. There's no no-op-stuff, and we need
> to spend that time getting translations.
>
> It might be that some people that build Git for Windows themselves an=
d
> know that they don't want a translated Git could benefit from a
> pre-processor, but I'm not so sure. Translated strings occur when
> there's communication going on between Git and the user, and then
> we're some times waiting for user-input, and even when we aren't it
> should be relatively few messages (unless verbose flags are turned on=
,
> which isn't an important use-case performance-wise to me).
>
>> Anyway, I can submit these patches (around 53) real soon, or wait
>> until the current series settles. It's the same to me, which would y=
ou
>> prefer?
>>
>
> If we're going to revert these patches in 4msysgit.git, then I can
> imagine that the process becomes very awkward and error-prone if we'r=
e
> going to diverge for a long time. So I think it'd make more sense for
> us (the msysgit-developers, that is) if it was merged together with
> the first translations. But that might be sub-optimal for the rest of
> you guys.

If it comes to that it'll be easier to have some perl script that
converts C<"$(eval_gettext "foobar: \$whatever")"> back to C<"foobar:
$whataver"> at build time than revert the patches.
