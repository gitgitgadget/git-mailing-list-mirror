Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5DCC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF4020720
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 21:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpGJTbEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgGGVZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgGGVZO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 17:25:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DD1C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 14:25:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a6so2558982wmm.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bDBibc/9tNprOYl6jrnZM1GlRb/CC1BkyCzQvjlT5jU=;
        b=FpGJTbEJ51GusRJAnUbysywUQBxYhlOBnGZR1mrYvEAbzmrnieYJOFtE8XNo0K87+I
         lUGzyuaLYSScG4j/5rU5X5GTIxSrwo1fG06UzAtxi/cW3qHHx+H48RDLlukhM9em1aQG
         N71XQj2bw6cmFIptGKlg0hYr/Kt5ZNlqbpeRMisu+/2BvEUNASmc4HA+8nriimy097R8
         fmGVUAhS/KGSztmxckDfc/JGdhE1cmqFE+4GFEDs7ibrcqsE8SzSkb3+0CZ4Z6OPavIY
         D7E8vaAsGYa2JP9YcwJsv3xZLE4A6KVGVqzKRJhmIC/OjxyUgpKDduH7IOcCgcRhqWnN
         UbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bDBibc/9tNprOYl6jrnZM1GlRb/CC1BkyCzQvjlT5jU=;
        b=juxnvjCJJELSscJiO8p1+KXIiWdkKnpBWEUwJZn5Rr/Z7sirczxr5xOuCJ1xPbKZBu
         JGbuGpGn4pLb2F49CiEjRUfa2B4Y0oLFZmyn+5JKxWJL3soAuDSfBC5UEAG8D6UYI4PJ
         AkEnSiOWbd1M+DZuux4KXrJAmlzjTgbaM1ElfYMd3Zv4bch9fkL2xWlgtrMTRj9ruuMX
         FW4IS6lxdQvA2uR+w+gaFiTMG8wDh7riw+MUz+qnRNTVglyrJSMJlDuNDbElQi9lu+Do
         1KxtPWmwwCtIQJ65Ya46et5hIqffrXXxrhYbMJTYERc9nBU14o4olsA7+2xFBYBWMBHa
         PvAw==
X-Gm-Message-State: AOAM530hVMpA+eSQy63AKe/QwdFzoCv54nOUuqsKUdFBw9+CKsScBf6D
        uBYE9CREexjcdQzT+Kz8+Mt8pyb1wNGTDrYacZvIFjg9
X-Google-Smtp-Source: ABdhPJy2C7fzeyXt0g7HfOoIZPzGqK4fYdqu68KxHf/LiA1i1+kdEGhgKOAPlwhVmqQzb5lBO1w/9orWM6ViVf0yoTc=
X-Received: by 2002:a1c:1b0d:: with SMTP id b13mr5824399wmb.169.1594157112426;
 Tue, 07 Jul 2020 14:25:12 -0700 (PDT)
MIME-Version: 1.0
From:   Zach Riggle <zachriggle@gmail.com>
Date:   Tue, 7 Jul 2020 16:25:01 -0500
Message-ID: <CAMP9c5nUteg_HouuYJZtq7g4MrSE638mns=HeKhNpNTYgQB4=w@mail.gmail.com>
Subject: git grep --threads 12 --textconv is effectively single-threaded
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like the bit of code that is responsible for performing
textconv conversions is single-threaded, even if git-grep is provided
a number of threads to use.

This greatly limits the usability of textconv filters for grep
expressions over a large number of files.

Note the difference in total CPU usage in the following expressions:

$ git grep --threads 12 -e foobar --and -e fizzbuzz &> /dev/null
0.24s user 0.28s system 710% cpu 0.073 total

$ git grep --threads 12 -e foobar --and -e fizzbuzz --textconv &> /dev/null
0.90s user 1.75s system 110% cpu 2.390 total

$ git version
git version 2.27.0

Zach Riggle
