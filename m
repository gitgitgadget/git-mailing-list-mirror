Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AECC2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 13:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DF122314
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 13:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF9P3R+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgATNs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:48:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45675 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgATNs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 08:48:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id j26so33874726ljc.12
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 05:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+RLfFKoh4LqEsgZK+OvTu6AZnIvXBamQMlIh7yfM3TI=;
        b=HF9P3R+Moi9gUZMiQNwUnyUH89i4TZhTdqxIepVY30SMekVLPdlxk64exGRQWpUmKa
         WxrPgMePm53ViIm+YRPENiPhyls1JuU7Nbs3+e2yY6qa4mNScc/5uN+h2/xRdSx9MSie
         KTrXlcWH3WAvZJIr/lozLptlHzlY001Cs7tGgyGTUMYtlagNTHucFdiuQuB0k60gWbPo
         PnLxN1mDrzWrb14T3YLE9QGtVe4W5duOdvtCJ+9oOfXtEBim+588TnEFxcU3FRBVr45v
         YGzRdGVUQQ3JILfU/iNFBDAB2tCXOxwtg3ahl/Esiio6El08QcF5Yp3yMUvRu4DKty+R
         mQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=+RLfFKoh4LqEsgZK+OvTu6AZnIvXBamQMlIh7yfM3TI=;
        b=SzDfb8jGBKDDQ67emSZfCxt6LthP1huXAJlYAfkPjzUQ+OF7lJ5ZHXGFymASZPFbGB
         TN6yW3MA71JcC9MhCgc0Jr9E4/1K2+8Y58eMlrAxJmmdiIH0QmMeU30H1pjIcdV8TjZM
         2e/ferdvabKuiJAmMwVy7WTfswQk9kcXqZHdNNncRpPuqfvO9d2GZvF1h0At+cPh/cqw
         kuCls/graP8v+otufyUbTybX5kBPjsVjYn82Ie6rtsA917KM4pOX8RSZNhpHUM5ndiZe
         lKLFXoT2yu7mDaDjq0WevN0yS6tgAJpIz/fvSVpq+EGVqXmdWUwxsx7zEx6+JXeKCCLy
         dW5g==
X-Gm-Message-State: APjAAAXL11SpO0fvfYIr+Salhf/ZJ3tgbgicC2VCWTLR5rVSvV2TyCri
        ZJ31ou0c4YN5FiIiVO/qHe4=
X-Google-Smtp-Source: APXvYqwPymyNvISXJkVW1a2vE3ZM11dOKbiRk0v+IB6aestOlczI7r2VBAb0zjiOtQuXFZZMjZOieg==
X-Received: by 2002:a2e:97c1:: with SMTP id m1mr13662373ljj.270.1579528106012;
        Mon, 20 Jan 2020 05:48:26 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 ([158.75.2.130])
        by smtp.gmail.com with ESMTPSA id y1sm16739857ljm.12.2020.01.20.05.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jan 2020 05:48:25 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <86d0c44f5s.fsf@gmail.com>
        <3aaf02fe-ac83-5694-2c69-e133879a0030@gmail.com>
Date:   Mon, 20 Jan 2020 14:48:19 +0100
In-Reply-To: <3aaf02fe-ac83-5694-2c69-e133879a0030@gmail.com> (Garima Singh's
        message of "Mon, 13 Jan 2020 11:54:32 -0500")
Message-ID: <868sm2ck7w.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:
> On 12/31/2019 11:45 AM, Jakub Narebski wrote:
>> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>> Performance Gains: We tested the performance of 'git log -- <path>' on =
the git
>>> repo, the linux repo and some internal large repos, with a variety of p=
aths
>>> of varying depths.
>>>
>>> On the git and linux repos: We observed a 2x to 5x speed up.
>>>
>>> On a large internal repo with files seated 6-10 levels deep in the tree=
: We
>>> observed 10x to 20x speed ups, with some paths going up to 28 times fas=
ter.
>>=20
>> Could you provide some more statistics about this internal repository,
>> such as number of files, number of commits, perhaps also number of all
>> objects?  Thanks in advance.
>>=20
>> I wonder why such large difference in performance 2-5x vs 10-20x.  Is it
>> about the depth of the file hierarchy?  How would the numbers look for
>> files seated closer to the root in the same large repository, like 3-5
>> levels deep in the tree?
>
> The internal repository we saw these massive gains on has:
> - 413579 commits.=20
> - 183303 files distributed across 34482 folders
> The size on disk is about 17 GiB.=20

Thank you for the data.  Such information would be important
consideration to help to find out whether enabling Bloom filters in
given repository would be worth it.

> And yes, the difference is performance gains is mostly because of how=20
> deep the files were in the hierarchy.

Right, this is understandable.  If files are diep in hierarchy, then we
have to unpack more tree objects to find out if the file was changed in
a given commit (provided that finding differences do not terminate early
thanks to hierarchical structure of tree objects).

>                                      How often a file has been touched
> also makes a difference. The performance gains are less dramatic if the=20
> file has a very sparse history even if it is a deep file.

This looks a bit strange (or maybe I don't understand something).

Bloom filter can answer "no" and "maybe" to subset inclusion query.
This means that if file was *not* changed, with great probability the
answer from Bloom filter would be "no", and we would skip diff-ing
trees (which may terminate early, though).

On the other hand if file was changed by the commit, and the answer from
a Bloom filter is "maybe", then we have to perform diffing to make sure.

>
> The numbers from the git and linux repos for instance, are for files=20
> closer to the root, hence 2x to 5x.=20

That is quite nice speedup, anyway (git repository cannot be even
considered large; medium -- maybe).


P.S. I wonder if it would be worth to create some synthetical repository
to test performance gains of Bloom filters, perhaps in t/perf...

Best,
--=20
Jakub Nar=C4=99bski
