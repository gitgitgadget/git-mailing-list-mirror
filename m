Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A911F404
	for <e@80x24.org>; Fri,  7 Sep 2018 06:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeIGLBJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 07:01:09 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:40666 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIGLBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 07:01:09 -0400
Received: by mail-pl1-f169.google.com with SMTP id s17-v6so6107280plp.7
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 23:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silentorbit.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=YkFu0jWgY7qHP9XJic9tlw2tW9hyI6WjCO11JcDnsbw=;
        b=duPdTtFnuE28N2HFiKNDgY09vR8KU9FKiuIDpxW03DliKRHr9zanuxmzJzsc9Xi4lv
         HnaPYRQu9Ab30n/O8NVz8EM3C+af8LR3OTDtcmiMwXFLZlevwgXFFDmPvZeouM4bUQ28
         51JTV69JsX02W7Jsr2CnZ5GJxsrVsIsG3h88E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YkFu0jWgY7qHP9XJic9tlw2tW9hyI6WjCO11JcDnsbw=;
        b=EAtZ9S7/iWYeUFbYVB8MOJDRPO9VwoE2uKGnTrVEeLAJnZz92FxRmfWvlIU4noszck
         JSkScv+AZCA+zjvMqoL77DpNuqYOc6RrR7G6dKZLUnXfdx7HHrx8uaSR8dIrTfeP5Iz0
         VNpDPUaVMe44Nx3JCbIqYP7EG6BI2d6DtDlO9gdMosmfzkCTINSP+D4D6Pu7oLGnbR3h
         Lv4J8g5QCo51rROy6AQebx3giWV+DjFANhpKNX4JjDHFJ/HVszxVwZF3LJW6Zt9DfpPZ
         YNWnySNLG39mlbWMJpKtxxRfCj8vXUkNBAHHSc0DGX/703pvxK1La9Wjnm6pKF+qonlz
         rL3g==
X-Gm-Message-State: APzg51ANOTMd/5RNkiYQiSB7kPT7f/5RylTfj0zOXnmz38JZU9inAwJ2
        xEPtVfGP2nFqDL844c6CWJckru2/XN7c0OIQkEIo+SiCeM5zIw==
X-Google-Smtp-Source: ANB0VdZGn8tsH4sDFV0NFoK6hlV7qSsCGmoIWfx4zVWn3g1iowgMfRxUUgTXx2zSHEWDqT9bYsgFLJ8swT5kU7Ffslk=
X-Received: by 2002:a17:902:163:: with SMTP id 90-v6mr6375643plb.322.1536301306446;
 Thu, 06 Sep 2018 23:21:46 -0700 (PDT)
MIME-Version: 1.0
From:   Hultqvist <hultqvist@silentorbit.com>
Date:   Fri, 7 Sep 2018 08:24:01 +0200
Message-ID: <CAJmnt9Yfed1W7F=C+dzac3AEe7nRq2cNP335MepTczboKJNoEg@mail.gmail.com>
Subject: Temporary git files for the gitdir created on a separate drive in workdir
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm having two types of git repos in separate drives, in this case G:
is a Google Drive File Stream meaning a slow synchronized storage.

First repo:
Workdir: G:\Test1
Gitdir: C:\Test1.git
G:\Test1\.git containing "gitdir: C:\Test1.git"

Second repo:
Workdir: G:\Test2
Gitdir: G:\Test2\.git

In the first repo I see a lot of "master", "config" and "index" files
being created in the root of the workdir.
The nature of the slow sync causes these files to duplicate - not gits fault.

In the second repo no artefacts are noticed.

I understand that the files are first created "somewhere else" to make
an atomic move later.
In the first repo, the nature of being two separate drives appear to
cause the residue.
In the second repo it works right.

Considering that the gitdir could be located on a different drive than
the workdir wouldn't it make more sense to create the temporary files
in a subdirectory inside the gitdir rather tan in the workdir?

Are there any flags or environment variables to control where
temporary files are created?
