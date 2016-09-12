Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0AE5207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 23:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbcILXaN (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 19:30:13 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36243 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbcILXaN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 19:30:13 -0400
Received: by mail-oi0-f44.google.com with SMTP id q188so228190250oia.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=jVBuER0Fo2BynxCrpOIGtpstJJqkf9bzzDo/9C/YUSU=;
        b=KvcMjXf2hjKIgPUA7e6d8FmI1rZZYcQo5/7THNYbaEzR8ELuCIH2l6Xu3HECevx780
         5bqa5RiBGyOkkqfGbd9hri1ySzL3xbu2MT7SlDf1X7ynbq9Wj9gymSnuYbZoHvwKE6VU
         q4pkXB1YWtXUU1f984VJTzETKZSCxHQxSQISFxUmkMjI8rmc6hoOSLCBW5kXnLx9+LA4
         bhD4F5UrX3TLmFbqZZHGrco4gt4A+vDc07ORiH4oRML+enVwNNe802qAzKpsbpUu5kPS
         xcTlNk2z9ee11QelAPGXVvWvgr12QOe0uW3U6k62C+Vcp11zHB2CbWwMCAF+laxNy5Q/
         E6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jVBuER0Fo2BynxCrpOIGtpstJJqkf9bzzDo/9C/YUSU=;
        b=OgWROCNaNQunyraLxqwIPgFilyG7Djhw4tNqR5WePy7zKit5SA7JkE3l+1SA13MK+C
         0/b68JiCmoc5dBpmRGfNE75LFIhQlwTOYajjYnoYey4AW5+/K5LHc6UCRtJgnVxZ9IZh
         8eTjErfvjzkApiP5Zu/Vdnpm+5yfB2UPo/ccMdH8q9rB/vva19klnKxP1cQhK1mYZIWS
         1vNvtZSljpriIy7S7cFIlEpjU5HKXBSGJG/11sGEAsZKK+RFrBBWlKw39GPbmtC1Zsz1
         Jab/ZOEkTKhYhJSe+oDa72GWeEchdGT9wA4paRPSf2DTjnhBo+6Rblzv5XvNq6Vnm9By
         W2Ow==
X-Gm-Message-State: AE9vXwOSHj+YoSj0ngpUQ6zNjGjrt+I78aczh7k59RuHvaOzzYqcHBmFFEOQ0CnkcuRWqSbcTnyEXhFOCw/yAQ==
X-Received: by 10.202.205.70 with SMTP id d67mr2303280oig.170.1473723011972;
 Mon, 12 Sep 2016 16:30:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.52.193 with HTTP; Mon, 12 Sep 2016 16:29:51 -0700 (PDT)
From:   Kevin Smith <noiz77@gmail.com>
Date:   Mon, 12 Sep 2016 16:29:51 -0700
Message-ID: <CAOY7EmCYjajQPPAVhAhzt7g0yA=QH2R9HZEAhztUo2JbfSiCwQ@mail.gmail.com>
Subject: Potential Same Name Bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I hit an issue in Git today that seemed to be a bug.  Basically what
happened is in our master branch we had two files, one named something
like "file_NAME.png" and another named "file_name.png" in the same
folder.  In the develop branch in the same repo we had removed the
"file_NAME.png" file so that only the "file_name.png" file was left.
If I clone the repo so I get master and then do "git checkout develop"
I would see when running "git status" that I would have this message:

On branch develop
Your branch is up-to-date with 'origin/develop'.
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        deleted:    file_name.png

no changes added to commit (use "git add" and/or "git commit -a")

So when I move from master to develop that status would come up.  If I
ran "git reset --hard" I would no longer have that message.  I also
saw that when I do a git clone and specify to clone the develop branch
that I would not see the git status above.  Is this an issue where if
one branch has two files of the same name where one gets removed that
it will remove both instances of that file in another branch when you
switch to it?  I fixed this issue in our repo by removing the
"file_NAME.png" file in the master branch, but it seems like this
should be handled better in the case I described.
