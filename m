From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv2 1/2] t5520-pull: Add testcases showing spurious 
	conflicts from git pull --rebase
Date: Sun, 8 Aug 2010 20:33:03 +0000
Message-ID: <AANLkTinkT5nZqJW=4ufU=oVp0GjUzh-HkLky_6S5RcJo@mail.gmail.com>
References: <1281294286-27709-1-git-send-email-newren@gmail.com>
	<1281294286-27709-2-git-send-email-newren@gmail.com>
	<AANLkTikhsFfCfmR2V8iSRvU73B5yW=_kqJAEfAGgxpLY@mail.gmail.com>
	<AANLkTimsfcSB7GMcNnZSBiwH4kwZeEazo5svW96_Nf9J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, santi@agolina.net,
	Johannes.Schindelin@gmx.de
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 22:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiCYS-0001du-0q
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 22:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394Ab0HHUdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 16:33:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41581 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab0HHUdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 16:33:04 -0400
Received: by iwn33 with SMTP id 33so3144366iwn.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+DJxdrcScyfS4isTUJWKIJ6utLrf6PCQuta8UmqJreU=;
        b=cIx7PYwjwudjqB+5S8KpxF/X8ydN1KjqGdP2tT1IjBwbWqq2euVPsMO3WLQL/pAqrf
         hliBrVHdxFfL8g3UfCxXz/Zx4sl20JMK3yI0QWwp8JD5ogRdxOcvwYExJOzV+u+qoXvb
         Zh7wnVmgMQFmOChzx9TwEato7tgWF6uqvTJ0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o4VEczaoz1WN/eiYCpR59drsTKilJ/eQ1E+ZIfsadizGni7HC9QkeGHgQWrKs4BSkH
         YNvbiw6f1YiHDR5rP3aMbH5/0+ndwzLPczNL3ydhd7ylHPI9ETkq2a9jKrdpU7N0UP/D
         ZyejyOsbxzMlR94Ra0bovHWmrJKSCucEFLf6Q=
Received: by 10.231.174.5 with SMTP id r5mr17654264ibz.132.1281299583478; Sun, 
	08 Aug 2010 13:33:03 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 8 Aug 2010 13:33:03 -0700 (PDT)
In-Reply-To: <AANLkTimsfcSB7GMcNnZSBiwH4kwZeEazo5svW96_Nf9J@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152926>

On Sun, Aug 8, 2010 at 20:17, Elijah Newren <newren@gmail.com> wrote:
> Hi,
>
> Thanks for taking a look!
>
> On Sun, Aug 8, 2010 at 2:01 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> <avarab@gmail.com> wrote:
>> On Sun, Aug 8, 2010 at 19:04, Elijah Newren <newren@gmail.com> wrote=
:
> <snip>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/5/43/ stuff &&
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "5->43" &&
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/6/42/ stuff &&
>>
>> Please use sed so the test doesn't depend on perl being present.
>
> The original series used 'sed -i', but I found out that is apparently
> not portable. =C2=A0Should I use sed + a temporary file + mv?

Yeah, a few tests do that already. E.g.:

    sed s/6/42/ <stuff >stuff.tmp &&
    mv stuff.tmp stuff

You could also just declare a dependency on perl:

    test_expect_success PERL 'setup for detecting upstreamed changes' '

But then you'd also have to use "$PERL_PATH" instead of just perl, see
t9700-perl-git.sh.
