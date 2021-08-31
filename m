Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE1C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 01:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F5860F6C
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 01:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhHaBW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 21:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbhHaBW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 21:22:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345CCC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 18:21:34 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x10-20020a056830408a00b004f26cead745so20812324ott.10
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 18:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j45dZZ2kNaNmF9nlWnjWmPwzQe02rmwtxmBwhKwFSF8=;
        b=mbF4Rwa583slEzBp5mh7a9CIX3GJbYSf/g1nPlHHJtMmSgrjAo7e9YlFA7giS9HHjU
         qkBu+w2vy7X+eGhEN294KUKhl8+guI28LMaTKqj8K0U2enH8DcPykfqDQR9Edtdr62eA
         3isf+T+RE+VEwyImDMJfT9XQvPhq7TABHxY8jBxYvRtvDUUZLj8Vpt9hUri2OAN25OOL
         8KA0eIhYIXs1pKhUBDiVKsLZ/+mnaSssHI3gD2T1mGndkZ6rjNyleV2uy0IlCzoZo5n8
         ZS0it9M2/H+1X9U29BqkUAY1xujIf0ZcJBH6jZ4jB5lGlq0wsGC+cggguFAaL3rU23fV
         J7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j45dZZ2kNaNmF9nlWnjWmPwzQe02rmwtxmBwhKwFSF8=;
        b=e658ISFhkGAKBrhpb3VKKynoXEwBopl8GdyW7qdXwaFWB0xb3tjifvX/zau9rJ9KRR
         8VCR1Ast83Tq5eBVPff0p8JqwI+RUhSq43Ic7DzLSRQbdmJm/qmvvUVqjOt/3HBFzene
         38U0YRzG5vWSfVmbwhkfJMHiMXGbrwqrGKfMYEvlXDyxIw9BHWv+0rovYiglDCBfa381
         G+PKAh8SVa05iXWMjMX8b6LKUlS5lONB9/henb5G9PU19gRp22crVZ+uQKe451gZzrE6
         xWWGQIBtsc8Ge3o5V67KL1DfsiT8pFyFkGmdAsvj0w9Ft2vLkPrVWeNyu4FmrxOX+XZx
         mUig==
X-Gm-Message-State: AOAM531n6qrHoojgDqbYm+Y5033uQA37RNLVBcxHR/A3prxjt8rWLaoQ
        YxGRFbTg70MV030H8MFAxI2u2IJhpFI=
X-Google-Smtp-Source: ABdhPJx0YnYIesie31SocAjcPj6dcv2LbIRy6RbywICdpT7nlOiKj1+k+BskLHrI0qyI8qk57crFKw==
X-Received: by 2002:a05:6830:1d59:: with SMTP id p25mr21592574oth.191.1630372893414;
        Mon, 30 Aug 2021 18:21:33 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:98ec:40d:44b0:1327])
        by smtp.gmail.com with ESMTPSA id n73sm3322618oig.9.2021.08.30.18.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 18:21:32 -0700 (PDT)
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
References: <xmqqa6l6oafd.fsf@gitster.g> <YSVX18UXh9vX+Zhp@nand.local>
 <xmqqr1eimtrp.fsf@gitster.g> <YSVjnSDaBXgXvT9W@nand.local>
 <xmqq35qymrcn.fsf@gitster.g> <xmqqy28qlcow.fsf@gitster.g>
 <YSVuUYFh7lmhNlEy@nand.local> <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local> <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <22366f81-65a6-55d1-706c-59f877127be0@gmail.com>
Date:   Mon, 30 Aug 2021 21:21:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YSwhNxqAS8JajA7p@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/21 8:07 PM, Taylor Blau wrote:
> On Sun, Aug 29, 2021 at 03:56:31PM -0700, Junio C Hamano wrote:
>> My recollection is that "--object-dir" is mostly about the alternate
>> odb usecase---am I correct?
> 
> That matches my understanding. The documentation refers to the value of
> this flag as `<alt>`, making me think that supporting non-alternates is
> a historical accident.

Yes, supporting non-alternates is a historical accident. Supporting
alternates that are not actually the core object database of a full
repository is on purpose.

So, hopefully the remaining discussion that I am seeing can be
solved by a decision such as:

  "If we add the restriction that the builtin always runs with a
   repository and --object-dir always points to its objects dir
   or one of its registered alternates, then we have access to a
   local config file to learn how to interpret that object directory."

>> I wonder if it is safe to assume that in practice a directory given
>> to the "--object-dir" option is always the "objects" subdirectory in
>> a repository, and it is an error if there is no "config" file next
>> to the directory.  Then, we could check ../config relative to the
>> given directory and error out if they use different hash.

I would say that is not always the case, and we should not error out.

I think taking a look to see if ../config exists to use the data
might be helpful for some cases, but should not be a blocker for
completing the requested operation. The config from the non-alternate
repo should be sufficient for this (somewhat strange) case.

> I'm admittedly a little unsure of how to progress here. Given that this
> series has received positive review over the complicated parts, it seems
> that it is getting stuck on how to deal with `--object-dir`, especially
> when invoked outside of a Git repository. My inclination would be to
> send a new version that simply requires the MIDX builtin to be run from
> within a repository (as well as the cleanups from Johannes).
> 
> Does that seem like a good direction forward to you? If not, let me know
> if there's another issue that we should deal with first and I'd be happy
> to start there.

I think it is sensible to restrict 'git multi-pack-index' to run
inside a repository on its own merits. It happens to also solve
some tricky problems that have come up since its creation.

Sorry I'm so late to this thread. I gave most of the messages in this
chain a quick read and this seemed like the best place to chime in.
Hopefully this isn't too much of a re-tread of things covered elsewhere.

Thanks,
-Stolee
