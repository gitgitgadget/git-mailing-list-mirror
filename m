Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69053C004D4
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 09:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAUJgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 04:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAUJgT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 04:36:19 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC8458BD
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 01:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674293768; bh=GQP1ILK00pr2fW+0sZKAW1TSHLSfhMliHK+hQVGG4As=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
        b=dPPyW7Vh7FnwTERZFlTmPHGtLZjP+Kyj2UycVFpHb7aUVgkudJz8oKxxaq49f36fq
         qM1/Ae9Wubzh+bSK+4tX1x5IYhmnGiKMCbTGhXKPuyi0/DeY8D2jHqQsR55LX/HiWw
         RWfeev8pVqxzDLDAO1y/sPUFWjR/jBpCAarJRF4gtfPteu9yysGcSWHufL72pW04Hh
         onyGyRrUCY02daVyp5bD2leeljypwvJVf1kX4CtgaP25+Qg5ZI8DKQs7NdWbbcSJk6
         Qjt0nhlotGM6zqvOuJVXpoVww7xGKkS01yM1aZ0IqJ8rZZcnpvupaqJIBbqvQFJtMp
         cl4k+ddVy2FCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.223]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MREzA-1p77cq34YW-00NTSy; Sat, 21
 Jan 2023 10:36:08 +0100
Message-ID: <97faa323-a5b9-e459-70d7-3f6318446898@web.de>
Date:   Sat, 21 Jan 2023 10:36:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [RFC/PATCH 0/6] hash-object: use fsck to check objects
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8ifa7hyqxSbL92U@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <Y8ifa7hyqxSbL92U@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QpRFNxy3TTR/SmziM1olCi9paqyvMZBk1d54TVYHpMx/r480cST
 s0S3E7Mv9UpCdMWc+t0y1O8G1jcdfIj+BVKjwsHY/4AUVF2fUfxkbIN9rCi/rzqfAeGZApi
 D9ijv2NSiTGjJTXE3TkrIN1fo5faTk634UNSRfZ0dqXfon6t4sJ1LZ3B2eyZkJjLcaeeCo/
 Qrn68Pfjnu4OFBKuFX8vA==
UI-OutboundReport: notjunk:1;M01:P0:D++XHiQZ3Gk=;LC7LLu00wnuc2eBFQsO2fvlLTra
 2QFhepdZs43QlzWBrieWAUMQ7t/HWkE5mQfxcsjIwvoCM716AuZQ0ttckHG4El+rbhTMc8m4v
 Ke2yEo3uEv8e9gjIK5RZOlmSyJB8x9go4h+SpWD01Mz4NRdQv7JOFGWbT29f6sNfubmLyFSBt
 4iKcvXJ1HT8zPTd2Fd4tQt088bcuTPFR2gE19roR+sIPtWaxEMMhBrdAWFk+OLPi9n/fJvyA6
 uWytk4jX5trlrnCB/R5lNW9gC97UOhaZ64rHimAKXggq/pSW2Vc+db120XUwVXxc2CmDRwm64
 A1N14ZKw0p4vWwUbTlMQragQnSCOK+ODSjEdHwLAfllol7Bsxn6H3ZofPryfzmPoIPHk9rIY9
 0o8zrfKbAyC9LYD4v54MSTcOZc8Ivr46n/gNO1EarfvEFlcbAeUi7JvyhQTYrexM4VvtAsiQn
 EUynjLQ+UXlnRbGw3UuoLjlc1Avp2N6hNNYPJmP1O1kPmCz8sRtOb5KTfOHYtAsViyAI6IZHq
 tQV4tcFxYDxpdOyfJJEYIz6UiEwR4IktViqGKUMeE3b44PtU92/cFv8xeGDQFM4P7vSI3De+n
 /8/fYtUYX2p+Qw7B/y8hn9nZEvBJulu9k2x8ZPPXP2jzkuAr/Mky2MhmSKI9jt4ypvcpRWibz
 56NgmTnIoVpTkkoR7uZQjs4jDfNYd+0w8cqAmVn2cqbwsFbSVF6eQGY2znRIkGzrKnTpkbmib
 EAsI4CtFXriTu8Q70sLLWbmkXEGEr5kMf2OzjqCurIGv6RFxb93GLS3Lu+O4wWg8lA6o6VUHm
 4yZMVZvUcwpHdq6vNgBFCNVe8Tvi6JltI1mzILJ9x6o1iCXP0wBvAtwAGM/dr0Ut7zfn6CZ3v
 /xbRPXpivMjruqL+d71vNd4kHstrO6z/SAGkd1hCNts9c8wqJKwhzHJuritoJFvPs2Afah8F3
 4c+7iA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.01.23 um 02:39 schrieb Jeff King:
>
> Though I do find the use of strlen() in decode_tree_entry()
> a little suspicious (and that would be true of the current code, as
> well, since it powers hash-object's existing parsing check).

strlen() won't overrun the buffer because the first check in
decode_tree_entry() makes sure there is a NUL in the buffer ahead.
If get_mode() crosses it then we exit early.

Storing the result in an unsigned int can overflow on platforms where
size_t is bigger.  That would result in pathlen values being too short
for really long paths, but no out-of-bounds access.  They are then
stored as signed int in struct name_entry and used as such in many
places -- that seems like a bad idea, but I didn't actually check them
thoroughly.

get_mode() can overflow "mode" if there are too many octal digits.  Do
we need to accept more than two handfuls in the first place?  I'll send
a patch for at least rejecting overflow.

Hmm, what would be the performance impact of trees with mode fields
zero-padded to silly lengths?

Ren=C3=A9
