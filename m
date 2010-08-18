From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v5 7/8] detached-stash: tests of git stash with stash-like arguments
Date: Thu, 19 Aug 2010 09:04:45 +1000
Message-ID: <AANLkTi=tuX9CPagi=j9gMt9Kr3P0G4Mpb+43w+NPbfvu@mail.gmail.com>
References: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com>
	<1282139333-5150-4-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 01:04:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olrgk-00011S-84
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 01:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab0HRXEs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 19:04:48 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:56818 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab0HRXEr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 19:04:47 -0400
Received: by qyk9 with SMTP id 9so1592728qyk.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 16:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S/sFhvMEk0ueR2WbGQJ8VF9bApxGtAf7rQLwSFn5mVc=;
        b=cikC/cWISCZmmIP8aBb2CiXdc/hjRm0qM7HMpe1JrfCXFoyWq26SmC+WBxxkBDXUHK
         D1h3U8x80eJby3e6zzcGD0UYQvemB8ABjaIVMkVfA0XHwudxkgWI/Sn2aVhpBEobJ3Fg
         2+KMKjJKcgi+haB3gGPHxDpL+pvKvj//MsUWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BhBBJA3Br3zf00zHcGkMMePMeM6p5DgsKfSKEXf9/n2CSa2RqfWXmkij30sa0krP0M
         gs6AQ+egoIGl4pcDyClmrDSdP+oFxVO94s80LQfRu8k8lJVRfU+YDWzE+yIdNvakTdmk
         wwju7OaOAejNJSVvvmhY9Prdi7VrD1y0jhdtY=
Received: by 10.229.1.208 with SMTP id 16mr988200qcg.264.1282172685792; Wed,
 18 Aug 2010 16:04:45 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Wed, 18 Aug 2010 16:04:45 -0700 (PDT)
In-Reply-To: <1282139333-5150-4-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153893>

I'll need to re-issue this patch. The later tests execute
'successfully', but don't properly implement the intent. In
particular, the condition:

! git stash stash@{0}

should really be:

! git stash drop stash@{0}.

Will re-roll a version 6, perhaps with a variant of Junio's git
rev-parse tweak...

jon.

On Wed, Aug 18, 2010 at 11:48 PM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
> Adds new tests which check that:
> * git stash branch handles a stash-like argument when there is a stas=
h stack
> * git stash branch handles a stash-like argument when there is not a =
stash stack
> * git stash show handles a stash-like argument when there is a stash =
stack
> * git stash show handles a stash-like argument when there is not a st=
ash stack
> * git stash drop fails early if the specified argument is not a stash=
 reference
> * git stash pop fails early if the specified argument is not a stash =
reference
> * git stash * fails early if the reference supplied is bogus
> * git stash fails early with stash@{n} where n >=3D length of stash l=
og
>
> | Amended per advice from Johannes Sixt to avoid burying stash create=
 failures.
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0t/t3903-stash.sh | =C2=A0140 ++++++++++++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 140 insertions(+), 0 deletions(-)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 62e208a..efc7e7f 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -378,4 +378,144 @@ test_expect_failure 'stash file to directory' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test foo =3D "$(cat file/file)"
> =C2=A0'
>
> +test_expect_success 'stash branch - no stashes on stack, stash-like =
argument' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git reset --hard HEAD" &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 echo foo >> file &&
> + =C2=A0 =C2=A0 =C2=A0 STASH_ID=3D$(git stash create) &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 git stash branch stash-branch ${STASH_ID} &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git reset --hard HEAD && g=
it checkout master && git branch -D stash-branch" &&
> + =C2=A0 =C2=A0 =C2=A0 test $(git ls-files --modified | wc -l) -eq 1
> +'
> +
> +test_expect_success 'stash branch - stashes on stack, stash-like arg=
ument' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git reset --hard HEAD" &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 echo foo >> file &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git stash drop" &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar >> file &&
> + =C2=A0 =C2=A0 =C2=A0 STASH_ID=3D$(git stash create) &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 git stash branch stash-branch ${STASH_ID} &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git reset --hard HEAD && g=
it checkout master && git branch -D stash-branch" &&
> + =C2=A0 =C2=A0 =C2=A0 test $(git ls-files --modified | wc -l) -eq 1
> +'
> +
> +test_expect_success 'stash show - stashes on stack, stash-like argum=
ent' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git reset --hard HEAD" &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 echo foo >> file &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git stash drop" &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar >> file &&
> + =C2=A0 =C2=A0 =C2=A0 STASH_ID=3D$(git stash create) &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 git stash show ${STASH_ID}
> +'
> +test_expect_success 'stash show - no stashes on stack, stash-like ar=
gument' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git reset --hard HEAD" &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 echo foo >> file &&
> + =C2=A0 =C2=A0 =C2=A0 STASH_ID=3D$(git stash create) &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 git stash show ${STASH_ID}
> +'
> +
> +test_expect_success 'stash drop - fail early if specified stash is n=
ot a stash reference' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git reset --hard HEAD && g=
it stash clear" &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 echo foo > file &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar > file &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash drop $(git rev-parse stash@{0}) &&
> + =C2=A0 =C2=A0 =C2=A0 git stash pop &&
> + =C2=A0 =C2=A0 =C2=A0 test bar =3D "$(cat file)" &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard HEAD
> +'
> +
> +test_expect_success 'stash pop - fail early if specified stash is no=
t a stash reference' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git reset --hard HEAD && g=
it stash clear" &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 echo foo > file &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar > file &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash pop $(git rev-parse stash@{0}) &&
> + =C2=A0 =C2=A0 =C2=A0 git stash pop &&
> + =C2=A0 =C2=A0 =C2=A0 test bar =3D "$(cat file)" &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard HEAD
> +'
> +
> +test_expect_success 'stash drop - bad stash ref' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar5 > file &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar6 > file2 &&
> + =C2=A0 =C2=A0 =C2=A0 git add file2 &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 ! git rev-parse --quiet --verify does-not-exis=
t &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash drop does-not-exist &&
> + =C2=A0 =C2=A0 =C2=A0 ! git rev-parse --quiet --verify does-not-exis=
t &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash drop does-not-exist@{0} &&
> + =C2=A0 =C2=A0 =C2=A0 git stash drop
> +'
> +
> +test_expect_success 'stash pop - bad stash ref' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar5 > file &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar6 > file2 &&
> + =C2=A0 =C2=A0 =C2=A0 git add file2 &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 ! git rev-parse --quiet --verify does-not-exis=
t &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash pop does-not-exist &&
> + =C2=A0 =C2=A0 =C2=A0 ! git rev-parse --quiet --verify does-not-exis=
t &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash pop does-not-exist@{0} &&
> + =C2=A0 =C2=A0 =C2=A0 git stash drop
> +'
> +
> +test_expect_success 'stash apply - bad stash ref' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar5 > file &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar6 > file2 &&
> + =C2=A0 =C2=A0 =C2=A0 git add file2 &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 ! git rev-parse --quiet --verify does-not-exis=
t &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash apply does-not-exist &&
> + =C2=A0 =C2=A0 =C2=A0 ! git rev-parse --quiet --verify does-not-exis=
t &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash apply does-not-exist@{0} &&
> + =C2=A0 =C2=A0 =C2=A0 git stash drop
> +'
> +
> +test_expect_success 'stash show - bad stash ref' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar5 > file &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar6 > file2 &&
> + =C2=A0 =C2=A0 =C2=A0 git add file2 &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 ! git rev-parse --quiet --verify does-not-exis=
t &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash show does-not-exist &&
> + =C2=A0 =C2=A0 =C2=A0 ! git rev-parse --quiet --verify does-not-exis=
t &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash show does-not-exist@{0} &&
> + =C2=A0 =C2=A0 =C2=A0 git stash drop
> +'
> +
> +test_expect_success 'stash drop - invalid stash reference' '
> + =C2=A0 =C2=A0 =C2=A0 git stash clear &&
> + =C2=A0 =C2=A0 =C2=A0 ! git stash stash@{0} &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar5 > file &&
> + =C2=A0 =C2=A0 =C2=A0 echo bar6 > file2 &&
> + =C2=A0 =C2=A0 =C2=A0 git add file2 &&
> + =C2=A0 =C2=A0 =C2=A0 git stash &&
> + =C2=A0 =C2=A0 =C2=A0 ! git drop stash@{1} &&
> + =C2=A0 =C2=A0 =C2=A0 git stash drop
> +'
> +
> =C2=A0test_done
> --
> 1.7.2.1.95.g4fabf
>
>
