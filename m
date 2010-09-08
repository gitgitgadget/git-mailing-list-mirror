From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] sha1_name: allow to add @{...} alias via config
Date: Wed, 8 Sep 2010 20:11:19 +1000
Message-ID: <AANLkTiknnbijQuL4RzPR7R9O6ra079eH6N_KOM-UHRKE@mail.gmail.com>
References: <1283918641-3662-1-git-send-email-pclouds@gmail.com> <AANLkTimK6MwJHYafAAYNn+h3HD1f0H-BHsQYph4qbCrJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Sep 08 12:15:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtHgG-0001hm-0k
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 12:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758615Ab0IHKOy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 06:14:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41941 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab0IHKOx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 06:14:53 -0400
Received: by wwj40 with SMTP id 40so9665934wwj.1
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=v8AhI4etzB+HTh3B9gm+1GDhxoTtFY9DZQ/Vn7y8aRw=;
        b=NoksEG32ji4qCrKMZVAgKOjBJmBOi/EYHWizXUlniDCpOa6sEpOHRmGIe9wT+je8mX
         PaMyBdfG2KQxwIy59KYRViA4FJlz9SuSydiKNxJOhRj/hGaxgL/yTqxjopG0zCDMn3O/
         i9xzqKULlVPifm/RuX4d+wuORi/zHRJvRPMx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aNzx70UhaIGkuVkIcCRBFW4KljzO3HURZDqB4/iowisrwMQ5sYjpx7T87LwD+syrap
         G+035dklh7EUJVlEMkLyW6q2uj9zrUIqPMHrLgiK1t4N0HluIPRTmm5xrQMpZh+mHhUb
         nf0k76bFfYydWHpK/Rkja0M7SaMORI4Of68cU=
Received: by 10.216.138.65 with SMTP id z43mr3248012wei.12.1283940892208; Wed,
 08 Sep 2010 03:14:52 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 8 Sep 2010 03:11:19 -0700 (PDT)
In-Reply-To: <AANLkTimK6MwJHYafAAYNn+h3HD1f0H-BHsQYph4qbCrJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155779>

2010/9/8 Santi B=C3=A9jar <santi@agolina.net>:
> 2010/9/8 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> This allows users to add new @{..} alias via ref-at.* config
>> variables. The rewrite rule is printf-alike.
>>
>> My itch is I usually work on a topic and only want to see commits in
>> that topic. So I make a tag to the topic's base, then do
>>
>> git log base/my-topic..
>>
>> That is a lot of keystrokes, and my mind is small enough sometimes I
>> don't even remember the topic name, stucking at "base/ =C2=A0what?"
>>
>> Now I have "ref-at.base =3D base/%(tip)" in my gitconfig and I only =
need
>> to do "git log @{base}..".
>
> I like the idea, but I would like something more generic, a ref
> transformation or expression (ref-exp?). Currently you can't say
> %(tip)@{1}, neither %(tip)^, nor origin/master..origin/%(tip).

The idea is to nail down what kind of expression that should be used.
Then implement it. My first thought was to use a hook, but I thought
it was overkill for ref transformation.

Something like bash variable substitution is probably enough.

> Another issue is that it can shadow builtin @{}s, like @{upstream}.

Yes. I think @{upstream} can be put in to ref-transformation list at
startup. That way it always gets precedence.

> Why %(tip) and not %(branchname), in line with other %() modifiers.

Oh.. I picked whatever name I had in my mind. @(branchname) of @(branch=
)
sounds good.

> In particular I have a use case for this @{name}. I would like someth=
ing like:
>
> ref-exp.last =3D %(tip)@{1}..%(tip)@{0}

Yeah I was tempted too after writing the patch. It's a revision range,
not a reference anymore. But from user perspective it's pretty much
the same. And transformation rule would be the same. Hmm.. tempting.
--=20
Duy
