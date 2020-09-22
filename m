Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9642BC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AE3221EF
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzXwLtwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgIVXJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 19:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXJl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 19:09:41 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6298C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:09:40 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id hr13so3446912pjb.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Kvz5z8XjsOiRF0Ft8vfvb2AWLbxq5jqCT81VzPAtPwI=;
        b=EzXwLtwfHgk0YEjtgNU13NSnyzF7zJ8hIh+bGsCOB61nV+m1eqGW+OwOFbC1mOoBaI
         grH1XPN5YjBUQyw2YPPpUNLU/ZyLgCBIUJ7NetaBnFfQXar5WNMlBjy9NX+mjm5dC5rf
         s8jS6cTKLQpbf3YEBkM4WM11nkManszLKh7tJwguhwe2ApNOZGRc46BOmuawLzBvcOUf
         EG5t4i2+W0Gzttwsp3PTdcQXZU4q3t8EDTcFCPNxO3yFBaXv1sVAPRPMISZFedTnktcb
         Hs8QxQzq4S/3UZZUa9uxbCyc2Htfro7cY0acpQEUd4PVI8YWHlvkovHElrFMuS0u9p3/
         OwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Kvz5z8XjsOiRF0Ft8vfvb2AWLbxq5jqCT81VzPAtPwI=;
        b=JJoXIe127IY9FggqVeYZ/HAh9781m8odQQoClZjJOBaQFZVvBg3aHmHFIoJ7Rv/BwN
         rx3XMlc11GbP9JZaOcuveyyZLAX+Xc0kphXVzfOd1EJ3D/dP4+YwFcOC8vMdFfKMq9Wz
         JvbcjYk6fFqaVK4LVfNhyw6a1KavLR4LuzR9ll9FEZeSYO0KQ9SR/ZKcNQtq+jp2gsa8
         OvVghb466bHgkbpLycXgMR3W8KAdtPa4ZWJd8/vliKb7ERSuRasc57zRmPH/LaraWRaq
         0pTn8vYzXtl90fnwV4w8ZXmaKoY5fMPT66T0qAbbnWyZjUR1FQKtlPKWbwFFcRvKBz6U
         laug==
X-Gm-Message-State: AOAM532A1UUo7MKUuzlriCQs9pMQplE+Jx5ADAeNUpbyj7dhW3WC2yVA
        EWeMDaETmeugr+hX+CaKVZmmTIYHWrCC+BG4zWBF
X-Google-Smtp-Source: ABdhPJxokFFfX6k6D1ccLnLxHtg9xjnnqfRXnFzsbUxNQjar6Hvuk734RXtCuOvPYwDctwaP0gZ+Ig1GAR23jNAV+IfK
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1356:b029:13e:5203:fba3
 with SMTP id k22-20020a056a001356b029013e5203fba3mr5982352pfu.3.1600816180151;
 Tue, 22 Sep 2020 16:09:40 -0700 (PDT)
Date:   Tue, 22 Sep 2020 16:09:37 -0700
In-Reply-To: <75e846456b8ac4a3518ecc9051c927539dd7ff08.1598380599.git.gitgitgadget@gmail.com>
Message-Id: <20200922230937.906065-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <75e846456b8ac4a3518ecc9051c927539dd7ff08.1598380599.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v3 2/8] maintenance: add loose-objects task
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Create a 'loose-objects' task for the 'git maintenance run' command.
> This helps clean up loose objects without disrupting concurrent Git
> commands using the following sequence of events:
> 
> 1. Run 'git prune-packed' to delete any loose objects that exist
>    in a pack-file. Concurrent commands will prefer the packed
>    version of the object to the loose version. (Of course, there
>    are exceptions for commands that specifically care about the
>    location of an object. These are rare for a user to run on
>    purpose, and we hope a user that has selected background
>    maintenance will not be trying to do foreground maintenance.)
> 
> 2. Run 'git pack-objects' on a batch of loose objects. These
>    objects are grouped by scanning the loose object directories in
>    lexicographic order until listing all loose objects -or-
>    reaching 50,000 objects. This is more than enough if the loose
>    objects are created only by a user doing normal development.
>    We noticed users with _millions_ of loose objects because VFS
>    for Git downloads blobs on-demand when a file read operation
>    requires populating a virtual file. 

[snip]

> This has potential of
>    happening in partial clones if someone runs 'git grep' or
>    otherwise evades the batch-download feature for requesting
>    promisor objects.

This part is not strictly true, as even when Git lazy-fetches one
object, it fetches it in the form of a packfile - so maybe remove this
sentence.

This is nevertheless a good feature to have - loose objects may not be
created during lazy fetches, but they definitely are created during
normal operation (e.g. commits). Git, as a whole, prefers packfiles over
loose objects, and just packing the loose objects themselves instead of
running repack (which goes through all reachable objects) is definitely
better for large repositories.
