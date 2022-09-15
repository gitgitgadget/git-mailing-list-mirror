Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A25AECAAD3
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 01:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIOBrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 21:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIOBrD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 21:47:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2F38E448
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 18:47:03 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 130so25458070ybw.8
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 18:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=nNwN6cZbnOW8sBCvdih+a/9zR+eSjldxjE038yTiin4=;
        b=KxoMGWB0nrYOdKeDAj3oOnz0wIxIvuxh6vlbV3J0uvgBXdO/xVKRVbsEjMoa7CZVHH
         ZE6Hz6X5hjWGzdoVN/l30Xvapc2xWsf7YZf6cqxv/7lIy4MR06bs8CjdYUBPkSCB4hu1
         W9deU99NSA5oLFqT+uJ4dKHpwPMGAyNX2p+4fN30NugVfbLlfb3IavhIZkr6F+0OtnHu
         /ha6nLya/Mqj+Oq9gTtUjEj8Yr33nEfNDwz+K2gaWiKiimCzALn8q/2jvcO0JMFSTE45
         S9knbjS5BJm1eiPtEfFyfc0hdKrEl2mXUvIQenaDGvO8wpynZf8axNPNxsV5lLV3Fx4L
         v8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=nNwN6cZbnOW8sBCvdih+a/9zR+eSjldxjE038yTiin4=;
        b=wTZac+Z3NDPwelVxQkMJxkOMqAwxjlbRuUi5ExnaEQm9CxoOZ6iT5I7ZlwKPJWG1S5
         QUs0hzCr0M31Zbrh4fWJb6olRWJxLsQo5YJCRkNYBkEYR0R0IvV+BkjxcAbUPEvd/YMT
         0p7FCSicB+tbqqZGnG/1Uw/3RxVaPuMHeBcmd2OAOmwPCH3r0DS6XYeaI5L9c0T928VD
         gZQvRCqG9sWFbkcfSiYneto5PTtcAr3kARjkQ64rjv//o2U+5xWFpvYzlf6fyjmXi/bh
         cS2ELzjVR/AxzurFUUrfqtQJhStZVLjprUsG1ncGaWH1KIClvONWaqc1iGITlWy1jADl
         L93w==
X-Gm-Message-State: ACgBeo2TSXn/Kd6ulo2wlZbZSan1dNJn1GzLoCf5BH9lfhXlJY+vEEyj
        GJDPEnmtoEuFSeWmaBrUFyhNqriv1dhSbBIBhYGk2nQPzMGhXQ==
X-Google-Smtp-Source: AA6agR7b12ZKa97BDoevS8n7W6O/u0BSNpx7KmStBCqzZVvqBNRpv96uv41+uFwYhdnumzDcyNBYW6je4E8v0jb41T4=
X-Received: by 2002:a05:6902:1001:b0:67b:53f9:df37 with SMTP id
 w1-20020a056902100100b0067b53f9df37mr33899479ybt.240.1663206422162; Wed, 14
 Sep 2022 18:47:02 -0700 (PDT)
MIME-Version: 1.0
From:   Brijesh Patel <bridgepatel@gmail.com>
Date:   Thu, 15 Sep 2022 13:46:50 +1200
Message-ID: <CACs=J2MLnawNF5mp19sCJAZADPenHjWVZvKW5rM1fwELHjqqyg@mail.gmail.com>
Subject: BUG: Value for GIT_SSL_NO_VERIFY has no effect
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

It appears that any value assigned to GIT_SSL_NO_VERIFY (true or
false) has no effect on the GIT operations. For testing purposes, we
have created a host entry for github.com and mapped it to foo.com.

Step 1: Clone the repo with default configuration.

git clone https://foo.com/bridgepate/gs_auto_provision.git
Cloning into 'gs_auto_provision'...
fatal: unable to access
'https://foo.com/bridgepate/gs_auto_provision.git/': SSL: certificate
subject name (github.com) does not match target host name 'foo.com'

As expected, the above fails with SSL certificate error.

Step 2:  Clone with GIT_SSL_NO_VERIFY set to true

GIT_SSL_NO_VERIFY=true git clone
https://foo.com/bridgepate/gs_auto_provision.git
Cloning into 'gs_auto_provision'...
warning: redirecting to https://github.com/bridgepate/gs_auto_provision.git/
remote: Enumerating objects: 244, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 244 (delta 0), reused 1 (delta 0), pack-reused 241
Receiving objects: 100% (244/244), 108.75 KiB | 611.00 KiB/s, done.
Resolving deltas: 100% (131/131), done.

The above works as expected.

Step 3:  Clone with GIT_SSL_NO_VERIFY to false

GIT_SSL_NO_VERIFY=false git clone
https://foo.com/bridgepate/gs_auto_provision.git
Cloning into 'gs_auto_provision'...
warning: redirecting to https://github.com/bridgepate/gs_auto_provision.git/
remote: Enumerating objects: 244, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 244 (delta 0), reused 1 (delta 0), pack-reused 241
Receiving objects: 100% (244/244), 108.75 KiB | 1.38 MiB/s, done.
Resolving deltas: 100% (131/131), done.

We expect the above to fail as we saw in step 1, but it succeeded.
This shows that the value for this environment variable is ignored.

Following is the platform details

OS: Ubuntu 22.04.1 LTS
GIT: git version 2.34.1

Thanks in advance

Brijesh Patel
