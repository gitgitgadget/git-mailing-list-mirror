From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v2] git-am: Ignore whitespace before patches
Date: Thu, 12 Aug 2010 08:50:13 +1000
Message-ID: <AANLkTin2DM-q7acST-x_Oz7jU-hODy8se6sngGxTDi_9@mail.gmail.com>
References: <1273944188-9472-1-git-send-email-avarab@gmail.com>
	<1281556645-23361-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 00:50:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjK7q-0001en-7O
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 00:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab0HKWuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 18:50:16 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43558 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab0HKWuO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 18:50:14 -0400
Received: by qyk5 with SMTP id 5so716351qyk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LTYsJJAGhfk9uzMMjPmPFvuEAdUX1PakWmWjJyE5o+o=;
        b=kZRfj2nxOSglTvpneQEguOvXY1wDB56G8PN/wAiLE090zM8S7W21GJ0u8io8xyEz+A
         geN09GyBYUQOr9Iv18JzFRrC6QMUZK7Mron6h6dQEpsqdQmQiJmzwjBrHzqvQZCtOT1c
         xBpj0wqToICVPZ9PZMwNuOOVy4cT7XUkkdebY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mIDZoSyKAco1usDYn25Xv9+LciW1V4OiMx4cK6vIqfVIr+MJQOmAnMBMDPUhHwA3aK
         V0LsYsc8dZMN59whvXZDrpd06nOC1PjmR9j/TpkU0hoZDS+rAcZ7qm3KkE+y7zVYWjCv
         BXik8o2XpFPm80Y2QG78D7lIvKUJA0RUgdr7A=
Received: by 10.224.72.37 with SMTP id k37mr11232306qaj.398.1281567013324; 
	Wed, 11 Aug 2010 15:50:13 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Wed, 11 Aug 2010 15:50:13 -0700 (PDT)
In-Reply-To: <1281556645-23361-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153307>

On Thu, Aug 12, 2010 at 5:57 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Change git-am to ignore whitespace (as defined by sh's read) at the
> beginning of patches.
>
> This makes git-am work with patches downloaded from the GMail web
> interface, here's an example from a raw Gmail attachment produced wit=
h
> `hexdump -C':
>
> =C2=A0 =C2=A020 20 20 20 20 20 20 20 =C2=A020 20 20 20 20 20 20 20 =C2=
=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> =C2=A0 =C2=A020 20 20 20 20 20 20 20 =C2=A020 20 20 20 20 20 20 0a =C2=
=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .|
> =C2=A0 =C2=A052 65 74 75 72 6e 2d 50 =C2=A061 74 68 3a 20 3c 61 76 =C2=
=A0|Return-Path: <av|
>
> Having to tell GMail users that they must manually edit their patches
> before git-am will accept them (as this article does:
> http://evag.evn.am/git/git-and-gmail) isn't optimal.

This is a good point. Current behaviour discourages testing of patches
as delivered by e-mail since the GMail user is more likely to overlook
actual whitespace errors in a patch because they come to expect this
usual failure.

jon.
