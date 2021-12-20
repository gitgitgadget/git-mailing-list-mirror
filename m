Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60002C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 18:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbhLTSv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbhLTSv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 13:51:27 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD45C06173F
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:51:27 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bk14so17162476oib.7
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1MKNRddHxDodnys0dx4LM48/hv1747V799fVvphb5H8=;
        b=GBmGaBtfMDmK34xQD7t2An24tzCO2v86qk0UvQAw3yxmL4XT5/uDgTUYELal6pNbi8
         RSIb+v4AO4PHOvvfIY8ftVrtwvzwUfCQWV3zWBMVO1D+i1n0h15CTtCoNfWb+c3Z6uUs
         HwetpRKvgUC7hLxn7siWMLZEMD4spQdtyObOtJdZE5597HlJJoXS294/JvrZFJCgXICy
         v9eo9swKJvrJL+r0jL8cd4wd6WehOCLej8qXhAA8+yB9wtUEIRS5E3DCG1x8o5I1Yw7w
         TMLLWvnNQ+QAxPaBizFx9VhXUiXyh+dUSxt7YKYcpTCLeubD88GlbY6Z5mfOv5oFlq/8
         b0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1MKNRddHxDodnys0dx4LM48/hv1747V799fVvphb5H8=;
        b=B5ZPLUOXlhM1PgGx1q805XegS65emhLguSQgc5vsP/py68a8PIMYnPDPjPVp5rB7Tp
         vichWRM8ChNJNDHfOf4MhpyMZKgDUutIh1EaM67fYK95QX1+is9VOPz9PWSezi9kmGiL
         lL2bz/gl52wFFhLpMGQqr75VfD7Tk5v/iQCSR6A+WMpbRJvAkw83ySQcYXqY7QvlKiXB
         OYSPuTO/1TDZmEd7PWfjXCX7JkqLaTb8wPjDUBN8SEi3ru4Op7PS32j0fQr16YzaHY0t
         Hkl6uNrXpOmnXGMagFutv8WKmc5Dlj+fAFHj4HCKzV6M53mfkbXll1Y8e6s8l1wuMrlb
         wVyg==
X-Gm-Message-State: AOAM532i8sGYaOGv7Ea8HPkw3rbST6dvyg8Fr6WTF15FWa202znz5/j0
        tsGalbM7XTf77E/e8jDC+BUl0pN/Eko=
X-Google-Smtp-Source: ABdhPJzeBZquXWSbGc/Rb4mOjcGipYPl+WBdjR7UjNs5iwCzN7lhanvCae5nJ91bK4o6XEC9MITOYQ==
X-Received: by 2002:aca:1c13:: with SMTP id c19mr315860oic.20.1640026286554;
        Mon, 20 Dec 2021 10:51:26 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id c10sm3548207ots.73.2021.12.20.10.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 10:51:26 -0800 (PST)
Message-ID: <886da3f3-aa6a-ac74-2aa2-26abdf832ebd@gmail.com>
Date:   Mon, 20 Dec 2021 13:51:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/8] midx: prevent bitmap corruption when permuting
 pack order
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com> <xmqqee6d648n.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqee6d648n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/15/2021 2:46 PM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> Here is a reroll of my series which fixes a serious problem with MIDX bitmaps by
>> which they can become corrupt when permuting their pack order.
...
>> So I'm definitely open to suggestions there, but otherwise this series should go
>> a long ways towards fixing my design mistake of having the MIDX .rev file be
>> separate from the MIDX itself.
> 
> Yeah, a single file with different chunks is a good way to ensure
> atomicity of update.

I just reviewed this series for the first time. Sorry for being so
late getting to it.

I had a few minor recommendations but they are mostly nitpicks and
don't deserve holding up the series if there are no other major
comments.

> A note to reviewers.
> 
> We need to make sure that not just we can still read .rev in
> existing repositories (and convert it to the new chunk) correctly,
> but also decide what to do to older versions of Git once the
> repository is touched by this new version.  Would they be upset to
> see no .rev files or is it just the performance thing (and it is
> more correct to recompute the reverse index on the fly)?  Should the
> new chunk be made mandatory to cause them notice that they should
> not muck with the repository, or is it optional?  Things like that.

1. Can we still read a .rev?

The new test script specifically verifies that existing repositories
will continue to read their .rev upon upgrade. Their .rev files will
be replaced with the chunk during the next write.

2. What if they downgrade after the RIDX chunk is in place?

The .rev file is missing and the repo has a performance issue because
they can't use bitmaps. Correctness is not a problem. Anyone using
.rev files for server use (where bitmaps are most useful) is hopefully
already careful about downgrading Git versions.

3. Should the chunk be made mandatory?

Unfortunately, the chunk format did not follow the index format's
example of making lowercase chunk IDs required. Instead, the chunks
that are necessary for v1 are necessary forever and all other chunks
are deemed optional. Changing this would require something more
drastic like updating the version number or giving some grace period
where released versions start treating lowercase chunk IDs as required
before creating a new "required" chunk.

This does mean that if there is a version incompatibility, the RIDX
chunk will just be ignored by the older version of Git.

In terms of making this a safe format upgrade, I think Taylor has
achieved that.

The only thing I can think is that server operators might want to
deploy this version with GIT_TEST_MIDX_WRITE_REV=1 for a while, so
any need to downgrade would not suffer a performance penalty for a
missing .rev file. If that is a planned way to safely deploy this
change, then it might be worth adding a test that we safely delete
a .rev file after writing both a .rev file and a RIDX chunk. (The
RIDX chunk will be preferred, so maybe the previous .rev file hits
some logic that would skip its deletion?)

Thanks,
-Stolee
