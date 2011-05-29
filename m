From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v0 3/3] Bigfile: teach "git add" to send a large file
 straight to a pack
Date: Sun, 29 May 2011 20:20:01 +0200
Message-ID: <BANLkTikB3VhB4nTZhjE+3znfVTuBYsnehg@mail.gmail.com>
References: <1304844455-23570-1-git-send-email-gitster@pobox.com>
	<1304844455-23570-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 29 20:20:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQkay-00059V-Si
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 20:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270Ab1E2SUE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 14:20:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36041 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab1E2SUC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2011 14:20:02 -0400
Received: by fxm17 with SMTP id 17so2111636fxm.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 11:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UG0X0hXNM6JRFOZ48LKZkX38IbpjswankFzYlHn9SXc=;
        b=xFX8hfrmkUhiZ03AASICJ5e9qiO2Qry4zgaYgzjuus3PaCF35pPGwMT2QkZz7Ea0AP
         +k/SZFZ0abIc/z9RU4oNfKb6+r8eKRkIwOpEil4+5XhuwXKAB7sRnno658rYD1SlWGhh
         4LCPMBavcmjygfIbvCb6jzKyAG7FJIDabusaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g0yw06C6aC3jAdJvRSpRvqcGjT1qFmuucDkt3bP7Y24eqB94Ot9zSfN//lmfTPDWit
         82GaXLcYiDBFOi2AYL78rlaf8CpQsapIxNKjLLByE812rknc6kOOu3Y5Q5nC1/AFdJCH
         6+ocw64YDhr+DiyXCvBLwtWLoBdgbWjOR0h18=
Received: by 10.223.145.78 with SMTP id c14mr4613794fav.75.1306693201344; Sun,
 29 May 2011 11:20:01 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 29 May 2011 11:20:01 -0700 (PDT)
In-Reply-To: <1304844455-23570-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174697>

On Sun, May 8, 2011 at 10:47, Junio C Hamano <gitster@pobox.com> wrote:

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char buf[10240];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t sz =3D size=
 < sizeof(buf) ? size : sizeof(buf);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t actual;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actual =3D read_in=
_full(fd, buf, sz);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (actual < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die_errno("index-stream: reading input");

=46rom clang:

    sha1_file.c:2710:14: warning: comparison of unsigned expression <
0 is always false [-Wtautological-compare]
                    if (actual < 0)
                        ~~~~~~ ^ ~

Looks like it's right. size_t is unsigned according to the standard,
so that die_errno() is never reached.
