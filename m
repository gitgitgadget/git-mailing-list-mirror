Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2117C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FF72087F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyUxsLkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgAGSon (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:44:43 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33118 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGSon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 13:44:43 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so322514qvn.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+R0/GLtxhkaAN6o4048v3I1tZejjtsqUR5ukFZxjaq0=;
        b=NyUxsLkw5g5yJFNsjkun3lGr1cn3+/bK/aGXYAh6hvgMqKHW2MdgOQFVRS2OjOZ2h2
         HhB1LIbVoUsuC/aVW4Qq8anq0Uj8iu49AuwKnIYvRKLXOHoCFq5LjCzAW5INyooKRcsB
         7nIJ7GwTXGUjjlGtr8k2G90jufEhAZ/rrCoZCBvttToL2f982bcTRHXhJN2Sv2+6ZeOD
         sIwSrW/1fkV/+Asrjp8Fco5bBk5Pnu3Yn4hspFgDe/6bdtoCwihsF1X+R45T7/spV+db
         yUKn6o0TmGnVi+iLNIT/tbV8ecPEKj/zwkM22EyOzsnPBH6g/+eY7uIf15rB+sSOP1UO
         eTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+R0/GLtxhkaAN6o4048v3I1tZejjtsqUR5ukFZxjaq0=;
        b=GjIVhPJhZuSVGX0KRSvx+4leTA1MZUOMDnAWd0u1nrfYF6cwxGKCoMZLphDNCR1uOK
         dYLh/ItVa8qWU1cWQpJY2vA535QQ9WCbu8QJK+a73SzNU9G/nj+aNqGsLZVQcb2kRMEE
         2z1x12Nr5rV3rLqBIvwabkKleN1OeQdBS2/VOYasBALnmNwtuIoADrmbfiDe2hf3RZA+
         tUbAvcBwbJMygTjcrM4aUYoJ3D2PH0dErFCp+/+pK8AWR6BGQt1aOYQB8Wkhy99Mnz5J
         8y4HuvgFKkDkHz73uGL0aNno6befzfO6TRJzPwFKXisZxfsH/npX8W1LIhTtSFEr1Sg2
         v54Q==
X-Gm-Message-State: APjAAAXZwoBELiD7VEkAVxErXxi8dM8vxgefrvgX9RPyPQE20UbxmE2V
        Hf5s6ubvnszUlDRx7IlHc7BBJM/4
X-Google-Smtp-Source: APXvYqzZDlLB6e8elhToOf46oUXijR+D1DH1QcwCL0ellzUzgL9JGAV0IFl3x4H3BVJ7rm12oQxBWA==
X-Received: by 2002:ad4:40cb:: with SMTP id x11mr737252qvp.167.1578422682322;
        Tue, 07 Jan 2020 10:44:42 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1010:f14d:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id g52sm303496qta.58.2020.01.07.10.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 10:44:41 -0800 (PST)
Subject: Re: [PATCH 3/3] t4215: add bigger graph collapse test
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     James Coglan <jcoglan@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
 <f74e82bea68701beb734537cafd147162d1bb2c6.1578408947.git.gitgitgadget@gmail.com>
 <20200107153922.GC20591@coredump.intra.peff.net>
 <xmqqftgr5elz.fsf@gitster-ct.c.googlers.com>
 <20200107180415.GB48806@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <31fb4e1f-be0b-d81f-8c53-81d6b0b95741@gmail.com>
Date:   Tue, 7 Jan 2020 13:44:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200107180415.GB48806@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 1:04 PM, Jeff King wrote:
> On Tue, Jan 07, 2020 at 10:02:48AM -0800, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> On Tue, Jan 07, 2020 at 02:55:47PM +0000, Derrick Stolee via GitGitGadget wrote:
>>>
>>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>>
>>>> A previous test in t4215-log-skewed-merges.sh was added to demonstrate
>>>> exactly the topology of a reported failure in "git log --graph". While
>>>> investigating the fix, we realized that multiple edges that could
>>>> collapse with horizontal lines were not doing so.
>>>
>>> Thanks for constructing this larger case.
>>>
>>> As for including this patch, I could take or leave it for now. I like
>>> the idea of documenting things further, but unless it's marked
>>> expect_failure, I don't think it's going to call anybody's attention
>>> more than this thread already has.

I think that's fine. I do believe this example demonstrates that the
behavior has changed, so adding an expect_failure (with the correct
expected output) may provide more motivation to fix the issue.

>>> So I'd love to hear what James thinks should happen here, given that
>>> it's an extension of his other work. But I'd just as soon punt on the
>>> patch until we decide whether it _should_ change (and then either mark
>>> it with expect_failure, or include the test along with a patch changing
>>> the behavior).
>>
>> ... and nobody CC'ed the person from whom they want to hear opinion?
> 
> Doh, thank you. :) I cc'd him in the earlier thread, but GGG creates a
> new one.

Sorry, that was my fault. I definitely intended to CC him, but forgot
when going through those who _wrote_ on the previous thread.

-Stolee
