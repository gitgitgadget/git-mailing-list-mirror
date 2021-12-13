Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F73CC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 14:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbhLMOA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 09:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbhLMOA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 09:00:58 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4651EC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 06:00:58 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso17444301otf.12
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t4VXMacX+FyJmo5SQDnHtVIqD50VUn2i4pvbb3BiA2w=;
        b=DvqpjbUbMbqgqgu1eff+jcYJy/bjmaPH+hHO1cKy0CKVf07QJJ1fZraD7130AGYcxL
         uFwS9v702LElz4u1Bw/b4rPsvbsVf+ODnW1ccGE8DbZeD/Z+QVWViqtVFF43cVTJRvw9
         QMlbJovdpkLq7UadpiQ3GUZoC7mcdFzO1W+Zs3n6s8l/b3aEtnab7t45D1a5GKOD7dZt
         EGydDVocdh8MMF2PSSthgXBTglILTsfn9/i1pIE4tdNlX5/g5BAF/ECCxBE80jFuSezm
         LkE/cRPeXliB3yFVG3Xxt8Tkc+O5UZSgCNLLJFHFg7g+wPKyvKcDeNZFuAeTIjpg5Crk
         Bv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t4VXMacX+FyJmo5SQDnHtVIqD50VUn2i4pvbb3BiA2w=;
        b=br9+4U4yeXr0NklKIQaMwzNv/iatAC7qsj0L8WiqDETh8htqRsZDC4GNWoqkgHFNAL
         4RFiJMtciLbppa2RNCUesNqdfv9Z61wDSAXj5OgDFNUBx6iBfcykc0aVBO1hqfABgRnb
         65cJ7lT0JEDMNzH74V5Wa+CDhwZ7yk4hsvtlcboZLlLje7/OKdQe0mVvAGsZMJtY6CWL
         LFP8JRDkzPGn79R/jpJ6yTzxpOJ2+q237+oANkJ4HjP+btZD7c9Hjuzvd4tSTWtIjkqR
         1G2iYC1SY19Xvf/N6003fGB34Xsmqz5GI5CG5xXgZzcuGDmAPani1OfgsjoPDXqgAANQ
         NoIQ==
X-Gm-Message-State: AOAM532miVMxYAyEae9Wj380YHo6cXiiSrjb13eXWhjYdlZnO5qQCoJj
        DCeK0y2aSqxCvzHKLYBIccApc9q+iw8=
X-Google-Smtp-Source: ABdhPJxQmngwq7UwrRbQEAthjl4hQunADd2d2r5SSVY1nQlDqg84yfGA6gbGva4oc3FhC5gvgOGkxA==
X-Received: by 2002:a9d:798d:: with SMTP id h13mr24581895otm.132.1639404057239;
        Mon, 13 Dec 2021 06:00:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9d64:cc62:7406:aacb? ([2600:1700:e72:80a0:9d64:cc62:7406:aacb])
        by smtp.gmail.com with ESMTPSA id m22sm2318224ooj.8.2021.12.13.06.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 06:00:56 -0800 (PST)
Message-ID: <6ea31bb3-3363-ece0-9947-b303d5975263@gmail.com>
Date:   Mon, 13 Dec 2021 09:00:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/2] midx: prevent bitmap corruption when permuting pack
 order
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <cover.1638991570.git.me@ttaylorr.com>
 <bf100d0c-66c7-d402-4790-9c5797e8baf3@gmail.com>
 <YbENofRtY0BPMEUd@coredump.intra.peff.net> <YbOeEjNic5ETGcdy@nand.local>
 <YbPVP0BvYcVsfOrf@nand.local> <YbQBZX+Wo3zlOcWc@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YbQBZX+Wo3zlOcWc@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2021 8:39 PM, Taylor Blau wrote:
> On Fri, Dec 10, 2021 at 05:31:27PM -0500, Taylor Blau wrote:
>> I had originally imagined that storing the preferred pack's identity
>> alone would be enough to solve this bug. But that isn't quite so,
>> because we break ties among duplicate objects first by prefered-ness,
>> then by their pack's mtime. So that could change too, and it would cause
>> us to break in the same way.
>>
>> At the bare minimum you need an ordering of all of the packs in the
>> MIDX (like I had originally imagined here). At most, we could do
>> something like what is unintentionally written here, which would allow
>> us to get rid of MIDX .rev files entirely. I think doing the former is
>> simpler, and I am not sure if there are practical advantages to the
>> latter.
> 
> Thinking on it more, I don't think this "at minimum you would need..."
> is quite right either. It would suffice to know the identity of the
> preferred pack, and the mtimes of all of the other packs, since that
> alone is enough to reconstruct the object order.
> 
> That is pretty appealing, too, because knowing the order of packs would
> require some major surgery (the order of packs isn't really something
> the MIDX code thinks about, it's inferred from the way it sorts
> objects).

I think the root cause is that the object order can change when the
preferred pack changes with the same set of pack-files. Suppose we
added more complicated ways of deduplicating objects across the packs?
Then whatever we include here based on preferred packs and mtimes
would need to be updated to match.

However, if we store the contents of the .rev file in the MIDX itself,
then we don't need that extra layer of indirection.

I'm leaning towards keeping the contents of the PORD chunk as-is, but
renaming it to something like OORD (for object order). Then, we can
carefully transition from using the .rev file to reading this chunk.
We will want to continue looking for the .rev file when this chunk does
not exist.

Thanks,
-Stolee

