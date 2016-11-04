Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81722022D
	for <e@80x24.org>; Fri,  4 Nov 2016 14:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934864AbcKDO3B (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 10:29:01 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33924 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934681AbcKDO3A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 10:29:00 -0400
Received: by mail-oi0-f53.google.com with SMTP id 62so164694721oif.1
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=u0HPcMBu4NUwPgU33HI/8lXcVt5k1WgmfMpmK0jro8Y=;
        b=L6NrUDuhoReegNGIjNzhrM66Wc6ZgImsA5Uqqsx8rOW9z3RU/wsK6k1DXREKNHWUsN
         Ue4Ki4iYkGc2VdvEcf5w3tu17BBMWVrPXdSofuN4ytJ6JMEhfMbWLKAS5TW5GU7bl5so
         XCeCX5n4qFHIo850rliSfq9OfDh1GaqvWOS99XDq1etQf0RwMXeVoQCxdhfBiHkoTlS0
         mJT8K6Nj17m5FCW0TRNKJzmWKzBEFcRY1jXBsqIa4YOfeTko9gsMH2u1pDUQIKYM0Fff
         qJN4xQsKzFrshT2rlG5xts/us1RmPJuScFjlRPLchk15J5IIIZsVGUpGWrmjv0FommNe
         HjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u0HPcMBu4NUwPgU33HI/8lXcVt5k1WgmfMpmK0jro8Y=;
        b=Po9I4NWylM4nh7tx4X2hdUrjqm5O0WxvLvW9FbMRyzh2PctBL0WcveQpvPv6vy3d26
         PC2IzxXnLbgIVvx7zOjSfqvkALWJ+zUaZ5Y0ajOHhSnzOW6a6G1vvUnILW4CscTaw+yH
         0++x7KDb+YHT0le18LgDJ9tNKLXgyj4fl8Dns/VDWTnIgO5QdxGd8I8MtVNQUqJNHRpP
         JqLBpJZU5QKY32VdtRVnqLHEE/dVkFe6aPk41uKZMsHJOwZYJQGp6Sdx537zutgMw+6f
         w58HUmgkp17f+9r65SWI8tbcOABvNQ9BRxLzxG67TvjPuJzyQ0ucSz9LzhrIrVCtQIuT
         x+IQ==
X-Gm-Message-State: ABUngvdLwnv3Yl2D6qt1ZZcecx8qWbFe4+OlVi7uSKcWCarosnt4zBWzA8VNXxjn5nNEMRVn3WGO+OoQr1K2cw==
X-Received: by 10.202.54.2 with SMTP id d2mr13157620oia.145.1478269739578;
 Fri, 04 Nov 2016 07:28:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.142.68 with HTTP; Fri, 4 Nov 2016 07:28:59 -0700 (PDT)
From:   Felix Nairz <felix.nairz@gmail.com>
Date:   Fri, 4 Nov 2016 15:28:59 +0100
Message-ID: <CADJspfL3zVCPv+mfRM_v4ukUggQkhGH7KB50a+HLPZXZqn1pXw@mail.gmail.com>
Subject: git -C has unexpected behaviour
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,

I ran into some really weird git behaviour today.

My git --version is: git version 2.8.1.windows.1

We have a git repository with a submodule called TestData. The data in
there is modified and reset as part of our unit tests.

The submodule is a sub-folder of the git repository called TestData.
So the relative path from the git repository to the submodule is
.\TestData

If I delete the entire TestData folder and run
git -C .\TestData reset --hard

I will get the following error:
git : fatal: Cannot change to '.\TestData': No such file or directory
This is as expected.


Now, to the unexpected part, which I think is a bug:

If the TestData folder is there, but empty (I deleted all the files),
then running

git -C .\TestData reset --hard

will NOT throw me an error but run

git reset --hard

on the git repository (not the submodule in the sub-directory!),
without warning, or error. This is easy to reproduce by having an
empty .\TestData folder, and just changing any file in your git
repository before running

git -C .\TestData reset --hard

and seeing the local file changes gone.

Because of this we have had losses of uncommitted changes a few times
now (loosing a few days of work, and getting a bit paranoid), but
could never find the root cause for this until today, where I found
out that it happens when the TestData directory is empty.

Thank for looking into this, and I am looking forward to hear your
opinions about this.

Best Regards, Felix Nairz
