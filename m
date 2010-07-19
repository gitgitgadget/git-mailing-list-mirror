From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] blame: Add tests for -L/start/,/end/
Date: Mon, 19 Jul 2010 21:21:49 +0000
Message-ID: <AANLkTinyTFzZgL2U7cvwnRVJeZTAhS3xW4v3TT6llVAn@mail.gmail.com>
References: <1279294507-9238-1-git-send-email-avarab@gmail.com>
	<7voce3nppy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 23:21:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oaxme-0003SL-QE
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 23:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966821Ab0GSVVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 17:21:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51652 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965514Ab0GSVVu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jul 2010 17:21:50 -0400
Received: by fxm14 with SMTP id 14so2427304fxm.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s2HpLwuU4r0eoNfo0FH7S8mB7yjkwUgSHvsqCit295M=;
        b=xMbP3d7YF/k0tofEwypDXXuCm2gbmGNTWtLNjuxP0qcokepYthDXNGfV57rJazuVe1
         037Krp9w56LZe8DqCiujIZAWn94SISexKb9JYRNKI5iItu4iEMcXL11UhMqSgiX2T8ty
         AjpCqdFDH3zHe2mLwQ8hy3dkhGO/mhHlsW8Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ft5BB4opRmTWg/ok2dEpOrVIRY3SJFwtE0m3jecBzdFJyTSPmjCi+gQjE8uH3VMsD3
         SbCtFBp2AASpipxnAGtJJ/bmM+7Bq+GU9P9zWbhD/eKqVNONtoEwTTqDofsfhes2e7l4
         9CfsN3NvAn2lYygqFjIlFOdX9z6l61pSkAn4Y=
Received: by 10.86.59.14 with SMTP id h14mr3268194fga.70.1279574509170; Mon, 
	19 Jul 2010 14:21:49 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Mon, 19 Jul 2010 14:21:49 -0700 (PDT)
In-Reply-To: <7voce3nppy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151287>

On Mon, Jul 19, 2010 at 21:09, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> git-pickaxe (later git-blame) gained support for the -L/start/,/end/
>> form in 2006 (931233bc66 by Junio C Hamano), but nothing was added t=
o
>> test this functionality. Change that by adding more -L tests to
>> t8003-blame.sh.
>
> If we look at the existing tests carefully, there is no tests for the
> range notation -L<start>,<end> in general, not just the regexp varian=
t. =C2=A0A
> few existing uses are only to limit the output for testing other feat=
ures
> and take it granted that -L works correctly (meaning they may detect =
it if
> you break -L implementation but that is merely a side effect).

I didn't submit tests for -L in general because I'm not happy with how
it behaves (as noted in "[BUG?] blame: Odd -L 1,+0 behavior"). So this
patch only tests the regex portion of parse_loc().

I might add tests for -L in general it later, but that patch will
probably include a behavior change.

>> +for comma in '' ','
>> +do
>> + =C2=A0 =C2=A0 # The comma in -L/regex/, is optional
>
> Is it just -L/regex/? =C2=A0I thought -L<start> regardless of the sha=
pe of <start>
> was equivalent to -L<start>,END-OF-FILE.

No, it's not just -L/regex/, but I try to in general to write tests
for thing that *might* break, not just things that are guaranteed not
to break as things are now implemented. If blame.c is rewritten in the
future "-L123", might continue to work but "-L/start/," might be
broken as a result of some code shuffling.

>> +test_expect_success 'blame -LINT,/end/' '
>> + =C2=A0 =C2=A0 git blame -L3,/GH/ cow =C2=A0>current 2>errors &&
>
> This is somewhat an interesting one. =C2=A0It asks for a range that b=
egins at
> the third line in the file, extending to a line after that line that
> matches the given expression. =C2=A0Unfortunately the test vector doe=
s not have
> a line that contains GH before the third line, nor more than one line=
s
> that contain GH after the third line (we should stop at the first hit=
), so
> this test is not as effective as it could be.

Yeah, I didn't test for ambiguities like that. I was going to expand
on that later, but see above about not having patched that yet.

>> +test_expect_success 'blame -L,/end/' '
>> + =C2=A0 =C2=A0 git blame -L",/^X/" cow >current 2>errors &&
>
> Missing <start> defaults to the beginning of file; the same as -L,INT=
 and
> not specific to the regex variant.

Yup, but I think it should be tested for anyway.

>> +test_expect_success 'blame -L/invalid regex/' '
>> + =C2=A0 =C2=A0 # At least GNU, Solaris and FreeBSD (and by extensio=
n, Mac OS X)
>> + =C2=A0 =C2=A0 # complain about this
>> + =C2=A0 =C2=A0 ! git blame -L/[b-a]/ cow >current 2>errors &&
>> + =C2=A0 =C2=A0 grep b-a errors &&
>
> The b-a in the error message comes from us, not the regex library, so=
 this
> test should be portable, I think, as long as the library detects the =
empty
> range correctly.

Yeah, it's just a test for:

    1. Invalid regexes being detected at all, i.e. git not ignoring
       the return value of regcomp().

    2. That we have an error message at all for it, and that the error
        message includes the invalid regex that the user supplied.
