Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E6BC2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 21:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C188320644
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 21:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hurrell-net.20150623.gappssmtp.com header.i=@hurrell-net.20150623.gappssmtp.com header.b="cnp4hlqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbgDMV4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbgDMV4C (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 17:56:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE35C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 14:56:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w145so7766787lff.3
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 14:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurrell-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=z7k/kX812LlS+fvZNL1tsAHClyPADTVY4HWaUuJaA84=;
        b=cnp4hlqTQUPBfnQElvOB7qJaM/8GN64SmCAlYiH/1S18DDzUmzB43oyfeym61vHyT5
         9DgljGzaHN8jBofAcYCiZi2xZ4ZQWhR96iww7qaPJPAgUEtgItHLwOHEbV1naFL7NRwF
         9Qnf7HCjZjOk/QYJwjmbO1GJ3M2Ws+wlPXr4mvgLB1a6NNN2OOm3HEPGf3VgAYNPISow
         7D1OBPmfX43uNdzNs2wGp0Uz95I5okZsnv/xJRm6Oblc8VccTFkuQnNJXnaHbYvI1KiX
         w0+fFo4/Da+AiVL6YgGR5yOU3Mq6zzAGzqjqgjWRMQT+weX27cCbVyTZdMz/yANUSFal
         cgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z7k/kX812LlS+fvZNL1tsAHClyPADTVY4HWaUuJaA84=;
        b=osKPR+jDBcwr5t09Weu5jxa/BS9GNzXbPHU4KAqubRTE2aN/vkQQJkPuhp332SyV38
         SVpEtXK31+9VltfIb+JwwBl5v5K7e3aTg+Az8LK+NtU5zicNyR/7In4HVHIXWsNLSq6A
         14VF25JWBwD6apPL0UPPYiwlFKRCS2LVSO+SZUHSK8wlX/mV3WlMKJXtnbE3Dvi4ZUW/
         0xvpsJZV3k7gPkoWVH8HoEBljRYd+ch8xyNQ1c685WEKyq6s8WgOWTxdKoZh7l9LKNHp
         VBRz+SUC9iX6Xij4wAbdh4zh+p9+opBs/3N/J5kf1bXtmev7CBpVivTAHiqcXu0EQu4+
         xjVg==
X-Gm-Message-State: AGi0PuZR8wehhvtwO7B89ylw+VkYfFELftKmoyJ6amjPCGUetvfs03XY
        +gnz6giMUwO4TcctK4Gl0Y3TNeSzSo5SKZpPP4HaamGA12lisg==
X-Google-Smtp-Source: APiQypLW/F7ipilNkErqll0iY7LQQEUjxAE2OaOnDTC1WAyi7PhOBMUYCYy6Illb0vSm9ivOUzfGJejP/IOQ+dp04RA=
X-Received: by 2002:ac2:5684:: with SMTP id 4mr11279042lfr.88.1586814959286;
 Mon, 13 Apr 2020 14:55:59 -0700 (PDT)
MIME-Version: 1.0
From:   Greg Hurrell <greg@hurrell.net>
Date:   Mon, 13 Apr 2020 23:55:48 +0200
Message-ID: <CAOyLvt9=wRfpvGGJqLMi7=wLWu881pOur8c9qNEg+Xqhf8W2ww@mail.gmail.com>
Subject: git-grep's "-z" option misbehaves in subdirectory
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

It seems that `git-grep -lz` behaves differently depending on whether
it is inside a subdirectory:

$ mkdir demo
$ cd demo
$ git init
$ echo content > 'an "example".txt'
$ mkdir nested
$ echo content > 'nested/other "example".txt'
$ git add .
$ git commit -m Initial
$ git grep -lz content
an "example".txt^@nested/other "example".txt^@

Note that, as expected, the files are NUL-terminated and not wrapped
in quotes. ("^@" represents NUL byte.)

$ cd nested
$ git grep -lz content
"other \"example\".txt"^@

As soon as we move into a subdirectory, files are wrapped in quotes
and contain escapes, despite the "-z" switch. git-ls-files doesn't
exhibit this behavior:

$ git ls-files -z
other "example".txt

And git-grep doesn't either, if you pass "--full-name":

$ git grep -lz --full-name content
nested/other "example".txt^@

Seeing this on Git v2.25.0 on macOS (10.13.6).

Does this seem like a bug, or expected behavior?

Cheers,
Greg
