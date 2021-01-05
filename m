Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA54C433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 15:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9918722B49
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 15:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhAEPKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbhAEPKa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 10:10:30 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA75C061793
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 07:09:50 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id g24so20977248qtq.12
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 07:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=UyNK72w3BeDB3GN+M9T41dGYGsRq41FLcGhWHVwRnxg=;
        b=qOjG9OWTzhUER6FHBO4WbjO2jkWgtUZcq6D3NGK5cMl5VH5OPYMM3vkAcMeph1w2cz
         SPEmwdNRjHtEewrpKdVrF/N9Oj6qY7BAGnnvIYRZBDg8teNb2XdXZPw/6QWq8V0zBCrP
         nD8QZCHsDbAM/YDDoR6FXTtiI835N6AxVwMFO5vG0Ljzs8uVihQqKQ1/TqszhOVX0Hq1
         yCsMMBwU/f7cjn/3HZ/RxyE0bT9uPaa7Kc80wPUSmKfemdjxxFgS6qEpRWFGV1c+GFLF
         MmA1nK2ep4QThWBsvbHv6SQxB9EIOu658vT82nLMqXXk5+aazSUtKHYoeeySeedhYdcO
         jcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=UyNK72w3BeDB3GN+M9T41dGYGsRq41FLcGhWHVwRnxg=;
        b=sl/5FeBP7J3dCljvZXSWwtGX83ba9/xJtwnYb1P4xzy22mJV3dphETrWUnP6wblrd2
         y7WXO9RCdOPi/M5D32IzwswBZISZliddHI1b9yCEeO1kF+dP4TtseR1qSy2ZlyrJAxxt
         nzD57KjufmTyHR+95BpXDHalsk6vBwRqshIeFKVd3yBjpJ4gLrhlg2gfcRSuek3AwVnL
         rZsCgw/d723WFp8aabS9xX9bdeksdy9iuIG4nopyFe7WlXKcTFZ4Oohldpj0SKDr0Cd+
         AfUGSAcP/0KJBZSs61K4xeMwhjfl7T5BJrY3TWAiFGSP5eQb30Qn92RaiB50PujA588n
         s3Vw==
X-Gm-Message-State: AOAM533REvb0cCx+Pt+uY4+KzXqm3OgJqHfyK1UoFjHREKNWty5Iw7LW
        figiAknDnD89SFtb2tTT7GEbjni6x1g=
X-Google-Smtp-Source: ABdhPJw0rlLqrPbhV1cFwkKDf5cXuHliX9XEr8BcGago+kZ23xhWsXVUU/aeJYIWFuUrRyYAbQTTqg==
X-Received: by 2002:ac8:5790:: with SMTP id v16mr77870002qta.332.1609859389344;
        Tue, 05 Jan 2021 07:09:49 -0800 (PST)
Received: from [192.168.103.12] (cpe00fc8d50b7d3-cm00fc8d50b7d0.cpe.net.fido.ca. [72.141.221.184])
        by smtp.gmail.com with ESMTPSA id a21sm84859qkb.124.2021.01.05.07.09.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:09:48 -0800 (PST)
From:   Utku <ugultopu@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: How to get the branch HEAD points to using a plumbing command?
Message-Id: <132D030A-AAD3-4EFC-9858-7EA39503A746@gmail.com>
Date:   Tue, 5 Jan 2021 10:09:47 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If HEAD points to a branch, then `cat .git/HEAD` returns (at least on my =
Git version):

    ref: refs/heads/2.x

So, to understand which branch HEAD points to, I can:

- Read file contents of `.git/HEAD`.
- Try to match the contents with the regular expression `^ref: =
refs\/heads\/(.*)$`. If the capturing group is not empty, then HEAD =
points to the branch indicated by the capturing group. Otherwise, HEAD =
does not point to a branch.

To do this using only plumbing commands, I came up with:

- Run `git show-ref --head --heads`.
- Parse the output first by newlines, then by spaces and test if the =
commit hash of HEAD is present in other lines. If it is, then extract =
the branch name and return it. If not, return empty string.

My question is, is there a "better" (more idiomatic, less "expensive", =
etc.) way of doing it using only one plumbing command? This solution is =
OK but it is more work than just matching one line with a regular =
expression. The reason I want to do this using only plumbing commands is =
because I think that plumbing command interface would be more stable =
than the format (organization, structure) of files under the `.git/` =
directory across Git versions. Please correct me if I'm wrong in this =
idea as well.

