Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E0EC4332B
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 23:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD47E23A5E
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 23:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbhAOXnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 18:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbhAOXns (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 18:43:48 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C207C0613D3
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 15:43:08 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id w4so7521708pgc.7
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 15:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=wk8dZZa5oedkto1avIomY77frdKv6Z11zC0q1QdK3sQ=;
        b=dpAF5WaX0HcxNELwzmRHYSnCjvB7QZlt+i5ZRAWadC7DiKAaerUtWO+PCf4gVOLXm+
         ArS9103rrhjiKhEpHQtso5DKzV8WYiNECU0VeQIqh9sWpckgNjrn1p92XVtC8m9Yg3B9
         xT3Prn/4b9qi88O43JspGHgnK7xR8hywycrXDypOao4WzBcXAP75G5ROIcGsu7oqcIlQ
         umlWu4pNtl/95VpHNfS7S2y1yKMeFslIXi7bspv9ERi7/pxBQX4VFfIiOtwNmcekMnke
         oas1EEdE/VpxFn96pSBubMzoK2rkLN/TUkhsbC8BIZiI1iAsTVho/nClJm2oQ6cZMI3y
         hZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=wk8dZZa5oedkto1avIomY77frdKv6Z11zC0q1QdK3sQ=;
        b=svYetZ5+OAwRwUUpH4MhC6W3ERd3Htg3us2deblmCRczg9Vv4K0i8Z4Z9mhH6vajKl
         lszfLnI/p0kBI3saMRhVpkQ2AwkADcJYfbB+w/W5PiHDiSpnF2mYMXz7B5R+NDMUhGeI
         7V29fVCxtEcZh4KcnbBK04tMCzCwLhYNN08zIzECjQV8xyb0zvkb6flNKJzizHKr2xDt
         mFlaYQBOhdv5X0fEvOfzy4EMP8qVX2xnoYQJPnP1chjPXmtoRtfDr0f8Q42AcsamevGt
         6ygNqEf8TVB/YX/ufBstgykeIEnHzVXVpC7NoHzz7NNCzrJAY46/raO1kBIkW8cklVxD
         NlzQ==
X-Gm-Message-State: AOAM530yiwrbnwWfN1TDuN1ARSaUx6SY6wDLuC1rvFdfP/GNWRxJ5phQ
        ntY72rCEH7zdw+1Wecr1Dlnd84I6qUWUXzMzPYu2cbP55OEVS5cO9X7ikrJhBCiPXWoaQBIpXXo
        vj7pBSq/oKZlletX1Xw6ZfbpAvN8W3arytik60VGIScE5wHKptS/KvvF9xWPOGMIlQAreNiPnAm
        Td
X-Google-Smtp-Source: ABdhPJzg6Shxm87/c3dnghOJT91VIwMos8J2G9euQ1tXA/ICbKs8oYXKuEGjvx1ZC1Jt7fZEBM0CTXMyAzP2LAx7K5Kt
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:a710:b029:dc:3817:e7c2 with
 SMTP id w16-20020a170902a710b02900dc3817e7c2mr15245862plq.0.1610754187474;
 Fri, 15 Jan 2021 15:43:07 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:43:00 -0800
Message-Id: <20210115234300.350442-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: RFC on packfile URIs and .gitmodules check
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Someone at $DAYJOB noticed that if a .gitmodules-containing tree and the
.gitmodules blob itself are sent in 2 separate packfiles during a fetch
(which can happen when packfile URIs are used), transfer.fsckobjects
causes the fetch to fail. You can reproduce it as follows (as of the
time of writing):

  $ git -c fetch.uriprotocols=https -c transfer.fsckobjects=true clone https://chromium.googlesource.com/chromiumos/codesearch
  Cloning into 'codesearch'...
  remote: Total 2242 (delta 0), reused 2242 (delta 0)
  Receiving objects: 100% (2242/2242), 1.77 MiB | 4.62 MiB/s, done.
  error: object 1f155c20935ee1154a813a814f03ef2b3976680f: gitmodulesMissing: unable to read .gitmodules blob
  fatal: fsck error in pack objects
  fatal: index-pack failed

This happens because the fsck part is currently being done in
index-pack, which operates on one pack at a time. When index-pack sees
the tree, it runs fsck on it (like any other object), and the fsck
subsystem remembers the .gitmodules target (specifically, in
gitmodules_found in fsck.c). Later, index-pack runs fsck_finish() which
checks if the target exists, but it doesn't, so it reports the failure.

One option is for fetch to do its own pass of checking all downloaded
objects once all packfiles have been downloaded, but that seems wasteful
as all trees would have to be re-inflated.

Another option is to do it within the connectivity check instead - so,
update rev-list and the object walking mechanism to be able to detect
.gitmodules in trees and fsck the target blob whenever such an entry
occurs. This has the advantage that there is no extra re-inflation,
although it might be strange to have object walking be able to fsck.

The simplest solution would be to just relax this - check the blob if it
exists, but if it doesn't, it's OK. Some things in favor of this
solution:

 - This is something we already do in the partial clone case (although
   it could be argued that in this case, we're already trusting the
   server for far more than .gitmodules, so just because it's OK in the
   partial clone case doesn't mean that it's OK in the regular case).

 - Also, the commit message for this feature (from ed8b10f631 ("fsck: check
   .gitmodules content", 2018-05-21)) gives a rationale of a newer
   server being able to protect older clients.
    - Servers using receive-pack (instead of fetch-pack) to obtain
      objects would still be protected, since receive-pack still only
      accepts one packfile at a time (and there are currently no plans
      to expand this).
    - Also, malicious .gitobjects files could still be crafted that pass
      fsck checking - for example, by containing a URL (of another
      server) that refers to a repo with a .gitobjects that would fail
      fsck.

So I would rather go with just relaxing the check, but if consensus is
that we should still do it, I'll investigate doing it in the
connectivity check.
