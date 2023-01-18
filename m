Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93508C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 18:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjARSHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjARSHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 13:07:12 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F711E9C
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 10:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674065133; bh=J0g/9jy+1Lmb5zRdLZMu4VpUOe/PeJYcre3hYrZBygM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=H28nK0Vu8/2vMHzIJOio+Hp1MPylR33XC++FbrzUywSTy0IzpJFifZR8e9xzMl+R0
         nQc9luRYQiSl7ZU5VyQc1ttdSFMbOStsvs6UPv1fKYkuYDfS+yYp5ft8da0uS/GQGp
         qUhEofWcD5N1YQ1icf5jABSt8OjNLrms7QOe4ciRLvJ5Y4+zKEqJqfQNkURS4r/iQz
         zbDxipl7GVL9/46ujmtUCSf0wlnzjUXuCOCJ6m8d6+0LZNf7rLAoybJ110GuJY59E+
         9uftEhfIlhIgKtUZBA0XM5Jp8f2MAKodIs3bQQ2UWSpQcpYvzR3cwOgVWsYCJHJH97
         vuxgZC4mr2fJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.223]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ma0PY-1pEv0L1JkC-00WPr2; Wed, 18
 Jan 2023 19:05:33 +0100
Message-ID: <fd883d86-0c85-6c72-a331-2e8b2064befe@web.de>
Date:   Wed, 18 Jan 2023 19:05:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 15/19] object-file.c: release the "tag" in check_tag()
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
 <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <patch-v4-15.19-66c24afb893-20230117T151202Z-avarab@gmail.com>
 <7e571cdd-c0fa-7519-848c-b0bc4613abab@web.de>
 <Y8gqJESD/wbEHZYb@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y8gqJESD/wbEHZYb@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k9VoBE1RURFoOiuVmYNHpscWECkbJHYsvgnLR22+lWrESnUfg3n
 UouMUzM4C1lFBvMoIR//uP0mdNjAsy2I54PgsJgNxfPl6X9pDXent3ACrTDknLhJ3lpSry9
 iXSm1tdzDMFuxS2pt0aLTPeeWacvv+yfIGS++YSZ/LHizPzjciA5oU79Z2UYeRiegLihFBb
 TimYTsGM8jcHeqC17lDiA==
UI-OutboundReport: notjunk:1;M01:P0:AlvHmiBiaX0=;G7oQ4KjYC1owKs8zUiI68mBAzfQ
 gLfDJf18Z3pmwz5x2vkPgDeNn++MkxIKcOE16DOs3SDZCyXZ5n7no8TcZLtzGDuWABlu7NbaP
 C/8NnzeG6uKluoqg0V8psc/g9JkNkF5Poz/AleSOwxp3S6GRnYqNWFoe2GtvwhWvsPu/oZZif
 nxCcl01gZQDcWkjh8R7Msz5GwZUhjWZn/Xxwuq/gyxgHomjqzwjY6fEPyhCIYGOfvRYGy8XAK
 ooTWDBgNHwmVT0cO+r1CBWOOaEVFb6nTmfDywrDkPoBRXUNO2Fi9pzf3QAaFzxzdA1XBYCASn
 lYwNkzHz2ew3ANElnCktRC1n70MRvt87tzMjOMqieEK7bkVmHtulcIBKDLoqmtdKYhbaoHW2G
 IIvoTtBcMxGP5MY89XA8agEWoIZ+GrwNwitulU+Rh7XZDT+2PT68Ss+Jsi6CZT6RlQSvvL0Ty
 x3aCtQEi1UzAIhlgrYkXv5wvooKcWNUEUcfeeXkuen+F/KH00OjPTn/QZpKiph1fYB82RwOkM
 TeKtlHswrC/3XKKkkbd8zaTkKRm8EFNwmGyVmbccxztw+pH5xkbGUojhpnbxwPefg2MdJdYEc
 czc5Og+eqXO2RBloGm5TcFS+0CbLzZ5GhGc4BC5JrFfm/Fl36eXJrQsSdsWQR4gdFqH4pCl5m
 KoitsMYWonbrs3g/ng9Nl2Rn2ADTgfobQ1lRkBUEL+7Ori7uMu433EhJTv9P6EQW2O1HO+whQ
 o86Ghoz9wfcLoFFZXj+1YlFVYyVrvugjf9WRRAjgSr+ZuDrXwUpa6sO+D7OLQQ+dGksSa7XsA
 f6t4gyDB503FFdPGkY+iR5nOr9cX3De0BDKygksikQnLy+L022CI1NbCnjKOxbJdZt3BF5JPd
 pKtvH8sNHa01ZpnFemqPd6SGkU2ngfNabEy1wK34MP1hCtHUcBnJEqA/QTstHZKnkfP9MMpm8
 pzCiwg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.23 um 18:19 schrieb Jeff King:
> On Tue, Jan 17, 2023 at 08:58:24PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Am 17.01.23 um 18:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> Fix a memory leak that's been with us ever since c879daa2372 (Make
>>> hash-object more robust against malformed objects, 2011-02-05). With
>>> "HASH_FORMAT_CHECK" (used by "hash-object" and "replace") we'll parse
>>> tags into a throwaway variable on the stack, but weren't freeing the
>>> "item->tag" we might malloc() when doing so.
>>>
>>> The clearing that release_tag_memory() does for us is redundant here,
>>> but let's use it as-is anyway. It only has one other existing caller,
>>> which does need the tag to be cleared.
>>
>> Calling it is better than getting our hands dirty with tag internals
>> here.
>>
>> There's similar leak in check_commit() in the same file, but plugging i=
t
>> would require exporting unparse_commit().  Or perhaps using the heavy
>> hammer that is release_commit_memory()?  Anyway, it doesn't seem simple
>> to me, so that would be a patch for a separate series.
>
> I think both of these cases are a bit sketchy, because they create an
> object struct on the stack, and not via alloc_*_node(), which may
> violate assumptions elsewhere. In the case of the tag, it's probably OK.
> For the commit, though, the "index" field is going to be 0, which may
> confuse release_commit_memory(). It calls free_commit_buffer(), which is
> going to use that index to try to free from the buffer slab.
>
> So I'd be wary of calling that. I'm also slightly skeptical of the
> existing code that calls parse_commit_buffer(), but I think it works. We
> do not attach the buffer to the commit object there (good), and we pass
> "0" for check_graph, so the graph code (which IIRC also uses the index
> for some slab lookups) isn't run.
>
> I think this code would be better off either:
>
>   1. Just allocating an object struct in the usual way. I understand the
>      desire not to spend extra memory, but parse_commit_buffer() is
>      going to allocate structs under the hood for the tree and parent
>      commits anyway.
>
>   2. The point of this code is to find malformed input to hash-object.
>      We're probably better off feeding the buffer to fsck_commit(), etc.
>      It does more thorough checks, and these days it does not need an
>      object struct at all.

I like the second one, as long as it won't check too much.  c879daa237
(Make hash-object more robust against malformed objects, 2011-02-05) added
the checks that are now in object-file.c and intended to only validate the
internal structure of objects, not relations between.  It gave the example
to allow adding a commit before its tree, which should be allowed.  And
IIUC fsck_object() fits that bill.

> Either of which would naturally fix the leak for tags. I'm not sure
> there actually is a leak for commits, as commit structs don't store any
> strings themselves.

parse_commit_buffer() allocates the list of parents.

Hmm, and it looks them up.  Doesn't this violate the goal to allow
dangling references?

> I don't think any of that needs to hold up =C3=86var's current series,
> though. Fixing the leak this way in the meantime is OK, and then if we
> switch to one of the other techniques, the problem just goes away.

Right.

Ren=C3=A9
