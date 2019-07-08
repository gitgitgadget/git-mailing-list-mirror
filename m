Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36DAE1F461
	for <e@80x24.org>; Mon,  8 Jul 2019 05:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfGHFDO (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 01:03:14 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46400 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfGHFDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 01:03:14 -0400
Received: by mail-wr1-f42.google.com with SMTP id z1so10824425wru.13
        for <git@vger.kernel.org>; Sun, 07 Jul 2019 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=SSibkmBzwwRCgzhjvmhGTZLTjWiOwIdgPXQMaGgc0xk=;
        b=bz8rNjStu3kacoxChuBFRnZoABo5g8wDpzeqKsk/su4fv1ZoQ2mF9VFQweZMBXkZz7
         XUCdU4QhcufIpfDDXR9KLEeKk+GxZAmZIyyTJCxrIJKqL5xEGhG6OqipyY+ovjfEGdVc
         KieJU38pbohp/cxxDPo9W0CjzZx7S2eaLLFp36ePkRB/ehPjfxBq9WOq+bWeQNBvJ8hj
         O7TKmhin9iHiXCNBbjmaPinn9b/QhNjLJHn7VnEA6q2UN2ptpi5rDXD5ibPhyChDTqrx
         JSEVtR4rs997kAboEbwNYTCIQRMr5YeeXr/tSRskT+y7UyAfpq0x5UVsBaUV5gCgY9Il
         cudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SSibkmBzwwRCgzhjvmhGTZLTjWiOwIdgPXQMaGgc0xk=;
        b=Uz/reUTpWMTUWj5uVRBuUF2kR9Vl8Qle2Lfp46CC1gPRbC0F4OTMITg6oPCJiQqwg+
         6H4DWZnQ8T3RApQP2VcoU54VkYyTSOeDpbtd/CYB0fF5gHYu+rsMDtdgDxtWsgRxtMuq
         c0wJEZzYEPDV0KMTcTtqtskTJdskKANUR+LeN/zK6zwLygaSeoVa+VysOIy/x70qQ8Jo
         Se4l2QP6Mf+OsX9vCmKOWmEEP4XCu+aqCin23tE7YpO0JFM1q1Dn5UDQIPe30S7rNRbt
         1Tm69T2s2Uxy8acNRWxvvyrwB3v2i8X3AW0msa6W8lHXKi0jyDjebQcuV4jsvZjzgf/Y
         FsDQ==
X-Gm-Message-State: APjAAAWFCGOjFC1j4wEzIffviNcBFFbYEb9fZx+w7ou9/q7y70bjrFP5
        pjqQTr+OxntBRxcb/galYlPmUCzq8zxtOKIAXoPkJ//tD94=
X-Google-Smtp-Source: APXvYqy4+tLEjjfCLkZjkxw9ENDbTbvVPxDJlzCFBOVWsaYU4GkuygUblxrKgP5WmoIk0HMIsBBmvsQLoc3sJ3ey63s=
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr16585463wrw.131.1562562190641;
 Sun, 07 Jul 2019 22:03:10 -0700 (PDT)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Sun, 7 Jul 2019 22:03:01 -0700
Message-ID: <CA+dzEBmmSmPWvK6ZKNiyH18V+HdTd+XMtq9TsSsDHorNThtGcA@mail.gmail.com>
Subject: `git describe` skipping shallow fetched (grafted) tag
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't been able to boil this down to a minimal reproduction yet
but here's my current reproduction -- I'm very confused by the output
I've gathered so far:

```
rm -rf repo1
git init repo1
cd repo1
git remote add origin https://github.com/asottile/pyupgrade
git -c protocol.version=2 fetch origin v1.20.1 --depth=1
git fetch
git describe origin/master --debug --tags
```

```
+ git --version
git version 2.20.1 (Apple Git-117)
+ rm -rf repo1
+ git init repo1
Initialized empty Git repository in /private/tmp/x/repo1/.git/
+ cd repo1
+ git remote add origin https://github.com/asottile/pyupgrade
+ git -c protocol.version=2 fetch origin v1.20.1 --depth=1
remote: Enumerating objects: 38, done.
remote: Counting objects: 100% (38/38), done.
remote: Compressing objects: 100% (32/32), done.
remote: Total 38 (delta 4), reused 27 (delta 3), pack-reused 0
Unpacking objects: 100% (38/38), done.
From https://github.com/asottile/pyupgrade
 * tag               v1.20.1    -> FETCH_HEAD
+ git fetch
remote: Enumerating objects: 1195, done.
remote: Counting objects: 100% (1195/1195), done.
remote: Compressing objects: 100% (436/436), done.
remote: Total 1195 (delta 753), reused 1188 (delta 748), pack-reused 0
Receiving objects: 100% (1195/1195), 290.55 KiB | 3.09 MiB/s, done.
Resolving deltas: 100% (753/753), done.
From https://github.com/asottile/pyupgrade
 * [new branch]      binary_literals -> origin/binary_literals
 * [new branch]      master          -> origin/master
 * [new tag]         v1.20.1         -> v1.20.1
 * [new tag]         v0.0.0          -> v0.0.0
 * [new tag]         v1.0.0          -> v1.0.0
 * [new tag]         v1.0.1          -> v1.0.1
 * [new tag]         v1.0.2          -> v1.0.2
 * [new tag]         v1.0.3          -> v1.0.3
 * [new tag]         v1.0.4          -> v1.0.4
 * [new tag]         v1.0.5          -> v1.0.5
 * [new tag]         v1.0.6          -> v1.0.6
 * [new tag]         v1.1.0          -> v1.1.0
 * [new tag]         v1.1.1          -> v1.1.1
 * [new tag]         v1.1.2          -> v1.1.2
 * [new tag]         v1.1.2-1        -> v1.1.2-1
 * [new tag]         v1.1.3          -> v1.1.3
 * [new tag]         v1.1.4          -> v1.1.4
 * [new tag]         v1.10.0         -> v1.10.0
 * [new tag]         v1.10.1         -> v1.10.1
 * [new tag]         v1.11.0         -> v1.11.0
 * [new tag]         v1.11.1         -> v1.11.1
 * [new tag]         v1.11.2         -> v1.11.2
 * [new tag]         v1.11.3         -> v1.11.3
 * [new tag]         v1.12.0         -> v1.12.0
 * [new tag]         v1.13.0         -> v1.13.0
 * [new tag]         v1.14.0         -> v1.14.0
 * [new tag]         v1.15.0         -> v1.15.0
 * [new tag]         v1.16.0         -> v1.16.0
 * [new tag]         v1.16.1         -> v1.16.1
 * [new tag]         v1.16.2         -> v1.16.2
 * [new tag]         v1.16.3         -> v1.16.3
 * [new tag]         v1.17.0         -> v1.17.0
 * [new tag]         v1.17.1         -> v1.17.1
 * [new tag]         v1.18.0         -> v1.18.0
 * [new tag]         v1.19.0         -> v1.19.0
 * [new tag]         v1.2.0          -> v1.2.0
 * [new tag]         v1.20.0         -> v1.20.0
 * [new tag]         v1.3.0          -> v1.3.0
 * [new tag]         v1.3.1          -> v1.3.1
 * [new tag]         v1.4.0          -> v1.4.0
 * [new tag]         v1.5.0          -> v1.5.0
 * [new tag]         v1.5.1          -> v1.5.1
 * [new tag]         v1.6.0          -> v1.6.0
 * [new tag]         v1.6.1          -> v1.6.1
 * [new tag]         v1.7.0          -> v1.7.0
 * [new tag]         v1.8.0          -> v1.8.0
 * [new tag]         v1.9.0          -> v1.9.0
 * [new tag]         v1.9.1          -> v1.9.1
+ git describe origin/master --debug --tags --abbrev=0
describe origin/master
No exact match on refs or tags, searching to describe
 lightweight        6 v1.20.0
 lightweight       26 v1.19.0
 lightweight       41 v1.18.0
 lightweight       63 v1.17.1
 lightweight       68 v1.17.0
 lightweight       76 v1.16.3
 lightweight       79 v1.16.2
 lightweight       82 v1.16.1
 lightweight       87 v1.16.0
 lightweight       99 v1.20.1
traversed 101 commits
more than 10 tags found; listed 10 most recent
gave up search at eff26acd6261727e049449e2aa481db4c8146d21
v1.20.0
```

If I inspect the history using `git log` inside of `repo1`:

```
$ git log origin/master --decorate --oneline | head -10
3c13b24 (origin/master) Merge pull request #184 from mxr/typing-bugs
a5bfb80 Fix type annotation
91815ae Merge pull request #183 from asottile/parenthesized_format
38f1bcb (grafted, tag: v1.20.1) v1.20.1
559bc04 Utilize rfind_string_parts to improve .format() rewrite
72575fe simplify _get_body test
c93c34e (tag: v1.20.0) v1.20.0
9bc6390 Merge pull request #181 from asottile/numeric_fixes_in_py3
6df0901 Also fix octal / long literals in python 3
14a7c6a Merge pull request #180 from asottile/stdin
```

I see the `grafted` tag appear sooner in the history than the
non-grafted tag, but `git describe` doesn't find it.

real-world issue: https://github.com/pre-commit/pre-commit/issues/1076

Anthony
