Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC68C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 17:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B645623CCD
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 17:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgLIRPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:15:32 -0500
Received: from mout.web.de ([212.227.15.4]:37961 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgLIRPc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 12:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1607534019;
        bh=vQsCmIunImIYQblec/7cWMVns46mj9gid5ZRgFcV8tI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Z0XrRqWqhQhvyRxVwiUr3mrZ3AGOzIjBzUtu7tBLA1TL4TQWtM8JvSH3Ya19ZZt0V
         gcbkWKbmoYc1LiA9bnBsU/KwA38qxRH4zlhw3z5/ka9TaXVdW3qe/BZ/UbTVFplChI
         qbr0bf/zjdybXPmSogpsZOb+GI3cNKs4TbjsofXs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MA5tp-1kxoXz3OrB-00BHdN; Wed, 09
 Dec 2020 18:13:38 +0100
Subject: Re: [PATCH 00/15] Refactor chunk-format into an API
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <ee0b73f7-8f59-a1dc-0a21-bf796bf9f2e2@web.de> <X8/K1dUgUmwp8ZOv@nand.local>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4696bd93-9406-0abd-25ec-a739665a24d5@web.de>
Date:   Wed, 9 Dec 2020 18:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8/K1dUgUmwp8ZOv@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:74Ww0WaDM9D2iR1bcvYsqw7kOJMGs4bI+5k6+jTJIlnzphkaixo
 JVL2JAGtOLixT/quaLb0o6YGDGbXm5MjA9JyUoi8pT3sk6V4p71h8gRnpc93Vdu49km0noF
 gSeWqVix/4CPa0cOR0CNZwIlZwi3OjJY04u2JOQ9T3KlFk2jeqMxTkBsB13dwg4iAKUrRsa
 ThAu7Zd367GTvHXTLlXhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aWBVYkAsiwY=:d3ItbpFdhAW9uVTRDPQhkr
 deZJhefF3fQU+mNcXE8OHo6/Yo+OjKTkmTADq+xlDQLaM9nJebBR1gNwiG0V/FM9KbhLXs18k
 wpTCum9D4h+kQGe7ie9tfehBhNClyaf0IBWziWsfxZqzy/z5T0UnkB0fmy2/W1j+wRR3iUuxa
 6xnnZPxVOxqAJuqBMw+eOgp4MQyGoJBOajOe+PGJeE1u/VK8PciXwrc2cEvuRHtJ0ss+rkpYx
 UyD88UO0p6HwgEMoVhGJpvqRx9UbPHweUaCPKEEb59+UKo5BRFYAZHXQrnEPV/SrU4zDpERWD
 PeYBufWbb/GsVgl80MBBdSu5rw4+tk0qUFLbEbenAq+ySogx3vPnZhb5vBCS2n1InSGSql4wc
 +R7ZNp2dLImnFpQ40LJPwv9Hf00kdV1dd1FA/fqVdgNtASxuLOAUoDQFfJwKV1oH0KB9MC1Sy
 i40uiByK8k9xv794HB48Ah3lc6DZ+l3rHJuzvKh3NIniG2pQbB3p6+3w45du/UlYsv5m4sfpT
 AwhomSr8TDaYQBXOItmGnLYwMBBtUam/nrRAlHn0ij/3aAbRcDU/IMjD/jpHSA7uQGzFZ8rPQ
 JsQf1ZXOL1o4EWjJdAA+pCDEqXCJjBS59FDGnoHAjlQDSLsW07Ns14xAOe2e8sikZdxO/QqDu
 uVWIlipJtF8sDyHGXD/GxbTJ6t5/3i3yqOHTHmTVM+xxEVci7ZiBx47bU8mnKWMDd5r2X9cMn
 wwS7MS/TBrB/gYNujDrSV+Q9q1OGJQIwE9KIqpywqvKiiy8zQCfDCZ+f2XFmL/T6M5JeVbxJx
 +OxnicVM30oYlQYc5NJ7A2ogE4oFqT9zC4DhhnQqD0jwOiTmR3iUg5SWaZmQoUM0L+afeTLT+
 HhhR4G8eo3HVOVuf3JSA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.12.20 um 19:49 schrieb Taylor Blau:
> So, I think that we should pursues that direction a little further
> before deciding whether or not this is worth continuing. My early
> experiments showed that it does add a little more code to the
> chunk-format.{c,h} files, but you get negative diffs in midx.c and
> commit-graph.c, which is more in line with what I would expect from this
> series.

OK.

> I do think that the "overhead" here is more tolerable than we might
> think; I'd rather have a well-documented "chunkfile" implementation
> written once and called twice, than two near-identical implementations
> of _writing_ the chunks / table of contents at each of the call sites.
> So, even if this does end up being a net-lines-added kind of diff, I'd
> still say that it's worth it.

Well, interfaces are hard, and having two similar-but-not-quite-equal
pieces of code instead of a central API implementation trying to
serve two callers can actually be better.

I'm not too familiar with the chunk producers and consumers, so I can
only offer some high-level observations.  And I don't have to use the
API, so go wild! ;)  I was just triggered by the appearance of two
working pieces of code being replaced by two slightly different pieces
of code plus a third one on top.

> With regards to the "YAGNI" comment... I do have thoughts about
> extending the reachability bitmap format to use chunks (of course, this
> would break compatibility with JGit, and it isn't something that I plan
> to do in the short-term, or even necessarily in the future).
>
> In any event, I'm sure that this won't be these two won't be the last
> chunk-based formats that we have in Git.

OK, so perhaps we can do better before this scheme is copied.  The write
side is complicated by the fact that the table of contents (TOC) is
written first, followed by the actual chunks.  That requires two passes
over the data.

The ZIP format solved a similar issue by placing the TOC at the end,
which allows for one-pass streaming.  Another way to achieve that would
be to put the TOC in a separate file, like we do for .pack and .idx
files.  This way you could have a single write function for chunks, and
writers would just be a single sequence of calls for the different
types.

But seeing that the read side just loads all of the chunks anyway
(skipping unknown IDs) I wonder why we need a TOC at all.  That would
only be useful if callers were trying to read just some small subset
of the whole file.  A collection of chunks for easy dumping and loading
could be serialized by writing just a small header for each chunk
containing its type and size followed by its payload.

Ren=C3=A9
