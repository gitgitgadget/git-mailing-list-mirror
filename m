Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8C4C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E76D2076C
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGvdEE7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHYRKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHYRKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 13:10:16 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93255C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 10:10:16 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z195so9232336oia.6
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eYupF+SwPhizhaaneSxWkFzXbNn9U/wpBrcPRVuvN5o=;
        b=NGvdEE7PCv5Po2aBiCqQjqQAUACGNWMRzX1THR2FjKkG5YsCfrMBa6AB1huK7SMQWI
         EhtCqNLWo3V0wfsvpEIlXFyxtKYH9K52MtE2KNIPkY0axCrGS2lOXqpbtjRUsmrBbnjX
         cEZwYlRDtcIl+XGLhEIHFNbLV3PC+wqN1Byl1QVHQZ8ZbBIGX8GTqFIzTTuKMcyI64Hy
         9V8V+zzrdkbjJkFMpGE1cYiKUBMoc5sxjq+AWXEd+2dr4EFHw7snA2uz2LpmlYUv+td9
         eOU0tZIyruKzlRktBy+E9bJudmK3+rAQVo9zC2G2IJ5TE2ERovejt5LHd/K42+vN5zvs
         DElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eYupF+SwPhizhaaneSxWkFzXbNn9U/wpBrcPRVuvN5o=;
        b=QP/8fLO0qE2RaegjXdeSLN6sPiiq6WKJPPu4ZjEcyrVnlRtFCtFnHSX0YtssvhwquC
         jJ80SJq5bXYe+98tIHOJJ8LcDQsQdwvSDHI6Jq5Wsf9l0SWMs9mNpkBChNcl6FK+IkEC
         sOosbrwCUc3Zhf72fidGH7NafHa6ymkavfN4jAJDYyiiauvQIlnAf1kPOqMTt3hEeYp8
         xJLvk3+9jI4cJ/UP4Mx33OxfteJ8reqm9aso2QNROpZ8VPqQnjMhbSa6B912tolqNmXt
         lWjP5eGk6yvoxT2GzhY1Fx2GF0RRA+b41aaLP9kNOTdmYpjWftiSisdcZHwEfVznT2yZ
         B6oQ==
X-Gm-Message-State: AOAM532JjOcLapdOhTIxSf82FSzPos/IO+E/AfPHqFMAZLuAc9dEMFB3
        dYX+2Hx2NNciQ23qUf4Z3E0=
X-Google-Smtp-Source: ABdhPJxkERl+9017/xg2Bu2w9vacqLc6BVEkfv6XoNVdy11RqdNE+QiyRXhIYOLgniL7qiPaaJhgQA==
X-Received: by 2002:a05:6808:2da:: with SMTP id a26mr1492082oid.79.1598375414547;
        Tue, 25 Aug 2020 10:10:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:600d:49d2:12ae:f5e7? ([2600:1700:e72:80a0:600d:49d2:12ae:f5e7])
        by smtp.gmail.com with ESMTPSA id z63sm2760441otb.19.2020.08.25.10.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:10:14 -0700 (PDT)
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     Son Luong Ngoc <sluongng@gmail.com>, git <git@vger.kernel.org>,
        dstolee@microsoft.com
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <CB6B70D3-5FC6-43FE-8460-33F6CFC123E6@gmail.com>
 <20200825144515.GB7671@syl.lan>
 <20200825164721.GA1414394@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <45921233-ac6c-05f2-e108-0ab2aeb56104@gmail.com>
Date:   Tue, 25 Aug 2020 13:10:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200825164721.GA1414394@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2020 12:47 PM, Jeff King wrote:
> It may be worth thinking a bit about atomicity here, though. Rather than
> separate delete and write steps, would somebody want a sequence like:

...
> If we do care, though, that implies some cooperation between the
> deletion process and the midx code. Perhaps it even argues that repack
> should refuse to delete such a single pack at all, since it _isn't_
> redundant. It's part of a midx, and the caller should rewrite the midx
> first itself, and _then_ look for redundant packs.

It is worth noting that we _do_ have a way to integrate the delete and
write code using 'git multi-pack-index expire'. One way to resolve this
atomicity would be to do the following inside the repack command:

 1. Create and index the new pack.
 2. git multi-pack-index write
 3. git multi-pack-index expire

While this _mostly_ works, we still have issues around a concurrent
process opening a multi-pack-index before step (2) and trying to
read from the pack-file deleted in step (3). For this reason, the
'incremental-repack' task in the maintenance builtin series [1] runs
'expire' then 'repack' (and not the opposite order). To be completely
safe, we'd want to make sure that no Git command that started before
the 'repack' command is still running when we run 'expire'. In practice,
it suffices to run the 'incremental-repack' step at most once a day.

[1] https://lore.kernel.org/git/a8d956dad6b3a81d0f1b63cbd48f36a5e1195ae8.1597760730.git.gitgitgadget@gmail.com/

This discussion points out a big reason why the multi-pack-index
wasn't fully integrated with 'git repack': it can be tricky. Using
a repacking strategy that is focused on the multi-pack-index is
less tricky.

I still think that this patch is moving us in a better direction.

I'm making note of these possible improvements:

1. Have 'git repack' integrate with 'git multi-pack-index expire'
   when deleting pack-files after creating a new one (if a
   multi-pack-index exists).

2. Handle "missing packs" referenced by the multi-pack-index more
   gracefully, likely by disabling the multi-pack-index and
   calling reprepare_packed_git().

Thanks,
-Stolee


