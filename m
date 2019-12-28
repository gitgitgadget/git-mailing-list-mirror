Return-Path: <SRS0=w8S9=2S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D5C2D0C6
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 13:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF20620748
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 13:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPa5D822"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfL1NU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Dec 2019 08:20:27 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:35703 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfL1NU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Dec 2019 08:20:26 -0500
Received: by mail-pl1-f169.google.com with SMTP id g6so12839842plt.2
        for <git@vger.kernel.org>; Sat, 28 Dec 2019 05:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EtTFtCse1vXWfVuH1mUzp37ClK8sFPqCqLt7c+1OprE=;
        b=fPa5D822Y8v3qE6sVctdvbU68a7n7HAaeze35U+q02YegzwF9vM8KDPsAfrTvLwmxu
         mj6VeG3gmgr59PA1TT45SQUjUh+WZEMG1BH3SJptsOCO2O82jP4Wxbt/1qTEnEhthcO/
         70KvPBfuTXsSgZ+Oou/Aa8W25FEHRJhW3inbn4OmMxKAHdnlxhcb4P3ZGrxeLfD5l/Ls
         MoqcwZJeb4O2sGq2bi8372zR/1nACxh+BOGOGvovPU5olHTdNZDsoNASNI+uWFLk9al2
         S9+cPLtjjIIAFgIxjHieK7vQtExENvmV/u2znqpWp7fhvLiiBgm5T4mD5dnwo1b0q9Sh
         EPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EtTFtCse1vXWfVuH1mUzp37ClK8sFPqCqLt7c+1OprE=;
        b=XOYQafeq3dDgB/Uq9KZtxPiaZra+XuXHwMoCwMNqBeEQ8P3WPXTlPTYQ21a8qog95q
         mYaPfGyVlEHELmOo8XUf0iAC4a0rUTv4eIcg2uHNPAIjzddWJaOdS1WBXJabhdoKnm3+
         HAVMyzA9AoxMzk8P/1O6OkZVrA9ziAI+r/m1Drkr3jitqBaGdJJNdugdUGEoFIjTx4H4
         OaoGr7ckjKeh4XfRQrMl7JV2abqmOn1fzAyKQq945LbXMu3ywak3ZvtpUIAQpNeuKc7A
         dkJyWKisjawktlZzZp0c4yPl97YRx76+s7SqOKcjTsKoRSgwV33LOC0Yh87U33kZaFS2
         wPkQ==
X-Gm-Message-State: APjAAAUEIZXRrLS00gJenEIF1KQ06BCvZ1TphC8CpRq6bp2pDuGYKaeq
        Ozz7E5B7WI2LDG4deJJKzPc=
X-Google-Smtp-Source: APXvYqyFpcOo3rYFli1Ex4gYFtLIlo4ndMrIQ5Sykhfe4VhXn2WHwzPluTffLiCc65peg9qCC3yh1w==
X-Received: by 2002:a17:902:fe0e:: with SMTP id g14mr22305049plj.58.1577539226168;
        Sat, 28 Dec 2019 05:20:26 -0800 (PST)
Received: from localhost ([2402:800:6374:a714:860b:62b8:d6c5:f06c])
        by smtp.gmail.com with ESMTPSA id z19sm41955991pfn.49.2019.12.28.05.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 05:20:25 -0800 (PST)
Date:   Sat, 28 Dec 2019 20:20:22 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Gal Paikin <paiking@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Updating the commit message for reverts
Message-ID: <20191228132022.GD24268@danh.dev>
References: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
 <xmqq7e2l5ych.fsf@gitster-ct.c.googlers.com>
 <CAEsQYpMJGbw3L66vCd25Ht0bTBzvvt1yMRd2U3=u3U-BZukyzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEsQYpMJGbw3L66vCd25Ht0bTBzvvt1yMRd2U3=u3U-BZukyzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-12-27 11:13:47+0100, Gal Paikin <paiking@google.com> wrote:
> Hi,
> Thanks for the reply!
> 
> So the idea of changing from "Revert Revert" to "Reland", "reapply"
> has a big problem: sometimes Revert^2 actually means 'reverting
> "Revert"' since "Revert" introduced a bug that wasn't in the original
> change.
> 
> So to your question, I don't know what Revert^47 means since it
> depends on each individual case. Sometimes it actually means "Revert"
> and sometimes it means "Reland".
> 
> So do people actually use it? Yes! Many users reported to me that it
> is not that unusual to get to "Revert^6", and it is very usual and

I've seen Revert x6 in a code base, I couldn't get to know the reason
for that reversion war. I think it could be seen more in some in-house
web development that uses trunk-based development, code is being
tested with CI/CD, lightly tested, squash-merged to master,
then run into problem in staging (or worst, production, because not
enough traffix was generated for testing environment).

> common to get to "Revert^2/3/4". It is also useful for the users to
> know the number of the revert, according to the reports. Here is an
> example:
> https://android-review.googlesource.com/c/platform/art/+/352330
> Feel free to also search for "Revert^2/3/4" to find many results.
> 
> Anyway, I am certain that "Revert^3" is better than "Revert revert
> revert". There is definitely no clear way to solve this issue, but
> perhaps "nth revert" would be a more "human language" solution?

In my very personal opinion, "nth revert" is a poor choice.
At a first glance, I would take it as:

	This is the "nth revert", after applying this patch n times.

-- 
Danh
