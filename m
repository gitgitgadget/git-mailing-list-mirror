Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACBAC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B734C20674
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfK0QJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:09:10 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.100]:59200 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0QJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:09:09 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iZzsG-0000Id-Rm; Wed, 27 Nov 2019 17:09:04 +0100
Subject: Re: [PATCH 2/2] checkout: die() on ambiguous tracking branches
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.477.git.1574848137.gitgitgadget@gmail.com>
 <7dde1a3b4e4e76cd1a820b5277f694fdfad3a922.1574848137.git.gitgitgadget@gmail.com>
 <87v9r5nx3w.fsf@evledraar.gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <08b8acc1-6925-ad40-faa2-88a16b8d135f@syntevo.com>
Date:   Wed, 27 Nov 2019 17:09:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87v9r5nx3w.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27.11.2019 16:43, Ævar Arnfjörð Bjarmason wrote:
> I'll reserve judgement on whether we really should do this for now, my
> current opinion on the matter is undefined as I haven't re-paged this
> behavior of checkout into my brain.
> 
> But a giant red flag here for me is that you say "I understand that this
> was never intended".
> 
> Just from a cursory look at this that's not true, for better or worse it
> *is* intended behavior. Most of the code you're moving around here is
> what I added in ad8d5104b4 ("checkout: add advice for ambiguous
> "checkout <branch>"", 2018-06-05), and the very start of that commit
> message refers to the checkout documentation we have that explicitly
> documents this edge case.
> 
> Digging a bit further reveals that we've had this behavior (again,
> intended, not emergent) since 70c9ac2f19 ("DWIM "git checkout frotz" to
> "git checkout -b frotz origin/frotz"", 2009-10-18), and had it
> documented since 00bb4378c7 ("Documentation/git-checkout.txt: document
> 70c9ac2 behavior", 2012-12-17).
> 
> So at the very least I'd say you need a v2 where you amend the relevant
> docs & commit message to make a case to the effect of "we've had this
> since 2009, but it was never really all that important etc.".
> 

I'm sorry, can you please clarify?

My patch addresses the situation where there are *multiple* remote 
candidates *and* a file with the same name.

My feeling is that in this case, reverting a file is an unintended surprise.

I understand previous patches this way:
ad8d5104 - patch series is mostly for "if there are *multiple* remotes,
            disambiguate via checkout.defaultRemote". This essentially
            converts the case of multiple remotes into a single remote.
            However, this also semi-documents what I'm now preventing.
            Was that really intended?
70c9ac2f - if there is *one* remote, DWIM it.
            This isn't what I'm changing.
be4908f1 - if there is *one* remote *and* file, die().
            This is what I'm extending further.

If the prevented behavior is documented, could you please quote it 
explicitly?

> Such a change should also be changing the docs etc. added in 8d7b558bae
> ("checkout & worktree: introduce checkout.defaultRemote",
> 2018-06-05). With this series our docs don't make a lot of sense anymore
> & don't describe the behavior with the patches applied.

To my understanding, my patch doesn't affect those pieces of docs? 
Please correct me if I'm wrong.
