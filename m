Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083CDC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 18:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96A920720
	for <git@archiver.kernel.org>; Mon, 11 May 2020 18:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm+xAfcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgEKSC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 14:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729305AbgEKSC2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 14:02:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6780C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 11:02:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id a4so4917111pgc.0
        for <git@vger.kernel.org>; Mon, 11 May 2020 11:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=pr+2h27KCvicdrFyhGTDiGskP9SAy29abRRB1E9lYZQ=;
        b=Cm+xAfcunOok6yd+3tAQB9As1ubjoA4ilS63cbFdWY0dH0B5I1GGSH/DRyKQ08kyUj
         eoPk79bxIsid0wMNFJHeL28CdXr8zoCJbVgxpolIfdAUo55opRMQDeRCjuCy8C73VBNP
         mng5K37Dl1fbegvY9f1Q4fats9/MEOVQd8TW6QOLczV52bRh+bkmwBYlahTPdtD+KtRU
         PQNu3TGjeTvN3ItO2dYRQ2OstPIduhY43iTq33JtdpMVKO4yu6c+IogyGeeXj0UB0DsD
         bZ3522Uwmvu+yUiNlZpkf/XJ9dzYh0eAD1KlbDfuSG7/sqMUVIYMu+eMLLoRECdhr8C4
         c7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=pr+2h27KCvicdrFyhGTDiGskP9SAy29abRRB1E9lYZQ=;
        b=roe+ixk/G/r8bRwE1PBTdviiF+cL6Q4ZclltPIsbSAfIfOd6ag8hszdTtGr4ANTTI9
         6erznLJUzm1aGN3u6iotFoISpZ1LBHmBre7SKunv0Fvb6Ocu6oZVkkjQMmWfPxHdZY0i
         vNwfcmf/w9CoBrZYhzzq7FGSVoxPa7ZFfv6kBZySjW7m0l3HsPsbMONmEPcJ5EBNkjRK
         kgh8KjcW+v+Gy3RMaKOsKuijvKsczsTVd1uyCKmQnfUBj6GEgFJi/Wnfr6Joml25botK
         SWbh+RZobXhFb0R+EYel/5V0Fo8l28SInLpxziYJ44aPDtsdggpUizbE2ZRouHLB00ZQ
         S0Uw==
X-Gm-Message-State: AGi0PuaUQ6E8cOpsGJEjvRS4pJlQp5UQdknbrT5EunbZvWn6tyg3hk5D
        ZsaaDoltj85S9CnTECndPvN2PlU9AS8=
X-Google-Smtp-Source: APiQypJ30E4o6aaI7IpK/1Djbk41zIoGhyLMuR547rg+wquxUEU0g/+Tv0i/F/9V0iYliJGPP3GEhQ==
X-Received: by 2002:aa7:9af9:: with SMTP id y25mr17799141pfp.134.1589220146472;
        Mon, 11 May 2020 11:02:26 -0700 (PDT)
Received: from ?IPv6:2604:5500:c240:e300:3f:746f:474b:29f9? ([2604:5500:c240:e300:3f:746f:474b:29f9])
        by smtp.gmail.com with ESMTPSA id y29sm10031752pfq.162.2020.05.11.11.02.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 11:02:25 -0700 (PDT)
From:   Arno Gourdol <arno.gourdol@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Issue with commit a2b26ff "fsck: convert gitmodules url to URL passed
 to curl"
Message-Id: <8F92F354-BBDD-4629-98D4-A67E0A865397@gmail.com>
Date:   Mon, 11 May 2020 11:02:24 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have run into an issue that is preventing me from pushing commits to =
my GitHub repo. I believe the problem can be tracked down to this =
change:

=
https://github.com/git/git/commit/a2b26ffb1a81aa23dd14453f4db05d8fe24ee7cc=


This change introduced stricter validation and checking of the =
.gitmodules file.

The problem is that I had an invalid URL in my .gitmodules file (an =
extra "/" in "http://=E2=80=9C):

```
[submodule "packages/website/assets/tecendil-js"]
    path =3D packages/website/assets/tecendil-js
    url =3D https:///github.com/arnog/tecendil-js.git
    branch =3D master
```

However, I cannot commit a fix to this, as it gets rejected because the =
current .gitmodules is invalid. As a result I can no longer push commits =
to my repo.

Any suggestion on how to work around this?

(PS: I have attempted to contact GitHub about this, but haven=E2=80=99t =
heard back)

Best,
Arno.


