Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5FD1F576
	for <e@80x24.org>; Fri, 23 Feb 2018 08:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeBWIP3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 03:15:29 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:42509 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeBWIP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 03:15:28 -0500
Received: by mail-ua0-f169.google.com with SMTP id b23so2673166uak.9
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 00:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maptek-com-au.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=x/Un6+NSZHNDK4/66gRdFgmSZqI/rsXoO5SqtIjvx4c=;
        b=waMNzII+bCXu4OHI7IjF4/Bruc8aSTQUoD7gytRoDfTo/kQhhvH73S/cLeS7cxAhcY
         fFmWF0WZeM4kDthHZ7ZbfvRGnMcKuoSrFvHpJHfNXPfcy1LuXPVPIUseU7bPfXOgEC8n
         UAGwrUe8sn+Zrb6NuDY+LSCl6Ty5MxjRkaf7p0QwkDCnFBXpuF384egJSDTmx4/zAdSV
         9kKpciTEWB1S9e++5NurUjD0utxL7gOHcmVzFZ06O6O14ZiMeD9lrQUrHc9a46P/K24G
         Vw19uUDicqFFlGoxy4rUlGm7j6Z8aCIHCfFsgPh0ustqdf+FILVUv7ZKBX1zjERm1bzT
         y57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=x/Un6+NSZHNDK4/66gRdFgmSZqI/rsXoO5SqtIjvx4c=;
        b=VfTOYcYoxfCk7rVOiZsqASZDajnr6K1sGTJo+zlmfye4t4g41iNyfk57i67o3aTTzx
         RFGMT4nyo4vbz/U2QZ/VXHbLYy03aWwHl90a7h3KAOKE994OQOrN65rw5srygeIN7On9
         6+bIjakXjeb8agpyiNtTYfjxpcSiC6ZfE+Qfxfde7NnE7s+tlOWKIXfzq/0WripjQ/VD
         HZNZkkmn2Sy0xYT+55H1gQZxlNUB0P5MrmfmKtQPHoYp82UALy6CuOf91kxryCBshFsE
         71/cBciRj9ClwLLcruyqsA40mMXXXJN3wXN8HyAyfm7dRGMswR3mpZe6NEeoNe1EhPaw
         s3Yw==
X-Gm-Message-State: APf1xPBOOgDm3x56cBU9vNPN7yr/53wMq+eEtF9jKCkkvifPTx4vRrsu
        kxJUrjBjgdRpQtZVrcPSHOlQUzlUMdZU67Fok8HFQQ0PnQ0=
X-Google-Smtp-Source: AG47ELvdaMz+B42YBBlBj2Q4rqfu/LpHTYZPtyGBmWAjHw0o7ZExUuZaQLXwTtorTiDkErrwg8evzH+dYAGU8Roq2wQ=
X-Received: by 10.176.72.197 with SMTP id y5mr605305uac.122.1519373727177;
 Fri, 23 Feb 2018 00:15:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.65.67 with HTTP; Fri, 23 Feb 2018 00:15:26 -0800 (PST)
From:   Daryl Van Den Brink <daryl.vandenbrink@maptek.com.au>
Date:   Fri, 23 Feb 2018 18:45:26 +1030
Message-ID: <CAC4jX8GEg5=9BPepYLntGRG7n_84ju7rTSYO82SQyuiiff0UcQ@mail.gmail.com>
Subject: git stash --keep-index doesn't have the expected behaviour
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you search the internet for "git stash only unstaged changes" you
can find much misleading information about what "git stash
--keep-index" does. However, it is my opinion that the --keep-index
option is broken, in that it doesn't do what 90% of people want it to
do - that is, stash only the unstaged changes and not include the
staged changes in the stash. You can find many hacks to work around
this limitation, none of which are very satisfactory.

It was pointed out by some commenters on Stack Overflow that the
examples given in the documentation at
https://git-scm.com/docs/git-stash imply that the intended behaviour
of "git stash --keep-index" is to stash only the unstaged changes.
Based on that, they reason that it's actually a bug. I'm not sure
that's true, but I find the existing behaviour of "--keep-index"
puzzling because I can't think of when I would use it (whereas
stashing only unstaged changes is a feature I would frequently use).

Is it possible that --keep-index could be fixed/improved/modified to
stash only the unstaged changes, or alternatively a new option
introduced which does this?

-- 
Daryl van den Brink
Software Engineer
Maptek | 31 Flemington Street, Glenside, SA 5065, Australia
Tel: +61-8 8338 9222 | Dir: +61-8 8338 9222 | Fax: +61-8 8338 9229
daryl.vandenbrink@maptek.com.au | www.maptek.com
