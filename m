Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA8F2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 17:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932669AbcKGR1N (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 12:27:13 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35618 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932314AbcKGR1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 12:27:12 -0500
Received: by mail-lf0-f49.google.com with SMTP id b14so119490090lfg.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 09:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=BbUwQBmqCTF1hFbvRhdVEM0Mowd4x44M41yv43TTc3E=;
        b=NE3vpoTgIE7AAXaCtzt/wORJ52cvKQ1DYD8cQWzaD7IlScsbChvZe7YvEceSCC7QLs
         jvVR0/ZVt789GVml9hJ8FykIHpPWw0FDKIMbeWMIZqjaCV9EmhKcUfVXyo7DF1CkzSLX
         lD/egfNp4tKjWuvfpab1NbogTrwf83t8aG0DFlw3HvhkD08g/hz2JcpP1u1OZgMEddmg
         oiA8MZFo/xXsrJOZIWOrvfuhHeP5IAMcT5F76NVJxXs+MrCgQxGKvyOfKKBsJleIRZoK
         V5oH8Vk8sAAsnwc5n65PfXbIjh1JcK1Ig/+wTi26Xrk2aw5jM7t1oMLDuSA7tlJSz/z4
         TQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BbUwQBmqCTF1hFbvRhdVEM0Mowd4x44M41yv43TTc3E=;
        b=YkRONw/v6DgO26cfvnlwnbEYe1RHkm1qr8d5jv3UpuM9CbZ8dyLzhAxT9FmkI+UBN8
         G1Zjm2pV+HVqNJ2qVVnuNC2gs4/hCsXjlbvc8WEIML66CxPmzZpCDt03eKOn31mYbLwz
         Q2Cjf8wvLhC5R7GPqXmXT2O2autpb5YX8lROc9n9toqVgOidu+5tG1IigXUIYA/wwu/7
         VqtM5hfH55lVPc4L6vemIkZhRToLsWvCGZHV3ssgQeOoQBfmPT2ciGLy+HsJiTwBMOUl
         ZWsoV5ReVBYhrofCUv0pLaqIMMxs1gZcWzVegYxrXHtlXYICpphRQ7Htr8sbrCAG5r8Z
         TQNg==
X-Gm-Message-State: ABUngveId8uNTUbsGN9M5DLh542hGVqHmk5OWx+kuX54STLVJgGhlvhhq4htNKPwJeNF+PWjeQ2oseDLAkRMS3Tw
X-Received: by 10.25.205.17 with SMTP id d17mr4778606lfg.29.1478539630488;
 Mon, 07 Nov 2016 09:27:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.198.143 with HTTP; Mon, 7 Nov 2016 09:27:10 -0800 (PST)
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 7 Nov 2016 09:27:10 -0800
Message-ID: <CA+dzEBmP2aUit00ukJyQeg=iqUJJLVaovafo2gngf9MvEqZDPA@mail.gmail.com>
Subject: git submodule add broken (2.11.0-rc1): Cannot open git-sh-i18n
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noticed as part of my automated tests here:
https://travis-ci.org/pre-commit/pre-commit/jobs/173957051

Minimal reproduction:

rm -rf /tmp/git /tmp/foo /tmp/bar
git clone git://github.com/git/git --depth 1 /tmp/git
pushd /tmp/git
make -j 8
popd
export PATH="/tmp/git:$PATH"
git init /tmp/foo
git init /tmp/bar
cd /tmp/foo
git submodule add /tmp/bar baz

Output:

$ rm -rf /tmp/git /tmp/foo /tmp/bar
$ git clone git://github.com/git/git --depth 1 /tmp/git
Cloning into '/tmp/git'...
remote: Counting objects: 3074, done.
remote: Compressing objects: 100% (2735/2735), done.
remote: Total 3074 (delta 249), reused 1871 (delta 215), pack-reused 0
Receiving objects: 100% (3074/3074), 6.38 MiB | 905.00 KiB/s, done.
Resolving deltas: 100% (249/249), done.
Checking connectivity... done.
$ pushd /tmp/git
/tmp/git /tmp
$ make -j 8
GIT_VERSION = 2.11.0-rc0

... lots of make output ...

$ popd
/tmp
$ export PATH="/tmp/git:$PATH"
$ git init /tmp/foo
warning: templates not found /home/asottile/share/git-core/templates
Initialized empty Git repository in /tmp/foo/.git/
$ git init /tmp/bar
warning: templates not found /home/asottile/share/git-core/templates
Initialized empty Git repository in /tmp/bar/.git/
$ cd /tmp/foo
$ git submodule add /tmp/bar baz
/tmp/git/git-submodule: 46: .: Can't open
/home/asottile/libexec/git-core/git-sh-i18n
$ echo $?
2


Thanks

Anthony
