From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v8 1/5] Introduce bulk-move detection in diffcore.
Date: Thu, 25 Nov 2010 18:19:36 +0100
Message-ID: <AANLkTimGOkv7db2YW_+-V_oJEheuwBiUW-3fFpHBOt4v@mail.gmail.com>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
	<1288303712-14662-2-git-send-email-ydirson@altern.org>
	<AANLkTi=Ekoe+RSrRFj63S___Vsa5kTsDKJVPamFsz0c2@mail.gmail.com>
	<20101125150218.GA16049@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org,
	Yann Dirson <ydirson@free.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 18:19:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLfU0-0000Ra-01
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 18:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab0KYRTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 12:19:38 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55543 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab0KYRTh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 12:19:37 -0500
Received: by fxm15 with SMTP id 15so66972fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 09:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WRx0IbI/SpI34EhMPTH/vBQKjZEl5NHXT3OmaCojQOY=;
        b=RfNRi9r4kUw9sW5qgSRF5mZJt/PJbO/SIqoSQay3lhFRic1kj6OOElLkhDamzsFimz
         QB5TtSQPq+57NVZS+JHh82UoH6SOY49OCYhDbPd3LoHu4ykjgA/UTIswmkXFyBZO4qY7
         j+Xrljs0B58BwMFNnSJrVtTnS1G9+vWztunNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fxxTlBhDRvGPSnPGRuslpC2me957dvFPmeFf+rO1vj7rg/TFoAI7TkSLD4cYnPjb4u
         G2Yl45x/jNhgJu8Ytw4mkV82ncpMbNMLkE3JiA+ICSy27X4LQlQmzvBEC0VN7mml/if5
         VqZ45wO6VhjQhxmpRqnzaJYkzE5gryMK4sYGI=
Received: by 10.223.86.129 with SMTP id s1mr1002363fal.144.1290705576204; Thu,
 25 Nov 2010 09:19:36 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Thu, 25 Nov 2010 09:19:36 -0800 (PST)
In-Reply-To: <20101125150218.GA16049@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162147>

On Thu, Nov 25, 2010 at 16:02, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Oct 29, 2010 at 00:08, Yann Dirson <ydirson@altern.org> wrot=
e:
>
>>> + =C2=A0 =C2=A0 =C2=A0 slash =3D memrchr(src, '/', len);
>>
>> I can't compile pu now on Solaris due to this bit. Are you planning =
on
>> picking up the patch / configure / Makefile detection discussed in t=
he
>> "[PATCH] compat: add memrchr()" thread? Just wondering what the
>> progress was on that.
>
> BTW, remember that the configure / Makefile detection is only an extr=
a
> nicety. =C2=A0[1] teaches git to rely on the system memrchr on glibc
> systems only; on other systems (unless they define memrchr as a macro=
,
> which would be a strange thing to do), gitmemrchr is used.
>
> Upshot: it should be safe to use [1] without the configure / Makefile
> support. =C2=A0Later, an interested person can write a patch for impr=
oved
> memrchr[2] on *BSD and Plan 9.

Sure. It's just a bit of a hack since we already have a standard-ish
way of doing this. Which is to optionally have configure.ac support,
then add platform-specific stuff to the Makefile & drop something in
compat/memrchr.c.

Doing it that way and actually detecting it means we use e.g. the
native memrchr on FreeBSD. I just don't see a reason to do it like the
[1] patch when it's just as easy to do it the "proper way", where it's
more extendable.

Anyway, it's a very minor issue. I'll probably do a patch for this
series like I did for that other thing that needed autoconf detection
recently. Thanks everyone.
