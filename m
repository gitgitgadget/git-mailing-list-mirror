From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv6 16/16] Introduce portable_unset and use it to ensure
 proper && chaining
Date: Mon, 4 Oct 2010 03:26:58 +0000
Message-ID: <AANLkTinU_fv7pJqw_ghM4RoF6dsiV8PFM3GgCqD-hh7L@mail.gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
	<1286136014-7728-17-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 05:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2bhg-0004RU-D6
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 05:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765Ab0JDD07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 23:26:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52423 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab0JDD07 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 23:26:59 -0400
Received: by iwn5 with SMTP id 5so6368605iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 20:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f3tPHZqBSgCBxRxDlZmYrPB1mEm7wApF9+y8uER19SA=;
        b=NpTQgBiNgooq4czHlxg187JDOvcDDuCKhsDPmwZJgTbcmbRspKozeqXBSJhUOyPPW2
         3qhJyK3u5hGaKP0IPYprvTMpWYNgR5ESaHDrTFXND4R1wyHqCD5XLA/XrhqiC8GtBqD/
         GdMRl3CdGL9AobpG8tpGtctRLVtYGMim9qo/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=if68JiAqQIP+94NVuRsyKXn0sq0Gr3BuHi3HVjPhasMIZBXBNFJ4W8fL6J7fP2jXfB
         hypC5Drn35w4Por0LDoUUjB40VIxM1DMu/8yOCQzXF4isvBlC1LQ1h7W7E5zZkgjVu/Y
         BG+aB3+0lVkWKJcTlMc5t3EVqGgncSyYmIuHo=
Received: by 10.231.193.81 with SMTP id dt17mr7717201ibb.177.1286162818381;
 Sun, 03 Oct 2010 20:26:58 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 20:26:58 -0700 (PDT)
In-Reply-To: <1286136014-7728-17-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157965>

On Sun, Oct 3, 2010 at 20:00, Elijah Newren <newren@gmail.com> wrote:
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> =C2=A0t/README =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 13 +++++---=
-----
> =C2=A0t/t0001-init.sh =C2=A0 | =C2=A0 28 ++++++++++++++--------------
> =C2=A0t/t7006-pager.sh =C2=A0| =C2=A0 10 +++++-----
> =C2=A0t/t7502-commit.sh | =C2=A0 =C2=A04 ++--
> =C2=A0t/test-lib.sh =C2=A0 =C2=A0 | =C2=A0 11 +++++++++++
> =C2=A05 files changed, 37 insertions(+), 29 deletions(-)
>
> diff --git a/t/README b/t/README
> index ee4c0cf..e10c0ce 100644
> --- a/t/README
> +++ b/t/README
> @@ -259,14 +259,11 @@ Do:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test ...
>
> =C2=A0 =C2=A0That way all of the commands in your tests will succeed =
or fail. If
> - =C2=A0 you must ignore the return value of something (e.g., the ret=
urn
> - =C2=A0 after unsetting a variable that was already unset is unporta=
ble) it's
> - =C2=A0 best to indicate so explicitly with a semicolon:
> -
> - =C2=A0 =C2=A0 =C2=A0 unset HLAGH;
> - =C2=A0 =C2=A0 =C2=A0 git merge hla &&
> - =C2=A0 =C2=A0 =C2=A0 git push gh &&
> - =C2=A0 =C2=A0 =C2=A0 test ...
> + =C2=A0 you must ignore the return value of something, consider usin=
g a
> + =C2=A0 helper function (e.g. use portable_unset instead of unset, i=
n order
> + =C2=A0 to avoid unportable return value for unsetting a variable th=
at was
> + =C2=A0 already unset), or prepending the command with test_might_fa=
il or
> + =C2=A0 test_must_fail.

This should be:

    diff --git a/t/README b/t/README
    index a1eb7c8..dc4b9d1 100644
    --- a/t/README
    +++ b/t/README
    @@ -259,11 +259,10 @@ Do:
            test ...

        That way all of the commands in your tests will succeed or fail=
=2E If
    -   you must ignore the return value of something (e.g., the return
    -   after unsetting a variable that was already unset is unportable=
) it's
    -   best to indicate so explicitly with a semicolon:
    +   you must ignore the return value of something it's best to indi=
cate
    +   so explicitly with a test_might_fail:

    -       unset HLAGH;
    +       test_might_fail some-command &&
            git merge hla &&
            git push gh &&
            test ...
    @@ -522,6 +521,10 @@ library for your script to use.
                    ...
            '

    + - portable_unset <variable>
    +
    +   .....
    +
     Prerequisites
     -------------

Or something like that. I don't know if we came to an agreement on
using test_might_fail for non-builtins, but the docs on do's & dont's
should mention how to do that, and portable_unset should be documented
in a new section in "Test harness library".
