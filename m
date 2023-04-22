Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4F7C77B76
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 15:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjDVPxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 11:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDVPxX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 11:53:23 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EE21713
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1682178786; i=l.s.r@web.de;
        bh=KAu1GglHTn6W5ofdjCVzvcBIyomqmhU72vVGJxFuC64=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=h1OvhRzklTeDx9aBubsZODsDc+7IG2x+3x/B8LN3wu1Q0FXeRbTetOf80dGTzhsZZ
         cm/ctdFO9pGPxh1QMo5zRoVG1Tjav9AGk12VS10/ijG0gCiOJx2u7YrTMEkdYPhVOL
         zyeZ8wUpzydAG8QQ3s0NqXxzNEh73xRjxBVbCBvSOrJXxDGS8/ivxV0riw9CSPLVff
         66EgXNZBSQAba/P8+xeL2OuLSQju+44rLxHjeX48uSZJyZPCWHAVDRvyMRfxgKsW9p
         uVM5nbSELe3OzLjCN8XTrqoSKzplYiy/gCCb+DIFiyHWpmNGXkirGgml39SKtBRwyz
         TsJ8FRHOmq3iw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8mzy-1qKkzM2CaU-015x4e; Sat, 22
 Apr 2023 17:53:06 +0200
Message-ID: <8d228041-d473-7f3f-87d7-543b350aab0e@web.de>
Date:   Sat, 22 Apr 2023 17:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/6] string-list: introduce
 `string_list_split_in_place_multi()`
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
 <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
 <20230422111213.GB2969939@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230422111213.GB2969939@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iYWpRiQpXVAO7s9+dqt2W5K/gZF8Acjgbx6KlARB20iTlL7SvHU
 ZEjA9ooTf7m12a0Ib7zN00xyZAVMNlA68F40tBGvj5b1FLC3S04WdCOxhdjP8BGEGq4xJ/0
 4DZoUZpQVaSnAuOOW6lodS2SdojLKW6YTVJtJ6z+haxtw/02SlGDD0Z3loU2IeO1jOurMlJ
 ZE7xn0LFkESmNAEaqCOUQ==
UI-OutboundReport: notjunk:1;M01:P0:WnYHZVnqJGA=;u5hkrQSyZqfz2aw95TuI5KVuYTh
 tg5we25ivbD7mySVSTVq/UrnChxEN5u/Vj30HQh3viDuRdHA5OpgMh1JhkIZkllHYEkV8WlqU
 9q4jDGzCbjFc190J7xc3X3VbrJXLMstwifPXIM0/7v7+rBlCRkKspjT5daPs9mjaeOoimhalM
 cnkh6btSs5C43agsPh9/ZbTjCk1wF6oDiyVhxqKjREMJmN1Nn7nrajoE/O2+DMEzf0HihSt7o
 +XUG4DBdSTTNctQ7AmhI0LY+PW1uYhp8G4A4ftzKXIVVoxCv5+JdbNR0g5aY9QH8sCx/vynj9
 IKLOVvrVll804e4bI6PBtNUN6rnmH41DzfO5k8J8zCEomSt54j5W7cxz46HkRTDd1HIAfTK9l
 KnhoP4lmd2y+Afuj22EpRf7bMyxp1IakpRbTI6BvLQNJfFltm6R0wLAkFhowMFBo13T16JW17
 LqtNMz1OIGI6zQQSpNxOyroSp1ZW1ICbRgb6sY7CKw6IgPyFxXQrethVR7jsF3uXhVxHkhHh1
 19uVh8NMsMya+gAavZIm9A5jSru/3oodxfN0KeQnwqONmJo8mLsGOULmUnRdD06+BLsVpOxDe
 uNzJZZ0HLhxjBDVgfpLkd1LEywdb9txThm+IXYzZmpBWLuK27IFpBrWkA0JN8PU5kIHcSELhZ
 WOyxymY06xB2mlnlFUSlWNA3KEk5OFeNs+Hb34xBKudGZWxdOsGfuTbSaonAkBAg8vO2833z/
 aDOQwQlOZtXUmpLS54bdFRJrjvOjNmB6qUQGZOV5S7bNMMDJc1A9ULAUztCw6GLNfCQ4SUBxs
 6J4yiKrRtgK7dI3AbqHrFU3ra7uzeGLuqDisFy+g8C7TKvLRUt/ZkZm75Ds0tVCv1wrhvmN0Q
 eyzGtETa/79hcgOOpJUpHgGVUODGLT2/cupHRa75QQKgu2lgLZxf3xfFPwhLzN8sHUKpHa67B
 QEuJHA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.04.23 um 13:12 schrieb Jeff King:
> On Tue, Apr 18, 2023 at 03:18:43PM -0400, Taylor Blau wrote:
>
>> Introduce a variant of the `string_list_split_in_place()` function that
>> takes a string of accepted delimiters.
>>
>> By contrast to its cousin `string_list_split_in_place()` which splits
>> the given string at every instance of the single character `delim`, the
>> `_multi` variant splits the given string any any character appearing in
>> the string `delim`.
>>
>> Like `strtok()`, the `_multi` variant skips past sequential delimiting
>> characters. For example:
>>
>>     string_list_split_in_place(&xs, xstrdup("foo::bar::baz"), ":", -1);
>>
>> would place in `xs` the elements "foo", "bar", and "baz".

Which one is it here really, string_list_split_in_place() or _multi()?

> I have mixed feelings on this.
>
> There are multiple orthogonal options here: single/multiple delimiter,
> and how to deal with sequential delimiters (you call it "runs" here,
> though I think of it inverted as "allow empty fields"). Plus existing
> ones like maxsplit.
>
> Your underlying function, string_list_split_in_place_1(), handles these
> independently. But it seems like a subtle gotcha that
> string_list_split_in_place() and its _multi() variant, which purport to
> differ only in one dimension (representation of delimiter list), also
> subtly differ in another dimension. Especially because it's a facet that
> might not come up in simple tests, I can see somebody incorrectly
> applying one or the other.
>
> Obviously one solution is to add the "runs" option to all variants. But
> I'd be hesitant to burden existing callers. So I'd propose one of:
>
>   1. Make your _1() function public, with a name like _with_options() or
>      something (though the function name is sadly already quite long).
>      Leave string_list_split_in_place() as a wrapper that behaves as
>      now, and have the few new callers use the with_options() variant.
>
>   2. Don't bother implementing the "runs" version. The only users would
>      be test programs, and nobody cares much either way for their cases.
>      Document in the commit message (and possibly above the function)
>      that this isn't a strict replacement for strtok(). That would
>      hopefully be enough for a potential caller to think about the
>      behavior, and we can add "runs" if and when somebody actually wants
>      it.

You can call string_list_remove_empty_items() to get rid of empty
strings.  And if the single-char version calls a multi-char version
under the hood then its only advantage is backward compatibility -- but
converting all callers isn't that hard.  So the only string_list split
function version you really need accepts multiple delimiters and
preserves empty items and can be called string_list_split_in_place().

Ren=C3=A9

