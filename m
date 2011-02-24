From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Thu, 24 Feb 2011 10:45:33 +0100
Message-ID: <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 10:48:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsXo5-00032J-1H
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 10:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab1BXJsQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 04:48:16 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62776 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab1BXJsO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 04:48:14 -0500
Received: by fxm17 with SMTP id 17so353529fxm.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 01:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7xxz0eAlmcLGW8/wVtq7EzdzhlgWVH3pqsuh7NnBrso=;
        b=UBkSbOhkHetkbSy+OJGs4xOhd0BCvSbOYUoZQoMK/Ne+4vLAhsDzJhP7hyf734rADO
         41xYUYBMbnFzPh4Nrg0fybO/jWm2wEx46vxz7y/mQNR7I9j3qeGbtGGrjA7SOMpvXE5e
         E6gKFo+ScOb84R7pObuONBS7opDP2MaCZLmyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=vzZC163ilF2snt0DlHV+JmXwSi1PEwhQ1XR+AvpGqU/HaeMyXnM1D1AoSkj54izdP+
         +K5DwdaR7WS0gJf8o8ycf7TjUBI4wwL/OyBjynb5KP3MCtXpGqtjMGIJtZenk5S8mA3v
         QE25PlOC3plJ0RalgBLOWG/zOvSWvuYRJ5NUw=
Received: by 10.223.101.134 with SMTP id c6mr751103fao.12.1298540753209; Thu,
 24 Feb 2011 01:45:53 -0800 (PST)
Received: by 10.223.95.206 with HTTP; Thu, 24 Feb 2011 01:45:33 -0800 (PST)
In-Reply-To: <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167788>

On Thu, Feb 24, 2011 at 1:32 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> And then there's the issue that unlike the C patches these will not b=
e
> a no-op that'll be optimized away by the compiler. We'll be calling a=
n
> external program for displaying messages. While this is a trivial cos=
t
> on Unix (especially in the context we're using it, i.e. not in tight
> loops) it's more expensive on Windows.
>

Ouch. I remember this being brought up earlier, but I just assumed it
had been fixed somehow. The shell-scripts are already pretty slow on
Windows, and the overhead of starting a new process here is quite
significant.

It sounds to me like we should revert these patches in msysGit, at
least until there's some actual translations in place (and that time
actually goes into something useful)...

> I don't see any way to deal with that short of implementing some
> pre-processor, but I think the cost is worth it, but others might
> disagree of course.
>

I'm not so sure. This is mostly a problem with the no-op version on
Windows (due to the slow process-startup there), but I think Git for
Windows probably wants to have i18n support in it's distribution as it
strives to be the canonical Git-distribution for Windows. But if we
do, there's nothing to optimize. There's no no-op-stuff, and we need
to spend that time getting translations.

It might be that some people that build Git for Windows themselves and
know that they don't want a translated Git could benefit from a
pre-processor, but I'm not so sure. Translated strings occur when
there's communication going on between Git and the user, and then
we're some times waiting for user-input, and even when we aren't it
should be relatively few messages (unless verbose flags are turned on,
which isn't an important use-case performance-wise to me).

> Anyway, I can submit these patches (around 53) real soon, or wait
> until the current series settles. It's the same to me, which would yo=
u
> prefer?
>

If we're going to revert these patches in 4msysgit.git, then I can
imagine that the process becomes very awkward and error-prone if we're
going to diverge for a long time. So I think it'd make more sense for
us (the msysgit-developers, that is) if it was merged together with
the first translations. But that might be sub-optimal for the rest of
you guys.
