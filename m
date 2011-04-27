From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-completion: fix zsh support
Date: Wed, 27 Apr 2011 11:20:42 +0300
Message-ID: <BANLkTinep961dg9v3TD8hZZAvTYL3_H+xg@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 10:20:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEzzR-0006xR-Pb
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652Ab1D0IUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 04:20:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61134 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab1D0IUo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 04:20:44 -0400
Received: by fxm17 with SMTP id 17so964208fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 01:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aBUJsamWPnWxm0n4Sym6v4K3zhTBl7F7lg7aLn0xSuk=;
        b=LoC4Qc/BCAtfwWJhrn870wx91wiqD7Ot9ZQ/PwtenVrnjFGjC6KTNk9Iuwc1kaWVJY
         PZK/RhCuyWjUOxy9AeSlgsA+z+UbeDJoyH9rmVZsVnd5zZMwa9X883CvtLTpEq/jtneP
         fHytKZ+bG2aLY6MqD+5cqaiu+jInwr9pv4d8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=csBXX9h/8pxDnNeMJ8pciwfJkQyCHuMEq4F/vcL80HjIYpy9sVAI6/ZnCV936cHajb
         RdkwGBnnnqZOZbccNy/8JriAXb6kaP3k7bi1n5B17xGLyL2SV7wTquG3oYanf78i1Z6d
         IDIpA5E5vae2lYhM1Dtha/5b+MhDT+j+FiK08=
Received: by 10.223.73.133 with SMTP id q5mr2021619faj.127.1303892442097; Wed,
 27 Apr 2011 01:20:42 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Wed, 27 Apr 2011 01:20:42 -0700 (PDT)
In-Reply-To: <7v62q0b8e0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172189>

On Wed, Apr 27, 2011 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Felipe Contreras wrote:
>>
>>> It turns out 'words' is a special variable used by zsh completion, =
and
>>> it has some strange behavior as we can see.
>>>
>>> Better avoid it.
>>
>> Hoorah! =C2=A0I imagine this fixes a regression introduced by
>> v1.7.4-rc0~11^2~2 (bash: get --pretty=3Dm<tab> completion to work wi=
th
>> bash v4, 2010-12-02).
>>
>> =C2=A0Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>
> I'd love to share the enthusiasm, but find that "as we can see" needs=
 a
> much more clarification.

Jonathan already described it:
http://article.gmane.org/gmane.comp.version-control.git/170665

And this snipped demonstrates it:
---
set_vars ()
{
	cur=3D"foo"
	words=3D"foo"
	cwords=3D"foo"
}

_foo ()
{
	local cur words cwords
	set_vars

	echo "cur=3D${cur} words=3D${words} cwords=3D${cwords}" >> /tmp/comp_t=
est.txt
}

compdef _foo foo
---

When trying to auto-complete 'foo' the result would be:
  cur=3Dfoo words=3D cwords=3Dfoo

You can see it's special in the source code:
http://zsh.git.sourceforge.net/git/gitweb.cgi?p=3Dzsh/zsh;a=3Dblob;f=3D=
Src/Zle/complete.c;h=3D6398fd3e77eff2ef819c10503d316b08421034ac;hb=3DHE=
AD#l1116

--=20
=46elipe Contreras
