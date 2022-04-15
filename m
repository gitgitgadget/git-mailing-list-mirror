Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E6C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 10:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiDOKRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352156AbiDOKRK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 06:17:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF836B60
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 03:14:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ks6so14691433ejb.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=LClz0hHDGlSp5YV26yGJlEa1vNgfpQXeWY/BrLaxF5A=;
        b=Z7Nn5F8f8kEC5enzI0wcri9Adc+LsIzsLid11I9gik+M3J8gWdD39J/1grYDJgHFt/
         K8UDTGEf5SE7chwHt3c/w3FACWOHykUo+XOA/Cxkyh3T4Lz/sMBD9zBiMQ//EAExY8vu
         D9NIcM8igkm5BGRiTSlhnrdAU1qpwpyJye9O2/GGWAHaH+Kit7IoTOGe8y5Pxx+QUmkM
         SSf5QxWsWYaprXwJqRBU4pFy825NCdOYnSZ9XGva8vFjZi0W6XCJudnfphejJ+GKPNzY
         Z/Nu4LWxaDiwoDaKy0CIU5jsDHwsYLzlarZfpY4wfrecCV8BlmXiVc5jn9jJqcLv2Ul6
         IZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LClz0hHDGlSp5YV26yGJlEa1vNgfpQXeWY/BrLaxF5A=;
        b=vuawr52jGv+I5PWjQuT2LHkuhRkvt3+86BCnZ4DwF3dpfBnH9eCTjkB07+aSKJAhXK
         uvLl7Xgvm3Ks2E1fdw9laUvzzXUF9Lo851EGUtp9djRPB3wXuoQXdZZc5oAkreDWXIEW
         2rmwoJnkh0cKADENyWleLGkLnCPO9ZhONx9o2YeI1RiEwf2TI4FRCTU/nq/ffeTVU4LJ
         1TSJo/arUksiT4NzQGaLuKoUgjET8GqlpMrr0vGtlsuEKozqRAi8ImKQDC3euePP1f+Q
         38IEAWm03pV4KD471DMN96rUveltU7y8E6sJgWAjkScmtbQWif3GOvRRIwELTSbrfbES
         ELgw==
X-Gm-Message-State: AOAM531bQl2FRLb2Bs7KY3dnP4I9ryNqFfO1YERTqiH7oBJxEuEsnghh
        hBGXndsoGSbrDfmz0VSKMwfUfuajol0tNp25xv8NdtGGPSM=
X-Google-Smtp-Source: ABdhPJxvQA+wxwq1BNK9T26ySaZHsHaD2y5RQ4nGztwdtaVTEOzhrZI1am62HZvZHWmb4clF38fEYbQ9J7HvSpJa+pM=
X-Received: by 2002:a17:906:478b:b0:6db:8b6e:d5de with SMTP id
 cw11-20020a170906478b00b006db8b6ed5demr5916881ejc.161.1650017676850; Fri, 15
 Apr 2022 03:14:36 -0700 (PDT)
MIME-Version: 1.0
From:   Andrew Noblet <andrewbnoblet@gmail.com>
Date:   Fri, 15 Apr 2022 06:14:25 -0400
Message-ID: <CAO=QCg5+M-=dOf=AFTDL8z9-LrK-7vau+=JV-7QJfVOhdFp1Aw@mail.gmail.com>
Subject: safe directory on shared drives
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new git security rules creates an issue on Windows systems where
the git repository is hosted in a shared folder.

$ git status

```
fatal: unsafe repository ('//192.168.0.120/config/' is owned by someone else)
To add an exception for this directory, call:

        git config --global --add safe.directory //192.168.0.120/config/
```

$ git config --global --add safe.directory //192.168.0.120/config/
$ git status

```
warning: encountered old-style '//192.168.0.120/config/' that should
be '%(prefix)//192.168.0.120/config/'
fatal: unsafe repository ('//192.168.0.120/config/' is owned by someone else)
To add an exception for this directory, call:

        git config --global --add safe.directory //192.168.0.120/config/
```

There seems to be no way to add a shared drive path to the safe directory list.
