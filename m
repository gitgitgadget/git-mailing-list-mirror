From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 2/2] submodule: fix handling of supermodules with relative
 origin URLs
Date: Sun, 20 May 2012 08:51:08 +1000
Message-ID: <CAH3AnrrqiXqdHHGZPyOPJ3Zend5JrQX0rKV+pz_mjs3SDjv9DA@mail.gmail.com>
References: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com>
	<1337402403-7546-2-git-send-email-jon.seymour@gmail.com>
	<4FB7ECCF.9020403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun May 20 00:51:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVsUW-0001aW-J5
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 00:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab2ESWvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 18:51:11 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61021 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab2ESWvJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 18:51:09 -0400
Received: by wgbdr13 with SMTP id dr13so3813523wgb.1
        for <git@vger.kernel.org>; Sat, 19 May 2012 15:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pRF7TB6XWt/kK4aTxEZFhn5Hh/n5+1s8ZZYGU/vVjuk=;
        b=OrNuakIeQW9Q0fuQT6q/W+T+IhPED0l9OVHkSwwbqgNH0F+DLdLilG/SiN6O4BFXuW
         PiuVfR0OUPGq5YcC0hsKaP1Y9HXLIcHcWt+pSPpfP1XagMnn57shKE2Y5EXfArdacFvo
         aDH1Z+b48/S+u/f3eeyb+dGz5Ii+6onTvI+yUImdQ+wlp0q8TMLXocpIg0/ze6Ia+2Ei
         RrpmtSVuqpHDRoj7nhpWtPPPHEvjX/LQFolhXIC0G2iZWKjPasZ/HAdfSgZw5goig3Kt
         LsY5PklIJgOS0m9v5z4k7uGG3rUr5nBP04SFndUkNWJVbDjyR4X/QyEtKEyPq8At70He
         ljqA==
Received: by 10.180.84.193 with SMTP id b1mr12575440wiz.11.1337467868219; Sat,
 19 May 2012 15:51:08 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sat, 19 May 2012 15:51:08 -0700 (PDT)
In-Reply-To: <4FB7ECCF.9020403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198041>

On Sun, May 20, 2012 at 4:56 AM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 19.05.2012 06:40, schrieb Jon Seymour:
>
> Just a small nit: I'd prefer to replace the 4 occurrences of the term
> "supermodule" with "superproject".

Sure. I can't argue with precedent, of course, but I guess I was
favouring the consistency in the suffixes used with sub and super.

>
>
> BTW, what happened to the following comment in you other email?
>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remoteurl=3D"${up_path%/}/${remo=
teurl%/*}"
>>
>> Meant up_path%/ to be up_path%/*
>
> The '*' is not there (but the test suite runs fine no matter if I add
> a '*' there or not). Thinking about it not adding the '*' should be
> correct, as you just want to chop off a trailing '/' from $up_path
> here, right?

Yes %/* was actually the wrong thing to do - my original intent was to
remove repeated trailing occurrences of /, but, of course, %/* doesn't
do that, nor should it be necessary  (assuming the sm_path was
normalized during add).

>
> So no objection on the code changes from my side.

I noticed one relative case that is not handled properly yet, but
there is a workaround. If the superproject's origin URL is of the
form: foo/bar (a case I actually have myself for reasons I can explain
if you want me to), then the correct rule doesn't get matched by
=2E*/*). The workaround is for the user to change foo/bar style origin
URLs to ./foo/bar.

Let me know if I should fix this case now too.

jon.
