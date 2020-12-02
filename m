Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A047EC64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 15:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D750221FC
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 15:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgLBP5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 10:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgLBP5S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 10:57:18 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05996C0613D4
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 07:56:38 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j12so2043346ota.7
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 07:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iDlYeBsyV7rD9dfuLxvlIBRB6YNZPP94k/v9TuAX/8A=;
        b=IyuWZh+14ih2beFcyGb4HgqU14xrjiGseSyM/dCBHvGRhf1dtcKah/KpErmBEN4jst
         Xmg1tnXIRj5byUQPC1sdRITdEjPcQ5OGd73XNMjGI/N1AEzkmBW6nT2GkbY4DKOj2nVp
         7hSfBa1orq0jE1QJJexCpoNYO43dZAlyL2Qw3U4BSeEV1pOWjAMnS9XhcWDMcu5cFj/g
         oZ3ncQCxPo9xjl0owtPG8RxrFJGm/QKObVA662tB7v87JSE/UKDgrt7EriREnFWu3g8P
         baPEGRH1IKjA+J5ocnATtC7sGq2JCeFRVDyUS9XTDWMdSjcrken+SyeF65YxNoP/pyRp
         qixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iDlYeBsyV7rD9dfuLxvlIBRB6YNZPP94k/v9TuAX/8A=;
        b=i2gfo/MGwoToYmT3V4LX1niNfUbDtE21tsI/enwyis9jEKYsUBYirNSwEo1kYkxYpj
         OFMncMD+9Cxmu0Vu5njpg2FyB7CdYQpp6F/l7KuVbFt4wf+B8qbuzq9bZG+7x7yTpTLi
         OG7bwhEjoCu1k38jn8Dj4ii+YYkNAQ2uLO2pvwS21psOf9XsEYryX9cUwvzErrHdI1/3
         WXrAVaRkVKTTtKTumrwTCHJ7FwGyAU3YkR8ZNlWGXSGqCWtwqf7NaKiAagtbnM6C0QTa
         AV/8gcz0PBYxXa5XDNvvdfTF/4lKNiWy371n+P6ZyXIzhff6Ziv+rbHamzgb2xAe5otE
         YVeA==
X-Gm-Message-State: AOAM531qOzWt8Unk2Rbo3/hoPBCX0oZwX6jZB8OxgcweK9Pl1gQWCu0U
        DkmhmsGkO3xvTATOVBdZz+PWP50WhsphG8l41g9MSg/KIEk=
X-Google-Smtp-Source: ABdhPJxRl8lLIl9HMdBbeKDmB7X/u1BDoUnXfY6RBAbc98xfs2w6pIUKaoMmDQKxeQQwu15rZ3fRlaMOkuVHoF70sU8=
X-Received: by 2002:a9d:3a76:: with SMTP id j109mr2318622otc.186.1606924597164;
 Wed, 02 Dec 2020 07:56:37 -0800 (PST)
MIME-Version: 1.0
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Wed, 2 Dec 2020 16:56:01 +0100
Message-ID: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
Subject: BUG in fetching non-checked out submodule
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, peter.kaestle@nokia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have the current 'master' branch of git installed and get
the following error when fetching a submodule that is not
checked out.

I've bisected this error down to commit
1b7ac4e6d4 (submodules: fix of regression on fetching of
non-init subsub-repo, 2020-11-12)

$ git version
git version 2.29.2.435.g72ffeb997e

$ git config --get submodule.recurse
true

$ git submodule status
-855827c583bc30645ba427885caa40c5b81764d2 sha1collisiondetection

$ git fetch
Fetching submodule sha1collisiondetection
Fetching submodule sha1collisiondetection/sha1collisiondetection
Fetching submodule
sha1collisiondetection/sha1collisiondetection/sha1collisiondetection
Fetching submodule
sha1collisiondetection/sha1collisiondetection/sha1collisiondetection/sha1collisiondetection
...

$ git submodule update --checkout
Submodule path 'sha1collisiondetection': checked out
'855827c583bc30645ba427885caa40c5b81764d2'

$ git fetch
Fetching submodule sha1collisiondetection
$

Ralf
