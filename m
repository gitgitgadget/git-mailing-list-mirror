Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59309C04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 12:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB302073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 12:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4ukRGUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLIMWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:22:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37764 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfLIMWu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 07:22:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so16027029wru.4
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 04:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8/pT8u06Rqsw+Y6fqJZUyhZvy3NRrqJZSCVdSFNhmBM=;
        b=h4ukRGUiYl2PoBFqZXCFxzDr8De0LA2ucFvzRKJ7aVCm6zHJnprMNmlO2wrvmAd3FW
         6w41L/pBGwCMw8yZv4BknltDuEa48r6ucPak+AlPoa0xn942gqCAIWt9W8iYho4ZJUfb
         L8uxsux8DpDkzQC5v4/izaM+aZ7us+ivlMjIBzgB2kO1AH3BNWsSJfiEciMexy/p7nQE
         Rfq/dKM5jGqyTMrO70NZ4hUZ7MJJZhJD0QTl3tws3dq97zI0yct6/v3Zb/BIXnbMTXVS
         iXV1n/j950FcWIlmBtg+6gvR2qYErr1stM5gW2B+I/CmULSLj2YnLWirhf1RlHOPYfeY
         r81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8/pT8u06Rqsw+Y6fqJZUyhZvy3NRrqJZSCVdSFNhmBM=;
        b=IsywH7s+hsTxvMx12CjpR8cSdDICW26dG3RvXYQB7MR32HC0rsF5QEEmQNlwSuzrXa
         kZP6vWms5kOQOPMQHmdgqRylPFEvIpg9SrLppCh78qmbWPtIYqeMU5uP2brYg9uVdqJU
         YlD/gwRXoa4VqaGv3IhW8JlDdCDg6cwuXQ8bNEQsgHkhIB/pHqI8a0S97Yrfiu0z/3+t
         Ft9Rgxhv6OsU3BKucpCQkotbLgfyTp92cJNCOtOe/+rpH7h3h5fnoXLrv+oKhit6HBf0
         QZXhiTf/B4frLY6c+KN/AnwVOhC8R2KEmBl4udxzi/+NvEW53HXqTmb5U833u0jj/JMJ
         Y1xg==
X-Gm-Message-State: APjAAAUuTqhvGVehfNmt8PFOz/1KnazLezm9J+13/gkrjmaBETCbYH++
        /a85jfJIQRN1ziDggMGLKyo=
X-Google-Smtp-Source: APXvYqwtFC1RUALKscwseI6xu47lDzqKKzcPJlmKpQd/UTuIXNeINjzE5A4WtucEgslcl5zQmVvACg==
X-Received: by 2002:a05:6000:1248:: with SMTP id j8mr1860988wrx.44.1575894169154;
        Mon, 09 Dec 2019 04:22:49 -0800 (PST)
Received: from szeder.dev (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id c1sm26941710wrs.24.2019.12.09.04.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 04:22:48 -0800 (PST)
Date:   Mon, 9 Dec 2019 13:22:46 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, stolee@gmail.com, l.s.r@web.de,
        git@vger.kernel.org
Subject: Re: [PATCH v2 12/13] name-rev: eliminate recursion in name_rev()
Message-ID: <20191209122246.GB2746@szeder.dev>
References: <20191112103821.30265-13-szeder.dev@gmail.com>
 <20191127175751.165445-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127175751.165445-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 09:57:51AM -0800, Jonathan Tan wrote:
> > Note that this slightly changes the order of lines in the output of
> > 'git name-rev --all', usually swapping two lines every 35 lines in
> > git.git or every 150 lines in linux.git.  This shouldn't matter in
> > practice, because the output has always been unordered anyway.
> 
> I didn't verify that the changing of order is fine, but other than that,
> this patch looks great.

FWIW, the sorted output is the same (well, it would clearly be a bug
if it wasn't):

  $ .../v2.24.0/bin/git name-rev --all |sort >orig.sorted
  $ git name-rev --all |sort >new.sorted
  $ diff -u orig.sorted new.sorted 
  $ echo $?
  0

I still don't understand where that slight change in the order of
lines comes from, though I didn't really tried to understand it, to be
honest...

> > This patch is best viewed with '--ignore-all-space'.
> 
> Thanks for the tip! I ended up unindenting the loop to see the changes
> better, but I should have done this instead.

At one point I was considering an additional noop preparatory commit
that would have added one more indentation level to name_rev()'s for
loop.  That patch would have an empty diff with '--ignore-all-spaces',
of course, and the diff of the patch eliminating the recursion would
look sensible by default.
Would that have been worth it?  Dunno.

> > -static void name_rev(struct commit *commit,
> > +static void name_rev(struct commit *start_commit,
> >  		const char *tip_name, timestamp_t taggerdate,
> >  		int from_tag)
> 
> There are many changes from tip_name to name->tip_name in this function
> that mean that tip_name is no longer used within this function. Should
> this cleanup have been done in one of the earlier patches?

I've added a new patch to do that.

> Apart from that, overall, this patch looks like a straightforward good
> change. When we have a parent, instead of immediately calling name_rev()
> recursively, we first add it to an array, and then (in reverse order)
> add it to a priority queue which is actually used as a LIFO stack.

Yeah, 'commit->parents' is a single linked list, so we can't iterate
over it backwards, hence that interim array.

