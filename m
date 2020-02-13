Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73002C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABAB206DB
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BCpBfPO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgBMR44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:56:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34050 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMR44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 12:56:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so3454255pfc.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 09:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xoKGa1iOitLiV95rUyYkYunlkOK/ce8Xt4zwMPE7XjQ=;
        b=BCpBfPO5koiVevEHq2ARrT5kTECfb9n7Qgj9UW4aNnhXV1ChKVedc5HduCmdDRlJK+
         HRsG3KTRHbqKlWarhIVTVXPrzbaybkrrISES3XlLSWVA+B+YBA6PMLNEIvST3HsadOlh
         UrXNUniZZi+9APJ3wr82D9GZky1FSbLbPYa5W1aVsAL8phFI82R5KNXbwkrMuwv53zZJ
         Zl7JsT0UeCrrQJLR+nSCg/tWhbmZRiuL7mI7fURCqN1TAhKlFh5OwBjpo9jzUXPBBFlv
         efa2Pl9Gs1fRyfdmLXcsQnLPAXHb3CDjm819mzRb8LgouP8RmIWGO1hwtVMg5TMVJeSc
         z1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xoKGa1iOitLiV95rUyYkYunlkOK/ce8Xt4zwMPE7XjQ=;
        b=NSLN1e3nJyJaIS4Z+Fm6uidDGN8ktIurJ82wLdO+ynNh5liR5b36XQBJcA8MnoMiHL
         6bHl3N+YCMzek34jIKw2p9okCBNfiOpSi0d91Ht0sCu6Vcd/9pLw7VHngX3OCmZwMIVA
         XqBxuh7SVlPikEaaSwzolMIrAYGXsPWffR30za++q01t5KVHOQN2KcQmVPoC+lcOxRNM
         DmnNWxywmqeXbU+cI7AZA9/WcRVC9fxZibbaEHONFH7YWBp9scUADJrD+adYoAYJw2N1
         +TSa/Z4XEJo4d6zljOtstnIgNt44kqh0tc5VO2u/dX9/V3oWATlETcsjeRUJaMBW3kjn
         d0uw==
X-Gm-Message-State: APjAAAXRddOfn7//RxqhBCVXnPuNLP1iy0d4QA6IAbw+WMOAkV72mJMF
        kfJBgFqr9Mnem3LR3aGqnCWxgg==
X-Google-Smtp-Source: APXvYqzOOphgdyP6C7ANSsmLy7pnO0lt8KpQNfAc51NgWPgRmnE9UqvDKWRvKd+mciBEXgbdzPp7jA==
X-Received: by 2002:a63:31d4:: with SMTP id x203mr18472009pgx.229.1581616615554;
        Thu, 13 Feb 2020 09:56:55 -0800 (PST)
Received: from localhost ([205.175.106.72])
        by smtp.gmail.com with ESMTPSA id c10sm3846120pgj.49.2020.02.13.09.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:56:55 -0800 (PST)
Date:   Thu, 13 Feb 2020 09:56:54 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 3/3] builtin/commit-graph.c: support '--input=none'
Message-ID: <20200213175654.GD45518@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1581486293.git.me@ttaylorr.com>
 <4e85c6f7e40e7d6a8d93574645d65971b7cfa4f8.1581486293.git.me@ttaylorr.com>
 <20200213123129.GQ10482@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213123129.GQ10482@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 01:31:29PM +0100, SZEDER Gábor wrote:
> On Tue, Feb 11, 2020 at 09:47:57PM -0800, Taylor Blau wrote:
> > In the previous commit, we introduced '--split=<no-merge|merge-all>',
> > and alluded to the fact that '--split=merge-all' would be useful for
> > callers who wish to always trigger a merge of an incremental chain.
> >
> > There is a problem with the above approach, which is that there is no
> > way to specify to the commit-graph builtin that a caller only wants to
> > include commits already in the graph.
>
> I'd like clarification on a detail here.  Is it only about not adding
> any new commits, or about keeping all existing commits as well?  IOW,
> do you want to:
>
>   - include only commits already existing in the commit-graph, without
>     adding any new commits, but remove any commits that do not exist
>     in the object database anymore.

This one, since the commit-graph machinery will drop any commits (no
matter what input/source/mode you specify) that no longer exist in the
object store.

> or:
>
>   - include _all_ commits already existing in the commit-graph, even
>     those that don't exist anymore in the object database, without
>     adding any new commits.

Thanks,
Taylor
