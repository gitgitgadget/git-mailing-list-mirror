Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB420C433E0
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C272070A
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNCe7Y6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGTLoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgGTLoi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 07:44:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D00BC061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 04:44:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id br7so17691328ejb.5
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=cpI38IqHTso7cQWosT179dgncEKVHGwMnFEF7EH05Lo=;
        b=dNCe7Y6HaeE+qAXURlPPPrUppohu1pEeYHdto8TgYHxclXNXwyZDSpNvh8X8LlzJWe
         vjcayqbqcax6947GWfK8QHKFmQ4wlqZYYBNJhcJbS2DYwyhQ+lAKNdFhCUFkIp68XMJN
         yN1vBLpnMaOc2OH7uNi0eUCZb9pWLP6QQplqRjwigoCmxg0rUPy3I+Dfpqp0FGL8JSQl
         SJD8D6KEl8CT/y5rpVsWkNfYHe4GzJJz/NLUY2q/ArI5iSHQwQ7fbXSTCj0nbkzxfiLZ
         VUEY9BW5wmha+7ZqPaK5iZy1I7etyx/i6Yu82Ezl0SSGMjULtfmeHN5QJ0YQw/Sskcoz
         fL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=cpI38IqHTso7cQWosT179dgncEKVHGwMnFEF7EH05Lo=;
        b=mPSFq6unU5tmkqU2bzdCsqUB8FvaPl7dAh0s0QTrV5a8SKgjN7t7M2pjjQFfo5lhcj
         zLW4Tzg1kmkEcv2Y16Ydf8v0bWutqL84T3qKttWmvvwD7ayq6pc+ZMNlWNZweKv2BA6L
         NaVooWw0z/UvWeZuqknCDRsa05pIhFISJumfb6w8cgf6twaxHvUIKwOpUP0dqPZYuUef
         8N8WqqV+NYmNfh2H5Z8T/xuROT1dIe9cSAj/T6NLQkoBKFn5SGgGSKRhzvtr0/vd7Xu3
         3QItoPeWtVzZRNAR4ZN20vw1vGoxdYAVZD/98L7rqXrYfZXyGBK0rG0L1YaZFlE9sUD5
         n73A==
X-Gm-Message-State: AOAM53070v07qGjUGlFuMDMtwLYmmGNuTUZZk4Q+xJChTQqRA9xyrZT4
        9rxc9KPJFwTOWogmX5ZSeA9Jac3S
X-Google-Smtp-Source: ABdhPJw7cgLgL4GDAcWhdEmkL1AeuW52G4gcEHKs2bEe7RLWjvJyne/NsK5I4BoOdFemIPBBBKkLRA==
X-Received: by 2002:a17:906:add3:: with SMTP id lb19mr19790956ejb.304.1595245476672;
        Mon, 20 Jul 2020 04:44:36 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:410f:b6f6:852c:ec06? ([2a02:a210:ca2:9c00:410f:b6f6:852c:ec06])
        by smtp.gmail.com with ESMTPSA id aq25sm14891101ejc.11.2020.07.20.04.44.35
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 04:44:36 -0700 (PDT)
From:   Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Pushing tag from a partial clone
Message-Id: <0DEFACA7-9D30-4DB1-9FDF-3E63945FAAB3@gmail.com>
Date:   Mon, 20 Jul 2020 13:44:35 +0200
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

At $day_job, we are trying to push tags to a repo from a partial clone =
copy.
However it seems like this push would requires the partial clone copy to =
download more objects?
Is this intended?

Reproduce:

	mkdir repo && cd repo
	git init
	git remote add origin git@domain.com:path/repo.git
	git fetch --filter=3Dtree:0 --no-tags --prune origin <commit-id>
	git sparse-checkout init --cone
	git checkout --force <commit-id>
	git tag -a sluongng-test -m "Test push from partial clone"
	git push HEAD:refs/tags/sluongng-test
	<git starts to download objects>

Ideally we would like to be able to push tag from a shallow + partial =
clone repo without=20
having to download extra objects if possible.
We would like to keep the required repo to the absolute minimum.
	git fetch --depth 1 --filter=3Dtree:0 --no-tags --prune origin =
<commit-id>

Creating and pushing tags should not require local repo to have =
trees/blobs in it?

Git version: 2.27.0

Cheers,
Son Luong.=
