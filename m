Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11203C35249
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 18:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3F820679
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 18:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqYb6ale"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgBBSny (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 13:43:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43846 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgBBSnx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 13:43:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so12251727ljm.10
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 10:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=dbC2AY+KXcUkzHXDqCnOJFMEOvy4eHWyVJxi9Upb+V4=;
        b=qqYb6alefzeG+dDtwLFOH0TP0Rh8QrdE27ppvzbl9r8q7gi2zW0U70L3I5TilQM34J
         2RUQwv7CNGzXc1sgvTUVLHiaZctF0WVKGBd+ok5vnbtqZVfBOsZ1rcZ1vuU3X/gr1nkr
         zmjJYS7fX8dbhOc2NIjpSH+MYp62RwF6cSZCTHSO//JuvFNzVznf972XfYtuqd0zLeX7
         sk79e+pBWzb0mNU34nbzUwXplvRzoTC0EMymzAhE6yvYQ9QRHFlT+LjMWica5qe0zKG8
         uiBTnWHCiW4QQCc5JeGFsYjlh1IYKFLnNkyHNzGdTtMfvKtn7RIrhcyB7yw6nPWkUEzn
         tPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dbC2AY+KXcUkzHXDqCnOJFMEOvy4eHWyVJxi9Upb+V4=;
        b=k1dVqUw7ZXltpbuC2rDw+OYqZTYUEoLhB0bbM3WEjippFugK/gd3WOwgrxgI7XE/jp
         XGs+Q6dbjo27297ViM/2xw/NepCwE0P5KcJX+wCQkWEgi8yxs21KCDWIz3l/V1h2+a5h
         Uft6Q7oEc1M7d5hMsjAjrS/fRxEsBiwSV7szGPrIsyu0NKYM4DkeRZcWFkLLko07R71f
         mKpbOq3z8dzSSrcsoG9K1D39HwiNzKC40eZ8p+Bne2FcbejGR35tRowPvN85D+MvhixT
         fSgQBFjgaN0sHSnl8FXIw+BeYdpzJlSZET2R2mXQP/H0osz3c8MKCI3NFBHPbw77aggl
         Risg==
X-Gm-Message-State: APjAAAUSs3s/O6dyr4851EIqqh6w2XpIJ5fVb2RQc1JRwti9exct2M4T
        BFHtMNnnyVZlDs2qr+bhHKM=
X-Google-Smtp-Source: APXvYqxdso77S7IQlDzXmMnXCCCFm5AKg1bOZhDtRQMU5J9miNR4EmZ/mpY/LS4UapWAOtm546xFOQ==
X-Received: by 2002:a2e:730e:: with SMTP id o14mr11236148ljc.51.1580669031118;
        Sun, 02 Feb 2020 10:43:51 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id l22sm8493474ljb.2.2020.02.02.10.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Feb 2020 10:43:49 -0800 (PST)
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
        <868sm2ck7w.fsf@gmail.com>
        <f5625b23-d7c4-9a72-4ed6-69893de103b0@gmail.com>
Date:   Sun, 02 Feb 2020 19:43:47 +0100
Message-ID: <86mua0zv6k.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:
> On 1/20/2020 8:48 AM, Jakub Narebski wrote:

>>>                                      How often a file has been touched
>>> also makes a difference. The performance gains are less dramatic if the=
=20
>>> file has a very sparse history even if it is a deep file.
>>=20
>> This looks a bit strange (or maybe I don't understand something).
>>=20
>> Bloom filter can answer "no" and "maybe" to subset inclusion query.
>> This means that if file was *not* changed, with great probability the
>> answer from Bloom filter would be "no", and we would skip diff-ing
>> trees (which may terminate early, though).
>>=20
>> On the other hand if file was changed by the commit, and the answer from
>> a Bloom filter is "maybe", then we have to perform diffing to make sure.
>
> Yes. What I meant by statement however is that the performance gain i.e.=
=20
> difference in performance between using and not using bloom filters, is n=
ot=20
> always as dramatic if the history is sparse and the trees aren't touched=
=20
> as often. So it is largely dependent on the shape of the repo and the sha=
pe
> of the commit graph.=20

It probably depends on the depth of changes in a typical skipped commit,
I think.

If we are getting history for the
core/java/com/android/ims/internal/uce/presence/IPresenceListener.aidl
and the change is contained in libs/input/ directory, we have to unpack
only two trees, independent on the depth of the file we are asking
about.

It could be also possible, if Git is smart enough about it, to halt
early if we are checking only if given path changed rather than
calculating a full difftree.  Say, for example, that the change was in
core/java/org/apache/http/conn/ssl/SSLSocketFactory.java file, while
we were getting the history for the following file
core/java/com/android/ims/internal/uce/presence/IPresenceListener.aidl
After unpacking two or three threes we know that the second file was not
changed.  But if we compute full diff, we have to unpack 8 trees.
Quite a difference.


All example paths above came from AOSP repository that was used for
testing different proposed generation numbers v2, see
https://github.com/derrickstolee/gen-test/blob/master/clone-repos.sh

>>> The numbers from the git and linux repos for instance, are for files=20
>>> closer to the root, hence 2x to 5x.=20
>>=20
>> That is quite nice speedup, anyway (git repository cannot be even
>> considered large; medium -- maybe).
>
> Yeah. Git and Linux served as nice initial test beds. If you have any=20
> suggestions for interesting repos it would be worth running performanc=20
> investigations on, do let me know!=20

If we want repositories with deep path hierarchy, Java projects with
mandated directory structures might be a good choice, for example
Android (AOSP):

  git clone https://android.googlesource.com/platform/frameworks/base/ andr=
oid-base

It is also quite large repository; in 2019 it had around 874000 commits,
around the same as the Linux kernel repository.

Another large repository is Chromium -- though I don't know if it has
deep filesystem hierarchy.

You can use the list of different large and large-ish repositories from
https://github.com/derrickstolee/gen-test/blob/master/clone-repos.sh
Other repositories with large number of commmits not on that list are
LLVM Compiler, GCC (GNU Compiler Collection) -- just converted to Git,
Homebrew, and Ruby on Rails.

>> P.S. I wonder if it would be worth to create some synthetical repository
>> to test performance gains of Bloom filters, perhaps in t/perf...
>>=20
>
> I will look into this after I get v1 out on the mailing list.=20
> Thanks!=20

It would be nice to have, but it can wait.


Keep up the good work!
--=20
Jakub Nar=C4=99bski
