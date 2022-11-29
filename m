Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91162C433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 17:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbiK2REO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 12:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbiK2RD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 12:03:57 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1969F5E3C6
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 09:01:15 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q12so10195233pfn.10
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 09:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jeJ6fFECKtauDaxIOImwhun3RsxmmCGAuom3FmmDOw=;
        b=qw5iCy/Gojp+4w0P+HcdMciugs6Rc6IThfYVR+CJm+OUNt0q6rRDACK/wO4e8jLuSe
         c2vPahIYxIOFcwBMorY0ZR7vSRpZ+Mf6KwTS9EdhuOJ8a+ktUWEWJViZVN0cjN4kkOvd
         iWLVuHHVYgNK9v44tCArYmB+gKq2VTrgajRT1M3//Oh2dXCArqRUvcxMRAvXCOn++BfG
         9yQZ0KgIAz6DE8z+mCyAKypaFFaeqSVtMUo/nRQQo9A1nzNVN5p2TIJMSm4PzrA5y9BY
         IGuy9y8h77Nfw9TIMb9QGIOLXKMnDBsB9PQlGhef+QdwgVLiMiFQaMHjR8VgGCSCsDG8
         MsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jeJ6fFECKtauDaxIOImwhun3RsxmmCGAuom3FmmDOw=;
        b=o4GqP2gJKUev4qSNJ0D50KkvA9nCHmtXpo0Wgh+4+K2k6hOl/6rTO0tpM8g6sjtbyo
         Cd+XXYbzf3+CBhHZAk9bkJHVZDTIwK5jGWr0i99h5iGLqaXNLoD7HyPGKIhowjPqgERn
         qZDK+N/v+s7ZXSS9mJk8Uiyq74siLhT2YC1x4L00EGh2YhUWPS/ArJmlmuN7uQzI7TXu
         aoHDWSLMS1mKC8pvxBRmSWRLQgjZEyLAQCi+LEx0Q0B+8VLtDwxj5v7CjGg13BzSFCNt
         Y+vXC1v4yj/XhIvPOIP13rPCKSIFeWO6GBUdrd88wUT1ZhJy5V3aIJQA0v6SEpvvU89O
         hSzQ==
X-Gm-Message-State: ANoB5pnkiLk5jsnFbBzP8trX/swmADl/JTnmt1sbEocZJT9nu5hb/hWz
        Q++GheQnwCMW6xwGf3FtPBeqLKBU7AVgcndN4A5dv5xTUMpb8g==
X-Google-Smtp-Source: AA0mqf7LP88m7xchOscfwJlxCpsmfIEcfiUi63A6sd+zAN/Go9Tb+D8TNTnHHucK+7SkQusoFF+y8igmDZudOcPc0qQ=
X-Received: by 2002:a05:6a00:10cd:b0:567:546c:718b with SMTP id
 d13-20020a056a0010cd00b00567546c718bmr38313191pfu.17.1669741274171; Tue, 29
 Nov 2022 09:01:14 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 29 Nov 2022 12:01:01 -0500
Message-ID: <CAH8yC8niurChnXPrZSeBa7g1z5AF3PqYdf1X0Rm03rDanec6Gw@mail.gmail.com>
Subject: Git port to Debian SH4 may have trouble
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

This is a crummy bug report... I am  testing on Debian Unstable within
a SH4 Chroot. I'm seeing a hang during a git pull. Eventually I have
to CTRL+C, which results in "fatal: fetch-pack: invalid index-pack
output."

(sh4) debian-chroot:~# git clone -vv https://github.com/weidai11/cryptopp
Cloning into 'cryptopp'...
POST git-upload-pack (175 bytes)
want e9cbc4698a6b3ed067910862ad1355069f348d2b (HEAD)
want e9cbc4698a6b3ed067910862ad1355069f348d2b (refs/heads/master)
...
want 511806c0eba8ba5b5cedd4b4a814e96df92864a6 (refs/tags/CRYPTOPP_8_7_0)
POST git-upload-pack (gzip 1602 to 825 bytes)
remote: Enumerating objects: 28448, done.
remote: Counting objects: 100% (68/68), done.
remote: Compressing objects: 100% (50/50), done.
remote: Total 28448 (delta 29), reused 49 (delta 18), pack-reused 28380
Receiving objects: 100% (28448/28448), 27.01 MiB | 4.30 MiB/s, done.
Resolving deltas:   0% (0/20757)
^Cfatal: fetch-pack: invalid index-pack output
(sh4) debian-chroot:~#

(sh4) debian-chroot:~# git --version
git version 2.38.1

Jeff
