Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F728C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 18:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjC3SXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjC3SXo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 14:23:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B5D5FEB
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:23:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5417f156cb9so197151867b3.8
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680200623;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/xRrajGpNkA2EcVlcZeQoH7yJqIq4LsASpWqpVPEg0=;
        b=tV6CDKLGX1dK0lWzKIVc1ZIBqcYXaGUg8iP9Kcbawj8YF09HFswHZjsPHlD24TMqnU
         JCwZ8drFTD9rH3P3Bw2rkMa0QufMHHY8F8NYUulnY16dc8eOYfU0uC1JTAgMDJlmCaWx
         szCcuAn9EaTQgWWY/WWd0Y7mQSQUCPYgqAJegqGo2wKS+kKOMUuAhVCIoZnkultJd6+v
         zOVpUgnsz9vXT0V5mHfQnRNwXCw85yIcCfQA8bJHONkGIB+nEq1QUXMGZRG6BnSRxzp4
         rO4N0SVuLmHoRPBSpA1ZFHxWVUiUrPQJxoAmRHowFqM0WOv52SfmHHWpGwEMK3QI9dWZ
         Q1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200623;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/xRrajGpNkA2EcVlcZeQoH7yJqIq4LsASpWqpVPEg0=;
        b=0FbeUyloDAQMax3ejv5A0cdKeuSQbeRAGQ/B+Ha83u8q/IDKe706HrA9xaAVvDxoa3
         5mTmKZnVTJ3qfSS22gGXqxuvJfN8+gQM7NalSn6UhsjqLngl4cEHLVUPm1wz38pj1HiL
         vy3sRVSeQUISB4m1+2J5mZIvupSp3WMas929wNWTQe83MKslN/tu839lAJMWSvEIphkA
         lU9+r2fVbNhiFsPhOFMuU6KhMJIdVFd/73Jck4zf0u3QJ5pdWTknKIBFldPXQ8hrA3ad
         QfY/s4bFE/c1JSeWyJZJGAQCrjdGeXPkif2dlwucm301HI51m80tov8PlZ/7AvZ08aHu
         lX1w==
X-Gm-Message-State: AAQBX9cal1DUGnW40VC2zL21Gu6wH5SIU8AFLpxzDERIO4XyArD75mQ4
        cIf+dkEIxRlzMZUMSV4WoElyS37TGT5zbwYiZf00R+nelPeNKp77TfO/RDpTecifrLSa5DWYND3
        AZNjFqR2pypmP6CiVqQJVA+7RVmx4tZc1EdwWpwWObDI8gWIFbtrIIEhfA0KQRZQ=
X-Google-Smtp-Source: AKy350bS6jqTfIbvXn+w6q5VL0E3wSDuLxWK0agB85otfAuu4L2+J9S3Y6gM7p/0ehvVRlU8mjpMzxDzN0w67A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:1009:b0:b6b:e967:920d with SMTP
 id w9-20020a056902100900b00b6be967920dmr13316427ybt.13.1680200622904; Thu, 30
 Mar 2023 11:23:42 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:23:40 -0700
Mime-Version: 1.0
Message-ID: <kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: How do we review changes made with coccinelle?
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C3=86var recently sent a series that made pretty extensive use of coccinel=
le
to remove a lot of the_repository [1], but then we ended up in this
weird spot where even though several reviewers thought the code changes
looked good, we weren't sure about giving Reviewed-By because we didn't
know coccinelle or how to review it.

I'm pretty sure that the series could have been merged without a hitch
if reviewers knew what to do about coccinelle. I expect more of these to
appear as a result of the libification work, so it's probably a good
time for us to figure out some norms about coccinelle :)

Perhaps we could start the discussion by sharing thoughts on the
following questions, which I'll summarize in a change to
contrib/coccinelle/README (where we can do final bikeshedding):

- Is it okay to give Reviewed-By on the basis of _just_ the in-tree
  changes and ignore the .cocci patch?

  - If not, what should reviewers look for in .cocci? Do we have a
    style?

- When do we introduce .pending.cocci vs .cocci?

- What do we do with .cocci after they've been applied?

- Do we care about new patches slowing down coccicheck?

Relevant threads
- How to learn cocci: https://lore.kernel.org/git/230326.86edpcw0yh.gmgdl@e=
vledraar.gmail.com/=20
- https://lore.kernel.org/git/230328.86a5zxw31u.gmgdl@evledraar.gmail.com/
- https://lore.kernel.org/git/230326.86ileow1fu.gmgdl@evledraar.gmail.com/

[1] https://lore.kernel.org/git/cover-v2-00.17-00000000000-20230328T110946Z=
-avarab@gmail.com/
