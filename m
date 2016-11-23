Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6DD1FBB0
	for <e@80x24.org>; Wed, 23 Nov 2016 00:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755942AbcKWAw2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 19:52:28 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33536 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753253AbcKWAw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 19:52:26 -0500
Received: by mail-qk0-f172.google.com with SMTP id x190so48777054qkb.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 16:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=jOj7zmTrfHXB4zCKmYfxCs/ThZmN6eOXCHs9JQBjLuc=;
        b=FfQKDRrGHzAOtfd4nb25XxdCNMNhKyfPjuz6a8wqr9PnY2AG2tslgI3xfVmo4ytnvI
         dmGoxclgX5vRZhW/FZ5DcTR6pp9g5aOC2t2zhgUXaFrt3KNa+Se47VBZt+jzcBILpNmc
         gbwsFLD5PFHR/4gs3vsCBwV3xvvId9ee8yu8z1+PjayqEmYkWJFlkGJW5/c1MNOiZHtL
         YwqbJhS78SniRMoxuiNtN/O6oQBTFwqX6lhNf9sVxNe6jN2kHIkUznwVhYlHICaJJMhR
         ejAQgIIaNguSy/0Vz7VM381mc3W8sBYsI7k1KidHBSp85/Aj+KWuhl+73A2P4g0+nNLJ
         nRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=jOj7zmTrfHXB4zCKmYfxCs/ThZmN6eOXCHs9JQBjLuc=;
        b=WGctFfBTYu3DE7RxcOMIKhwDTNfnSxc/ulaJ4CGJUl4VrJshPlC6vbOer64uY0pzAz
         agiC315+402mCwXKon5Dd0SekHCYBL8A1YVkYoNnvYeoKXzxdCckBz7ovEXqSjHPN+Gx
         ODQ57YmvonM9yq4tU0mI8D41Fw2A3sM4rIvjNvecDdkJerpXNogGGv8UlCWmXyQxTUbE
         UyjE7fR3aChmXfQc90vXLqT1KhxiSO9Ec6EN4cPnBEATF0uYNo7c+x5fFznv0E4haaH3
         GotW5cTUPZXQpqLwdqxPu4ObHvrgzBM93PWzymQOKsLXImonVqJ7un2r6peagmOxdzTe
         md0A==
X-Gm-Message-State: AKaTC03ikIMeac3Mh+xjRAsTGqv070mOTvzbpLU/ll6lVr/MW4/tym7XmirguVYz+EO55P/iKHQrVdCbVnHBeQ==
X-Received: by 10.55.183.3 with SMTP id h3mr486505qkf.33.1479862323384; Tue,
 22 Nov 2016 16:52:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.55.41.218 with HTTP; Tue, 22 Nov 2016 16:52:02 -0800 (PST)
From:   Van Oostenryck Luc <luc.vanoostenryck@gmail.com>
Date:   Wed, 23 Nov 2016 01:52:02 +0100
X-Google-Sender-Auth: FuHDAqQU6K4FMZUFzyFp6BFnuog
Message-ID: <CAExDi1SYOuq7GJC69+5yDmzaw--vKMmmqv0Jsm80hU1L5phDUg@mail.gmail.com>
Subject: dangling commits in worktree
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

More or less by error I used the fsck command in a worktree and I had
the surprised to see that it reported a lot of dangling commits while it was
not supposed to have one.
I quickly realized that it was the case only in the worktree, in the main dir
things were OK. While experimenting a bit I also saw that git gc had not the
same effect in a worktree than in the main tree (the pack was smaller, more
files were left in objects/xx/ dirs), which is even more odd and a bit
scary when thinking to the pruning.

This seems like a bug to me and googling about it didn't returned anything.

Luc Van Oostenryck
