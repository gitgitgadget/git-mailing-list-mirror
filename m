Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30184C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0099A2072D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 09:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3/nq3tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437662AbgDNJcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437642AbgDNJcD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 05:32:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA06C0A3BD0
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 02:32:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn19so4978253pjb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gjUdO6y5VjJ440itC9vb4z1i9se0rdz8WYyFtwwU9c=;
        b=F3/nq3tAfhYIBcF+AtMrQIR/NXIPMt+9RL4dtam0QgdJPuMXNjCtDCaMn+zDUMuDGm
         5DPTf4lseDLawPB4wnMznBpAZRJsiVUyWhgJsHp9VNM+bso6caNsXrU3fuC12tKP1sTG
         GWhYChPkWO7XaZRc6VNqxrMlKSX7MOul1dmjn3rMcoP08a/txjx1Y1sX7oFSlpan8vgI
         jcixsU7Bc5KdeAgIzfntoHXRJ5R/vKOYnhsPi1JL/olwjXEHxwVLQmwKjIifhUTHL4RE
         qpynvUyr/rlmJtjZqSnUhRJwfEAL44P4yuhmNtmqZbYvrBybwztAqF80LE6FqEGOMYa5
         u5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gjUdO6y5VjJ440itC9vb4z1i9se0rdz8WYyFtwwU9c=;
        b=LWB0kmTaiex3ahlC5mU2WA78VKQj5lSHzKom30rMBVVOgNIugeiIrDUrFhP9DzL3t4
         8uBlFpOeWjM/w4hM43T4OH/kP2Cfqx0TeY9l8HozYmL9Fbu1yl7vVOeSCDDMqMAYRfVW
         iq7TtkHs9zhQzPqPVZWNfBnrpHMe+D3ZjfuZqOMxKyO3gE8uAAKh87OobgzKFwPH1ajh
         QKje9VLBRnBR1T9S8ZbD0v2KipOWTyIJZEGhoU0X9FDiaJaw2SgqEj7wYMzDki/FTG+1
         fU6dyiSGQ2w1QLGK6etbj6z5OmUlBIbomnjJ2itSjUXs4vYYuX+FG93f2G4rbzXtj15N
         hquw==
X-Gm-Message-State: AGi0PubxLiwnm5hI59AYMxzh60nwsoSUHCir9ELrIr0clTRtcbYnM0fs
        QYWJHoMlg/ipA4YHDg8blKX1brW0
X-Google-Smtp-Source: APiQypKDeiiGkwS4utYfjJAyPVlnVyjFI5o6cZPF6NonZucz4yYoPeSHXgHz1OoJUcGMrvPLaf+koA==
X-Received: by 2002:a17:90a:24a7:: with SMTP id i36mr18265864pje.32.1586856721331;
        Tue, 14 Apr 2020 02:32:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id mu15sm11881506pjb.30.2020.04.14.02.31.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 02:32:00 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/2] More ISO-8601 support
Date:   Tue, 14 Apr 2020 16:31:53 +0700
Message-Id: <cover.1586856398.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.485.g518673e55f
In-Reply-To: <20200414000324.GA2751707@camp.crustytoothpaste.net>
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-14 00:03:24+0000, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> git-commit(1) claims we support ISO 8601 format.  However, our
> approxidate code misparses some dates with fractional seconds.

We have never fully supported ISO-8601, those representation are
perfectly valid ISO-8601 (for 2020-04-14) but it would require
more code to parse correctly, perhap "tm_wday" and "tm_yday",
and mktime may help.

	2020-W16-2
	--04-14
	2020-105

I don't think not many people interested in those formats.
If someone really need them, we can get back to them later.

> Reproduction:
> 
>   git init foo
>   cd foo
>   echo abc > abc.txt
>   git add .
>   git commit --date="2020-04-03T12:43:55.019-04:00”
> 
> This should produce Fri Apr 3 12:43:55 2020 -0400, but actually produces
> Sun Apr 19 12:43:55 2020 +0000 (at least on my system, which uses UTC).
> Note the different date, which is 16 days away from what is expected.
> 
> Since we claim to support ISO 8601, we need to either reject fractional
> seconds with an error, or accept and ignore them.  If what we really
> support is RFC 3339 (which I suspect it is), we need to do the latter,
> since that profile explicitly permits them in the syntax, as well as
> update the documentation accordingly.
> 
> This was originally reported at
> https://stackoverflow.com/questions/61193896/how-does-git-parse-date-string/61197722.
> I don't plan to send a patch for this right now, but I wanted to make

If we plan on supporting more format from ISO-8601, these 2 patches
can be used.

Đoàn Trần Công Danh (2):
  date.c: allow fractional second part of ISO-8601
  date.c: allow compact version of ISO-8601 datetime

 date.c          | 20 ++++++++++++++++++++
 t/t0006-date.sh |  4 ++++
 2 files changed, 24 insertions(+)

-- 
2.26.0.485.g518673e55f

