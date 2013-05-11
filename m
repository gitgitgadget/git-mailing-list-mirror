From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Cannot push anything via export transport helper after push fails.
Date: Sat, 11 May 2013 16:17:37 -0500
Message-ID: <CAMP44s2XGcJT3SXFGVbKWdQMn8QuCCJ9MVob-CsZSM8O8aUy8A@mail.gmail.com>
References: <20130511162936.0354e5d7@opensuse.site>
	<CAMP44s1YhQR0o-0CLc2PG-EJTZdN4tha-4BVEUy-K_Av81D=GQ@mail.gmail.com>
	<20130511224837.39a1c551@opensuse.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 23:17:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbHAm-0001yY-5C
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 23:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab3EKVRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 17:17:39 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56859 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab3EKVRj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 May 2013 17:17:39 -0400
Received: by mail-lb0-f174.google.com with SMTP id r10so5267762lbi.33
        for <git@vger.kernel.org>; Sat, 11 May 2013 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=BbC6XBXGFpInoIS6RRs0gvm+60TugLY8ZSpQ6kdHslI=;
        b=FZDepxzUl8L6fI6wSMyVU1YETYfOE9jcsmOps41ZC1hWv7d/h7zjYuo5NSnndFLibR
         lXapxT7dmDvceE4OB3b/KnyXM3g/rtNdgng4EQmgPa82vRSvD0shs64zfF1oSaOqXJ44
         A3z33drpF3ZO7J9xEEHN1BLuvBly1a6XZi1fe1MQc/cTWevBaydRAkkKBZbKSuzzaiC4
         l7NJ1HJVE3lHqBoUovC+TsywCwPgBrm8ei00AMo0/q9EMSKUO8wknX1PcrupsvBhThzk
         SU93++XhLXKz/Rwp+Sh2qmqJ6Ld21qAdFqj4SpSUqxPA+FXaNWqoKaN6knODoloIEeFB
         WONA==
X-Received: by 10.112.1.166 with SMTP id 6mr9992405lbn.135.1368307057255; Sat,
 11 May 2013 14:17:37 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 11 May 2013 14:17:37 -0700 (PDT)
In-Reply-To: <20130511224837.39a1c551@opensuse.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224012>

On Sat, May 11, 2013 at 1:48 PM, Andrey Borzenkov <arvidjaar@gmail.com>=
 wrote:
> =D0=92 Sat, 11 May 2013 08:57:14 -0500
> Felipe Contreras <felipe.contreras@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
>
>> >
>> > The problem seems to be that git fast-export updates marks
>> > unconditionally, whether export actually applied or not. So next t=
ime
>> > it assumes everything is already exported and does nothing.
>> >
>> > Is it expected behavior?
>>
>> Indeed, this is the way it currently works, and it's not easy to fix=
=2E
>> We would need some way to make fast-export wait until we know the ex=
it
>> status of the remote helper, and then tell it when it failed, so the
>> marks are not updated.
>>
>
> One possibility would be to omit *export-marks and manage GIT marks i=
n
> remote helper as well. Helper would then update synchronously both GI=
T
> and BZR marks if no errors were detected. Or even better, it could
> update just those commits that had been successful.

That would need to change the whole architecture, because right now
the remote helpers are agnostic of Git SHA-1s.

>> However, the way remote-bzr/hg work is that the commits are still
>> there anyway. So if you merge the next time you push those commits a=
re
>> already converted, so it's not a problem if fast-export is not
>> exporting them again.
>>
>
> As I understand bzr commit ID is stable. What happens if we try to
> commit the same ID second time?

It's skipped, because it's already converted.

>> So even though it's not ideal, it should work.
>>
>
> I'm more concerned about transport errors. Any network glitch during
> push renders you repository unusable (at least, without much efforts)=
=2E

No, it doesn't. If the remote-helper fails gracefully, the bzr
revisions are converted and stored in the bzr repo, even if they were
not pushed to the remote. So it's OK if fast-export never exports them
again; we already have them.

Cheers.

--=20
=46elipe Contreras
