Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E61C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiKVRh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiKVRhy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:37:54 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1729E13D5F
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:37:53 -0800 (PST)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 256B83F339
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669138671;
        bh=kHmmgcYdGPRXQyJFkLWaCfyWhCFOgGRzAgwXlqMaTaU=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=QdSdTXNyxrOXNytIpyKC4bfpaTIeOnH1QHLtGsFyilNetCiJcK2wb+5YQ6gpWmCT1
         r+TaP/RsW0nKCNXGAZNOps0RoCWXbpWdlwWJT1zPzn5OX234qYR1JhvNJsmhfyAIPP
         VTvcR4Tc0mThidL9MHD+TQ1uDh0KpqThRrM+lBvsG29v/ZLsb7Tng/9T73uy6AkU9Y
         ffF/4LgYwSr0faZaL3uii9bG5v5cXd6OJ2g3KOpD7Z6FoNstZWa4ATWtO4VI9g7Vdl
         1aEr/wJ/T7TrJmGnuZVh5DFIOJXzMJjJ/+KVvtapjUVQXexPOv4bWOkXUL8coXBU8u
         s561RzR4dtspw==
Received: by mail-lj1-f200.google.com with SMTP id p6-20020a2e8046000000b0027703bb5701so4598648ljg.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHmmgcYdGPRXQyJFkLWaCfyWhCFOgGRzAgwXlqMaTaU=;
        b=pVckzftENY4RX1hdPCyT0zgp48ANagniiBK9ZhDn7HgfuQUe+vpf5z7JzkqYwU1HqU
         vmTkXdmL2MkeCXmRbR/seWfun2wIU+DCF04Mcnb7lIzjfaJF4B1xh2jbTZb6DMNnwSY6
         Rj/4DiX3Uq6qUgPGOFv3DtqgZpTke8sp3Yw4PFIzfG69T94mk0frB+vS3iYOROpHP6zS
         UUraxI1z14AROOID+Kv5R19lE2r8yfYWvRfEqIvHobEyMrltbhj6HMK88xQOr9QdSo5y
         peJWqCnHYYuEtEeCUUsU9b2uHonSKY/ExSz5PXQlaS67yhY8wo41ApjxOfCsf5EoSyq3
         58EA==
X-Gm-Message-State: ANoB5pmegYcYtJFpJANy4uO9C9XRMrwGzmyhjkVn7RY2BZ0MD9cqGvi7
        yB8rMK8tD9YcQlG87d6qsjQCH0UGnXkdK0j9sbRZq5u3tJBs8cjITN6RoXOEgpbywtCKfsmYIW5
        rLaPMhxqLB9CoJ9xL+cWGUh+DAC8wiDaSrFYP3BrKaegxkA==
X-Received: by 2002:a05:651c:1993:b0:26c:4fb:b084 with SMTP id bx19-20020a05651c199300b0026c04fbb084mr7474509ljb.383.1669138670123;
        Tue, 22 Nov 2022 09:37:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Q+L2ItpIdpt0X5h8A0TqfZx7lH2arjxKDybt47sqgO1lxwYuCESiDqbDjSXa3RNQcvXGYhuZKBgz9Yp57DiE=
X-Received: by 2002:a05:651c:1993:b0:26c:4fb:b084 with SMTP id
 bx19-20020a05651c199300b0026c04fbb084mr7474503ljb.383.1669138669861; Tue, 22
 Nov 2022 09:37:49 -0800 (PST)
MIME-Version: 1.0
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Tue, 22 Nov 2022 14:37:38 -0300
Message-ID: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
Subject: chainlink.pl /proc/cpuinfo regexp fails on s390x
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

(please CC me on replies, as I'm not subscribed)

git commit 29fb2ec384a867ca577335a12f4b45c184e7b642[1], present in
2.38.0 and later, introduced a function that gets the number of cores
from /proc/cpuinfo. It essentially does this on linux:

    do { local @ARGV='/proc/cpuinfo'; return
scalar(grep(/^processor\s*:/, <>)); } if -r '/proc/cpuinfo';

On s390x, the ^processor lines are like this:

processor 0: version = FF, identification = 148F67, machine = 2964

In other arches (I checked amd64, armhf and arm64), they are like this instead:

processor : 0

As a result, that function is returning 0 on s390x, and that value is
used for the number of jobs the script should execute. Since it's
zero, it exits without doing anything, and that breaks the test and
the build[3] on s390x.

This is trivial and I don't think a PR is necessary, but let me know
if you want one.

That regexp could perhaps be:

/^processor\s*\d*\s*:/

or

/^processor[\s\d]*:/

or something else.


1. https://github.com/git/git/commit/29fb2ec384a867ca577335a12f4b45c184e7b642
2. https://github.com/git/git/commit/29fb2ec384a867ca577335a12f4b45c184e7b642#diff-e7042d714d4be11a06d153e6f2daeb3c3a9766b972522baab8ba113b962086cfR574
3. https://launchpadlibrarian.net/635348769/buildlog_ubuntu-lunar-s390x.git_1%3A2.38.1-1ubuntu1_BUILDING.txt.gz
