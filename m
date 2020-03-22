Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EEBC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 18:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A99206F8
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 18:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuhdkhUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgCVStY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 14:49:24 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:40255 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVStY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 14:49:24 -0400
Received: by mail-qk1-f180.google.com with SMTP id l25so8108894qki.7
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=IoZq+k7rQ64yr10SuZOzk9Qqx827XhF4TNjaejrHZ60=;
        b=DuhdkhUQhK0uqm7CRv93dtvaWoadbzwHHF8GXhU2hncb9k6OMbZiTJahjzZ8oiIUoZ
         xVZf+oF5ZvmHkSoFYtN1EfmQJbLtm6FyUJQJ5sEhREwbROWkpOun/WxhVVqScYFvgFXe
         XZkDZCQ7L9k0hm/tqblu13VU8e2QIw4qEaq/VZDxPBE5TdL3YJvjPAyNZVAuI0YsWMJE
         1uinNmUdsKSuGZ8WbtU9N0XFGmlQQsGNlfK8aUQEvEztTtsjxV7uisu8y7ydd0+I9nzp
         pbyPXF5M/8UDd9fJmadeqhUY8a+2kCocTDjmzNOfOcBdlkySmdcR5671hxRx29j89a53
         Vcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=IoZq+k7rQ64yr10SuZOzk9Qqx827XhF4TNjaejrHZ60=;
        b=oClP2NuLecwmI2WLa9Me6iAJ2JC0verT2bDqmw5x6/c8uv4HnNDcpe/0US8qBAFg2+
         dCCtJ5AIqdjnt4K0qIdZ6hoEVEHDtD1nyAW64lG6/PfTAhACuyzIzBb8GyDAoiXx7SYr
         OW959t4IJcGU1Fw5IiCxyClijlD1cerjF5h2mHKL/oTt+fXj3spClUBYhIpbtKkgaqV8
         /wqEM1QhNl5FrhBsCrJzOI3gI4ai9G+bLKfMw1+dHRrF7jwbbDneukxnWTwaPNn57iEL
         Ay4BsE9SBUDz8/uWABBgf+hrFXzMBNHId8ZixA2/VMTC7hefst/f7pbKs5RQG9NF8XI1
         uYmQ==
X-Gm-Message-State: ANhLgQ2NDaSbz4jS9t1M5Aic8RpX7u7jaKAWmnzR0Uh2mkJf8GK+29PK
        vyFRRJs/1Z3NCNoEv1Dcee4=
X-Google-Smtp-Source: ADFU+vuzKqrWUESJMSu9rk4Hy9F2AKUbxkTI/gdSML+EX86JEDDDrXFZzVbBscJCTJx8WCQKVLJEMA==
X-Received: by 2002:a37:95c6:: with SMTP id x189mr16883750qkd.19.1584902962586;
        Sun, 22 Mar 2020 11:49:22 -0700 (PDT)
Received: from [192.168.1.2] (cpe-74-133-2-244.kya.res.rr.com. [74.133.2.244])
        by smtp.gmail.com with ESMTPSA id d2sm9346089qkf.117.2020.03.22.11.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 11:49:22 -0700 (PDT)
From:   Jason Karns <jason.karns@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Recommended release flow for multiple git-subtree repos
Message-Id: <D0A8C46D-F611-4B78-AA41-A1D75E38BB10@gmail.com>
Date:   Sun, 22 Mar 2020 14:49:21 -0400
To:     apenwarr@gmail.com, git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

Firstly, thank you all for your work on git-subtree. It has been a =
fantastic alternative to submodules for me.

I=E2=80=99m looking for some guidance on a recommended flow for a single =
parent repo with multiple subtree projects, assuming that the subtree =
projects _may_ have work directly in their repos, but most work for the =
subtrees will occur directly in the parent repo.

The project began with a single repo and the subprojects were extracted =
and created using `subtree split =E2=80=94rejoin` and `subtree push`. So =
at this point, all the subtree repos do share a common ancestor due via =
the rejoin merge commit.

My question is regarding future releases. (Releases will be done from a =
tag reachable from the parent=E2=80=99s master.) When I do a release, =
should I run only `subtree push` for each subtree? Doing so would keep =
the subtree repos HEADs at the correct place, but that will not change =
their merge-base with the parent repo, correct?

Alternatively, should I run `subtree split =E2=80=94rejoin` _AND THEN_ =
`subtree push` each release? I believe this would create a new =
=E2=80=9Crejoin=E2=80=9D merge commit for each subtree and therefore =
advance the common ancestor for the subtrees and parent repo?

Understanding that work in the subtrees would be rare means there would =
only rarely be a reason to `subtree pull/merge` any work from the =
subtree repos. Therefore, without a regular split-rejoin, the distance =
to a common ancestor would be ever-increasing. I suspect this would =
cause the subtree commands to take increasingly longer as they have more =
and more commits to replay each time?

Assuming that regularly running split=E2=80=94rejoin is a good way to =
mitigate this, is there a mechanism such that the rejoin merge commit =
can have multiple parents? (ie, merging all split subtrees into =
parent-master at once, instead of separate merge commits for each =
subtree)


Thank you so much for any insight you might be able to provide.

Regards,
Jason=
