From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/2] git.c: make sure we do not leak GIT_* to alias scripts
Date: Tue, 8 Dec 2015 17:55:20 +0100
Message-ID: <CACsJy8BHT2+_i4SoG6xv40wGX_gxwZFk=3WYOH196ZiHA7raWQ@mail.gmail.com>
References: <1449166676-30845-2-git-send-email-pclouds@gmail.com>
 <1449329538-18623-1-git-send-email-pclouds@gmail.com> <xmqqzixmm6na.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 17:55:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6LYS-0003O8-2U
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 17:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbbLHQzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2015 11:55:52 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34165 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbLHQzv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2015 11:55:51 -0500
Received: by lffu14 with SMTP id u14so16717229lff.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 08:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hB2WhYHU08GYjS8CbHs5p/69NgR5YDT8kJiilralWGg=;
        b=Rp24umqx1v6opOBQeTuSSsFvy0sEyocX6wFC9DMoJTZtfFMQJAVynjUvC7l4eFMgVT
         GlebMqHA7z9Dd/K1FTBxwZShR5LOxExp86g0JZfow6wT8zUyH6lW0qv9GqqLUaPS2nEb
         6YCZc0R4NHGWdAoI350ZjjlFQY+DIsM8TUs+LaQMj1qfgVZHZTkM1yirm7br0yP8ynh2
         YYUQ319MwOjglVW6tE6C1M6rlgK2x6FQgSDT3z1+7H/iMzeUf6mD7JjMpotNzB0n3dLJ
         cEPc/qOiGcD6GuVpv4cw8buigwX6VuuLOpJu4grxwc1UMzoJXD0WxT+8C8VI3rBYBk/k
         jTRA==
X-Received: by 10.25.165.202 with SMTP id o193mr226016lfe.83.1449593749656;
 Tue, 08 Dec 2015 08:55:49 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Tue, 8 Dec 2015 08:55:20 -0800 (PST)
In-Reply-To: <xmqqzixmm6na.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282157>

On Mon, Dec 7, 2015 at 7:54 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>>  Let's hope there will be no third report about this commit..
>
> Hmm, why does this additional test fail only under prove but pass
> without it?

It passes with prove for me. Some mysterious variable leaks through som=
ehow?

>> +     env | grep GIT_ | sed "s/=3D.*//" | sort >actual
>
> This is more about coding discipline than style, but piping grep
> output to sed is wasteful.  "sed -ne '/^GIT_/s/=3D.*//p'" or somethin=
g
> like that, perhaps?

OK will fix.

> I wondered what happens if the user has an unrelated stray variable
> whose name happens to begin with GIT_ in her environment, but it
> turns out that we cleanse them in test-lib.sh fairly early, so that
> would be fine.  You need to tighten your "grep" pattern, though.

OK
--=20
Duy
