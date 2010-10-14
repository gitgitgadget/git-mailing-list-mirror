From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] Makefile: new prove target for running the tests with TAP
Date: Thu, 14 Oct 2010 09:05:30 +0000
Message-ID: <AANLkTimuoanpbFbyv9C8qUbut22me1gMhH02eLqg0Nyd@mail.gmail.com>
References: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 11:05:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Jkq-0001A5-MS
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 11:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab0JNJFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 05:05:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40783 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab0JNJFd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 05:05:33 -0400
Received: by fxm4 with SMTP id 4so2241973fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 02:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d8BpGi/lOZwGUkqPKjfuYWRXE3mls5Kyw/8qSNvX5wQ=;
        b=gnxmagyZ/t/bK3hfS8bsRfnAHdTMFRCN3LZU/yq1+7HVna21pPT/PPiHQcaTUndMXH
         OiCuN7UbsMaFGxTExIW4J06B4FO8/qkJflkkzaOIJ9jusQHnWLM+qukdI7v3oy7i93MY
         CGy4LDfvfPs/GbMYo+Bt3WzTVjjbTdGqb4Exs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OfwOF8XkoESo2PFT3p8PlSZxc7jXSiZjQDAgWKPKJJys1OTogzLII3wefCIbOZ3jkb
         g+cwYwKRH9zCYjCWqZPw6sp17gQhUtCn8cFF/2yhCNVB3h7/P65K1wC8Ip7+7czMFW7o
         GuTYsDV5+mLAz8evpPUiV1V7xNdPhn9QJrMG0=
Received: by 10.103.124.7 with SMTP id b7mr1794331mun.102.1287047130163; Thu,
 14 Oct 2010 02:05:30 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 02:05:30 -0700 (PDT)
In-Reply-To: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159033>

On Thu, Oct 14, 2010 at 08:53, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Introduce a new make target "prove" which runs the tests via "prove" =
(or
> $(PROVE) if set) so that one does not have to cd around any more. One
> can simply use "make prove" for "make test" or go wild as in:
>
> GIT_SKIP_TESTS=3D't[0-4]??? t91?? t9200.8' GIT_PROVE_OPTS=3D"-j9 -v" =
GIT_TEST_OPTS=3D"--verbose --debug" make prove
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> RFC also because of lack of doc, and:
>
> Currently, one can do
>
> make -C t t6010-merge-base.sh
>
> or even
>
> make -C t t601*
>
> which is cool but undocumented. If we want this with prove it require=
s more
> effort, or shoving prove into the $(T) target rule which is doable, o=
f course.
> I'm just wondering whether it's accepted to introduce a specific rule=
 for prove
> at all.

I like the rationale behind this, but fwiw. I already had a patch that
was ejected for this:

    http://article.gmane.org/gmane.comp.version-control.git/146566

Quoth Junio:

    "Besides, "make -j15 test" from the toplevel already runs the
    tests in parallel.  I don't see much point in this change."

But I'd like to have it so that I could `make && make test_harness`
and get readable test output.

But we should probably be using t/harness to run them, not
prove(1). Then we would make the test_harness target respect the
HARNESS_OPTIONS variable, which I e.g. have set to HARNESS_OPTIONS=3Dj9
on my system.

>
> =C2=A0Makefile =C2=A0 | =C2=A0 =C2=A03 +++
> =C2=A0t/Makefile | =C2=A0 =C2=A05 +++++
> =C2=A02 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1f1ce04..3478515 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2046,6 +2046,9 @@ export NO_SVN_TESTS
> =C2=A0test: all
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(MAKE) -C t/ all
>
> +prove: all
> + =C2=A0 =C2=A0 =C2=A0 $(MAKE) -C t/ prove
> +
> =C2=A0test-ctype$X: ctype.o
>
> =C2=A0test-date$X: date.o ctype.o
> diff --git a/t/Makefile b/t/Makefile
> index c7baefb..e4661c0 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -11,6 +11,7 @@ SHELL_PATH ?=3D $(SHELL)
> =C2=A0PERL_PATH ?=3D /usr/bin/perl
> =C2=A0TAR ?=3D $(TAR)
> =C2=A0RM ?=3D rm -f
> +PROVE ?=3D prove
>
> =C2=A0# Shell quote;
> =C2=A0SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
> @@ -21,6 +22,10 @@ TSVN =3D $(wildcard t91[0-9][0-9]-*.sh)
> =C2=A0all: pre-clean
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(MAKE) aggregate-results-and-cleanup
>
> +prove: pre-clean
> + =C2=A0 =C2=A0 =C2=A0 @echo "*** prove ***"; GIT_CONFIG=3D.git/confi=
g $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TE=
ST_OPTS)
> + =C2=A0 =C2=A0 =C2=A0 $(MAKE) clean
> +
> =C2=A0$(T):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0@echo "*** $@ ***"; GIT_CONFIG=3D.git/conf=
ig '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
>
> --
> 1.7.3.1.184.g5b1fd
>
>
