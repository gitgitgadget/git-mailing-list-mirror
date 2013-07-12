From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] add a testcase for checking case insensitivity of mailmap
Date: Fri, 12 Jul 2013 18:38:42 -0400
Message-ID: <CAPig+cTE7ELo9xfNqOCq1p7xUgOUrr9WDiRkTbXgHPjqtzeEsw@mail.gmail.com>
References: <1373665135-32484-1-git-send-email-gitster@pobox.com>
	<1373665135-32484-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 00:39:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxlzW-0001Xy-V4
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 00:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757836Ab3GLWiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 18:38:46 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:53127 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757555Ab3GLWip (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 18:38:45 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so7966761lba.2
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=oUJkhlCx29n0wlUysU4Szlfyr+a3blsrkUlMUEddyt4=;
        b=e0p0EPPUStJDCOyTBanTE83/6S7cihFdZvJ3EQ/0C8sHhcS1JHR/rWs4iJhNk/KLVN
         ftip/A9S/lDYeTD5RmpyxISMsAy0+o73Qikp0HVaZkt6Gb/Vu2a68iOTQpEup1jfvZG6
         hJMwKH+axpfO7GZaQBZ05XGatyea6llmZAcDHxv/creprsf2iy43yrlaVAiyhJ6bPMx7
         B0B66BjDpb7UJdVtOXpD+8gHEOlXbUkbK26FQLc1kAQO26bHPGp3KnWhDEOk+K6wWjng
         fen4ag7lL0D2IO92xi5GeytPR6TQFr4pdoBTCJGKWH0iywE3Sm2cgy5s/z799vw6z2Xv
         WUxw==
X-Received: by 10.112.12.225 with SMTP id b1mr20284832lbc.3.1373668722990;
 Fri, 12 Jul 2013 15:38:42 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Fri, 12 Jul 2013 15:38:42 -0700 (PDT)
In-Reply-To: <1373665135-32484-5-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: 2QXrgWNDf7zfTwi8CMUFj7IGW28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230263>

On Fri, Jul 12, 2013 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> From: Stefan Beller <stefanbeller@googlemail.com>
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t4203-mailmap.sh | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 842b754..07152e9 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -409,4 +409,37 @@ test_expect_success 'Blame output (complex mapping)' '
>         test_cmp expect actual.fuzz
>  '
>
> +test_expect_success 'cleanup after mailmap.blob tests' '
> +       rm -f .mailmap
> +'

This "test" was copied from earlier in the file, but the description
was not updated; it has nothing to do with mailmap.blob tests for
which cleanup has already taken place.

It's also misleading since no .mailmap file exists at this point.
Instead, configuration key mailmap.file is set to
internal_mailmap/.mailmap, so if you need to clean up anything, it
would be that.

(You're also recreating .mailmap from scratch directly in your test
via "echo foo >.mailmap", so this "test" doesn't really add anything.)

> +cat >expect <<\EOF
> +     2 A <A@example.org>
> +     2 Other Author <other@author.xx>
> +     2 Santa Claus <santa.claus@northpole.xx>
> +     1 A U Thor <author@example.com>
> +     1 CTO <cto@company.xx>
> +     1 Some Dude <some@dude.xx>
> +EOF
> +
> +test_expect_success 'Test case sensitivity of Names' '

s/Names/names/

Also, most of the test descriptions in this script start with
lowercase, so s/Test/test/ would be appropriate.

> +       # do a commit:
> +       echo "asdf" > test1

Git practice normally avoids whitespace after the redirection
operator. This particular test script, has a mix of ">foo" and ">
foo", but we may want to avoid adding more of the latter form.

> +       git add test1
> +       git commit -a --author="A <A@example.org>" -m "add test1"
> +
> +       # commit with same name, but different email
> +       # (different capitalization does the trick already,
> +       # but here I am going to use a different mail)

Without context of the mailing list discussion, the reader does not
know what "trick" is or precisely how this may have failed in the
past. It's also not clear why the test is being performed with a
different email address entirely rather than one which differs only by
case (which is what the test description talks about).

> +       echo "asdf" > test2

Whitespace after redirection.

> +       git add test2
> +       git commit -a --author="A <changed_email@example.org>" -m "add test2"
> +
> +       # Adding the line to the mailmap should make life easy, so we know
> +       # it is the same person

The comment can probably be dropped, as the new .mailmap entry is
self-explanatory.

> +       echo "A <A@example.org> <changed_email@example.org>" > .mailmap

Whitespace after redirection.

> +
> +       git shortlog -sne HEAD >actual && test_cmp expect actual

For consistency with more other tests, perhaps break the line apart:

  git shortlog -sne HEAD >actual &&
  test_cmp expect actual

> +'
> +
>  test_done
> --
> 1.8.3.2-941-gda9c3c8
