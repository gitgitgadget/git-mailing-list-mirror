Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5426C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 23:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjAIXM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjAIXM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 18:12:26 -0500
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543D43BE87
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 15:12:25 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id E3DC2160054;
        Mon,  9 Jan 2023 15:12:24 -0800 (PST)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QUKYHr1oDdhJ; Mon,  9 Jan 2023 15:12:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 0E66D160056;
        Mon,  9 Jan 2023 15:12:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.9.2 zimbra.cs.ucla.edu 0E66D160056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=78364E5A-2AF3-11ED-87FA-8298ECA2D365; t=1673305944;
        bh=BjAoBqk7Uzf8782MPAQGxCGw88gce3GnII+peA/HPj8=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
         Content-Transfer-Encoding;
        b=ZCl0Y/BcJcKj5hCPFkegIR4vlqONfqZRG4dB2EtSGSzY05belsjIHgkeIBzmvZ0U7
         BbM4HgPJBYzfghxfciZG3wKzgKmrG0INprlLZRmUTx+oNGKRjFkaiOopMNL4cLiOfo
         VM6e7aRUAh+FfoeiTY+DyikrricO6FqHC87BLtiE=
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O3xC3cGB2yBT; Mon,  9 Jan 2023 15:12:23 -0800 (PST)
Received: from [131.179.64.200] (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id DAE02160054;
        Mon,  9 Jan 2023 15:12:23 -0800 (PST)
Message-ID: <80b42740-c85b-cef2-622c-c5b2450e264c@cs.ucla.edu>
Date:   Mon, 9 Jan 2023 15:12:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: bug#60690: [PATCH v2] grep: correctly identify utf-8 characters
 with \{b, w} in -P
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        demerphq@gmail.com, pcre-dev@exim.org, 60690@debbugs.gnu.org,
        gitster@pobox.com, git@vger.kernel.org
References: <20230108062335.72114-1-carenas@gmail.com>
 <20230108155217.2817-1-carenas@gmail.com>
 <230109.86v8lf297g.gmgdl@evledraar.gmail.com>
 <d6814350-10a3-55c0-68da-7e691976cd45@cs.ucla.edu>
 <230109.865ydf1mdu.gmgdl@evledraar.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <230109.865ydf1mdu.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/9/23 11:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> 	/b:
> 	155781
> 	(*UCP)/b:
> 	46035
> 	/s:
> 	0
> 	(*UCP)/s:
> 	0
> 	/w:
> 	142468
> 	(*UCP)/w:
> 	9706
>=20
> So the output still differs, and some of those differences may or may
> not be wanted.

I took a look at the output, and by and large I'd want the differences;=20
that is, I'd want the UCP version, which generates less output. This is=20
because several Emacs source files are not UTF-8, and \b has nonsense=20
matches when searching text files encoded via Shift-JIS or Big 5 or=20
whatever. For this sort of thing, the fewer matches the better.


> If all you're doing is matching either ASCII or Japanese text and you
> want "locale-aware numbers" it might do the wrong thing.

I'm not seeing much of a problem here. When searching Japanese text, I=20
would expect \d and [0-9=EF=BC=90-=EF=BC=99] (using both ASCII and full-w=
idth digits) to=20
be equivalent so (assuming UCP) it's not a big deal as to which regex=20
you use, since Japanese text won't contain Bengali (or whatever) digits.=20
And when searching binary data, I'd expect a bunch of garbage no matter=20
how \d is interpreted.

Here I'm assuming [=EF=BC=90-=EF=BC=99] (using full-width digits) has the=
 expected=20
meaning in PCRE2, i.e., that PCRE2 didn't make the same mistake that=20
POSIX made.
