From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Add C_LOCALE_OUTPUT prereq to test cases that require
 English text matching
Date: Mon, 25 Jun 2012 18:45:06 +0700
Message-ID: <CACsJy8BMizkU+P6VPhkbY_q2tYY5=aY-GNHeDjBYN9-zg2nENQ@mail.gmail.com>
References: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
 <1340541692-10834-2-git-send-email-pclouds@gmail.com> <20120624162807.GB18791@burratino>
 <CACsJy8DpOL+V=sVZt3B-7OQ=POHtu1bovFB-sQ9HwPpmdKmN-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 13:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj7ji-00026l-OV
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 13:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab2FYLpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 07:45:38 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46389 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab2FYLpi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 07:45:38 -0400
Received: by wgbdr13 with SMTP id dr13so4018596wgb.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=iYeEa2OVp10vlMhq0sQpYFmko9tOK2YjBcfZHHmt3II=;
        b=vSDcAZiDt/tbClaR7IOf0Nk3cjW94aL0K45TohqFBG5eAhZjVRmOWGi1MAttDm2twv
         6g1jslbglhjk/aYujBMssvZQFm7fWbX8tfmnjo5eqTRuTQhwFN9K+Fw6/livDo1v2TbZ
         lZNjlD/ST5/9habwbpRDFXs3am9pEYz4m2pngEiNAYe08uuPWuTjNTTmt42khYZ/naZZ
         rxj2NwjMEP5jbJtWGhMp7Sr0EZd+VaBOJNDQIiW6GeTuzCU0p//1aJXm8mOpb9DOFB07
         3Z1gBtfsuNwkgbekbCmwMViwh6LK3KSUpAGQ5cmuu1jugRAjJEqjrOXhFIb13n9Xx+z4
         ZTlw==
Received: by 10.216.194.196 with SMTP id m46mr6556001wen.197.1340624737134;
 Mon, 25 Jun 2012 04:45:37 -0700 (PDT)
Received: by 10.223.79.76 with HTTP; Mon, 25 Jun 2012 04:45:06 -0700 (PDT)
In-Reply-To: <CACsJy8DpOL+V=sVZt3B-7OQ=POHtu1bovFB-sQ9HwPpmdKmN-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200571>

On Mon, Jun 25, 2012 at 6:32 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
>>> --- a/t/t0006-date.sh
>>> +++ b/t/t0006-date.sh
>>> @@ -9,7 +9,7 @@ TEST_DATE_NOW=3D1251660000; export TEST_DATE_NOW
>>> =C2=A0check_show() {
>>> =C2=A0 =C2=A0 =C2=A0 t=3D$(($TEST_DATE_NOW - $1))
>>> =C2=A0 =C2=A0 =C2=A0 echo "$t -> $2" >expect
>>> - =C2=A0 =C2=A0 test_expect_${3:-success} "relative date ($2)" "
>>> + =C2=A0 =C2=A0 test_expect_${3:-success} C_LOCALE_OUTPUT "relative=
 date ($2)" "
>>> =C2=A0 =C2=A0 =C2=A0 test-date show $t >actual &&
>>> =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
>>> =C2=A0 =C2=A0 =C2=A0 "
>>
>> Could use test_i18ncmp so we catch if test-date crashes, but anyway,
>> yeah, we can't expect to be able to meaningfully test date formattin=
g
>> in another language.
>
> This reminds me of an inkscape crash I encountered long ago because o=
f
> a mistake in Vietnamese translation. Too bad we can't test all locale=
s
> for similar bugs (or we would need to i18n-ize expected results in th=
e
> test suite too)

What if we allow to run the test suite in non-C locales and skip the
tests that require C_LOCALE_OUTPUT? In non-C locales, we won't set
C_LOCALE_OUTPUT prerequisite. This allows to test a localized git with
~90% of the test suite. Would it work?
--=20
Duy
