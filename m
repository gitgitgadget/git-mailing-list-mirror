Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC7C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 00:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiBQAGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 19:06:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBQAGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 19:06:10 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C36B29C111
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 16:05:57 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t68-20020a635f47000000b003732348b971so1987683pgb.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 16:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=U0V0cDnIxhbdO1rp12fG31HZiDcYE7Qk8xdfVZA7H54=;
        b=bDwK2cy3N2zuoXzUEt6RciqPCu/hC6J00ZaDgh7KedUM8K9Xn7xbeBj/WIDF5SyrsU
         DVfY0mTJTHEHP4ngB4BBDe/z3ckW9IpUx7EJ76e/Pf5hoMwNMT9hoAu41P3RBZ1quoqI
         zAQw+MKey4KQmnxYE9BtUevUzlnGXnmZqD4k612a7aYDsQz7A7hKEQ+uhVhFp9gVToUQ
         DZbiuRj6+9/88BdezkOCteSE69c/5896A7GZq4/dNbYAXmjs+oNhzYF3OKXUPDZFUTVy
         HWAi+MelNaf5MHZ9ldfQARnuCcPXsMPKNdzlLEYLuj/xlNUUY6f55Q1/+97BpEdz0XIq
         4BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=U0V0cDnIxhbdO1rp12fG31HZiDcYE7Qk8xdfVZA7H54=;
        b=Pr/VYDTS4GuGSC2rQNTNYuKDE6LuCS6M42nZZ9czoUv2nIWBu/iPiWR5JwKRm17nUk
         3zFs8fsf28ZXYImpTOwer7sDpLSikgruESgqQs02kPqmLTX5N5b+7khepduAKXwHeJ6b
         nPfjEUvdkPWJcdcCSY2TGlVcR8IN8QfftrHg5uwjM1mrbZnfdsY85E6DxyIeBWmQmrW7
         dwcMVYYiU6x/Ob0Ho58DeTJ7RIoTn7KvfYoPbkTQBcWIptJ4ZN0XD3IMCFk7IPxdDLpV
         FrftPi0V200tJzvYsMiG/dWGrDA8CGRCjT59vwH4zbVs4d1OUfYBHJTzlZT72x89ukKb
         RTnA==
X-Gm-Message-State: AOAM532WLzbHe6sUdVrwDglIx54B9EwOAebrviCrqteR7BBl3wOcWQ4c
        2HzEG46JZhOBR09jWfVXn/9B4Eos/HXEOJNS896x
X-Google-Smtp-Source: ABdhPJzxKWiVf5tRAX27Rw7MSjtpCUHUFtUJEruhl3yK2F+Bs1CkdBeHEQQyqCJjO78g22agjqSbQ7wHSc0fdVzLOj/f
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1744:b0:4c4:4bd:dc17 with
 SMTP id j4-20020a056a00174400b004c404bddc17mr279526pfc.57.1645056357079; Wed,
 16 Feb 2022 16:05:57 -0800 (PST)
Date:   Wed, 16 Feb 2022 16:05:54 -0800
In-Reply-To: <CACf-nVePhtm_HAzAKzcap0E8kiyyEJPY_+N+bbPcYPVUkjweFg@mail.gmail.com>
Message-Id: <20220217000554.1978909-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH 2/6] fetch-pack: add partial clone refiltering
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Robert Coup <robert@coup.net.nz>
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, stolee@gmail.com, me@ttaylorr.com,
        christian.couder@gmail.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Coup <robert@coup.net.nz> writes:
> On Fri, 4 Feb 2022 at 18:02, Jonathan Tan <jonathantanmy@google.com> wrot=
e:
> >
> > The approach that I would have expected is to not call
> > mark_complete_and_common_ref(), filter_refs(), everything_local(), and
> > find_common(), but your approach here is to ensure that
> > mark_complete_and_common_ref() and find_common() do not do anything.
>=20
> v0: find_common() definitely still does something: during refiltering it =
skips
> checking the local object db, but it's still responsible for sending
> the "wants".
>=20
> filter_refs() is necessary under v0 & v2 so the remote refs all get marke=
d as
> matched, otherwise we end up erroring after the transfer with
> "error: no such remote ref refs/heads/main" etc.
>=20
> > Comparing the two approaches, the advantage of yours is that we only
> > need to make the change once to support both protocol v0 and v2
> > (although the change looks more substantial than just skipping function
> > calls), but it makes the code more difficult to read in that we now hav=
e
> > function calls that do nothing. What do you think about my approach?
>=20
> My original approach was to leave the negotiator in place, and just condi=
tional
> around it in do_fetch_pack_v2 =E2=80=94 this worked ok for protocol v2 bu=
t the v0
> implementation didn't work. After that I switched to forcing noop in [1/6=
]
> which made both implementations match (& tidier imo).
>=20
> To make the test pass and skip those calls I need a patch like the below
> =E2=80=94 filter_refs() is still required during refiltering for the ref-=
matching. To me
> this looks more complicated, but I'm happy to defer to your thinking.
>=20
> Thanks,
>=20
> Rob :)

Thanks for investigating this; looks like I was perhaps too optimistic
in thinking that the code could be reorganized in the way I'm
suggesting.

I think that it's worth checking if we could refactor the parts that are
needed with --refilter out of filter_refs() and find_common() (and in
doing so, make these functions do only what their names imply). I
don't have time to do so right now, but I don't want to unnecessarily
block this patch set either, so I'll say that ideally another reviewer
(or you) would do that investigation, but I have no objection to merging
this patch set in this state (other than the change of the argument
name, perhaps to "--repair", and associated documentation).
