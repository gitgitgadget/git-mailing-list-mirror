Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1927A20248
	for <e@80x24.org>; Fri,  8 Mar 2019 15:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCHPnt (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 10:43:49 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:44633 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHPns (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 10:43:48 -0500
Received: by mail-oi1-f171.google.com with SMTP id a81so16159769oii.11
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 07:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DvY8bBOlp0poczCq/F4t/w1M/C4lOdrlbIJ86h7ZvB8=;
        b=s/9y0GnsrxyXYcR4P9qOwNiZj+xvyOOE1jfgLpIVzLvikDqoDlriwXeL9aUMjInzZ/
         O4bEIly+mHZ3DbzZp9RNvZood7POvEXefau6DcUPeQ5SXI8nwoKCMH0StXnxEpbzk1bt
         eSmIRlYWzqbV56b1/bdMBeFd/VKdxsA4UY0Eupjb2qox63KnLdeZRBz4bwxeb6NynRKB
         R/r7jxEyjxJ5lswEogDZA4+YQK/4xNL6RpPhvspMwe7mxirEbIdB5dgZoLFuY0ylF2dd
         k1Pj8sDJNTziqu7rILoB5sEKF67pVrXTpoYrZad2VjHYX//SG1tkhhtDp2Prz2edmf0G
         rHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DvY8bBOlp0poczCq/F4t/w1M/C4lOdrlbIJ86h7ZvB8=;
        b=kM0l+YatBJn8Og9n4WldKIocUCL7frnmPmMVXJVkoFN7JnyufC7W5QbabeR7DEbqZM
         a8zr0Pyg23cM5tbHz2lInKtP1E/ICwUQWuFfMVk16CxjodyrdbLRzGBRjJA1tI0+1wvl
         xcZIgNARTFpAEaTUHCPbjRO+OhoMAi1EsQsbxM0xSno+/C6dXepbEC76wpItbbUCB9yc
         3yqWgFjE2Q3rwGc81Or+ayIDnCFXGKtmr8hT05dp42UOe/DuZhY+Ndi5KAXxIO0B+obg
         tekbTgoFCnqt/xAVK+5HKqaMqB7xm5UcpvmsMh1kvm9MPH9UQ4teykVZ2A7I+BhfYkbm
         WOoA==
X-Gm-Message-State: APjAAAX42K5WwBFK5Q45Zx5/cTcf8Hgl2mToNY4MAXOPauhL521xy1gI
        2kUMq5oB5W43EdzWPJ2VWQiH+1TSxqscyyaJtMceUSZc
X-Google-Smtp-Source: APXvYqxAxDl65Ka7MOGqRx6Ov/pphmcJcPyijYxuG+ZKoQuEGoB4RdUf98A67jSE88djNqQ+jJ7RqDqLuh+khe21aNw=
X-Received: by 2002:aca:eb52:: with SMTP id j79mr8117047oih.119.1552059827682;
 Fri, 08 Mar 2019 07:43:47 -0800 (PST)
MIME-Version: 1.0
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Fri, 8 Mar 2019 21:13:36 +0530
Message-ID: <CAMknYENWOW0mj6Bn9OooqKg-sZi9bZUO461Gv1F00=phNwLFQQ@mail.gmail.com>
Subject: New Ft. for Git : Allow resumable cloning of repositories.
To:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Objective: Allow pause and resume functionality while cloning repositories.

Below is a rough idea on how this may be achieved.

1) Create a repository_name.json file.
2) repository_name.json will be an index file containing list of all
the files in the repository with default status being "False".
   "False" status of a file signifies that this file is not yet fully
downloaded.

Something like this:

{
  'file1.ext' : "False",
  'file2.ext' : "False",
  'file3.ext' : "False"
}

3) As a file finishes downloading, say 'file1.ext' and 'file2.ext'
have finished downloading, their status will change to:

Something like this:

{
  'file1.ext' : "True",
  'file2.ext' : "True",
  'file3.ext' : "False"
}

4) Suppose due to some reason, before 'file3.ext' could finish
download; cloning is interrupted.
5) After the interruption the repository_name.json and downloaded
files are preserved.
6) Now, when cloning of the same repository begins next time, files
would be downloaded based on information taken from
repository_name.json file.

Note 1: Doing this for cloning would be the main objective, further
this may be extended for fetching, pulling, and pushing too.

Note 2: Since this is gsoc time, please don't take this to be a
project idea for gsoc, as it was pointed out on irc that this would be
a time intensive functionality.

I want to work on building this functionality.
Please discuss thoughts on this, so as to make a technically sound to-do list.
