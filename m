From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv2 4/4] t7500: add tests of commit --squash
Date: Wed, 22 Sep 2010 18:12:09 +0000
Message-ID: <AANLkTi=MjE3OBqAd8NqFCMdSb3qfNW_1QKvrL6-AK+Er@mail.gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com>
	<1285100703-49087-5-git-send-email-patnotz@gmail.com>
	<AANLkTinTA23Xf2AFLW+tzeLq1AWUhBBuca63qs_foXtr@mail.gmail.com>
	<AANLkTinajr6DvYeyiK79xESYqg0kegUN1s8LxEqGoUc+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 20:12:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyTnm-0007tt-OF
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 20:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab0IVSML convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 14:12:11 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59830 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349Ab0IVSMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 14:12:10 -0400
Received: by gxk9 with SMTP id 9so266081gxk.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f8dafWAWMrWNT6WpM55U10GhD7kITQNzCHkS/mlagW0=;
        b=VQXv9ETA1Jqwk+8aLKqhyHFg3TBUlLHYLvY223rttJtIlsO3Dha5tdk3OrBwR+SkVx
         w3847gv/pJULEpTxG415Lwyu+rePyCM56VF96q3rRlAYUN4+XGGOVJAOScTuHi5gvlYE
         /oVKvv/UyjbeF9CNh9ousPiX3lxKtTTzMddaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fAQL/7urrRZrdA0UNPluLFDxozh3CcFeob8wuHdKuXbxQLgTjKVLUyEXwA44o1mMvh
         9SYJS8hZKg5tty0DKGQ47Vicf39XpdaDUikyMdI+R+/qjn8S3txkBieDOLH5uQWYl2Nl
         FzCAuIezBHyad8LFzUG8PcrG72uDYOFLzAddQ=
Received: by 10.90.49.2 with SMTP id w2mr1096572agw.119.1285179129772; Wed, 22
 Sep 2010 11:12:09 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 22 Sep 2010 11:12:09 -0700 (PDT)
In-Reply-To: <AANLkTinajr6DvYeyiK79xESYqg0kegUN1s8LxEqGoUc+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156816>

On Wed, Sep 22, 2010 at 17:59, Pat Notz <patnotz@gmail.com> wrote:
> On Tue, Sep 21, 2010 at 2:36 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>>
>> On Tue, Sep 21, 2010 at 20:25, Pat Notz <patnotz@gmail.com> wrote:
>>
>> > +cat >editor <<\EOF
>> > +#!/bin/sh
>> > +sed -e "s/intermediate/edited/g" <"$1" >"$1-"
>> > +mv "$1-" "$1"
>> > +EOF
>> > +chmod 755 editor
>> > +
>> > +test_expect_success 'commit --squash works with -c' '
>> > + =C2=A0 =C2=A0 =C2=A0 commit_for_rebase_autosquash_setup &&
>> > + =C2=A0 =C2=A0 =C2=A0 EDITOR=3D./editor git commit --squash HEAD~=
1 -c HEAD &&
>> > + =C2=A0 =C2=A0 =C2=A0 commit_msg_is "squash! target message subje=
ct lineedited commit"
>> > +'
>>
>> Why not put the editor in t/t7500/ and use test_set_editor() like th=
e
>> other tests?
>
> The real reason is that I'm new enough that I wasn't aware of this
> pattern. =C2=A0I saw what was done in t7501-commit.sh and followed al=
ong.
> I missed the use of test_set_editor() right there in t7500-commit.sh.
> Doh!
>
> I can certainly do that if it's preferred. =C2=A0I must say, though, =
that I
> find it odd to put test inputs in a separate file in a separate
> directory from where the test transforms those into expected outputs.
> To see what the test is doing you have to load both files and trace
> through it.
>
> Still, I'd be happy to change do this if that's the preferred way.

It's a bit odd, but it's best to following existing style within a
test. Then maybe submit fixup patches to fix the whole thing later.
