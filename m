Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE62C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292C861164
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhEFIlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 04:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhEFIlL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 04:41:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C13C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 01:40:14 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso4230235otv.6
        for <git@vger.kernel.org>; Thu, 06 May 2021 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NFK/EIqYKeR8P0YgmBGpPOHv81n3kM8h13BbftbWxeM=;
        b=o+3qekIncl2LR3d8NN7psQKCfHfcG7X8yDa2adJpwEcqq0Tb1+GgTMIif+e+YfZ0LZ
         U1esxKyyvkFsJ1CGGeaSuOrB89+0KkFtnHb0G0RWlSpnyh0vv8l6ebamPtg2M9dZlQye
         5m9RBfWFhiERJmo+KUYotnD+d6I50fy0YsEz3ydhK/q01HN9mr/W+ahn+xqdIPOa8+ZE
         BEoVb4XTiU648Wro+fp1aS4jdtpMKzFKxhJIIkVp792ucoSlrgdccBWlDdmms5N2RFmX
         46GwnvArtUBI8GmuYSoxqFlWTrHXQ+UGS2aMl4MQb9sTUnN3WdRZmkGJqakSqLGPQKr+
         17HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NFK/EIqYKeR8P0YgmBGpPOHv81n3kM8h13BbftbWxeM=;
        b=fAsKTLLgLUq4MwiLQSazO6lwjBfyXt7m6kReCtLN2QM/XC5KTD1nh2qwCdrIgUexIC
         ZxKI9R7YV9ACVsCZdqQLV5W2wqnNlFylfMzIDbuq/osMPu9+L9drBkbZrnie48+jsyiJ
         USX5U8Y1pLaD7T+JlQBWqYcUx6usLQvYMKVIPPAqx0HkAyHErMX5Ha3msmYGbHyxMOvw
         2ffErfRgDWfYPGNtFi/JASDLicwwR2PdU5tDEbetW+V0FwG15SRertiWgG11PWFy5qYl
         eRd/QVDRtvI9CPr2fA4mQWGMN96y7ahcxBS31JXLgKcEOighT72HbaaImf9FSgpjg0xu
         U+jQ==
X-Gm-Message-State: AOAM533Lc5YEbodYKlGa8MGo35GFQv6A+BsHk43qrCbmOPcjCsfyA/te
        a4aHWiyzKRdzefCqx8DvYJunR35wt2m4Ng==
X-Google-Smtp-Source: ABdhPJw8iQJFt9BOutdoG9bicBRvjyI43Q9vPhGQ6CdIbrkM7XCC/HLLlcS7G7k2msP5dN+hl/jbtQ==
X-Received: by 2002:a9d:d0e:: with SMTP id 14mr2743997oti.12.1620290413410;
        Thu, 06 May 2021 01:40:13 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id u24sm446466otg.73.2021.05.06.01.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 01:40:13 -0700 (PDT)
Date:   Thu, 06 May 2021 03:40:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Yuri <yuri@rawbw.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <6093ab6bd3ea8_24e620862@natae.notmuch>
In-Reply-To: <d4ae27b9-3911-506c-a23c-3ed91bb250d1@rawbw.com>
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
 <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
 <e75f000b-e376-45d5-ee5a-2a555076a3d9@rawbw.com>
 <35877543-93b8-00f8-692e-09a06d4679aa@kdbg.org>
 <d4ae27b9-3911-506c-a23c-3ed91bb250d1@rawbw.com>
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri wrote:
> On 5/5/21 11:43 PM, Johannes Sixt wrote:
> > I know. But, as I said, when you turn away from your current work, which
> > is precious, then you should make a commit, in particular, when you can
> > forsee that you might not be able to come back soon.
> 
> How can I commit unfinished work?

Just like that: `git commit`.

That's what you are doing anyway, whether you realize or not.

> Commits are public, this would break things.

No. Commits are most definitely not public. Not unless you do
`git push`, and only if you push to a public repository.

I have countless commits on local branches that nobody would every see.
Many on a "tmp" branch.

I also have many private repositories, which contain passwords and other
sensitive information. Again... Only for my eyes.

> > For long-term storage, use branches.
> 
> Branches are too heavy-weight.

No, each one is a single file consisting of 41 bytes.

A single stash takes about 200 bytes. Considerably more.

Compare:

 * .git/refs/heads/master
 * .git/logs/refs/stash

> They need merging. Sometimes several stash items need to be used
> together, which makes it inconvenient.

You mean like one stash item goes on top of another?

Like... Commits on a branch?


I think this boils down to a confussion of concepts. Stash items are
commits. The only real conceptual difference is that you did not
specify the message (-m tmp would do that trick).

Again. Check yourself; the commit is there:

 * git cat-file -p stash@{0}
 * git cat-file -p master

Cheers.

-- 
Felipe Contreras
