Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4370E1FE4E
	for <e@80x24.org>; Wed, 22 Jun 2016 09:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbcFVJXa (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 05:23:30 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34220 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbcFVJX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 05:23:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id s17so2446460oih.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 02:23:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CIHVWePipLdm2ALzcl6uAJIBpCo2qCdCdlhZdu2r1rM=;
        b=lfDqWHiuwCrK0ncQhlZKzK3SQDcgEtY+7upn6jddnzuqCizCNSzNv0CbUTkib3BnrE
         9eKomqRfgBLRMTm2nqfIHAHaZDnMABKZ85Y0H9XSApktJLmRJJQXzhjuFu9VuPVideen
         rRB1OvYPRj0SjZeiQ505mvhN4xwD1OEqwU5r0imAaxxmE2f6xMZHhSUXLEzkAXIAhqiA
         n67Q0V4bN7zuI1G7YG/7x4bAAEXSRKRtkw+bzq+YW/9DizaFp1aE1iktcCb7eI57jfND
         g6R9CYHhSGxlC9fpikNTyBOSsjudbj+2lP9Zz+5PwU/mW+4EOU8n7My9J5TyWQpACxUF
         3ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CIHVWePipLdm2ALzcl6uAJIBpCo2qCdCdlhZdu2r1rM=;
        b=OrTEAwTJtot0gU8Pbvd1/CbJjhm4dcoPapEgxWexQsee4v/EQe8yu+nuBEHYwLeXti
         RGx6IWt665614dSiEg+PZdtS4ZgxDGPTL2kY6Ud3qrDVo7SKzLwV9S5z/rgsRkD2lAD/
         4KyZstdrbVB8oqONOqCnEBOI/smHBzWrXTeKgcoDjBzy49R1Ywrnbsn3ryQOgk0NbGRT
         X2aFiTkHaD3vCCMtKW8PWphD0DdCF7vXaWwSeks9O3YVn9WS29PN8UK0lUeYsX8zVmGI
         hunbBo7UeSCnNcM5QSG5YeX/Qjty4E0TinbNFWHi+PsEHFUsww34rcdABt6Yrupuj7Zb
         3FZg==
X-Gm-Message-State: ALyK8tIdPrH5CCFifPaWkguuKn10buN5tTDwwdwhMsCYRlsPjpZbkLsxJ6ylrSFcJlW1KVYkoCZnStp+B3vOnw==
X-Received: by 10.202.222.5 with SMTP id v5mr1083953oig.104.1466587407770;
 Wed, 22 Jun 2016 02:23:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.48.35 with HTTP; Wed, 22 Jun 2016 02:23:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1606211555380.22630@virtualbox>
References: <cover.1466420060.git.johannes.schindelin@gmx.de>
 <cover.1466505222.git.johannes.schindelin@gmx.de> <CACRoPnRvp7oguE2w2mcsEZfaX_fni8UhFCdsGQ3ZaijQprSHog@mail.gmail.com>
 <alpine.DEB.2.20.1606211555380.22630@virtualbox>
From:	Paul Tan <pyokagan@gmail.com>
Date:	Wed, 22 Jun 2016 17:23:27 +0800
Message-ID: <CACRoPnTYjZzVe7iKTu_nzosbgm19fAq9csFiZs3rvEPqkAusPQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Let log-tree and friends respect diffopt's `file` field
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Johannes,

On Tue, Jun 21, 2016 at 10:12 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Paul,
>
> On Tue, 21 Jun 2016, Paul Tan wrote:
>
>> On Tue, Jun 21, 2016 at 6:34 PM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> > - this uncovered a problem with builtin am, where it asked the diff
>> >   machinery to close the file stream, but actually called the log_tree
>> >   machinery (which might mean that this patch series inadvertently fixes
>> >   a bug where `git am --rebasing` would write the commit message to
>> >   stdout instead of the `patch` file when erroring out)
>>
>> Please correct me if I'm wrong: looking at log-tree.c, the commit
>> message will not be printed when no_commit_id = 1, isn't it?
>> This is because we do not hit the code paths that write to stdout since
>> show_log() is not called.
>
> Why does builtin/am.c use log_tree_commit(), then? Why not simply run
> things through the diff machinery?

It's because git-am.sh called "git diff-tree", which in turn calls
log_tree_commit(), so to be safe I used the same function to ensure
that there were no unintended behavioral changes. e.g. what happened
with 3ecc704 (am --skip/--abort: merge HEAD/ORIG_HEAD tree into index,
2015-08-19)

Of course, it may be true that the diff machinery should be called
directly, although the code is quite involved so I can't really tell
the impact the change will have.

Thanks,
Paul
