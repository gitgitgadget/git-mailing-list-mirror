From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on
 Mac OS X
Date: Fri, 17 May 2013 17:38:20 -0700
Message-ID: <CAJDDKr58oM6Dm7sb-sUu2tTt210Su_q+ixc+HA0DHbc0Kmrv9w@mail.gmail.com>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
	<5193CC6B.50909@web.de>
	<CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
	<CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
	<7vbo891ra8.fsf@alter.siamese.dyndns.org>
	<CAPig+cSYKM3XUm4m=ip_=p0mQz=gz0VKx7bfS=UdUsFMECWEQw@mail.gmail.com>
	<7vfvxlzdyu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 02:38:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdVAH-0002eW-C2
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 02:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774Ab3ERAiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 20:38:21 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:65230 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab3ERAiU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 20:38:20 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so4063241pab.13
        for <git@vger.kernel.org>; Fri, 17 May 2013 17:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=4z9ae8S2iKIVTAtygY5WejHHVkNw2UrJKc7iWj3o17c=;
        b=jC7lR7RoGBSyVB30oqO5D0YRiam0h6Ot77yNlHB8uUw1/7vPQTynrd2xburNk2QiKG
         6XfGFdPvDBDjtYldIhWyoUD7jEvo1yYWHrSSNCSshhuuNBcKZ/+DzhQcQ6sQF1X+w2/l
         3S//ygKnAHz4/XKhh8DHzmkgLF9gnp1IoMnJmus0gpL2pCKSOWKOSERbDImqQjWDOvoq
         +8DZFrVJReCwEtiSOSYe8MplvnBu530z9STsF9DdYORw+BLra8O4kFF6jd5CbWJxjxgD
         Jtyc2Ig/cA/EEYOMiTsv3n1UdDKidK6freTrxkITvGHaSfEDq9HYZa+3rckf1PxSn3YO
         CqBA==
X-Received: by 10.68.134.163 with SMTP id pl3mr51254608pbb.101.1368837500422;
 Fri, 17 May 2013 17:38:20 -0700 (PDT)
Received: by 10.70.55.106 with HTTP; Fri, 17 May 2013 17:38:20 -0700 (PDT)
In-Reply-To: <7vfvxlzdyu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224747>

On Fri, May 17, 2013 at 10:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Fri, May 17, 2013 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> David Aguilar <davvid@gmail.com> writes:
>>>
>>>> Do you have advice on how we should proceed?  :sigh: sorry for wasting
>>>> so much maintainer time on this series already.  If you need any
>>>> resends or anything please let me know.  This time I'll wait for a
>>>> strong opinion before firing off patches.
>>>>
>>>> My opinion: yeah, v5's ([NO_]APPLE_COMMON_CRYPTO) was probably where
>>>> we should have stopped painting.  Hindsight is 20/20.  Luckily it
>>>> never left "pu".
>>>
>>> I could do this easily:
>>>
>>>     $ git checkout da/darwin ;# b72ac20a6f73b
>>>     $ git format-patch --stdout -2 |
>>>       sed -e 's|COMMON_DIGEST_FOR_OPENSSL|APPLE_COMMON_CRYPTO|g' >P.mbox
>>>     $ git checkout HEAD^^ ;# 29de20504e
>>>     $ git am P.mbox
>>>     $ git diff da/darwin HEAD ;# sanity check
>>>     $ git log da/darwin.. ;# sanity check
>>>     $ git branch -f da/darwin
>>
>> That would lose the one legitimate COMMON_DIGEST_FOR_OPENSSL which
>> needs to be defined before <CommonCrypto/CommonDigest.h> is included.
>
> It probably is a good catch, but I'll stop reading patches and start
> today's integration cycle (and will tag 1.8.3-rc3).
>
> At this point, I think the best would be for you to reroll these two
> patches, then after David reviews it and I'd re-queue the result
> with
>
>         ... original commit message ...
>
>         Reorginized use of Makefile variables and C preprosessor
>         macros with help by Eric Sunshine.
>
>         Signed-off-by: David
>         Signed-off-by: Eric
>         Signed-off-by: Me
>
> or something.  Can you two help that?

Thanks Eric and Junio.  I looked over the patches and they look good.

Signed-off-by: David Aguilar <davvid@gmail.com>

Cheers,
--
David
