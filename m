Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390241F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfA0AQq (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:16:46 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:36450 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfA0AQp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:16:45 -0500
Received: by mail-ed1-f51.google.com with SMTP id f23so10258150edb.3
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=3YPhIKFLKKo17My9qZdQANEM8yUK8GBFmPcr3S2vB6M=;
        b=WyS3fc6fkis7Oce8fDLKIp5Y4GkmXBlOoVjEdRdbDvhEpJg2asR80qYvfBX8N2b8C7
         MQt241bz9+7i8TB7sCIsOu0YI/nQ98001+9YoQHB/HFM9xrJOsDy/0qvR4F+tzLBTxiO
         TxKPxLo0OYnHnPW/LHFZ7HSHUgifFjHj/SkWDIKIVZ0jRpPlKpx051ao/4wAM/+fvKic
         787oqRIDLC29kFm80bLC6yF/MnFYiBNrxeRGJqtesRr8fX3HeaARVK+fJiojV2J2iIna
         N4uaUsYCvIKMmjXirBPOGXXBMJv5/ubL2uEeafDzEx14xiGagwF54STAnGh53WAeaEWq
         xgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3YPhIKFLKKo17My9qZdQANEM8yUK8GBFmPcr3S2vB6M=;
        b=Vgh2Lzz6XARVkCvgGnEWQ70CZPMansWHv+azqUCnv8YZk+OnpMGy3wrOFZo6kMRWye
         ykx01GT9tueasDjT4N8NKSv/L3z+j2VCOTjLNIlb+RyejFvXMl5Uu5M256+VEHR7izF4
         9UUPBPEt/RsT51AwGZVb6Bd2AqZ02BOdHBTMvnbyKHUX+cnHwb9LjtO3YuYOe9UAK8Qq
         HYWMEFIyOetx4OXM3hiCJCS7W3kZmSHhgNs4UtLYQ3FHggukEPn73WaonVPqQmFtJVOX
         sGsId7jXvXp64pRY2cri3Fn+8L9XA4yhafV82dX4xAaRU6XwuEmXyRGb64blXptLsIl2
         lGPg==
X-Gm-Message-State: AJcUukeMSyvL1aVuqrYtNTF5cvgr6KT4Nf3i6iY+tjD44auuR2MC0qn9
        gUelF0y4MdSIey+sIn6RqJdNGRYwHsKZdTYVgVQyXtadVDycyjnQ
X-Google-Smtp-Source: ALg8bN7Q9I7NHmNTtTBMY/CkdeJClOn+WDm7l0CN9ZZn2rN+O/JsV4X3dFb1b98tdO4A9OFcI+mum3ZBsJqkBQ9KOYw=
X-Received: by 2002:a50:ba5c:: with SMTP id 28mr15779027eds.91.1548548203805;
 Sat, 26 Jan 2019 16:16:43 -0800 (PST)
MIME-Version: 1.0
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Sun, 27 Jan 2019 01:16:17 +0100
Message-ID: <CABUeae_tm__uvHH74UARG805uTa2Sf0v6wYk=pmKvxxH3kvQ8A@mail.gmail.com>
Subject: Checkout branch and prune everything related to previous checkout
 (incl. LFS remains)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a repo of a superproject with number of submodules.
lots of files of both are in Git LFS.
The repo comes with multiple long-lived release branches.
The complete clone transfers 20 GB of Git and Git LFS objects.
Checkout of master deflates the total repo to 40 GB in total,
that is the objects and the working tree files together.


Let's consider three separate clones as canonical way to create
three working copies, one per the long-lived branch:

```
git clone --branch master      --recursive --jobs 8 https://repo repo_master
git clone --branch release/1.0 --recursive --jobs 8 https://repo repo_release1
git clone --branch release/2.0 --recursive --jobs 8 https://repo repo_release2

```

I'm trying to work out a network-optimised equivalent of the above:
- clone once with the default master checked out
- make multiple copies of the cloned repo
- checkout release branches

How to checkout an existing branch fetched from remote,
delete the previous branch and clean up any remains?

How to clean up everything related to the previously checked out
master and its working tree, any cached previous LFS downloads etc.?

But, to keep the history of origin/master.

Here is what I have come up with for the the network-optimised workflow:

```
git clone --branch master --recursive --jobs 8 https://repo repo_master

cp -a repo_master repo_release1
cp -a repo_master repo_release2

cd repo_release1
git checkout -b release/1.0 --track origin/release/1.0

git pull
git submodule update --init --recursive --jobs 8

git branch -D master

git lfs prune
git submodule foreach --recursive git lfs prune

git lfs checkout
git submodule foreach --recursive git lfs checkout
```

Does it look correct or any steps are missing/redundant?

Does it make sense to run any of these, at which point?

git gc --aggressive --prune=now
git submodule foreach --recursive git gc --aggressive --prune=now

Please, assume, no new commits will happen locally between the
`git clone --branch master ...` and `cp -a repo_master ...`.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
