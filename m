From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv2 1/2] t5520-pull: Add testcases showing spurious 
	conflicts from git pull --rebase
Date: Sun, 8 Aug 2010 14:17:45 -0600
Message-ID: <AANLkTimsfcSB7GMcNnZSBiwH4kwZeEazo5svW96_Nf9J@mail.gmail.com>
References: <1281294286-27709-1-git-send-email-newren@gmail.com>
	<1281294286-27709-2-git-send-email-newren@gmail.com>
	<AANLkTikhsFfCfmR2V8iSRvU73B5yW=_kqJAEfAGgxpLY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, santi@agolina.net,
	Johannes.Schindelin@gmx.de
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 22:17:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiCJc-0004zK-6m
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 22:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab0HHURs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 16:17:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38288 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab0HHURr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 16:17:47 -0400
Received: by fxm14 with SMTP id 14so4652820fxm.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vQF888r/kQdooCxjtDXCmbGFKK8wHsBjc2+T4LUabTA=;
        b=mvFPJV4HpocB8OjTka4+ZMJHsDWgjjNec/wWNJkDiQAQGbN1pfse3cmNOmqnXf3BRH
         yinEpHuKnDwpeuRXMskBWs0RlgAh5dxJyqCDWh+ZHP8HmDRfuERHsqR96FblsuP4l5D8
         1jJbYCuQHJTyudsSCHIseevQklg07A6NPJZJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pe/P8pNkbaYEZE/A22U1775jNu7ijO7AGfA8DWg9GJJLs1OD1czv0pAFBTPcuiMVwu
         M7meewe0KAak7SajEGwynOFcgZWz+5WbrGrQenkq/kgpu4FJMhDgAVMbm45958WXFltJ
         jxdQL/cS4WDbOG0q6ReQZUBltQUJI8UdVRKm8=
Received: by 10.223.121.19 with SMTP id f19mr15681833far.73.1281298665972; 
	Sun, 08 Aug 2010 13:17:45 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Sun, 8 Aug 2010 13:17:45 -0700 (PDT)
In-Reply-To: <AANLkTikhsFfCfmR2V8iSRvU73B5yW=_kqJAEfAGgxpLY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152924>

Hi,

Thanks for taking a look!

On Sun, Aug 8, 2010 at 2:01 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Aug 8, 2010 at 19:04, Elijah Newren <newren@gmail.com> wrote:
<snip>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/5/43/ stuff &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "5->43" &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/6/42/ stuff &&
>
> Please use sed so the test doesn't depend on perl being present.

The original series used 'sed -i', but I found out that is apparently
not portable.  Should I use sed + a temporary file + mv?

<snip>
>> +test_expect_success 'setup for avoiding reapplying old patches' '
>> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0(git rebase --abort || true) &&
>
> If you're ignoring the git rebase --abort return value:
>
> =C2=A0(cd dst &&
> =C2=A0 =C2=A0git rebase --abort;
> =C2=A0 =C2=A0git reset ...)

Makes sense; I'll do that.
