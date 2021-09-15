Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2983CC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABF36124D
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhIORGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhIORGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 13:06:32 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298CC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 10:05:13 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso4400588otr.13
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=l9/+SCX+6q1lNByX3kw/7teR6fWmRDX5ozThgOwKv7E=;
        b=Zn5JXMz5aD6zQnMQW1Xq9kxUpJ4QlydgYmA5mo07J823OnPeiF86+MHYIVtRAUDR+A
         rS3r9KQ+6cqEgzr0/eNRmQvd5anWOQAPUFRqvLBTkCFRGCnESUdlXT/5+WThYay3HquF
         1eCM29Rprsfw9zecYWa5C9leEM5l8k8QINtlf2cQGdn9N4PptoIdqPww70e7RWUfvDiD
         J2xWocMoSsNXZ4aAOm9I1zXoOY+nNTkh2PK6KTN+T7UHwVc0fUuwhEBEBatN0/bfLONY
         OtnzjHUSPUJMhyyihXvMyaQrix8GrkqlzDSDhC81hXRQ9NSMEEh6DqlYpmeo91UAODlM
         1jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=l9/+SCX+6q1lNByX3kw/7teR6fWmRDX5ozThgOwKv7E=;
        b=mwWYmn6Xpxv11u15Z8U+RnvIkzJBryz94zxn5UJZChcsNt0IRMT6h3tkbm1lwJtt6K
         XiDnpJ1tAZIC2gtZ18+Kv5fvjEHv0w2ydM9kE6EUZ3aDP0D5L+aHVOtuOhws3jcfLgWJ
         Jvo0aAP4D84WtpE8A6TL8x2tPcnop50HkwsnMZPJ1CN9OoKfl1BSCOaZE4oUYVf8CWo4
         iWztCG6jcnkmmExUoVJRK5vbEfMEarwLslQT7QSnQNnGRMYcII5thKoj8JeHpcqxKwEw
         kiXR5psVyOPS4CZpmbyxaOQvuCxp3NxmM5YmWie7O9UfuxDhdnI+Qv6EIPsAB319p9rD
         wLQw==
X-Gm-Message-State: AOAM530x62y2tPVJ5AFcQqpm24lexanCqULw2z9BkBqDHtoWls+0XSJu
        fqcC3YTjWcf9JV4dBg9M1cK+bSDwjz8=
X-Google-Smtp-Source: ABdhPJwgcHaQcNGtg7mMIGYa/G6ZHns2eAhfa09yml2nXNwVWOr6Gnm/eQNh/+cnRsCrMhd2xvkivg==
X-Received: by 2002:a9d:4785:: with SMTP id b5mr907293otf.188.1631725512330;
        Wed, 15 Sep 2021 10:05:12 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:4881:cd0:6961:cea7:fb59:3ccd])
        by smtp.gmail.com with ESMTPSA id d10sm143528ooj.24.2021.09.15.10.05.11
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Sep 2021 10:05:11 -0700 (PDT)
From:   Stephen Holland <kd4ttc@gmail.com>
X-Google-Original-From: Stephen Holland <sholland@me.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Suggestion for addition to error message upon push to a checked out
 repository
Message-Id: <3A78A2D9-1926-44F0-AC27-3A94FA717CAB@me.com>
Date:   Wed, 15 Sep 2021 12:05:09 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You guys are nice. I=E2=80=99m new to git, just getting a modest =
personal project big enough to need version control, and a dabbler in =
Django (which moved to git from Mercurial), so I=E2=80=99m getting into =
git. The reason I say you=E2=80=99re nice is that on using git I find a =
number of very helpful comments appearing in my terminal that give rich =
error messages, instructions and hints on how to proceed.=20

In developing my workflow where I can update a server either directly or =
remotely I came upon the "refusing to update checked out branch: =
refs/heads/master=E2=80=9D error when trying to push changes to the =
server from remote. Googling shows this error gets asked about a lot. A =
beginner like me didn't understand that theoretically, since git =
maintains a graph of changes in the .git directory which could be =
checked out by anyone, pushes to the .git directory would causes =
problems down the line if different people could do updates and then try =
to push them back. (I=E2=80=99m learning, and seeing that git is based =
on a sound design managed by experienced people). I now see I could have =
modified a new branch, pushed that, then gone back to the server and =
merged, but there is another option perfect for my workflow: using the =
command "git config receive.denyCurrentBranch updateInstead=E2=80=9D on =
the server.=20

The updateInstead is documented in=20
=
https://git-scm.com/docs/git-config#Documentation/git-config.txt-receivede=
nyCurrentBranch
which summarizes this nicely.

My suggestion is that the updateInstead option should be mentioned in =
the error text that is issued by git after a push that modifies the =
checked out branch.

For my part, I am a beginner who is living the experience of learning =
git for the first time. One thing that is missing in the documentation =
for a beginner is a short introduction to the overall organization of =
git, what it means for a repository to have been checked out vs bare, =
and how git works from a hidden directory. I=E2=80=99m willing to =
contribute such a modest intro, aimed at the beginner to git.=20

Should I get into git development to propose this?  Has this been gone =
over before? What is the process by which suggestions are considered?

My first post, please be gentle.

Stephen Holland, MD
KD4TTC=
