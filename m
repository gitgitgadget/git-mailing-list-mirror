Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64CD01F731
	for <e@80x24.org>; Sat, 10 Aug 2019 20:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfHJUMi (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 16:12:38 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:35538 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfHJUMi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 16:12:38 -0400
Received: by mail-qt1-f174.google.com with SMTP id d23so99266321qto.2
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cUVyBKogb9spRq+NtuNqdWHuc1NU84TqKQtosIc+XzI=;
        b=LjxUWklD+IH6zc5BEvos/aMjc4z4lX8EdC4C19YaTtyUGh1TZT2QcAxtz8JIJEcnF8
         vNqRMTqTljwiLXIIpg6lDYYTnWGh0exWYCb8y7+NlKfSDGZhdTm5D09TSFyRLXujdPF4
         D4DtAtF8sSFwuZGmttUd68nA3l7trngT98ebnB+515MFbbqpZ+urX4W1H++LYVx41aCv
         sHyqX3obBByD+csJyOXWrv2EUyWq6vjUDQ34je+buYU9gjWvvuHU8qXU+Kn4eXEoFOZo
         pORCEaSNeKaKdbJ2ukm1UWJayxMr/1jjGe6dIE5MzfCTHiRNYsJthhMLFmZzFAms6gfd
         qlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cUVyBKogb9spRq+NtuNqdWHuc1NU84TqKQtosIc+XzI=;
        b=r3mhqd/NGlEV1bpbMRSzI9Lc1Z7EXmRNsKHQqUm9ChTEXNPgZI9S/0c+bx3oLQv0eZ
         9KU8tYyF8JOJJYzCKTQQIIUkapMvsAqxKJJAi2PUnAfz0oeZECJRvtjIK0uwYg0XhnT9
         0i2nuGngfyv06g5ZW4TOIFOL0TZKlsHfO01+V6R+rbpcO2eYQ2IbEsAejYuirhsfaClH
         fG2IhPGsOnqL6248lJhZ+S0ssGBl3r9b3CyvQhhFKDpyEgGnx6CyONxnLHOGIUauojP3
         r6XM9839TPt466caCtAL4/E+JOatjZd6GtC6EdN3c/f8owPAp/pDJGJyCqyIKN8q99Ou
         tMSA==
X-Gm-Message-State: APjAAAVMEUOa5X09StHyEOfkhfPOBuREgfqQq0XgR7AJfqlapuWjj1A3
        X2qKyZ0CCX2sSlGpU2LedojYnXWr6Mc1lFc+S9ONX60x
X-Google-Smtp-Source: APXvYqy1qvS3wXZJVltKm0ZA/4KkXH0kGuxDXuN0uATam8ekKmMGPY607byZ1pM1nf0MW8A6m4ACCbAEmhz4/ok+RTg=
X-Received: by 2002:a0c:983b:: with SMTP id c56mr24481951qvd.131.1565467956957;
 Sat, 10 Aug 2019 13:12:36 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Kaminski <davekaminski@gmail.com>
Date:   Sat, 10 Aug 2019 13:12:13 -0700
Message-ID: <CA+zjYZsojm0QgHBC3GFb2NeZR1aK3Uh7vO4ojBzsMKVvP6X+Tg@mail.gmail.com>
Subject: Incorrect behavior from git checkout --patch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am observing git checkout --patch making changes to the wrong lines of a file.

This is with a clean install of git version 2.20.1 on a debian docker
container (image tag 10.0 which is also "latest" as of this writing).

With a diff that looks like the following:

diff --git a/file.txt b/file.txt
index 868aa22..ea4d786 100644
--- a/file.txt
+++ b/file.txt
@@ -1,35 +1,51 @@
 block_one {
 line 1
+line 1.5
 line 2
+line 2.5
 line 3
 2 4 6 8
 line 4
+line 4.5
 line 5
+line 5.5
 line 6
 2 4 6 8
 line 7
+line 7.5
 line 8
+line 8.5
 line 9
 2 4 6 8
 line 10
+line 10.5
 line 11
+line 11.5
 line 12
 }

 block_two {
 line 1
+line 1.5
 line 2
+line 2.5
 line 3
-2 5 6 9
+2 4 6 8
 line 4
+line 4.5
 line 5
+line 5.5
 line 6
-2 5 6 9
+2 4 6 8
 line 7
+line 7.5
 line 8
+line 8.5
 line 9
-2 5 6 9
+2 4 6 8
 line 10
+line 10.5
 line 11
+line 11.5
 line 12
 }

doing a `git checkout --patch -- ./file.txt`, splitting the diff into
hunks, and discarding all of the hunks that begin with numbers, e.g.

@@ -22,3 +32,3 @@
 line 3
-2 5 6 9
+2 4 6 8
 line 4

the expected state of the file in the working directory is this:

diff --git a/file.txt b/file.txt
index 868aa22..9ab67a1 100644
--- a/file.txt
+++ b/file.txt
@@ -1,35 +1,51 @@
 block_one {
 line 1
+line 1.5
 line 2
+line 2.5
 line 3
 2 4 6 8
 line 4
+line 4.5
 line 5
+line 5.5
 line 6
 2 4 6 8
 line 7
+line 7.5
 line 8
+line 8.5
 line 9
 2 4 6 8
 line 10
+line 10.5
 line 11
+line 11.5
 line 12
 }

 block_two {
 line 1
+line 1.5
 line 2
+line 2.5
 line 3
 2 5 6 9
 line 4
+line 4.5
 line 5
+line 5.5
 line 6
 2 5 6 9
 line 7
+line 7.5
 line 8
+line 8.5
 line 9
 2 5 6 9
 line 10
+line 10.5
 line 11
+line 11.5
 line 12
 }

but instead the actual state of the file is this:

diff --git a/file.txt b/file.txt
index 868aa22..76fe65d 100644
--- a/file.txt
+++ b/file.txt
@@ -1,35 +1,51 @@
 block_one {
 line 1
+line 1.5
 line 2
+line 2.5
 line 3
 2 4 6 8
 line 4
+line 4.5
 line 5
+line 5.5
 line 6
 2 4 6 8
 line 7
+line 7.5
 line 8
+line 8.5
 line 9
-2 4 6 8
+2 5 6 9
 line 10
+line 10.5
 line 11
+line 11.5
 line 12
 }

 block_two {
 line 1
+line 1.5
 line 2
+line 2.5
 line 3
 2 5 6 9
 line 4
+line 4.5
 line 5
+line 5.5
 line 6
 2 5 6 9
 line 7
+line 7.5
 line 8
+line 8.5
 line 9
-2 5 6 9
+2 4 6 8
 line 10
+line 10.5
 line 11
+line 11.5
 line 12
 }

See the changes between "line 9" and "line 10" in both blocks that are
not correct.
