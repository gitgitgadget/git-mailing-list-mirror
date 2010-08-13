From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] t5525: test the tagopt variable and that it can be overridden
Date: Fri, 13 Aug 2010 20:55:35 +0000
Message-ID: <AANLkTimYm+GmJ4BmZKOmcZkJf_wgeUiKhTs06qxex+0q@mail.gmail.com>
References: <7v8w4bmhmc.fsf@alter.siamese.dyndns.org>
	<1281730410-20009-1-git-send-email-ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 22:55:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1Hy-0006vU-M0
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab0HMUzg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:55:36 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37113 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab0HMUzf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 16:55:35 -0400
Received: by gxk23 with SMTP id 23so1120449gxk.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RCsKE5gxFYCWWTOMb6o/NJvJjiHKpFUVcMlQDfl3lKE=;
        b=cXB1uFUNTou6dNzk2oYj2FJy2LVirj0faO4i0r9q2T+KDQpgg8rNWENUAvFqRXx44N
         7ML5PclOLbeaNlFiY/MbYOXYUDI7mCaefM6NAkzOS+t/87OQHIrC+l3Czldhik8j/RY7
         0bF5v/sxyCt4RohJ8Cu/GpurcrJV1hnLiUIdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wiCBeyo/7WHT+GN7sSOeEKDY1LwQT38vHlSllnl8xd27DJ9m6/umEGHROHTKLUd3YJ
         LsFSMsg5JOiJ/oCsQ/5yP1NnsHVc2tWgUTj+v5JkLucLRJ07J6MJmk/kcLsAx5RyLzY0
         2iNA/nr5BOomusIV07o0mBAObRu5oFdTlJJyA=
Received: by 10.151.24.11 with SMTP id b11mr2470700ybj.317.1281732935120; Fri,
 13 Aug 2010 13:55:35 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 13:55:35 -0700 (PDT)
In-Reply-To: <1281730410-20009-1-git-send-email-ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153506>

On Fri, Aug 13, 2010 at 20:13, Daniel Johnson <computerdruid@gmail.com>=
 wrote:
> ---
>> The current behaviour seems to me a bug introduced while git-fetch w=
as
>> rewritten in C (the original found in contrib/examples reads from th=
e
>> config only when no --tags/--no-tags option is given from the comman=
d
>> line).
>>
>> Is this something we can protect with a test script from future brea=
kages?
> This should test that behavior. I'd appreciate feedback on how to imp=
rove this
> test. I'm not sure if this is the right name/number either.

Thanks for tackling this.

> =C2=A0t/t5525-fetch-tagopt.sh | =C2=A0 44 +++++++++++++++++++++++++++=
+++++++++++++++++
> =C2=A01 files changed, 44 insertions(+), 0 deletions(-)
> =C2=A0create mode 100755 t/t5525-fetch-tagopt.sh
>
> diff --git a/t/t5525-fetch-tagopt.sh b/t/t5525-fetch-tagopt.sh

The test name looks fine.

(The t55* test names are a bit of a mess with mixed pull/fetch, but
that's not something that should be dealt with here)

> new file mode 100755
> index 0000000..17bd407
> --- /dev/null
> +++ b/t/t5525-fetch-tagopt.sh
> @@ -0,0 +1,44 @@
> +
> +#!/bin/sh

Is that an empty line before the test begins? The shebang should be on
the first line.

> +test_description=3D'tagopt variable affects "git fetch" and is overr=
idden by commandline.'
> +
> +. ./test-lib.sh
> +
> +setup_clone () {
> + =C2=A0 =C2=A0 =C2=A0 (git clone --mirror . $1 &&
> + =C2=A0 =C2=A0 =C2=A0 git remote add remote_$1 $1 &&
> + =C2=A0 =C2=A0 =C2=A0 cd $1 &&
> + =C2=A0 =C2=A0 =C2=A0 git tag tag_$1)
> +}

Maybe only put the "cd $1 ..." inside a subshell for clarity.

> +test_expect_success setup '
> + =C2=A0 =C2=A0 =C2=A0 echo >file original &&
> + =C2=A0 =C2=A0 =C2=A0 git add file &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -a -m original &&

Maybe this can use test_commit if you don't mind it creating a tag
too.

> + =C2=A0 =C2=A0 =C2=A0 setup_clone one &&
> + =C2=A0 =C2=A0 =C2=A0 git config remote.remote_one.tagopt --no-tags =
&&
> + =C2=A0 =C2=A0 =C2=A0 setup_clone two &&
> + =C2=A0 =C2=A0 =C2=A0 git config remote.remote_two.tagopt --tags
> + =C2=A0 =C2=A0 =C2=A0 '
> +
> +test_expect_success "fetch with tagopt=3D--no-tags does not get tag"=
 '
> + =C2=A0 =C2=A0 =C2=A0 git fetch remote_one &&
> + =C2=A0 =C2=A0 =C2=A0 ! (git show-ref tag_one)
> + =C2=A0 =C2=A0 =C2=A0 '

Doesn't need a subshell? You should also use:

    test_must_fail git show-ref ...

> +test_expect_success "fetch --tags with tagopt=3D--no-tags gets tag" =
'
> + =C2=A0 =C2=A0 =C2=A0 git fetch --tags remote_one &&
> + =C2=A0 =C2=A0 =C2=A0 (git show-ref tag_one)
> + =C2=A0 =C2=A0 =C2=A0 '

Doesn't need a subshell?

> +test_expect_success "fetch --no-tags with tagopt=3D--tags does not g=
et tag" '
> + =C2=A0 =C2=A0 =C2=A0 git fetch --no-tags remote_two &&
> + =C2=A0 =C2=A0 =C2=A0 ! (git show-ref tag_two)
> + =C2=A0 =C2=A0 =C2=A0 '
> +
> +test_expect_success "fetch with tagopt=3D--tags gets tag" '
> + =C2=A0 =C2=A0 =C2=A0 git fetch remote_two &&
> + =C2=A0 =C2=A0 =C2=A0 (git show-ref tag_two)
> + =C2=A0 =C2=A0 =C2=A0 '
> +test_done

test_must_fail etc etc.

Otherwise it looks good.
