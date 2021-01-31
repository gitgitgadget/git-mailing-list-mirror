Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD3C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 04:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8719964E21
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 04:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhAaD7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 22:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhAaD7u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 22:59:50 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA729C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:59:09 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id t25so2718600otc.5
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8oJKmhVWpEKuDmJT03oQZgKbGeI83IrfX41Eu7SI6AI=;
        b=ANMoN0ux8y9nwE+d0FGIgmh4jDf8xel6eGYS/ekaQAI0rxpWieKqqmXabXQwbBfor2
         KMQUeqGLpHw/0bC6awDbYHEjWwoq7G7LYB+Ny1/LqhQUCHVaNGWXUH+YSFuCQfBVER9Y
         0NXlbC9V1k9TL1AuLrahAb97U/th+AP0FCa0g/rzvpn1w5jM9qGpKW79V4mZXQMn3ZAU
         pSzx1Av5DbO9nPDX+hF8sDpIrArZOTgqsMwYmsYJ8Ngdt43WUU7g4ZfWbR3xdHkB3qQV
         aYYlrTm8Xi3KM8MYjum2qUXoa9/N+cK/PC/rYTZMJ4SA3Ka9fLi/dgqkiOPTCOnyTFHD
         qPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8oJKmhVWpEKuDmJT03oQZgKbGeI83IrfX41Eu7SI6AI=;
        b=kwL5mDyG+fWde4+4JNXgTLlbw2uITJQkqu1cwKnMRhcNTqM3Q7x7oGPFITtIcDQ7vc
         Ur2ZZ9C4V/+gRYQWfVA4qP1E1SJO1qOkYYCg0PrJLASLSDf0UoLfsgXXnVNJ/H3gu2Ig
         zoAD75u+OgdOIwQDo1kv3NFPDVaOOeLmK5EfiPwe/OjYVKPfm2+NNLvEBRyZ25c8TMHe
         /Mtyr/15UsenxdY4N2aEtDZHFE3BXqJo237sigAn+YDZe+gMiEBBNuMU9WcF9CCvucxQ
         ge9W16C8raXshux7lOUI3a+UvDxa22NLj+s5HPDk+qCXNVkctLeg8CKWf7xbN62WOAdF
         8BHQ==
X-Gm-Message-State: AOAM5333k7dmVkXk1DVVJnPQn4Hv/Ou4LaZKiNsmaqufXFju0/x615Z4
        3o9T0+i6HxVfhaK+4Nlt3EA=
X-Google-Smtp-Source: ABdhPJyMbfxmtBCLM/4BGKnLNaNl/2wSijNJBuPpdnzML4Q2BQT/7zqABf0mDe/Fq7r8pJs/LCqw9A==
X-Received: by 2002:a05:6830:573:: with SMTP id f19mr7530584otc.117.1612065549311;
        Sat, 30 Jan 2021 19:59:09 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:383e:f17:3be5:db8d? ([2600:1700:e72:80a0:383e:f17:3be5:db8d])
        by smtp.gmail.com with UTF8SMTPSA id z20sm3124814oth.55.2021.01.30.19.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 19:59:08 -0800 (PST)
Message-ID: <e5863616-ff74-88f2-3d6a-c8dbe03477fe@gmail.com>
Date:   Sat, 30 Jan 2021 22:59:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 1/3] commit-reach: use one walk in remove_redundant()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
 <xmqqtur0vl7i.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqtur0vl7i.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/28/2021 3:51 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +		parents = c->parents;
>> +		while (parents) {
>> +			if (!(parents->item->object.flags & STALE)) {
>> +				parents->item->object.flags |= STALE;
>> +				prio_queue_put(&queue, parents->item);
>> +			}
>> +			parents = parents->next;
>> +		}
>> +	}
> 
> So, the inner loop makes sure we won't revisit STALE parent, but
> keep digging parents we haven't seen, and stop when the generation
> is old enough.  What happens when there is no generation number
> computed yet, I wonder...  We'll keep getting infinity and dig all
> the way down to root?

If we are on commits that have no generation number yet, then we
will walk until reaching commits in the commit-graph file that have
a computed generation (or in the heuristic case, when we have reached
all but one of the commits).

In the case of the commit-graph, all commits will have generation
number "infinity". In such a case, perhaps the old algorithm _is_
the best we can do, at least for now.

The trade-off is that we might walk more commits in unusual cases
with few input commits. That quadratic behavior will take over as
the input size grows, no matter if there is a commit-graph or not.

I can do a big more digging into these unusual cases, especially
when we cannot rely on commit-graphs being present.

One way to ensure we do not regress from the current behavior
would be to condition the new algorithm with

	if (generation_numbers_enabled(the_repository))
		new_algorithm();
	else
		old_algorithm();

much like in repo_is_descendant_of().

Is that a good plan?

Thanks,
-Stolee
