From: Antonin Hildebrand <antonin@hildebrand.cz>
Subject: Re: contrib/workdir/git-new-workdir broken in 1.7.10 after
 introducing gitfiles
Date: Sat, 21 Apr 2012 20:56:16 -0700
Message-ID: <CAHsq6J6MK4x7WZ=aox3hX11hFAng7Tp-XpR0ADs=UgUMwf20Ow@mail.gmail.com>
References: <CAHsq6J6JOTYfEtK0Z=_qfMFf9N1DWQ4zx46YhBbNu-1gEMyfog@mail.gmail.com>
	<4F930043.1080506@web.de>
	<xmqq397wzwwd.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 05:56:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLnux-0002et-EF
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 05:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800Ab2DVD4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Apr 2012 23:56:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64396 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab2DVD4R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2012 23:56:17 -0400
Received: by obbta14 with SMTP id ta14so11238244obb.19
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 20:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+jw6kxdEJfUqusu8C/bOBsTuZt26zN/UPNv/OgjBcKQ=;
        b=EM86b1vmQWkeXgxZRmoMAzkW/biEmPS3iOXOwZ2euUYI02TUJsFfLWUTiLXZtQNlCv
         V25i+T0YLjHyoPrr+gR3wwqrSJ8c9ZS7ZBlTRY7LmB7rJP1EMEaMjWp4Wotjn3QAz3dr
         DElpr+oH0qTEyhhRoFFYZpzMMc+tp7GV2XB8OE7j0kEh8QAClEviwhUpdOoZKOrFX0Ub
         4qFqtKluqeHGqziCTYOuIriK246ISis0hJ6IBNEgu5Xdbo8tergiyuLXwPYtHWRgsQHP
         3qZrgwyWMTpLVaDPq2465J31nEv7lmFmgDNrzFnH77RgPiHqUJpftmLvntPw9Bu9KRlO
         GxeA==
Received: by 10.182.16.1 with SMTP id b1mr4474082obd.31.1335066976942; Sat, 21
 Apr 2012 20:56:16 -0700 (PDT)
Received: by 10.182.17.163 with HTTP; Sat, 21 Apr 2012 20:56:16 -0700 (PDT)
In-Reply-To: <xmqq397wzwwd.fsf@junio.mtv.corp.google.com>
X-Google-Sender-Auth: Yg7AW_RDdhWzqQ180h7oZRPfo94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196072>

Quite frankly, the discussion got pretty technical for me and I don't f=
ollow it.

I have just posted my current solution involving hard links instead
new-workdir script:
http://stackoverflow.com/a/10265084/84283

Also it links this discussion as a warning that new-workdir may not be
the right solution.

Anyways, thanks for your great job on git! Much appreciated.

On Sat, Apr 21, 2012 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> Opinions?
>>
>> ----8<-----
>> Subject: [PATCH] git-new-workdir: Suggest unsetting the core.worktre=
e setting
>>
>> Linking to a repository that has the core.worktree option set can on=
ly
>> work when that core.worktree setting already points to the new-workd=
ir.
>> In all other cases strange things will happen, as new-workdir will b=
e
>> overridden by that setting.
>
> As you analyzed correctly, core.worktree lets a GIT_DIR to declare th=
at
> there is a single working tree associated with it. It fundamentally i=
s
> incompatible with new-workdir, which is a hack to let more than one
> working tree associated with a single GIT_DIR.
>
> I however do not think a simplistic "unset core.worktree" is a good
> suggestion, though, as we do not know why the original repository has
> that variable set pointing at somewhere. =A0Blindly removing it will =
break
> the use of the original repository. =A0If somebody _really_ wants to =
use
> new-workdir for whatever reason in such a setting, I would imagine th=
at
> doing something like this:
>
> =A0- Create a new repository somewhere that is an identical copy of t=
he
> =A0 original repository's GIT_DIR, except for core.worktree dropped;
>
> =A0- Turn the working tree original repository pointed with core.work=
tree
> =A0 into a "new-workdir" off of that new repository; and
>
> =A0- When you want more "new-workdir"s, create them off of that new c=
opy.
>
> may work. =A0But honestly speaking, "Do not use this hack---having mo=
re
> than one working tree is fundamentally incompatible with it", may be =
a
> more sensible message.
>
>
