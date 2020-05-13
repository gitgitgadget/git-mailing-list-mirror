Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6B0C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4446A2053B
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfoSc9w+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbgEMXvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 19:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732456AbgEMXvr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 19:51:47 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A65C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 16:51:47 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id p123so337118oop.12
        for <git@vger.kernel.org>; Wed, 13 May 2020 16:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:message-id:date:to:mime-version;
        bh=T9wFvsZpaZGQyqO7+gyCKhSSOGi5PG7zwgGPXm7wr+A=;
        b=YfoSc9w+xXq08YFHYk6zxla1oq0H4MMRnisHsKKPK0M2loVW8K4LFLG2DJXufwxfJo
         CXrUpzcLrosEvvjTnQfz+qB6ScJZv2F0e3MMSTKhwkocq3SvAz+2tl9DYEMBzORtdMdN
         XpDgzUqlu3vYgr53zRQWTB3U34tEfHEKJIvCD+biyXpyBI/FNWcMgCF/aAOOzOTTQTzC
         J1sLqRQtxYMbW1wTFNxI9uaw9qqdMyuByRR3SEA31yzslmq0gpfKagOOEuXm0Je2+LU5
         B77fze07p8V/fA6m6MNemX3cVM6snCkhIriEvRkcHe3zMa7tSRUVx2QwaTD5K3QKaMHW
         g8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:message-id:date:to:mime-version;
        bh=T9wFvsZpaZGQyqO7+gyCKhSSOGi5PG7zwgGPXm7wr+A=;
        b=N/xBoOXkSZMj97tZQMUg0KHg6B5iAor6aH6DAWQOkgvHsG8ng/ydxgiXCNwLo3lWnT
         A/idoiFmFlySZExPmcTolWQeGsjppVAgWIZjhku3FCbQ8vhDF2vhKYbkk2CiazYWi9hj
         9YHqi3EYUGJc94PRMs2X2xigVe4xWE/iXOdZnLj4ajp57D+ZdTJk1x/d275ECfNfeB2j
         Swk3od/cgGv3WQzM6EBucTzkisfMsmg0PLh6SLgoDgVpuPaPqKZi+1i7QbdYswT6klwj
         eYHHNyWgNVkPIDPYDVwmIEj2WHOdYV7q6wVM5fZjOsMXVNzUZBI0wzMnmtUNPkbF6PlN
         GMTg==
X-Gm-Message-State: AOAM531N5YUWuwQ4bZitgIdag5Yfn7Zu71DM3wrzNpdcO+24Wu7P50mP
        95yiWAk2D2jre9XlAOIPiutzMkEp
X-Google-Smtp-Source: ABdhPJztRWCFUwlgnytOC90ltNmOuxRNps2StQ8x4yvBBDnuleQFKMKOmIZPVnYiF2zYmXw6vb+xAw==
X-Received: by 2002:a4a:e2c5:: with SMTP id l5mr1494836oot.47.1589413906322;
        Wed, 13 May 2020 16:51:46 -0700 (PDT)
Received: from [192.168.1.6] ([71.221.150.3])
        by smtp.gmail.com with ESMTPSA id p17sm326120oot.17.2020.05.13.16.51.45
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 13 May 2020 16:51:45 -0700 (PDT)
From:   Mark Wartman <markwartman1@gmail.com>
Content-Type: multipart/mixed; boundary="Apple-Mail=_FD7C6175-700A-43AC-BCAD-6A2731C866B4"
Subject: How to Not Track .metadata
Message-Id: <DD111BBE-F04A-4E44-99FE-5672FF2934B5@gmail.com>
Date:   Wed, 13 May 2020 18:51:44 -0500
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_FD7C6175-700A-43AC-BCAD-6A2731C866B4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello,

In a sentence, I cannot get Git to not track a .metadata file.  How =
would I correct this?=20

Please see .txt files as the mail system would not allow me to mail it.

I can say that I did try running: git clean -n
I realize that the -n is for a dry run but it did not return anything =
anyway.

I am using:
git version 2.10.1 (Apple Git-78)
OS X El Capitan version 10.11.6 =20


Thanks,

Mark Wartman


--Apple-Mail=_FD7C6175-700A-43AC-BCAD-6A2731C866B4
Content-Disposition: attachment;
	filename=how-to-not-track.txt
Content-Type: text/plain;
	name="how-to-not-track.txt"
Content-Transfer-Encoding: quoted-printable



I have cloned a repository that a particular .metadata file was pushed =
too.  This .metadata file seems to be causing me many git conflicts and =
other issues with Eclipse.

So lets say I had a folder named rev.  I navigated into the folder rev =
which there was nothing in there to start with.  I ran the command:
git clone https://github.com/BenArayathel/0427Java.git

So now 0427Java lives inside of rev

Then inside of 0427Java there is folder called usf-batch-workspace

Inside of usf-batch-workspace are java projects that I and my fellow =
batch-mates work on.  I have a .gitignore in all three of:=20
java-project, usr-batch-workspace, and 0427Java and all three =
.gitignore=E2=80=99s are the same.

I suppose hierarchically it might look like:

rev   <---------( regular folder not tracked )
	0427Java
		usr-batch-workspace
			java-project

Inside my .gitignore I have used these:

/.metadata/
/usf-batch-workspace/.metadata/*
**/.metadata/*

# Created by https://www.gitignore.io/api/eclipse
# Edit at https://www.gitignore.io/?templates=3Declipse

### Eclipse ###
.metadata

# as well as the rest of the provided template





--Apple-Mail=_FD7C6175-700A-43AC-BCAD-6A2731C866B4--
