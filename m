Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F88C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 11:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjAVLjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 06:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVLji (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 06:39:38 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B01DB99
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 03:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674387567; bh=iwvA0zbtXeaNFpYCCzcDNS1aPOhDB+QOQn0Ob6rT1AY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tsSbBZkcvS9Bg01Pn/G57zQhGUyd/Ggjv7Co4M7VrcO6IuQzbEjcaIj/WtZ8XT+Q1
         ZWzykNBB91xh2ylkXYxVp5HkfmFxJ3FEqTCKxsM9KimCYCAfj2N7kUgjtweyKZfq/9
         xQexUJBu1/FF3aQvtuycWIsd3CtomC5w7RidFCETqsVEB9Ozaa/5Ab2n2EfLV5ERfu
         K/A64pd+7/aBW8EXM5EHAbuLjIWapYC/Yeme675ghJy///PwKwwMBdB6U6IUIDd2I/
         gq63Z72+F9mx6xEUoV26M7ugkTPKThiLUYPRTvLTzPaal6GZNyU9izlmjn9JRAJnFv
         SdORBKMK9Ykpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.223]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sXj-1pIk0m1eYp-001vyT; Sun, 22
 Jan 2023 12:39:27 +0100
Message-ID: <d225dddc-973c-f710-9d24-cb53b26b973f@web.de>
Date:   Sun, 22 Jan 2023 12:39:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC/PATCH 0/6] hash-object: use fsck to check objects
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8ifa7hyqxSbL92U@coredump.intra.peff.net>
 <97faa323-a5b9-e459-70d7-3f6318446898@web.de>
 <Y8zqZH+X6fOoCOYV@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y8zqZH+X6fOoCOYV@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nYGGaxflsP/Bedmy3Aa2lK+bnTu91JQFXRNlR0P3qabRptlQHKh
 dDBwsHlUPItN1/cwITkfa7vs6qG57n5QC70UKFxMSJhUyoM9P+bSojkfGhqoDQyU20qZUiP
 1i/sZikbk+P/WvJjka6OMA/e/Fylh8P07uih3z/drKkeVkh15/Hyl863zYIFcIG7zK6GVr9
 5LnLH2oCGmI+PV9etFakQ==
UI-OutboundReport: notjunk:1;M01:P0:G6jDABhbYBA=;1QaqKQHstX3eW4syQ9ewOinBt5s
 NqzBab31AX+OZkCuSsUCMwrlScl4rhDYQz4lbitx79HCEqWXM0pPjnofrFNNBlBvJHZTuJVnf
 iPbtepzSOub/GZuKhz3ybxFI2sMydR3VA6sMNIVOBzqQE/pAUsBirdjniMVA74OrFT2evn7Yi
 95WJD58nK82KZ3Q2uTrs+McJUndrZm5g8UhR21FhtLBSJSS1JrCNLRhEqarEmKNs1kPjbUEIS
 x1gH4e8/TxIBuhsCj05m6uYBw+0sTZT4rIjzZIs2Em020qiaSgY+ky0LTFTpJ+mndKM4+SE/u
 d7WTVkSXutd5isp2DCIpchdl0Yh9qtE/O8vPk20hP5uZE8cZX/72K2mJ5okTFi8kNIf4LOXYV
 f/fhSK2kwVRWpPe0PkEq4Te+ouO0nBxwQX4KCjJoIK5VE7SY1cWt9kxB1H2kpouQErT24PWFy
 lq8/paCWSfTFBqjUeQ5XlRLwNYTcKkZTahuvf2tGyJvNtbRGulbKkldsL4wzaJ0XJzt6kXc2e
 qRpXkLSVgXhSdvst0ZKDP6o8hut6ICru/HpTxuZhT7jKbeajJr+JLNJfixDJFE4dOe6FlQe+o
 CImcAnqZHOgAgWHZTI6iH38K/MtnnC8v4qZAQS49PzYQZeJ/ikj4B2KUvsbwqVo3Y8OlofLMB
 qUXNDied22ovVsjWcERGi/kzXxRuUCeLbCyeRjBvnuYfJw9EbJPmTvUdd77zGT9QNoYMS/Jbl
 OxKwpveGZ9K4MrN+WrhLwlp96HukUmw65urJy0gwQrqetelMY6toEHcSEaoMz3CsmbeXzMqSt
 dnA4HQQSAAbFr4xSb0zl0DzBXKyeBVX+pEYztHLLecRFRrjbWOyoQsCyFp7AkE8uT7qnjj+Ow
 Qe9/64fvtTwdd6MQC7j45IKoF+q8+3ibdQ+am5+0TW9YlkGz/mEqPYoJRq9kXrbAGwgBmOKyo
 Bq+gEtGMMOWqHq7T8LXvTytDqAI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.01.23 um 08:48 schrieb Jeff King:
> On Sat, Jan 21, 2023 at 10:36:08AM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Am 19.01.23 um 02:39 schrieb Jeff King:
>>>
>>> Though I do find the use of strlen() in decode_tree_entry()
>>> a little suspicious (and that would be true of the current code, as
>>> well, since it powers hash-object's existing parsing check).
>>
>> strlen() won't overrun the buffer because the first check in
>> decode_tree_entry() makes sure there is a NUL in the buffer ahead.
>> If get_mode() crosses it then we exit early.
>
> Yeah, that was what I found after digging deeper (see my patch 7).
>
>> Storing the result in an unsigned int can overflow on platforms where
>> size_t is bigger.  That would result in pathlen values being too short
>> for really long paths, but no out-of-bounds access.  They are then
>> stored as signed int in struct name_entry and used as such in many
>> places -- that seems like a bad idea, but I didn't actually check them
>> thoroughly.
>
> Yeah, I agree that the use of a signed int there looks questionable. I
> do think it's orthogonal to my series here, as that tree-decoding is
> used by the existing hash-object checks.

Sure.

> But it probably bears further examination, especially because we use it
> for the fsck checks on incoming objects via receive-pack, etc, which are
> meant to be the first line of defense for hosters who might receive
> malicious garbage from users.
>
> We probably ought to reject trees with enormous names via fsck anyway. I
> actually have a patch to do that, but of course it depends on
> decode_tree_entry() to get the length, so there's a bit of
> chicken-and-egg.

Solvable by limiting the search for the end of the string in
decode_tree_entry() by using strnlen(3) or memchr(3) instead of
strlen(3).  You just need to define some (configurable?) limit.

> We probably also should outright reject gigantic trees,
> which closes out a whole class of integer truncation problems. I know
> GitHub has rejected trees over 100MB for years for this reason.

Makes sense.

>> get_mode() can overflow "mode" if there are too many octal digits.  Do
>> we need to accept more than two handfuls in the first place?  I'll send
>> a patch for at least rejecting overflow.
>
> Seems reasonable. I doubt there's an interesting attack here, just
> because the mode isn't used to index anything. If you feed a garbage
> mode that happens to overflow to something useful, you could just as
> easily have sent the useful mode in the first place.
>
>> Hmm, what would be the performance impact of trees with mode fields
>> zero-padded to silly lengths?
>
> Certainly it would waste some time parsing the tree, but you could do
> that already with a long pathname. Or just having a lot of paths in a
> tree. Or a lot of trees.

That's a cup half full/empty thing, perhaps.  What's the harm in leading
zeros? vs. Why allow leading zeros?

Ren=C3=A9
