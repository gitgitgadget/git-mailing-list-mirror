Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F920C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 22:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBXWG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 17:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBXWG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 17:06:26 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4809F6F413
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 14:06:22 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id z42so476481ljq.13
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 14:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8n84MsvW4QWJk5SA5UC0FioIP3Y4YPXmt2vV23yRJc=;
        b=bEAGpVMjDb6+hPf3U7kwetyLmXAIg8xaM8tKAImNtUS8dMRG58CYnsgnUmxk/nifyg
         sOQzH3J60y90MewFqfueqlg9A2VYDN2zqxbdIAs1hcf67bTS7OahQvxvXERJhgeBoCU8
         CUW7urE8K8g1x4w6u4DVzz/w+pYoYZ68A6C0z3uR9BmuGntNSGt5xoopb8TjNJ1PQfiv
         vi4EVgATAo7v+gwLl5b9d+WliJyWDqmQFZYfQNFIXXI7isOHb5999gZl4o4W7BXHlc2G
         IFtHQHAN3GsBKf03j0GzwgCbZNhCZWGIy0/qzttOYp/hNRZLEPNEwa6hSLMi7zbeX3D4
         P8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8n84MsvW4QWJk5SA5UC0FioIP3Y4YPXmt2vV23yRJc=;
        b=4rt1j/PL+fggz1AbzQCXxWXXvbM9SsbuiCH9lEgHq/AkyuOorC4YIx3g8w15hI2JCb
         0wntxksytl81EIrcdGiRxIuuFol77a1LfKzdLyWrKHmzxQ9yLOahOGNsA5QAXKfQEm1r
         3U0sB4VviDGE3LbRPDrXfe9KpiGALpHGmN6DK58g1EanA8tksiVL4i0LEGQfuun0h6SW
         sea5tc8LdDWMnQw9CtZUfNbwAFjLipjhBpT8NIhrEiMBtM5oAiVYMTU8Zy3BNJ0TGxhu
         McI6ubWXukUg/Z1obk55IrzVkRXg10BdLig9v2lCrTgiwEe97LKEhT49lnatm4zcocka
         O1lw==
X-Gm-Message-State: AO0yUKUIusqIOkxq1EEptqiCmvvd3oIHB3KYl5YwOqNvDmVJpnjJk4AZ
        QMQFVZlCOFjAOH0jdOuG9SM=
X-Google-Smtp-Source: AK7set+xWCkt947WZ28VnCS5hvB0e3zsU9y59qbiGNHeBDB7h/CU/Gb6B3iUvZiehKNlt+RqlyZIIw==
X-Received: by 2002:a2e:be14:0:b0:295:965e:8506 with SMTP id z20-20020a2ebe14000000b00295965e8506mr5275194ljq.41.1677276380289;
        Fri, 24 Feb 2023 14:06:20 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bi36-20020a05651c232400b002934b5c5c67sm17008ljb.32.2023.02.24.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 14:06:19 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, phillip.wood@dunelm.org.uk,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
        <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
        <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
        <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
        <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
        <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
        <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
        <87a615vkqk.fsf@osv.gnss.ru>
        <CABPp-BH2XPB4BN5Oo=VnLav_wvAGGUAyZC4HRHRRmES5k75P1Q@mail.gmail.com>
Date:   Sat, 25 Feb 2023 01:06:18 +0300
Message-ID: <87bklilnvp.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Feb 22, 2023 at 6:27 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Tao Klerks <tao@klerks.biz> writes:
>>
>> > On Sat, Feb 18, 2023 at 5:39 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> >>
>> >> On 18/02/2023 03:17, Elijah Newren wrote:
>
> [...]
>
>> I also agree (in particular with Buga) that from the POV of user
>> experience the method suggested by Phillip should be superior, as it
>> emphasizes the natural dominance of the "current branch", as opposed to
>> originally described symmetric method that is more suitable for formal
>> analysis than for actual convenient implementation. Yet creating U1' and
>> U2' from the original method could be useful for the purpose of checking
>> for possible problems with automatic rebase that the user may need to be
>> aware of.
>>
>> The biggest problem here, as I see it, is designing UI that'd make sense
>> in the case of conflicts in multiple stages of the suggested algorithms,
>> but I think we can simplify it for now by stopping and suggesting blind
>> re-merge in case of any conflict but that on rebasing of changes to the
>> first parent. Even this would be a huge step forward compared to silent
>> drop of merge commits and blindly re-merging of updated parents.
>
> I'm not so sure it's a huge step forward.  Or even a step forward.

Git currently throws away my precious merges! Silently! How it's not a
step forward to stop doing this?! Sorry for getting that heated :)

Git is well-known for being extremely careful with user content, and
there is the only case where it fails miserably: rebasing merges. The
above method will simply fix this long-standing deficiency that is even
more dangerous as users do trust Git so much.

I can only tell that I, for example, will definitely benefit a lot once
it is implemented, as currently a rebase containing merge is at roughly
the same level of risk as "cvs update" was in the old days: run and keep
your fingers crossed. Well, with Git it's unless you are careful to do
2-step merge-fixup thingy every time you merge, that is basically just
poor man attempt at fighting long-standing Git weakness.

> Dscho actually implemented the old proposals and tried them out, as
> mentioned in the threads I linked to.  The results on balance were
> significantly worse to him than just throwing away the previous merge
> resolution information and redoing the merge from scratch.  He really
> wanted a better solution, but the previous proposals didn't provide
> it.

OTOH, Buga has sketched the proposals, confirmed problem with my
original one (that Dscho predicted), then sketched the update I came up
with, and showed it does work in common cases as expected.
 
That said, I'm almost sure that for any method of rebasing and/or
merging of whatever, one motivated enough will be able to find corner
cases where the method fails, yet we do have both merges and rebases in
Git, and rebasing of merges falls to the same category. We need them.
Merges need to be properly rebased, not silently replaced with
(different) merges, unless user asks for re-merge explicitly. To me
Dscho (or anybody else) finding rough cases is an expected outcome, and
is not a convincing argument against the feature.

As for Dscho results specifically, I've got an impression that he never
needed rebasing of merges in the first place, and re-merging always
suited him just fine, so it'd be rather a surprise if rebasing of merges
suddenly started to work better for his needs and workflows once he has
implemented it.

That said, when better method(s) of rebasing of merges will be found,
I'm sure they'll be adopted, but for now I do believe we need something
reliable that has been checked to actually work for common cases, as
blind re-merging simply does not, and I still suspect the best choice
for the time being is Phillip's incremental method.

Overall, I'm still in desperate need for my precious merge-the-commits
be rebased, and not replaced with Git idea of how merge commit would
look if [current version of] 'git-merge' algorithm merged my branch in
[using Git current default settings]. It's my dream that Git finally
stops silently substituting a result of 'git-merge'
(just-a-helper-operation intended to simplify creation of merge commits)
for actual merge-the-commit that is part of my content.

Best regards,
-- Sergey Organov
