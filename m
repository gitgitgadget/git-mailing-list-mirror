Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1FD8200B9
	for <e@80x24.org>; Sat,  5 May 2018 20:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeEEU1J (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 16:27:09 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33728 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeEEU1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 16:27:07 -0400
Received: by mail-wm0-f43.google.com with SMTP id x12-v6so10956978wmc.0
        for <git@vger.kernel.org>; Sat, 05 May 2018 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fr8FZexxsBTyj2lIXsvZoRGTwubuaUyJDlFbKJhd2oI=;
        b=O4r3IUDRzFMq40+rMZ+ZHF1jOuYHJV32ANRIZKF1trQwNeFw14mWXKixjAWRVKJOau
         QlA9RdjeAWZptloAkFBLzUXHktg4mRlUMaeB/OsMs/BINq2uTdDfzbhe6mQwLJEGwo/W
         4JawtotZbRb/BVMdMVilESC5NqE4IJ+gZOdd7aG8CwDgsGkORb/fGk9sxs+0izN6Uy+j
         GTDAohQiR01xjOXatWIFX0jsajIi04JlPV10cXBiOwFdqbJn+m0/9sA8OjxMhP/I7Mr5
         Ran5cs2vwGRqK57wxkM/RKuvh4MLViyxXGmL7o/DVaLSbBMcCjwIe2u1IPjQZiCTYpvK
         Fh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fr8FZexxsBTyj2lIXsvZoRGTwubuaUyJDlFbKJhd2oI=;
        b=XThgvDx/yzc89oAsVW9u4nsFGIrKx1nikjsj/eDVAx3/G/R61vxW05n2RXUJzrOaJ9
         8kCKGXYfjTtPIp/7kBncR3j6jOLK9fumOLUalbCYi7yTXoSyjFBkEXgSh0/51RlT3VRl
         aLJinfB4BJlUBEGl46NZDkC7gKEPturyLajpDIV+6uqOHCFfNSyCnzreFUaWV6siHT50
         tQxzUv8gAU0EvOikXc2RjqzRCW/1x5ed9/Uyuif/7VqCP9PgIdTmO1H9b9B2lmqm9wrR
         UlW8o4DUrmcxcXVNXy3snjK1sdhiXnsoFbSsCV9jpJgTodYy8+bPiBCAPEoq0sXzww5+
         nJCA==
X-Gm-Message-State: ALQs6tDsrV7+XRTM3zIB8FjSgQ/e2aFZB4OHaONwlu58HSN9dWw0X7at
        +5GRMWWG+DUlZ8QNeMFmzyr9gHTRMJULiSKyHQPQFR5d
X-Google-Smtp-Source: AB8JxZoYe1Dv7lrkJOduDSmiPIIw7kojGPsyApscffm0LlGk3Ldgc/s5gNU1L1Fwjq/sBSDrp3gC60mH4W34OXtp89I=
X-Received: by 10.28.147.131 with SMTP id v125mr20658200wmd.58.1525552025702;
 Sat, 05 May 2018 13:27:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.152.138 with HTTP; Sat, 5 May 2018 13:26:45 -0700 (PDT)
From:   Ilya Kantor <iliakan@gmail.com>
Date:   Sat, 5 May 2018 23:26:45 +0300
Message-ID: <CAFU8umjvEATZguGDmcRMcfAkqn4LW7vf_B9qpLD7uc-E_7qR9g@mail.gmail.com>
Subject: cherry-pick --no-commit does not work well with --continue in case of conflicts
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Somewhy cherry-pick --no-commit does not work well with --continue.

Let's say I'm copying changes w/o committing and get a conflict:

> git cherry-pick -n master..feature
error: could not apply 2c11f12... Run work

Then I fix the conflict, but cherry-pick refuses to go on:

> git add .
> git cherry-pick --continue
error: your local changes would be overwritten by cherry-pick.
fatal: cherry-pick failed

It could continue *if* I committed, but I'm --no-commit for a reason,
so I shouldn't have to commit to go on with cherry-pick.

Maybe there's a preliminary check that prevents --continue and should be fixed?

---
Best Regards,
Ilya Kantor
