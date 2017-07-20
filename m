Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1BE220288
	for <e@80x24.org>; Thu, 20 Jul 2017 00:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbdGTAzG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 20:55:06 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35189 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932167AbdGTAzF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 20:55:05 -0400
Received: by mail-io0-f179.google.com with SMTP id p185so3337592iof.2
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 17:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tqCzJheY7h8Sx215rkmMQQJT3/Gzlmp6qGOMvW8onfg=;
        b=C+ZnhQvKF32GdH1KIqZ2tKxui0tqEU8A+kwunOuV7G9rPQW6n8IavxmRVdSt7eN8zZ
         MBq9jp2utdK3eK1R/A5qpVJeKrknBIOSUjJjkUReg7YUQwjiSphjr1niD8uQ785Zf4F7
         x79yo7ECTDmLhKeCN2FI5BHuyHJdJAOq7BkEF29sInaPVMv8pHpUAzoHCn0HXl3Dp4tr
         BfnQZMxQypzaQ/VQ6B0r836EsYaK+C4YOv5P80/MROEzY88b4MeKK0UGmxEFxj/gwa8z
         dWqN8ajlVKK64dAegSOjv9T3jxxlPn/0mftvNmo3dEesvGOpc5VNvZ6XyXsz9et6500c
         8sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tqCzJheY7h8Sx215rkmMQQJT3/Gzlmp6qGOMvW8onfg=;
        b=DMlidZVEzhtg2O7xx6h77g61KdcA14f016ujVRrPoZw/FqzyAh8cshf9n9GN4dyfe9
         gPD9lj90snG2hfOXVDTHrRrFNSpi6rcBiFqP+5pmv4cvdJUp3Z1ILEPBPehD0m2lJ5Bl
         AtQjiJj49vL0v8EGVZ/s8Vya4/i6EtXLI8wh8Nw4EIt+qmAxxK80Efi8r36KedbQJRxN
         D9cd9wfh4FM3ypNhH4TFwicjGFnOhU84yLxjkMeSxeiApmxX7RKVzkswohGfl/YMR9U1
         ReF8oca6tA2ltGU9kNOMqArtul4fD1HJ8+qvFlqZexsFSrkVwekXoGzAhftarkhsDcjW
         Y6Xg==
X-Gm-Message-State: AIVw112F/qmGd1iKuEF6uFRhx1lfWo9nyBayZ3b2tQGBaKFssBeY8Rix
        LHstUNaA2+QZdn0Kt4ufMbvuZ0rJ4g78
X-Received: by 10.107.148.135 with SMTP id w129mr1885754iod.234.1500512105056;
 Wed, 19 Jul 2017 17:55:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.43.106 with HTTP; Wed, 19 Jul 2017 17:54:44 -0700 (PDT)
From:   Tillson Galloway <tillson.galloway@gmail.com>
Date:   Wed, 19 Jul 2017 20:54:44 -0400
Message-ID: <CAO1QjAFGnK+riGT_ZffM_-=ymJm08U8adOfHV4wrhR9LJLhSAA@mail.gmail.com>
Subject: Bug Report - Segmentation Fault on "git add --all"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Context:
We currently have a git project with a root directory ("~/project")
for pipelines and deployment of a Node app, and then a subdirectory
("~/project/project-app").
After realizing that we didn't need the node app in a subdirectory, we
moved the full app into the root directory (using the mv command).

The Problem:
Our node_modules folder is being tracked by git (173MB) and was moved
into the root directory along with the other files.  After moving the
files, I ran "git add --all" in order to track the new files.  Rather
than the expected output of the (albeit very long) list of files, I
was presented with a segmentation fault error.

[1]    90837 segmentation fault  git add --all


Attempting to run other git commands (commit, add) now responds with:

fatal: Unable to create '/Users/tillson/project/.git/index.lock': File exists.

Running "git status" shows that git successfully tracked that the
original files within ~/project/project-app were deleted, but it did
not pick up the "newly created" files from moving.
Removing .git/index.lock (an empty file) allows for me to run "git
commit" but no changes are recorded ("no changes added to commit").
Running "git add --all" again causes a seg fault and repeats the
cycle.

I would assume that the cause of the seg fault was that node_modules
held too much data for git to be able to handle in one go.  I'm not
sure if this is considered a (likely at this point known) bug or if
it's just a caveat of using git.
I am admittedly not an expert with git, so if there is anything useful
(logs, config files, etc.) I can supply to help fix this, I'd be happy
to.

Thanks,
Tillson Galloway
