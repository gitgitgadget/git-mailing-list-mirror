Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F3BC1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 23:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeDPXgV (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 19:36:21 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:45658 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeDPXgU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 19:36:20 -0400
Received: by mail-io0-f171.google.com with SMTP id a7so4282546ioc.12
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 16:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bPdJFqubyhzR04t3h+qKaw6pHlY9JdZBQpDZA/h7uMo=;
        b=oA8I4dzLYImGiRpXP+mDz+avrl0zq8CpBMy0jfEMpsWdIVOdAvSwe7PSacmstkUfb3
         r/d5hIuwZC31psZ+qsEOdMVAs5OBHkLe1xizHWakwd4pYEQVKN4JVOz3RT5wCwHiFRTr
         zvuhZRvBGTzYGT4N2T7J0tJBNTwfoxuQSJqB1+UusGgQ30LUmOotl7rgqIn+ApnNGVod
         P8DxEcUTyRohZvOPa8MqsMZDf0gSkV9mYwxowxwYQXv1WeFNHFZSXugujTRTst1pnXe/
         smfjFrd/Ol6rX6OpKmKLcBFJuf4bi/FJr9P6w4fpBxzhkPiMjmJylyj0O1YU7og1OvXc
         DZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bPdJFqubyhzR04t3h+qKaw6pHlY9JdZBQpDZA/h7uMo=;
        b=QcHNonQoq8O/6BAxGZhl0h6e4NwuDDkuqWVlZLgQ9XsaQm/lsRhvhkuWOYFYV2RbO2
         aXgYyxNrlFtK1QQcNN/ZHvntn8nhKpFPmtsHzNaVSzTV5E76j4R9nK+j1r1hZbsdTHVZ
         i4AqVeK3/kXX4n3zlzjTjvxjmFBJVskav3t2lDyBfQFN4aaRF5Tgvo/mUkoY/Xn8Vm+d
         BiNDCDRuDCEwoZsDAReEObpAJHiAruSQpXVYv5QWBBmZky4/nDk6I5bZFGESgjnph6Dd
         Tkw3qfrqD4q1KNjPM7DzpfOeXnugTpd15ETYV+T3xzVlnkYOECykqqy19vcFGl3QpWyu
         ILtw==
X-Gm-Message-State: ALQs6tCDim+9a/qAgGeWSy3O+nU61u3XPva7euwZKAtaXF3qFFUCOGMJ
        SeyvMB8JPWCpZ3XAKQV8N9QIsYd/Qwh0VYYc9IWa6w==
X-Google-Smtp-Source: AIpwx4+4kcknCWqAVZByGUcWd5CV48iMpDVv9tMOZObj9nRKSS716xsidQA28H4N/81lupBlyb4RE6xIS4IrldgoKzs=
X-Received: by 10.107.133.68 with SMTP id h65mr14092341iod.271.1523921779901;
 Mon, 16 Apr 2018 16:36:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.167.138 with HTTP; Mon, 16 Apr 2018 16:35:39 -0700 (PDT)
From:   Thandesha VK <thanvk@gmail.com>
Date:   Mon, 16 Apr 2018 16:35:39 -0700
Message-ID: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
Subject: [BUG] git p4 clone fails when p4 sizes does not return 'fileSize' key
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git p4 clone fails when p4 sizes does not return 'fileSize' key. There
are few cases when p4 sizes returens 0 size and with marshaled output,
it doesn=E2=80=99t return the fileSize attribute.

Here is the demonstration and potential fix



$ cd /tmp/git/



$ git remote -v

origin  https://github.com/git/git.git (fetch)

origin  https://github.com/git/git.git (push)



$ git branch  -v

* master fe0a9eaf3 Merge branch 'svn/authors-prog-2' of
git://bogomips.org/git-svn



Problem:



$ /tmp/git/git-p4.py clone //depot/<path>/@all   . =E2=80=93verbose

.

.

.

Traceback (most recent call last):

  File "/tmp/git/git-p4.py", line 3840, in <module>

    main()

  File "/tmp/git/git-p4.py", line 3834, in main

    if not cmd.run(args):

  File "/tmp/git/git-p4.py", line 3706, in run

    if not P4Sync.run(self, depotPaths):

  File "/tmp/git/git-p4.py", line 3568, in run

    self.importChanges(changes)

  File "/tmp/git/git-p4.py", line 3240, in importChanges

    self.initialParent)

  File "/tmp/git/git-p4.py", line 2858, in commit

    self.streamP4Files(files)

  File "/tmp/git/git-p4.py", line 2750, in streamP4Files

    cb=3DstreamP4FilesCbSelf)

  File "/tmp/git/git-p4.py", line 552, in p4CmdList

    cb(entry)

  File "/tmp/git/git-p4.py", line 2744, in streamP4FilesCbSelf

    self.streamP4FilesCb(entry)

  File "/tmp/git/git-p4.py", line 2692, in streamP4FilesCb

    self.streamOneP4File(self.stream_file, self.stream_contents)

  File "/tmp/git/git-p4.py", line 2569, in streamOneP4File

    size =3D int(self.stream_file['fileSize'])

KeyError: 'fileSize'



Signature of the sizes output resulting in this problem:

$ p4 -p <port>  sizes //foo.c

//foo.c#5 <n/a> bytes



$ p4 -p <port>  -G sizes //foo.c

{scodesstats    depotFiles4//fooc.c50



Signature for a file without problem:



$ p4 -p <port>  sizes //bar.c

//bar.c#5 1105 bytes



$ p4 -p <port> -G  sizes //bar.c

{scodesstats    depotFiles;//bar.csrevs5fileSizes11050



Patch:

$ git diff

diff --git a/git-p4.py b/git-p4.py

index 7bb9cadc6..f908e805e 100755

--- a/git-p4.py

+++ b/git-p4.py

@@ -2565,7 +2565,7 @@ class P4Sync(Command, P4UserMap):

     def streamOneP4File(self, file, contents):

         relPath =3D self.stripRepoPath(file['depotFile'], self.branchPrefi=
xes)

         relPath =3D self.encodeWithUTF8(relPath)

-        if verbose:

+        if verbose and 'fileSize' in self.stream_file:

             size =3D int(self.stream_file['fileSize'])

             sys.stdout.write('\r%s --> %s (%i MB)\n' %
(file['depotFile'], relPath, size/1024/1024))

             sys.stdout.flush()



Thanks & Regards

Thandesha
