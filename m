Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 17:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiFHRfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiFHRfE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 13:35:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D45825EC
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 10:35:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3135d02968bso31121337b3.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 10:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E2vA/E+TEld2abRl4fqphEL/8Pk0ZUhjdp8jBkkf4B4=;
        b=VsFjVWTv5L7VzVzT3WmMqDctX9AbS/LkNFOsmRre3QoRLjQil/vQX9fVVNhlrYKAjx
         BUTKyuUg1px5ARpgjnlurlebQ6jYsHNT8Q+L9JIRW487vNrOs/d+m+Lukjlg37Kbm5pO
         amLI0DUrJWV5r9gkx5e9TWoKA8IphYdvSbcaZTco/0rpgpJMq5CWf6eW/LQBZAaWRdzm
         C20PFqcu1q8dwCF3gyAJKauyemBPjrGOzMwq6YFM++EsBEVTVXCc9l12/N4ThG1fRZkF
         tnGbpJOfCguSd7zRH7AysDw3vJVTDO3wHwXgTg93B7i6v7I1xyWKypTidnJ/HqoTkT7+
         V+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E2vA/E+TEld2abRl4fqphEL/8Pk0ZUhjdp8jBkkf4B4=;
        b=iMDtRNucZVeISpw0uc9w0qg4UjWPZWnYf06441x/l6Pr/XfIjpkk+COTCtaAlmzjmP
         4hMdLmAAEQLI7j8wyFCDmgfV4+m1G5xzGSrJHApZ9XcnsTKHkm2I7w4+exnahWB0TDqj
         JIoMBf3f2h0c3liXedz3T46N7y2iUjElAlE8s2q6uoEnmyosA7pTBTU8P9c7w5fZnj7M
         xHnXu/x++8iWFYh+1Mnc62X9mNbk9Xi4wjDmMxxLPC9f5C2cpUkvXIDhnzW1wPEDxW4O
         24ISPtT8Sc0MuCUJvOs5K5Zi9UuGnwftj0LfiA2X2ryDuuYBfec6XtgtZW96Vm9HbcG1
         BSIw==
X-Gm-Message-State: AOAM531OjOoDE0mCjJFueOtTY9juvBTLDLLpWEDiJgbX2KKR2Bw04lG9
        VWTkx2GNBio0MvvG6TlHRh6BrNY/DB0kaQ==
X-Google-Smtp-Source: ABdhPJw78LAyrN+X59n1SUPerjXNwBK0dkgsCPic+vMe6T/Awx96Jr+pX+k2kQ/8nvorEEU5cwFBi4elL+hkfw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:690c:110:b0:2ec:2d79:eee1 with SMTP
 id bd16-20020a05690c011000b002ec2d79eee1mr39912638ywb.21.1654709702605; Wed,
 08 Jun 2022 10:35:02 -0700 (PDT)
Date:   Wed, 08 Jun 2022 10:34:52 -0700
In-Reply-To: <CAFySSZC0ieObo=CzhoHiqrcdv3335VaRBtYMLFe9oEJ0hucOCA@mail.gmail.com>
Message-Id: <kl6l8rq76oub.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220606235449.2890858-1-calvinwan@google.com>
 <xmqqh74x1eol.fsf@gitster.g> <CAFySSZC0ieObo=CzhoHiqrcdv3335VaRBtYMLFe9oEJ0hucOCA@mail.gmail.com>
Subject: Re: [PATCH] submodule merge: update conflict error message
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> Hmph.  Is 1. necessary?
>
> I just tested it and it is not, so I do agree recommending to abort the
> merge is unnecessary/bad advice. How does this sound?
>
> Failed to merge submodule <submodule>
> CONFLICT (submodule): Merge conflict in <submodule>
> Automatic merge failed; recursive merging with submodules is currently
> not supported. To manually merge, merge conflicted submodules first
> before merging the superproject.

This message sounds ok to me, since this is probably what the user wants
90% of the time. Since we don't abort the merge, this just a 'regular'
merge conflict resolution (albeit with submodules). The user probably
wants to merge the submodules, but they can choose however they want to
resolve the merge conflict, e.g. maybe they'd prefer to just pick one
side (or even more exotically, a different commit altogether.)

An improvement for that other 10% would be to print this help message
with the advice() API so that users can turn it off if they don't find
it helpful. Or maybe it's confusing to some new users who use a
different merging workflow and so an admin might turn off this advice
for them.
