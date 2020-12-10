Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2474FC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 16:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E679B23B26
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 16:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390789AbgLJQsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 11:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389097AbgLJOhl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 09:37:41 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8E1C0613D6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 06:37:01 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id 9so1312912ooy.7
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 06:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AM/016tgEwxz44fkGTqEQ9a37Hy29EbbOPEHb/AtUZ0=;
        b=Qv2nK+JEjy47uZFjvIEoYkrshJU2ha1jP4NW44Suz5kHTqwpA1qNfhf6cTskHxfuMK
         2vKXwl4aQTquMo8rrUPeGZ82j0cRqlHYsUEXLd4RyOqLihwyslYOZDzrtimEQnVNe4Vf
         J3o3whp82BdzlbQnhvqRxVsjM0EXcRjn/ERLVk0bAx1jb72otmCx+2fMY8n7eT034eV2
         i7IrAvEYgBzIdt+eNOY/WdnnsIQKD4yBJHRiB3adHu/5pymIzKN+ZB22sRuJo390r8Uh
         xUcuk27T8qwpgghp9zt9ezOMUNEPvxSGoTMe3oXyDzb/mNKXMC+TH8TtLnYbyC7bi0k1
         nnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AM/016tgEwxz44fkGTqEQ9a37Hy29EbbOPEHb/AtUZ0=;
        b=h7EYyhhZdOV/7mwJgtHINwBwWXtda1NQ6OsOo1vCm/yFg77RV+SBZXRJoD6/uOJ6Yh
         dslVufkAlyXjrwsTMKftfPObFyBv3PSekehelQ8NCEdghi9EZh+hjSi4Vp+VDxMiBOGP
         uDmXuish+h52+d7mmgn+B6KRs3ghhmLOp5eCeXtfhGyt1ahjVORdvr0saQ2EVR9vcer+
         Oc84BH4luO8npmr/gm17YpB4dznhxDgZGAPSwAiOBR6xOmV7LHHTTryahrS32+NJ1GV6
         xws3kP1jSdT8FhDxRw53R2zNyU+Uo8+t2emd2wPVcJzLX2NDshJvUqTPhvo8OTQwSLpr
         Przg==
X-Gm-Message-State: AOAM5338yWb5LJdyqEJhbHfzQKGfVVwVymu/6pTiMFiwmLrEbdTZzfby
        fGM+jWemzpHK4M3ndozb1Ok=
X-Google-Smtp-Source: ABdhPJx1PKhg3hN4g75ZKnYopy9OAa00XKCtIRt0jdKdG2OQ2+UNws4ZZVWriqw0qMCnR9xui2RywA==
X-Received: by 2002:a4a:9563:: with SMTP id n32mr6130025ooi.53.1607611020422;
        Thu, 10 Dec 2020 06:37:00 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:585e:c315:5afa:f8a1? ([2600:1700:e72:80a0:585e:c315:5afa:f8a1])
        by smtp.gmail.com with UTF8SMTPSA id 9sm1104278otl.52.2020.12.10.06.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 06:36:59 -0800 (PST)
Subject: Re: [PATCH 10/15] midx: use chunk-format API in write_midx_internal()
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <f2f78ee1054f64fe767335c4b0c77ba2fbec5fae.1607012215.git.gitgitgadget@gmail.com>
 <X8/I/RzXZksio+ri@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <47900592-2c97-cff1-c70f-594691a8083f@gmail.com>
Date:   Thu, 10 Dec 2020 09:36:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X8/I/RzXZksio+ri@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2020 1:42 PM, Taylor Blau wrote:
> I wonder what it would look like if we introduced a new 'struct
> chunkfile' type. It would know about the underlying hashfile that it's
> writing to, as well as the chunks it's supposed to write. It would
> likely support three operations: add a new chunk, write the TOC, and
> write the contents (the latter two could probably be combined into one).
> 
> Below is a patch to do just that. It seems to work OK on t5319, but
> fails some tests in t5318. I haven't looked into the commit-graph test
> failures, but I'd be happy to do so if you think this is a direction
> worth going in.

I like this direction. It makes it easier to adapt future formats or
add new chunks. I wonder how this write interface can adapt to the
reading portion, since that is where some of the magic numbers came
about. Likely there is an equivalent that we could do to have the
chunk-format API construct the "struct chunkfile" and then the
commit-graph and multi-pack-index parsers can interpret the chunks
_after_ the TOC parse is complete.

As discussed, I'm putting this series on hold for a while so
generation number v2 is not interrupted. When I come back to it,
I'll incorporate these design ideas and build on top of that
topic.

Thanks,
-Stolee
