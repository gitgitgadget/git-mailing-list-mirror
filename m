Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5021FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbdEIDIT (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:08:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36581 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdEIDIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:08:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id v14so12041078pfd.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 20:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tFB4cdFPcL8wUtnBnHfJxppPNUBPRyEebykmWmf+wdY=;
        b=HU7IJB8Km0WzTVy8vO8FQJD7hx2CYmKjEcGAl1HfsD+XyBcGUZKDnNRFwKEzmrSmye
         TuSGDdrnsH3JKIZDoUtDBPr7f8XoRuh681MJrB5BCWv135/VdtXkWumG9WMseodcGewj
         /KUM51McdOgnVbhFMKu5zmDW3f5DGCKvjyISAHEBox/CPI1I0+oB+we4GwMAm4YTdTOq
         yekPAA4xSEqcg6oa01apNotg8ECjg4aVv6Upz+kPXDK4IdamR2tUK/zP99CFIHAPF6r0
         tTvmORAiZOPcqIy91dgWFnycw4tosuFS12OFKpmnZeoZ0xAKkbXKY02B4ouKBCKgjQyo
         ntfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tFB4cdFPcL8wUtnBnHfJxppPNUBPRyEebykmWmf+wdY=;
        b=BX4ArcCv8O+ckwkhwftCNJCcPc2+sdNWKGQfktka6lsDC2SykByA/d3AEcPXs4Ln5c
         x08JwotjQnheFO29Hn6N9SM+Zritt/2floOFen0EMgm8Maa/E8DXoyAuv3ALyN/RqNao
         9LZOTz9MOfA2GQE8wcMiPMjY1uqt+uiL53IOl6o6QemcEkEfy+k6wignGYtaepqjYUrj
         9MpR2diulZiaqZb9J7agY7tMhN8q5zSHI9PtY796i1fD9576j6eW22krl5ESWKookSq+
         Hf1kNCGPjnhAba+ToT7xUo3dUHfcw9yAlBcHuCF1yqle4zzWzOC/RX9urixPzUTyRbpb
         OsMQ==
X-Gm-Message-State: AN3rC/7r8AV49oq5IJQfTTxmtWJMlv5uUwLrTkYBEDeuXLNZPl8U+Q4R
        1SQYR2ngsPwhcA==
X-Received: by 10.99.116.74 with SMTP id e10mr21489874pgn.135.1494299297636;
        Mon, 08 May 2017 20:08:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id r68sm19356091pfd.91.2017.05.08.20.08.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 20:08:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: disable pack reuse for object-selection options
References: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
        <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
        <20170508073143.lu73w5b54lvstty2@sigill.intra.peff.net>
        <xmqqd1bi7ta5.fsf@gitster.mtv.corp.google.com>
        <20170509020010.meefcustv7uufard@sigill.intra.peff.net>
        <xmqqfuge6akl.fsf@gitster.mtv.corp.google.com>
        <20170509022114.s3tpxrgtplsopr4x@sigill.intra.peff.net>
        <xmqq4lwu68zy.fsf@gitster.mtv.corp.google.com>
        <20170509025412.6fkrlnbsdk6qmoia@sigill.intra.peff.net>
Date:   Tue, 09 May 2017 12:08:16 +0900
In-Reply-To: <20170509025412.6fkrlnbsdk6qmoia@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 8 May 2017 22:54:13 -0400")
Message-ID: <xmqqpofi4ti7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, May 09, 2017 at 11:48:17AM +0900, Junio C Hamano wrote:
>
>> > I guess what I was asking was: do you still think it was unclear, or do
>> > you think you were just being dense?
>> >
>> > I don't feel like I gave any information in the follow-on explanation
>> > that wasn't in the commit message, so I wasn't clear if I worded it
>> > better or if it just sunk in better.
>> 
>> At least, "the current code is buggy when --local and friend are
>> given and includes needless objects in the result" was something I
>> learned only during the discussion, and would never have guessed by
>> reading the log message.  The second paragraph does talk about "This
>> bug has been present since...", but the first paragraph does not say
>> anything about the current output being broken.
>
> While waiting for your response I took a look to see if I could improve
> it and came to the same conclusion. The result is below.

Looks good to me.  I really like how the third-paragraph reasons
about pros and cons and decides to just disable the codepath.

I see this as an example of omitting something you know so well as
"too obvious", and it turns out that it isn't so obvious to others;
I commit the same sin all the time myself.  Catching instances of
these is part of the review process.

Thanks.

> -- >8 --
> Subject: pack-objects: disable pack reuse for object-selection options
>
> If certain options like --honor-pack-keep, --local, or
> --incremental are used with pack-objects, then we need to
> feed each potential object to want_object_in_pack() to see
> if it should be filtered out. But when the bitmap
> reuse_packfile optimization is in effect, we do not call
> that function at all, and in fact skip adding the objects to
> the to_pack list entirely.  This means we have a bug: for
> certain requests we will silently ignore those options and
> include objects in that pack that should not be there.
>
> The problem has been present since the inception of the
> pack-reuse code in 6b8fda2db (pack-objects: use bitmaps when
> packing objects, 2013-12-21), but it was unlikely to come up
> in practice.  These options are generally used for on-disk
> packing, not transfer packs (which go to stdout), but we've
> never allowed pack reuse for non-stdout packs (until
> 645c432d6, we did not even use bitmaps, which the reuse
> optimization relies on; after that, we explicitly turned it
> off when not packing to stdout).
>
> We can fix this by just disabling the reuse_packfile
> optimization when the options are in use. In theory we could
> teach the pack-reuse code to satisfy these checks, but it's
> not worth the complexity. The purpose of the optimization is
> to keep the amount of per-object work we do to a minimum.
> But these options inherently require us to search for other
> copies of each object, drowning out any benefit of the
> pack-reuse optimization. But note that the optimizations
> from 56dfeb626 (pack-objects: compute local/ignore_pack_keep
> early, 2016-07-29) happen before pack-reuse, meaning that
> specifying "--honor-pack-keep" in a repository with no .keep
> files can still follow the fast path.
>
> There are tests in t5310 that check these options with
> bitmaps and --stdout, but they didn't catch the bug, and
> it's hard to adapt them to do so.
>
> One problem is that they don't use --delta-base-offset;
> without that option, we always disable the reuse
> optimization entirely. It would be fine to add it in (it
> actually makes the test more realistic), but that still
> isn't quite enough.
>
> The other problem is that the reuse code is very picky; it
> only kicks in when it can reuse most of a pack, starting
> from the first byte. So we'd have to start from a fully
> repacked and bitmapped state to trigger it. But the tests
> for these options use a much more subtle state; they want to
> be sure that the want_object_in_pack() code is allowing some
> objects but not others. Doing a full repack runs counter to
> that.
>
> So this patch adds new tests at the end of the script which
> create the fully-packed state and make sure that each option
> is not fooled by reusable pack.
>
> Signed-off-by: Jeff King <peff@peff.net>
