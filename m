From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] tests: use test_cmp instead of piping to diff(1)
Date: Wed, 15 Sep 2010 23:15:36 +0000
Message-ID: <AANLkTimpV20yGKw57raxho-8zSymLEvXgXSAayEmb7M9@mail.gmail.com>
References: <1284411582-1088-1-git-send-email-avarab@gmail.com>
	<7vy6b59q5a.fsf@alter.siamese.dyndns.org>
	<AANLkTinGt6d8tKh8yOT0SJpcgsv+KgrE4jPT2_RgGzeG@mail.gmail.com>
	<4C90029F.6020909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:15:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow1CZ-0007mb-LX
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab0IOXPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 19:15:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37698 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab0IOXPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 19:15:37 -0400
Received: by iwn5 with SMTP id 5so487628iwn.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MDPaytulk5pG1RHL2BOe11lTkUDQ4GnaUrOdUNom35c=;
        b=ppCACxdKMK5NoagEJTp30w6kCO/7EYR6oUWpOlGPQNDKD2FquqvOvHEw/TXunIPSQb
         bVMXq2CGqYu/q1PJpWOhifVCHHHbL2Szz2E1cjkCKvcGVwwn6lXCY/mKsVK3UxJUt1WG
         vU7zgwCz7V/xdes6scvcqP3wSTdw/wZpNJFDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V9/BsHI1e6Q+AQG5hPe05d3AkN72E+xOw/6nIOiiHXuumy1Za2VdVLhnEwMlrpAkdo
         bJl0Goz9xgJxz9+kmrCB7WczRKeFKGHyLZpdB4IJ3P6BklUmSHw/rBLfi45/Yf5V/zXV
         wjg4KdvbwHGF+yivd8toXiFfqZtlkt39J1Gs8=
Received: by 10.231.157.195 with SMTP id c3mr2349029ibx.155.1284592536590;
 Wed, 15 Sep 2010 16:15:36 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 15 Sep 2010 16:15:36 -0700 (PDT)
In-Reply-To: <4C90029F.6020909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156271>

On Tue, Sep 14, 2010 at 23:17, Jens Lehmann <Jens.Lehmann@web.de> wrote=
:
> Am 14.09.2010 03:45, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Mon, Sep 13, 2010 at 23:31, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> @@ -37,9 +37,10 @@ head1=3D$(add_file sm1 foo1 foo2)
>>>> =C2=A0test_expect_success 'added submodule' "
>>>> =C2=A0 =C2=A0 =C2=A0 git add sm1 &&
>>>> =C2=A0 =C2=A0 =C2=A0 git diff-index -p --submodule=3Dlog HEAD >act=
ual &&
>>>> - =C2=A0 =C2=A0 diff actual - <<-EOF
>>>> + =C2=A0 =C2=A0 cat >expected <<-EOF &&
>>>> =C2=A0Submodule sm1 0000000...$head1 (new submodule)
>>>> =C2=A0EOF
>>>> + =C2=A0 =C2=A0test_cmp expected actual
>>>> =C2=A0"
>>>
>>> Nit. =C2=A0Did you really mean <<-EOF, not <<EOF, here, especially =
you are
>>> writing the here document without indentation with any TAB?
>>
>> I just meant to replace the diff invocations with test_cmp. Changing
>> the surrounding here-docs was outside the scope of the patch.
>
> I plead guilty for introducing the "<<-EOF"s in the first place by
> simply copying the frame for this test from t7401. But me too thinks
> the "test_cmp" should have TABs in front of them instead of spaces.
>
> With the "TAB in front of test_cmp" issue fixed you may add:
> Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

Junio, since you picked this up as part of the ab/i18n branch I fixed
this issue up there. You can pull it from the usual place
(git://github.com/avar/git.git ab/i18n).

I didn't switch to TAB in all cases, but only the ones where the
surrounding test code already used TAB. t4041-diff-submodule-option.sh
uses TAB for indent, but t7401-submodule-summary.sh does not, this way
my patch retains the indentation of the surrounding code.

(I didn't add Jens's Acked-by to the patch since I didn't strictly do
what he was suggesting).
