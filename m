Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC7C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4108D600EF
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhHCWIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhHCWIK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 18:08:10 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F36C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 15:07:59 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c3so19303ilh.3
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IGeoBGD06f0lV1ge6PUPqTI6sFqUVN8txg9q8mB8QxA=;
        b=DRyQrp58WesDpikxTV++BTrIIFaqf97ywku3yy6cKRtCFRa/57/iUSeblQAej7j/1P
         jWweqox9lhDEi0BljbOZm/KEiBcrJU/abVGi54jWvGCDzKJB9We3IonNJfDobkjS/JhK
         Xrpa+p2Q+ctvAcLe/f/WQ6QfSsxsCsCtt4K/ZkzuSQe4siXsujxi+pmvVqAN5g5jiK5P
         zMcIkW567slVD90SG10AY+JC2AmQ5//wqrVg3kC03lKj2/DvURlKIiD41XiF7TpeHyL3
         /Zi9N7jVGmVsl8q+dEYRBMTZsEmjQZOU0K1bCsQ5NaVLeg5NFrjvoQQ0aL7H8UTg5vCz
         Da9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IGeoBGD06f0lV1ge6PUPqTI6sFqUVN8txg9q8mB8QxA=;
        b=PsidDOJ8ajB08yjwXBG7Vry0DnSytJg5/Le4vS7KS4xSBTrGJlbzf73hBfs2XTmphV
         d6GJn7CE3fMQEszbprIdcHwPBvQGwgVgYq3gaO2eOrBV9zx+Bwwfqkj6OQNKszjdRQ4y
         wkoGbjEWryLA4rHMiM3NN8w1k5nuz730HPfiXXBh8Mk0W5NmOaOfhAPQNSphnsrmgnq5
         HZOfwcdQUHmo+QzsN2dWJaYU5bdMrYu1UQyQpfQkS/5OYipY3ACEUzcKD1HcfJJ/BVLt
         puhV7fwN57bndsz8/o3bYKLpd5X627CMUYN4wBJyiGHE7j5INr0D8NnvD36syCCW9W0r
         vemQ==
X-Gm-Message-State: AOAM533Kmbbkb7X0i3npfb7yMJttF9Vk+uiW6xhdEdEty7gBiVEzN36W
        lI7eWk24pW8srbf67eWrMmUd5w==
X-Google-Smtp-Source: ABdhPJyYNl4NjWyBbVOrKIQU0mT3qm86fLF7UoUjK+eVRFZNYVgvGYXOyNvq66ArfoR2XH2dVinT+Q==
X-Received: by 2002:a92:d346:: with SMTP id a6mr503785ilh.249.1628028478417;
        Tue, 03 Aug 2021 15:07:58 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a92c:44a1:9adc:e4de])
        by smtp.gmail.com with ESMTPSA id q1sm237635ioi.42.2021.08.03.15.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 15:07:58 -0700 (PDT)
Date:   Tue, 3 Aug 2021 18:07:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Cameron Steffen <cam.steffen94@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: git revert --continue --no-verify
Message-ID: <YQm+PWAtc3rixqsw@nand.local>
References: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
 <YQmsJUe6hAMy/QGA@nand.local>
 <CAAVFnN=W27rdE1EH-joscyJEooAsDrdtPropVVaBYwhte=cPJA@mail.gmail.com>
 <YQmuT2ZYe1mzHBjI@nand.local>
 <CAAVFnNmitHeimogaGUUwWGWhve+wbF6CXcSNUonGCWAgOSKzjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAVFnNmitHeimogaGUUwWGWhve+wbF6CXcSNUonGCWAgOSKzjA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 04:33:09PM -0500, Cameron Steffen wrote:
> Perhaps the issue then is that the pre-commit hook should not run for
> `git revert --continue`? It does not run for `git revert`.

This does look like an oversight to me, but you'll have to bear with me
since I am relatively unfamiliar with the sequencer code.

Ultimately `git revert` calls do_pick_commit() which either calls
do_commit() or run_git_commit(). A couple of curiosities there:

  - do_commit() does fall back to run_git_commit() if it has the
    VERIFY_MSG bit set in `flags`.
  - run_git_commit() passes `-n` only when VERIFY_MSG *isn't* set, so
    the VERIFY_MSG bit does imply that the pre-commit hook would be run
    there.
  - when do_pick_commit() does have to fall back to run_git_commit(), it
    sets the VERIFY_MSG bit in flags.

But we never end up calling run_git_commit() (except in the case of
errors) because do_pick_commit() special-cases `command == TODO_REVERT`
(which is the case for `git revert`) and calls `do_commit()`.

But it gets weirder: do_commit() calls run_git_commit() itself, but
before the caller in do_pick_commit() has had a chance to add VERIFY_MSG
to the flags.

So I suspect that this is an oversight, but perhaps somebody more
familiar with this code could confirm my thinking.

Thanks,
Taylor
