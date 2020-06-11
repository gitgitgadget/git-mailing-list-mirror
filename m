Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9D6C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFBA2075E
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnPfXnlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgFKO7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgFKO7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 10:59:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B0C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 07:59:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so6513918wrc.7
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5GoCDm1a4++UtVF0IwMiIgcVlpDzZvy1hQhpde0RvnI=;
        b=lnPfXnlS3xPtPOlUPPtwmQOZKxtsMo278SiNo4eW2CysOfCIf1FNO9LVzdlQKNHGuU
         wEZuHDG/KK2U76y3vnLYeRkdzpXHrS8DwQ0+PpO6ypD1ULcoVmCs8lFXMbFf91AOWZ5H
         mz8nUwoa9kIa8I0/9J63bycXsp7iHxC7kVpwFi3IwKeDqyYMKs4xRwTT82Tcc8GGfFaO
         7NVX/kbmyGdvdUCoW6KPgn5IMfnjwCC6g7UqHZ4Chb5a/0yz5WuA4xpuc6miNlk9qXpz
         nldgkhRD7hvzscmdqWASQZz3D5QcYWA+/FC8S4czlu+fgITuV8m6Bat3dhek6sT5Zi2E
         /T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5GoCDm1a4++UtVF0IwMiIgcVlpDzZvy1hQhpde0RvnI=;
        b=FBA1dRvXoodqcfTgikmvu6ye59X+diXfjHfF09iHr+nL2pqO0O4cunu1h2GWsR4bU7
         sjuFDbod0R3ALgyvvDyPXInMlfYAPYeFZTWs/oKhGJcd625fOuXjjEHj2Q7g004nTJYG
         GkR5ssYUSLp/L8J8KzNhFkkbUuIPj4YfMfVTfAdsoAa5LAlHWHwzKMhTP/TKzMEtpOvK
         qMc0NJtNDLtQDLzD8nclPnx4lU7+grL8EWZ9ca7WB5kxqVfGZKO12SlYWFKmXawrzXLC
         5/bkiEFq05y6Ny972RpDCJ8RlYXuYvBEmM1L3EnIRweYKXDAuidMmfPBXjoMzsG+EfBw
         SAqg==
X-Gm-Message-State: AOAM530qPdCzEikoL0ZVEpnfctnN9xutVgjbNoaO1HWYOMvHLCLB6l2q
        zuqj/rfCm1jjJaekn2r+y0Tk6B3e
X-Google-Smtp-Source: ABdhPJwakmkeml3bSvmL+6O9zyzZOPzRMhn2ZJgrofEsxsriiTe6PVcFFoic3tgblaEmJ7K2h062lg==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr9573117wrx.231.1591887558447;
        Thu, 11 Jun 2020 07:59:18 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id z6sm5345932wrh.79.2020.06.11.07.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 07:59:18 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v16 02/14] Make refs_ref_exists public
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
 <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
 <a4a67ce9635197d759a12a617711764c1df16b65.1591380199.git.gitgitgadget@gmail.com>
 <9a5c0243-115e-ce50-dd80-2be4c889f4ba@gmail.com>
 <CAFQ2z_MDeiZshhmx=BjqCg7hTF04Fj7oM5dKs15qeESEPjjXEg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <543c80ab-9e51-ed34-baca-70a1f8b46b2e@gmail.com>
Date:   Thu, 11 Jun 2020 15:59:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAFQ2z_MDeiZshhmx=BjqCg7hTF04Fj7oM5dKs15qeESEPjjXEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2020 19:05, Han-Wen Nienhuys wrote:
> On Tue, Jun 9, 2020 at 12:36 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 05/06/2020 19:03, Han-Wen Nienhuys via GitGitGadget wrote:
>>> From: Han-Wen Nienhuys <hanwen@google.com>
>>>
>>> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>>> ---
>>>   refs.c | 2 +-
>>>   refs.h | 2 ++
>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/refs.c b/refs.c
>>> index 12908066b13..812fee47108 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -311,7 +311,7 @@ int read_ref(const char *refname, struct object_id *oid)
>>>        return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
>>>   }
>>>
>>> -static int refs_ref_exists(struct ref_store *refs, const char *refname)
>>> +int refs_ref_exists(struct ref_store *refs, const char *refname)
>>>   {
>>>        return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
>>>   }
>>
>> It is a shame that ref_exists() does not take a struct repository. The
> 
> I'm trying to follow the pattern that the rest of the code
> establishes; you're right that the code isn't very consistent (the
> fact that it uses unlink() rather than go through the ref store in the
> first place is an indication of that). I want to avoid starting a
> general cleanup tour of the code base, the reftable patch is hard
> enough to pull off without.

Sure

>> The existing code is inconsistent about its repository handling - we
>> create the refs with update_ref() which operates on the main repository
>> but when checking their existence and deleting them we use a path which
>> depends on the repository. I've realized now the answer to my question
>> about using delete_ref() in my reply to the previous patch - it does not
>> take a repository - maybe it should along with update_ref() but that
>> might be more work than you want to do though.
> 
> Why do they take repository arguments anyway? Is it because
> rebase/cherry-pick supports recursion into submodules?

It was a stepping stone towards that, the git_path mechanism that is 
used to create git_path_cherry_pick_head() etc was changed to take a 
struct repository so it could support submodules without forking a 
separate process. However are still plenty of places where the sequencer 
code assumes a single repository (it calls update_ref(), delete_ref(), 
commit_tree_extended(), ...) and the two contributors who did a lot of 
that work have moved on. With that in mind perhaps we'd be better off 
just using ref_exists() and delete_ref() in this conversion. The call 
sites will be easy enough to fixup if those functions are converted to 
take a struct repository in the future and the result of this patch 
series will be nicer. I've cc'd dscho and Junio to see what they think.

Best Wishes

Phillip

