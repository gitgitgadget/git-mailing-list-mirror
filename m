From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Add C_LOCALE_OUTPUT prereq to test cases that require
 English text matching
Date: Mon, 25 Jun 2012 18:32:30 +0700
Message-ID: <CACsJy8DpOL+V=sVZt3B-7OQ=POHtu1bovFB-sQ9HwPpmdKmN-A@mail.gmail.com>
References: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
 <1340541692-10834-2-git-send-email-pclouds@gmail.com> <20120624162807.GB18791@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 13:33:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj7XY-00043J-OV
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 13:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab2FYLdD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 07:33:03 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63906 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2FYLdB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 07:33:01 -0400
Received: by wgbdr13 with SMTP id dr13so4007841wgb.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TGd1SuYtwQQXdjs5zMW8ellPWB7/EyIwmuCmlppQ4cs=;
        b=r8FW49+I8iUcIi6JQGdcfGHXOy+NGtGgxCtcjnMAKbaK7boK1AKwqb9N8XkXlalV7g
         5Co3ZQDpdYqZuRh8MmC4P1/bfJO+PZAaOJhEdaBVg4io+8ARbh6qOvIER/93pM7q2QX/
         v5i+fr/3M3jWuOkkV/A4I6JsKgL+iVcJxjEZTkmQ6HGaBbO8e2BZjbWdl0hw8vd36/cp
         f2FkWwJwvRYNr37TdJdGs2DBa+cVDf7nKP/RXmDqh+oU7RFBXdz4hwgsTuep1MEQRLqt
         Et9wbL3IXEbmZrRrf0cx6siZQ6cWwX84x4SbXIyU8LY6pA9LupCs/9+UzdkgQqzVc8QG
         A2Lg==
Received: by 10.180.76.135 with SMTP id k7mr24362453wiw.7.1340623980601; Mon,
 25 Jun 2012 04:33:00 -0700 (PDT)
Received: by 10.223.79.76 with HTTP; Mon, 25 Jun 2012 04:32:30 -0700 (PDT)
In-Reply-To: <20120624162807.GB18791@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200568>

On Sun, Jun 24, 2012 at 11:28 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> This fixes all GETTEXT_POISON breakages caused by recent i18n change=
s.
>
> First, thanks much for this.
>
> Lots of these could be fixed in a more targetted way by using
> test_i18ngrep, but the C_LOCALE_OUTPUT prereq works just as well as a
> way to double-check that the newly translated strings are hopefully
> not disrupting any functionality people rely on.

I probably still don't grasp the principles behind gettext-poison.
Pretending success quietly in test_i18ngrep and test_i18ncmp makes me
uncomfortable. At least C_LOCAL_OUTPUT clearly shows the test is
skipped, which is why I prefer it over test_i18n*. Letting it run to
catch crashes is good, but not enough (it's more likely to crash with
wrong printf format specifiers for example, which gettext-poison won't
catch). Will update it according to your comments.

> [...]
>> --- a/t/t0006-date.sh
>> +++ b/t/t0006-date.sh
>> @@ -9,7 +9,7 @@ TEST_DATE_NOW=3D1251660000; export TEST_DATE_NOW
>> =C2=A0check_show() {
>> =C2=A0 =C2=A0 =C2=A0 t=3D$(($TEST_DATE_NOW - $1))
>> =C2=A0 =C2=A0 =C2=A0 echo "$t -> $2" >expect
>> - =C2=A0 =C2=A0 test_expect_${3:-success} "relative date ($2)" "
>> + =C2=A0 =C2=A0 test_expect_${3:-success} C_LOCALE_OUTPUT "relative =
date ($2)" "
>> =C2=A0 =C2=A0 =C2=A0 test-date show $t >actual &&
>> =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
>> =C2=A0 =C2=A0 =C2=A0 "
>
> Could use test_i18ncmp so we catch if test-date crashes, but anyway,
> yeah, we can't expect to be able to meaningfully test date formatting
> in another language.

This reminds me of an inkscape crash I encountered long ago because of
a mistake in Vietnamese translation. Too bad we can't test all locales
for similar bugs (or we would need to i18n-ize expected results in the
test suite too)
--=20
Duy
