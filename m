From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/t3700: convert two uses of negation operator '!' to use 
	test_must_fail
Date: Tue, 20 Jul 2010 15:55:12 +0000
Message-ID: <AANLkTil9jA8Dva_KqW67c1ZgWk9_a5S1rBViui8Jn0Os@mail.gmail.com>
References: <tMTpk3TmiYV54AYDiNJMBdnlXhSooJQQ1gRoAEsSwmcSwJ9ROgOpr75wpEQNx6_kZkqBtD71_QU@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 20 17:55:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObFAD-0004Lw-CX
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 17:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483Ab0GTPzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 11:55:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59587 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367Ab0GTPzO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 11:55:14 -0400
Received: by iwn7 with SMTP id 7so5824214iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IBt2edFLGaQlbQUvu83IpAluHFc0gI+QloW1CEhMbdE=;
        b=PTo88O+6GxXeHedY9Kdpw+0O8KNd1XixhX3y3BwNzT+byJhnRCJRRLTjgTK/B9dnl+
         HTwJ6WdPfmyXG+4Uszes42ibHYrHRm7RevGQuoypq7ZQ8IZVuut88cN0mLbcEpbALnoK
         oltw6gcMCv2dGpdN8Rgz6BzD8gUDbLgv7S5mA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kr3ZzUXndbNdyFkr7wAzjHD90szFOD9CWiMtXbAxld0bWxyI/4tlvAdrDc5CFmLTYt
         cR8J5gPM1hIAxr4i2zd3zbdkBBeQVoYMUIHi9HrBSwFk9BVAbwcAZLt+eySPnPnOogw6
         q7Q6hJaVpRI+28TcwBLsIxHLEH3+alAJagahk=
Received: by 10.231.14.201 with SMTP id h9mr7001881iba.129.1279641313302; Tue, 
	20 Jul 2010 08:55:13 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 08:55:12 -0700 (PDT)
In-Reply-To: <tMTpk3TmiYV54AYDiNJMBdnlXhSooJQQ1gRoAEsSwmcSwJ9ROgOpr75wpEQNx6_kZkqBtD71_QU@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151321>

On Tue, Jul 20, 2010 at 15:24, Brandon Casey <casey@nrlssc.navy.mil> wr=
ote:

> These two lines use the negation '!' operator to negate the result of=
 a
> simple command. =C2=A0Since these commands do not contain any pipes o=
r other
> complexities, the test_must_fail function can be used and is preferre=
d
> since it will additionally detect termination due to a signal.

Maybe I'm missing something, but unless `git add --dry-run` is special
in being killed due to a signal this seems misguided. We actually
prefer to use !, from t/README:

 - test_must_fail <git-command>

   Run a git command and ensure it fails in a controlled way.  Use
   this instead of "! <git-command>" to fail when git commands
   segfault.

> This was noticed because the second use of '!' does not include a spa=
ce
> between the '!' and the opening parens. =C2=A0Ksh interprets this as =
follows:
>
> =C2=A0 !(pattern-list)
> =C2=A0 =C2=A0 =C2=A0Matches anything except one of the given patterns=
=2E
>
> Ksh performs a file glob using the pattern-list and then tries to exe=
cute
> the first file in the list. =C2=A0If a space is added between the '!'=
 and the
> open parens, then Ksh will not interpret it as a pattern list, but in=
 this
> case, it is preferred to use test_must_fail, so lets do so.

Isn't this a completely seperate thing? Was this test really the only
bit in the test suite that did "!foo" instead of "! foo" ?

Does the test pass for you if you just:

    @@ -281,7 +281,7 @@ add 'track-this'
    =C2=A0EOF

    =C2=A0test_expect_success 'git add --dry-run --ignore-missing of
non-existing file' '
    - =C2=A0 =C2=A0 =C2=A0 !(git add --dry-run --ignore-missing track-t=
his
ignored-file >actual 2>&1) &&
    + =C2=A0 =C2=A0 =C2=A0 ! (git add --dry-run --ignore-missing track-=
this
ignored-file >actual 2>&1) &&
    =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expect actual
    =C2=A0'

?


> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> =C2=A0t/t3700-add.sh | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 47fbf53..d03495d 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -268,7 +268,7 @@ test_expect_success 'git add --dry-run of existin=
g changed file' "
>
> =C2=A0test_expect_success 'git add --dry-run of non-existing file' "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo ignored-file >>.gitignore &&
> - =C2=A0 =C2=A0 =C2=A0 ! (git add --dry-run track-this ignored-file >=
actual 2>&1) &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git add --dry-run track-this ig=
nored-file >actual 2>&1 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo \"fatal: pathspec 'ignored-file' did =
not match any files\" | test_cmp - actual
> =C2=A0"
>
> @@ -281,7 +281,7 @@ add 'track-this'
> =C2=A0EOF
>
> =C2=A0test_expect_success 'git add --dry-run --ignore-missing of non-=
existing file' '
> - =C2=A0 =C2=A0 =C2=A0 !(git add --dry-run --ignore-missing track-thi=
s ignored-file >actual 2>&1) &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git add --dry-run --ignore-miss=
ing track-this ignored-file >actual 2>&1 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expect actual
> =C2=A0'
>
> --
> 1.6.6.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
