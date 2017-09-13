Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081E020A21
	for <e@80x24.org>; Wed, 13 Sep 2017 11:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbdIML7T (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 07:59:19 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:47148 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdIML7S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 07:59:18 -0400
Received: by mail-io0-f174.google.com with SMTP id j141so1333814ioj.4
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EvQqlVGLPo3TY8f4/8lXL1Y7ZgNn2Oy+I7vTHwrUzw0=;
        b=JCGiWg5t5nyMhoJsw+S9Sz52aQtp2C3lwiK7PEGih5WHlhReh3lBYowz7VdSp8HzG8
         s19nTL2mTs36oofvahbormHLT8AwZG/81PNzBMVzkQ3WHgSWwTJO/46TjtvfgF22Tu3W
         H4PeYZaRLuTP8xBxmYHwy9qX5Fnc5oOfY1XxwZILo7c2zQPThGI+W+mh91XHDIlg4S9K
         7jX1jT8DW9CCSTEtkj2aDbeWbbpa0YSI7jVMrubG101e428uFCqAF2G2XRISkZtSQYsx
         fQDHLcPTxphXLrJ6Fi2NpHCQ04Gu/mpKS4BgkeEaM8iDuTLah60SsBt5dnyuN562QTSO
         ZmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EvQqlVGLPo3TY8f4/8lXL1Y7ZgNn2Oy+I7vTHwrUzw0=;
        b=ec+V7p4vCrtAmpO+tz8Ch04Afc8tSS50VvLYyvamlkL6/dk6N1rE7q/+VacvTvRtPK
         g378I/1l3/poYgkg27eku667+63N4pkIX0qg+pazecDjGZ/oIdj4i/zYjJPatPT+L2XL
         wpcJ9wbfo2Q3Nza3RF27GiKnbB2tK3mpdqLWzEk+4UiwkIuz45MXhJD4WzQ4CNFoML9Q
         +fGOYVTUTVwPLgqkxaMKtS6JGjfFnWgB3nvAZQj/U4bJdcL6Qlw4dErKoijyJNH3zXEj
         W5RxIdOt9U+lQy576q1xwjZon8eXMBL+Z3YUnItGGJZdqFTAfCp7O73cyNTQ0xPBYkbV
         k46Q==
X-Gm-Message-State: AHPjjUjFscoHeMgRctAzJa8jPgQ736wsY+E8tQy6HF4tYfvaHZMS6tqu
        KIXFIALTKsI6Pr83clNHrF24YmH6A5TYDQxxyF81HDte
X-Google-Smtp-Source: AOwi7QDZ4ttG/O4jmzph6jf+UxkoYmHXO8oz/yrpbRV6sOwvdWRBHxlKc7WCmGxnjLlJGdygeqtJZLd2pvbcDf3iH7E=
X-Received: by 10.107.48.140 with SMTP id w134mr11307845iow.301.1505303957952;
 Wed, 13 Sep 2017 04:59:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.4 with HTTP; Wed, 13 Sep 2017 04:59:17 -0700 (PDT)
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 13 Sep 2017 13:59:17 +0200
Message-ID: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
Subject: Bug: git branch --unset-upstream command can nuke config when disk is full.
To:     Git <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After being away for a while I saw the following message in one of my git repos:

$ git status
On branch yves/xxx
Your branch is based on 'origin/yves/xxx', but the upstream is gone.
  (use "git branch --unset-upstream" to fixup)

nothing to commit, working tree clean
$ git branch --unset-upstream
fatal: could not unset 'branch.yves/simple_projection.merge'

At this point my .git/config file was empty, and all of my config was lost.

I assume that things that rewrite .git/config do not check for a
successful write before deleting the old version of the file.

This was git version 2.14.1

Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
