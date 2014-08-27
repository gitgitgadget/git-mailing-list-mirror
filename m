From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Windows tests: let $TRASH_DIRECTORY point to native
 Windows path
Date: Wed, 27 Aug 2014 20:08:23 +0700
Message-ID: <CACsJy8CDZCkQNSfu7HMvfv6++fjr9V6KvhFmgqBQMyd4qnqMtg@mail.gmail.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com> <53CFC414.1010601@gmail.com>
 <CACsJy8DqdTWqVimK0o4rcBXL==iZCsu1OgX2W9ZbgebcSDaKxg@mail.gmail.com> <53D7F97B.7060607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 15:09:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMcyB-0001cB-OV
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 15:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933706AbaH0NIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 09:08:55 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:48358 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933551AbaH0NIy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 09:08:54 -0400
Received: by mail-ig0-f169.google.com with SMTP id r2so7259695igi.4
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z7t7RtPcsQfbExMBNix3MZFHzNrRjNzIb/V/DhxFIso=;
        b=ZBHHloClcG+iK//CNsIWnijnSlK38H7LQwm/MmOPI08uHPzITkG7jqRtwz2CRiGH7S
         5z+IlzfLDy/dXO+XqJUJp+JA7iRVohHlGur4OZaABmBbRgkAjfK+n7Yad8gFvooCE12D
         Gn1mDYWObDedETZjNWyQYZsvXNlWKvjbLnARkn0I9O80HTJVznymSDNxj0EoRK/Ty7fR
         fwtqWnqofqXRhEQyWhTc2Y+XS8bYw8vaaUBfp1G6hYHWt47/Zc6AFAr9pB5pK08VecKd
         v9ypVZLmz3YcEMKaTfmBJlrWSmRa6W7yXPJ5KhCi1nGlG8EGA5Gwq0i4uNDNZoUfdXSD
         JgfQ==
X-Received: by 10.50.43.164 with SMTP id x4mr30063006igl.27.1409144933561;
 Wed, 27 Aug 2014 06:08:53 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Wed, 27 Aug 2014 06:08:23 -0700 (PDT)
In-Reply-To: <53D7F97B.7060607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255992>

Ping...

On Wed, Jul 30, 2014 at 2:43 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> MSYS programs typically understand native Windows paths (e.g C:/git), but
> native Windows programs (including MinGW) don't understand MSYS paths (e.g.
> /c/git).
>
> On Windows, set TRASH_DIRECTORY to the absolute native path so that it can
> be used more easily in tests.
>
> MSYS 'tar -f' interprets everything before ':' as hostname, not as drive
> letter. Change respective tests to use stdin / stdout instead of '-f'. Also
> use $TAR from GIT-BUILD-OPTIONS rather than hardcoded tar.
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
>
> Am 25.07.2014 14:30, schrieb Duy Nguyen:
>> On Wed, Jul 23, 2014 at 9:17 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>>> With the version in pu, three tests fail. t7001 is fixed with a newer 'cp'.
>>> The other two are unrelated (introduced by nd/multiple-work-trees topic).
>>>
>>> * t1501-worktree: failed 1
>>>   As of 5bbcb072 "setup.c: support multi-checkout repo setup"
>>>   Using $TRASH_DIRECTORY doesn't work on Windows.
>>>
>>> * t2026-prune-linked-checkouts: failed 1
>>>   As of 404a45f1 "prune: strategies for linked checkouts"
>>>   Dito.
>>
>> I need your help here. Would saving $(pwd) to a variable and using it
>> instead of $TRASH_DIRECTORY work? Some tests "cd" around and $(pwd)
>> may not be the same as $TRASH_DIRECTORY.
>>
>
> Yes, that would work.
>
> (Actually, you'd only need to change 'echo "$TRASH_DIR..."' in two places (both
> before cd'ing away). The other instances are parameters to non-msys programs and
> are thus automatically mangled by msys.dll.)
>
> However, I wonder why we don't set up TRASH_DIRECTORY to the native Windows path.
> I believe we'd get much fewer 'special' cases that way. Ideally, you shouldn't
> have to worry about the intricacies of MSYS path mangling when writing tests...
>
> [CCing msysgit for opinions]
>
>
>  t/t3513-revert-submodule.sh | 4 ++--
>  t/t6041-bisect-submodule.sh | 4 ++--
>  t/test-lib.sh               | 1 +
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
> index a1c4e02..4a44dd6 100755
> --- a/t/t3513-revert-submodule.sh
> +++ b/t/t3513-revert-submodule.sh
> @@ -14,11 +14,11 @@ test_description='revert can handle submodules'
>  git_revert () {
>         git status -su >expect &&
>         ls -1pR * >>expect &&
> -       tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
> +       "$TAR" cz * >"$TRASH_DIRECTORY/tmp.tgz" &&
>         git checkout "$1" &&
>         git revert HEAD &&
>         rm -rf * &&
> -       tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
> +       "$TAR" xz <"$TRASH_DIRECTORY/tmp.tgz" &&
>         git status -su >actual &&
>         ls -1pR * >>actual &&
>         test_cmp expect actual &&
> diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
> index c6b7aa6..0de614f 100755
> --- a/t/t6041-bisect-submodule.sh
> +++ b/t/t6041-bisect-submodule.sh
> @@ -8,7 +8,7 @@ test_description='bisect can handle submodules'
>  git_bisect () {
>         git status -su >expect &&
>         ls -1pR * >>expect &&
> -       tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
> +       "$TAR" cz * > "$TRASH_DIRECTORY/tmp.tgz" &&
>         GOOD=$(git rev-parse --verify HEAD) &&
>         git checkout "$1" &&
>         echo "foo" >bar &&
> @@ -20,7 +20,7 @@ git_bisect () {
>         git bisect start &&
>         git bisect good $GOOD &&
>         rm -rf * &&
> -       tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
> +       "$TAR" xz <"$TRASH_DIRECTORY/tmp.tgz" &&
>         git status -su >actual &&
>         ls -1pR * >>actual &&
>         test_cmp expect actual &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 5102340..5f6397b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -868,6 +868,7 @@ case $(uname -s) in
>                 md5sum "$@"
>         }
>         # git sees Windows-style pwd
> +       TRASH_DIRECTORY=$(pwd -W)
>         pwd () {
>                 builtin pwd -W
>         }
> --
> 2.0.2.897.g7f80809.dirty
>



-- 
Duy
