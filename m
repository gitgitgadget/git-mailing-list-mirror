From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCHv2 4/4] t7500: add tests of commit --squash
Date: Wed, 22 Sep 2010 12:16:24 -0600
Message-ID: <AANLkTi=5smrhYk0YA6qxoa7PZNRisVuhzciStXuje4=A@mail.gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com>
 <1285100703-49087-5-git-send-email-patnotz@gmail.com> <AANLkTinTA23Xf2AFLW+tzeLq1AWUhBBuca63qs_foXtr@mail.gmail.com>
 <AANLkTinajr6DvYeyiK79xESYqg0kegUN1s8LxEqGoUc+@mail.gmail.com> <AANLkTi=MjE3OBqAd8NqFCMdSb3qfNW_1QKvrL6-AK+Er@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 20:16:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyTsE-0002Uj-QE
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 20:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab0IVSQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 14:16:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60264 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab0IVSQp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 14:16:45 -0400
Received: by fxm12 with SMTP id 12so233226fxm.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oZQNuUbgXEfd2zFwtk9CqbKo9r9qp82zAbzdkW0PQPA=;
        b=gq6Nsk5KsLr0efGxIcodauvZIEQElQloeP9wTKqS0NKht19lFZ0WMem2CdkU1V7rS0
         cT43C/b0dYeCO1RCLHhWt74Ymd/BLMzx8wlBL+xRcrsdklVqwuSKGxmCUUC0Hx0twWxY
         hhjr+Iv7okScxxXdBIAt4U2+54Q3eGWvDWWxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lLt1QmjeZybKjA+SFRT1hrpPS8vx/M4Z7tvTBDZppXDVPK/ZAt/GaqI7jkyno7afsK
         pHXbUWH00zry0nxqMph1xjyF1GXmmzKx2pffN/+7rmXWaLdANTmgtEifSH0Hzt8zfZPu
         FboJiCop3vA2VL3VAxV/6M0+TNFw0ZSitJRNQ=
Received: by 10.239.187.134 with SMTP id l6mr31442hbh.132.1285179404376; Wed,
 22 Sep 2010 11:16:44 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Wed, 22 Sep 2010 11:16:24 -0700 (PDT)
In-Reply-To: <AANLkTi=MjE3OBqAd8NqFCMdSb3qfNW_1QKvrL6-AK+Er@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156818>

On Wed, Sep 22, 2010 at 12:12 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Sep 22, 2010 at 17:59, Pat Notz <patnotz@gmail.com> wrote:
>> On Tue, Sep 21, 2010 at 2:36 PM, =C6var Arnfj=F6r=F0 Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>> On Tue, Sep 21, 2010 at 20:25, Pat Notz <patnotz@gmail.com> wrote:
>>>
>>> > +cat >editor <<\EOF
>>> > +#!/bin/sh
>>> > +sed -e "s/intermediate/edited/g" <"$1" >"$1-"
>>> > +mv "$1-" "$1"
>>> > +EOF
>>> > +chmod 755 editor
>>> > +
>>> > +test_expect_success 'commit --squash works with -c' '
>>> > + =A0 =A0 =A0 commit_for_rebase_autosquash_setup &&
>>> > + =A0 =A0 =A0 EDITOR=3D./editor git commit --squash HEAD~1 -c HEA=
D &&
>>> > + =A0 =A0 =A0 commit_msg_is "squash! target message subject linee=
dited commit"
>>> > +'
>>>
>>> Why not put the editor in t/t7500/ and use test_set_editor() like t=
he
>>> other tests?
>>
>> The real reason is that I'm new enough that I wasn't aware of this
>> pattern. =A0I saw what was done in t7501-commit.sh and followed alon=
g.
>> I missed the use of test_set_editor() right there in t7500-commit.sh=
=2E
>> Doh!
>>
>> I can certainly do that if it's preferred. =A0I must say, though, th=
at I
>> find it odd to put test inputs in a separate file in a separate
>> directory from where the test transforms those into expected outputs=
=2E
>> To see what the test is doing you have to load both files and trace
>> through it.
>>
>> Still, I'd be happy to change do this if that's the preferred way.
>
> It's a bit odd, but it's best to following existing style within a
> test. Then maybe submit fixup patches to fix the whole thing later.
>

Yeah, there's certainly value in doing that.  I'll follow-up with a v3
and include the documentation changes I noticed in the other patches.
