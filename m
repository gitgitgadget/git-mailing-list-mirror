Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB53C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 13:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbjAINh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 08:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbjAINh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 08:37:27 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143F3E0FF
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 05:35:19 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id az20so1057861ejc.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 05:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ip6h/ABhQLJb7wJrKyzxbAhbqRQ09YnkWOMyJiwtIRw=;
        b=W5kJB3wuw5Y+5vUTIXOwfSRX55L9vs5V0gS6APb+h8iADoCdoMCqSN3+TWwi7tmLK6
         Y1DK9xtFs/vGcZou+jfi4SsUPyagsJBQyDlreQHfeXWy+fvNw3ULYyvl3wwKi0+7Vqws
         CuKLTxQj5KiVqvMDhp+PR4FlytGgEP/e6oSTKBYJKcAbQ5OXDGmAbUg2zgGz/zolsmrF
         a20dHnptH0bVAS8fMML/dKcj5jy6gG3hzHRvMPjeYoGRnwnKrplBBEijSN8SEvchFYHN
         kz8EUkD4/CKV4hizpOjZDGR8+slT024W0LUXFLxcGW4zpth8/oQqWcfLDG+oVxn4UG7f
         ZFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ip6h/ABhQLJb7wJrKyzxbAhbqRQ09YnkWOMyJiwtIRw=;
        b=I5a4UNYqWPRo9WsNKWXNA0iu4JEXRY9lr+H3S/LnqLcxdww7Od+3oEcZg0xKsjU6r7
         2zljHlRaF81Uck5dw83vG87qwM6b9XpcuFbStKDwp73F3S/9TVQ/RElIoIIDeFVyLhgY
         UvBmcXjxYzXjVLde6X3mOxxuhvzYR08XP4nJKUEO1SA30jxauU6dzOPM6ooLNZ6/Ipnx
         LRd1PrldeRCzCNbzGmj3SreESCUawVsrsN+LO9BuiayrBsxGMwHJeclbqlsfqP9FUrdp
         G/kGtG4aQUm6o/x/tnoKRva9fuAxl2K6b47rMEokZPS1EgEU8q/HZyPTFcKzCOfXbdgI
         W9TQ==
X-Gm-Message-State: AFqh2krvCGD+VXCzzezdiE4ilVlmrkzvOvygSSmEhBE42PjzU1cpfMv2
        k3/1QPmkpc2duVU7Y0IgU8rqwSXXcIlymFRFeuzbWMXyMorXQA==
X-Google-Smtp-Source: AMrXdXsPhyimfhjm8TGJs2F4z5mua9xrfbMBP9em712bkIJRQaciLY3k4t/IpZ2WxZav3CNf3WwXtl/uPXTkNXBYKkI=
X-Received: by 2002:a17:906:4684:b0:7c0:efba:a8c6 with SMTP id
 a4-20020a170906468400b007c0efbaa8c6mr3895439ejr.632.1673271316951; Mon, 09
 Jan 2023 05:35:16 -0800 (PST)
MIME-Version: 1.0
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Mon, 9 Jan 2023 14:35:05 +0100
Message-ID: <CAHGBnuOcNb0niPThM9gtmoJui+bz1mmhKXjUn71P3Q53aM-HLA@mail.gmail.com>
Subject: How to debug "fatal: external diff died, stopping at ..."?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

similar to this [1] question on StackOverflow, ever since a
distribution upgrade of my Fedora Linux box (KDE spin, now on release
37), my configured diff / merge tool (Beyond Compare 4) crashes with
"fatal: external diff died, stopping at ..." after displaying the diff
for the first file, for every operation I've tried so far (including
resolving merge conflicts). I've also posted to the Beyond Compare
forums [2], but the people from Scooter Software seem to be clueless
as well.

Would anyone have an idea how to debug this?

PS: I also tried to use an X11 instead of a Wayland session with KDE /
Plasma, but that did not help.

[1]: https://askubuntu.com/questions/1437667/git-difftool-with-meld-broken-after-update-to-22-04-fatal-external-diff-died
[2]: https://forum.scootersoftware.com/forum/beyond-compare-4-discussion/linux-aa/88824-bc4-as-a-git-merge-tool-says-fatal-external-diff-died

-- 
Sebastian Schuberth
