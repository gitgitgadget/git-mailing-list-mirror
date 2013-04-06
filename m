From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/4] remote-helpers: trivial test fixes
Date: Sat, 6 Apr 2013 11:29:36 -0600
Message-ID: <CAMP44s0Lbg-_JKPR6WF6Qhkz7cgweHejA-T_V3mCO73a4iXpNA@mail.gmail.com>
References: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
	<51605546.3080503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:37:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWvv-0002PV-GR
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab3DFR3j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Apr 2013 13:29:39 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:55390 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab3DFR3i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Apr 2013 13:29:38 -0400
Received: by mail-we0-f174.google.com with SMTP id u12so3599119wey.5
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=UIGLv1n1kK4DnCFtLdBnYogGaTJI70F+jXOH1drMYes=;
        b=bNGsFUm6Tl2xJy+f+jyzkzSkY0RhJoJXz3MvB/+s9B9K8El9hIjISeFBSCZMynXePM
         tPZWmv4gAABmDyS9QaXVh6Ssyu813k+O5vuF5nUPXuLVtfzxcOpTeVZC/7PC5xw1MUm4
         uH3qHBg7gGhae4pOwNi1JALtv3QvNOi0VgLNqPqg0vsUpnqL6H4niYu9jS7tOiZiP28j
         YFSk8UYfweIyM3g0HWUdzUSMmGcNtrSV+02gSZkIZHv2CGf56YPoRDYaBtv5KpnAF8qI
         iX1oQrZY9RZoq3nHx3PBJSBBi9gJfuFIVxawE1KMMhszAUvy2RCVWVGfsmjwmjj2Pl0E
         UWPQ==
X-Received: by 10.180.210.241 with SMTP id mx17mr5060574wic.1.1365269377062;
 Sat, 06 Apr 2013 10:29:37 -0700 (PDT)
Received: by 10.194.41.2 with HTTP; Sat, 6 Apr 2013 10:29:36 -0700 (PDT)
In-Reply-To: <51605546.3080503@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220267>

On Sat, Apr 6, 2013 at 11:03 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 04.04.13 17:36, Felipe Contreras wrote:
>> Hi,
>>
>> A reroll, now we do some checks, just avoid test-lint-duplicates, an=
d fix the
>> outsanding shell portability issue. The rest is the same.
>>
>> Felipe Contreras (4):
>>   remote-bzr: avoid echo -n
>>   remote-helpers: fix the run of all tests
>>   remote-bzr: remove stale check code for tests
>>   remote-hg: fix hg-git test-case
>>
>>  contrib/remote-helpers/Makefile          |  1 +
>>  contrib/remote-helpers/test-bzr.sh       | 16 +---------------
>>  contrib/remote-helpers/test-hg-hg-git.sh |  1 -
>>  3 files changed, 2 insertions(+), 16 deletions(-)
>>
> Sorry being late, now I installed bzr and hg on one of my machines
>
> One defect found: "\s" is not portable on all grep versions
> A "*" is not a "basic regular expression", so we need to use egrep
>
>
> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpe=
rs/test-hg.sh
> index 5f81dfa..2e80c11 100755
> --- a/contrib/remote-helpers/test-hg.sh
> +++ b/contrib/remote-helpers/test-hg.sh
> @@ -115,7 +115,7 @@ test_expect_success 'update bookmark' '
>    git push
>    ) &&
>
> -  hg -R hgrepo bookmarks | grep "devel\s\+3:"
> +  hg -R hgrepo bookmarks | egrep "devel[[:space:]]+3:"
>  '

I would rather use [ \t] instead.

> 2 mninor nits:
>
> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-help=
ers/test-bzr.sh
> index 8450432..7970f9e 100755
> --- a/contrib/remote-helpers/test-bzr.sh
> +++ b/contrib/remote-helpers/test-bzr.sh
> @@ -13,7 +13,7 @@ if ! test_have_prereq PYTHON; then
>  fi
>
>  if ! "$PYTHON_PATH" -c 'import bzrlib'; then
> -       skip_all=3D'skipping remote-bzr tests; bzr not available'
> +       skip_all=3D'skipping remote-bzr tests; python bzrlib not avai=
lable'

"python bzrlib" is meaningless to the user; bazaar provides it;
basically all the code is there.

>         test_done
>  fi
>
> diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remot=
e-helpers/test-hg-hg-git.sh
> index 3f253b7..5d87282 100755
> --- a/contrib/remote-helpers/test-hg-hg-git.sh
> +++ b/contrib/remote-helpers/test-hg-hg-git.sh
> @@ -21,7 +21,7 @@ if ! "$PYTHON_PATH" -c 'import mercurial'; then
>  fi
>
>  if ! "$PYTHON_PATH" -c 'import hggit'; then
> -       skip_all=3D'skipping remote-hg tests; hg-git not available'
> +       skip_all=3D'skipping remote-hg tests; python hggit not availa=
ble'

Same. Google for 'python hggit' and the result is hg-git; and that's
what you would actually tell your package manager to install.

Cheers.

--=20
=46elipe Contreras
