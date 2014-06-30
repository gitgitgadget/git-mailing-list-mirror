From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH v2 2/2] sha1_file: use strncmp for string comparison
Date: Mon, 30 Jun 2014 18:43:35 +0200
Message-ID: <53B193B7.6020407@web.de>
References: <53AED59B.1020209@web.de> <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com> <53AFA775.1090900@web.de> <53AFAA89.6050200@web.de> <20140630134317.GB14799@sigill.intra.peff.net> <CACsJy8A5Dq6MP8kH7R3POSjXoJjYvWF695fKj1YgTdscF5xYxA@mail.gmail.com> <20140630142232.GC14799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:43:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1egE-0003Bo-T2
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbaF3Qnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 12:43:43 -0400
Received: from mout.web.de ([212.227.17.12]:65156 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbaF3Qnm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:43:42 -0400
Received: from [192.168.178.27] ([79.253.187.118]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LecRm-1WIzun22eM-00qTxj; Mon, 30 Jun 2014 18:43:39
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140630142232.GC14799@sigill.intra.peff.net>
X-Provags-ID: V03:K0:hOnq1/IbmzfBDbM5CC46kZe3v7w5FMMoTusgODxGC7Qwmxkmh8x
 Ugd6V5SIRx6hUCSXBiVAJghHPneorAWydBtTszP/qIeQUNR4skDitzRLVYYZPa1tT245I7f
 GkvoPO8tyoopm4/CDcd/UAEj6bkwOfQKwe3R3wKPcGAyyLeL3nqQ6hMB/fYyPwamsPWEJfD
 ZqYk3IHzk6VX9uXJkwrjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252679>

Am 30.06.2014 16:22, schrieb Jeff King:
> On Mon, Jun 30, 2014 at 08:59:53PM +0700, Duy Nguyen wrote:
>
>> On Mon, Jun 30, 2014 at 8:43 PM, Jeff King <peff@peff.net> wrote:
>>>> diff --git a/sha1_file.c b/sha1_file.c
>>>> index 394fa45..8adab14 100644
>>>> --- a/sha1_file.c
>>>> +++ b/sha1_file.c
>>>> @@ -1207,7 +1207,8 @@ static void prepare_packed_git_one(char *obj=
dir, int local)
>>>>                if (has_extension(de->d_name, ".idx")) {
>>>>                        /* Don't reopen a pack we already have. */
>>>
>>> If we don't follow my suggestion above, we still have this
>>> has_extension. This is a reimplementation of ends_with, isn't it? W=
e can
>>> probably drop it and just use ends_with.
>>
>> This calls for another patch if we just want to kill has_extension()
>> in favor of ends_with(). There are 12 call sites of it.
>
> Yes. Some of those would want to become ends_with, and some would
> actually want to become strip_suffix. I'm working up a series now.

NB: has_extension is almost the same as ends_with, but it also checks i=
f=20
the string is longer than just the extension:

	ends_with("x", "x") =3D> 1
	has_extension("x", "x") =3D> 0

Ren=C3=A9
