From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on
 Mac OS X
Date: Fri, 17 May 2013 13:29:21 -0400
Message-ID: <CAPig+cSYKM3XUm4m=ip_=p0mQz=gz0VKx7bfS=UdUsFMECWEQw@mail.gmail.com>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
	<5193CC6B.50909@web.de>
	<CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
	<CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
	<7vbo891ra8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:29:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOTA-0004XI-4d
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416Ab3EQR3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:29:24 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:42568 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341Ab3EQR3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:29:23 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so4666530lbf.14
        for <git@vger.kernel.org>; Fri, 17 May 2013 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=W7KCxdKvFKrBwU368K4AwhNsvr521kEsWy38rkaQ7Z8=;
        b=osF/UYBLkR+YlFNQGccW8DZZbCTspF9wZ7iW+0pys+DyUpquz07e6O4edahqxp+9GQ
         Qt76toV8HuzPQnb5rHOkl70RSR2+fYU/6Ejzi6OSKqDTwJIlYLzkqJ09xvb/sE4K1orf
         GoYJu3x9cZRy7EnXyjdSalKbsTrslGI76LMlqZUWOTp9t1JwV+RJg2hjjsr/CjIMrS7W
         9FVZcAb3AAyp5lx4lBX2EbkdTHXskeGwO9S2PMVgWzx7FB6nVIMJrPGtIQJvtaaTqUOR
         3v7zn1wZwTGThnPQpX53bfWXCYOXh96TCLkyy6RoivO8sQveaU8VotL7fixRqTvHSUrK
         vXMw==
X-Received: by 10.112.125.232 with SMTP id mt8mr19832956lbb.55.1368811761769;
 Fri, 17 May 2013 10:29:21 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Fri, 17 May 2013 10:29:21 -0700 (PDT)
In-Reply-To: <7vbo891ra8.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: Z-GIcT57hV9OsPzx_wiUVHXCZAU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224718>

On Fri, May 17, 2013 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Do you have advice on how we should proceed?  :sigh: sorry for wasting
>> so much maintainer time on this series already.  If you need any
>> resends or anything please let me know.  This time I'll wait for a
>> strong opinion before firing off patches.
>>
>> My opinion: yeah, v5's ([NO_]APPLE_COMMON_CRYPTO) was probably where
>> we should have stopped painting.  Hindsight is 20/20.  Luckily it
>> never left "pu".
>
> I could do this easily:
>
>     $ git checkout da/darwin ;# b72ac20a6f73b
>     $ git format-patch --stdout -2 |
>       sed -e 's|COMMON_DIGEST_FOR_OPENSSL|APPLE_COMMON_CRYPTO|g' >P.mbox
>     $ git checkout HEAD^^ ;# 29de20504e
>     $ git am P.mbox
>     $ git diff da/darwin HEAD ;# sanity check
>     $ git log da/darwin.. ;# sanity check
>     $ git branch -f da/darwin

That would lose the one legitimate COMMON_DIGEST_FOR_OPENSSL which
needs to be defined before <CommonCrypto/CommonDigest.h> is included.
