From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sat, 8 Jun 2013 21:25:16 -0500
Message-ID: <CAMP44s0RqtoP8iHZ+rEqPDKSLxZLESS8qKFhb2vzSd7-mtKreQ@mail.gmail.com>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
	<1370644168-4745-3-git-send-email-felipe.contreras@gmail.com>
	<51B31651.6020307@lsrfire.ath.cx>
	<CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com>
	<51B32FFD.5070302@lsrfire.ath.cx>
	<CAMP44s3K=VtkeCoKqnU9To9YbfO7vph9MsMWtgLWw0n=cYyq5g@mail.gmail.com>
	<51B35414.1090101@lsrfire.ath.cx>
	<CAMP44s3UYCX+DzgnErB=0GdD3w5k2GkNKjv46ZA_NVHm1Z0YLQ@mail.gmail.com>
	<51B36849.3030608@lsrfire.ath.cx>
	<CAMP44s1ffOUd3DkphHAj8ZmovBazPFdMgtvEptR6kW9+ZMLLjA@mail.gmail.com>
	<51B3E44C.4030304@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 09 04:25:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlVKB-0003C8-P9
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 04:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab3FICZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 22:25:24 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:60514 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab3FICZR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jun 2013 22:25:17 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so2973192lbi.11
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Zk5ehrTGQTRoefDxuQFJfc06rRkFYPNK4G834SyV4to=;
        b=SN2jHVAhdRjbmyQR25bToOVEXGVlZ+krrHI6948Zgr6b+njF+CG67G5Qo7dXphbOBP
         yNbx0lg07mxmMJ8vfKJkCNVtbIVZChZMQ7N6ElaoxSl81Lzw/mJ7+B4gwvJ+DCofDvso
         rmzBD3bfMhtsH+ueka/1AeFFtbyATY6SrLC134g6NkIT0cuIkN1wSz2iOHwGR/cPw2AZ
         gGUsYaO5sK6fXgdOFOfAzG6QSD84SCinhBjZNHhCml4kA1JEMKnSqWQlz48s6keRtE44
         IWfltTPBclYuedM1Lfg6mdnBElVpBuNdcNwDdRzfXm5YnUVhggdBTqNIUDrHydZXCvGU
         2NcA==
X-Received: by 10.112.140.231 with SMTP id rj7mr4033321lbb.16.1370744716155;
 Sat, 08 Jun 2013 19:25:16 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 19:25:16 -0700 (PDT)
In-Reply-To: <51B3E44C.4030304@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226871>

On Sat, Jun 8, 2013 at 9:11 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 08.06.2013 19:27, schrieb Felipe Contreras:
>
>> On Sat, Jun 8, 2013 at 12:22 PM, Ren=C3=A9 Scharfe
>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>
>>> Let's find and fix those leaks by freeing memory in the right place=
s.
>>> Freeing memory just in case in places where we can show that no lea=
k is
>>> triggered by our test suite doesn't help.
>>
>>
>> It helps; it prevents leaks. The real culprit is the bogus API, but =
I
>> don't see that changing anytime soon, so there are two options when
>> somebody makes a mistake the API allows; leak or don't leak. And you
>> seem to prefer the leak, even though it provides absolutely no
>> advantage.
>
> It covers up bugs,

It doesn't. I thought you already silently agreed that nobody would
ever find that leak, as they haven't found the hundreds of leaks that
plague Git's code.

> What would be a better API?  Making discard_index free the array is a=
 good
> first step; what else is bogus?

'initialized' for starters; it should be renamed to 'loaded' or
removed, but removing it would require many more changes to make sure
we don't load twice. Also, when loading cache entries, it might make
sense to check if there's already entries that have not been
previously discarded properly.

In the meantime, just in case, the only sane thing to do is free the
entries rather than leak.

That being said I'm not interested in this patch any more. The patch
is good yet after three tries and countless arguments it's still not
applied, nor is there any sign of getting there.

--=20
=46elipe Contreras
