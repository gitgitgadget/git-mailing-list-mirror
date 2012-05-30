From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for translation
Date: Wed, 30 May 2012 12:11:07 +0700
Message-ID: <CACsJy8BvZSbsXyh3ct-M3rcWQf9Fw4VDX2VYVy+0Hv+53AQWnw@mail.gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com> <20120528224729.GK14606@burratino>
 <CACsJy8ANyMxLNCP1P28AKywssGdSQP3QnE_HZHHGzkX-4oqFtw@mail.gmail.com>
 <20120529121428.GD14697@burratino> <7vmx4q4ycj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 30 07:11:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZbCE-0007Pb-1S
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 07:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582Ab2E3FLl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 01:11:41 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:32841 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab2E3FLj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 01:11:39 -0400
Received: by weyu7 with SMTP id u7so3088130wey.19
        for <git@vger.kernel.org>; Tue, 29 May 2012 22:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OTRZV9fCcSfd/JNmv8W1cswHJDGEkDov8xUziYRAdTo=;
        b=xVt+j8iKb4Y6X7MXw30N08JeEmGZP347QepC5TU9Cc1zM5oqUxAM8J3sdCrfDO2+P5
         0WtiauWk5tww6DqTiNhJrFkYBjNBabWar9fNPs1mX6SZAVlmAT//jGdH0Wwsd0d9OGUy
         enpKulAH4MPNIMBuUTSdzr2CJG1fmPvfV7Dl4nnbEzew07gHRQxY7W3izFprT4+RgeG0
         hUQyWUimS5S7khmIAkfyy3eQ11s5wamRmn2qyNN1Lg7VfS7wAIVaLDRv9VdnYGW+G+cC
         OExt5my99zZ+Ti10WP2zVoge4wpncCZoKp/3Ob9Wtmn4jdFvWldDa/uGyosVKhTiRE2R
         3QZg==
Received: by 10.216.212.157 with SMTP id y29mr9950242weo.146.1338354698178;
 Tue, 29 May 2012 22:11:38 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Tue, 29 May 2012 22:11:07 -0700 (PDT)
In-Reply-To: <7vmx4q4ycj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198780>

On Wed, May 30, 2012 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Nguyen Thai Ngoc Duy wrote:
>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 The test suite is currently more focused on
>>> features than human readable output.
>>
>> Thanks for clarifying this. =C2=A0Yes, that's the point of the
>> GETTEXT_POISON check. =C2=A0It is supposed to make sure that running=
 git in
>> another locale does not break features by modifying text that
>> (internal and external) scripts parse.
>
> Correct. =C2=A0The most important thing to review in test scripts is =
that
> tests that verify output from the plumbing commands are *not* marked
> with GETTEXT_POISON (hence test_i18ncmp). =C2=A0IOW, storing "ls-file=
s"
> output and then checking it with expected result using test_i18ncmp
> is *wrong*, as it won't catch mistakenly marking plumbing messages
> with _() and N_().

The intention is good, but the execution is not. Requiring special
flag to turn this feature on loses its value as normal "make test"
does not catch stuff like this. We might want to turn this on by
default (at least in the test suite), or LD_PRELOAD this feature in
when the test suite is run. Or generate a poisoned .mo file, then make
git use that.

Another thing is GETTEXT_POISON poisons too much. printf(_("this is
%s\n"), path); is turned to "# GETTEXT POISON #". There's no way for
test scripts to verify the correct "path" output.

Anyway I'll send a fixup patch later to make gettext poison test run pa=
ss again.
--=20
Duy
