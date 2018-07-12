Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6FC1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 02:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeGLC6T (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 22:58:19 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:45568 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeGLC6T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 22:58:19 -0400
Received: by mail-lf0-f46.google.com with SMTP id m13-v6so22924602lfb.12
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oVIVSGrbKeoKgp/hf9z18CUk0hI8SEU5nmBKnNeymPY=;
        b=O2grFmmhkBEGIxAwN0FkQhGfUn+SLEZisKguPqNwt1Rk3sNy1FD/0XxddKb2AcjV7W
         qhctyKxJwHZXI43kL6l3DRRrTvvKRkAf2rx+rpBMwQlRDAcUWC3refh2L2UgI8AJYbLn
         ByuB05NtxB3RdCO3G8P4LhZCyHpsOJFTEirEU2rb3ioffEDlATv6PX57Pn7AOESyf82Q
         yRIoRK6tkLgkVvFtN8SBMH50KrIXfniWISuthrIPBfy6M4iBS+yOpMQrP+7Z9jW79hZ/
         Z84PHAlsqNtYW1rcIf5OohTx+egUCvZgHtUuTWUcIu9ysJ8Pe09/9PW3gyR++CEGuMvX
         l1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oVIVSGrbKeoKgp/hf9z18CUk0hI8SEU5nmBKnNeymPY=;
        b=WLaYaKDvJhns7bpY9oRydclA+tHhoARHFAYzVAese71AMri/3wHCkL6IoBGE5nUk7F
         xPXSlPBY9Bvj2uy4MlGfVOJxwGVF3r9U8VfSCtzkPbJE6dJgpbYbF997fZb8Kzcyb1F7
         AiJQK3W/QYt9b4HMOkHqIpyJc9ifEJn1vuHNe0tKf4dbLMquRACZUYpWW0IP9ZLhM05V
         P1STzB7ocBj5+68jHCxl20zm/0IycqKJr+qo4pUIk5RaR7FQu/N4QzJlfkjMoM2yxb9j
         KJiyEVa4tkAp/O85bstL++NeeKRGU6sltCUgLuHPkRHX5+T5HRSeyqJTevlb1GTYNWun
         ZO4A==
X-Gm-Message-State: AOUpUlGULaOE1q8wYe4pHE62P5ENkGMSNMKoC91HDq/c3VI9mu5OJnMC
        oCGhrhNrUmPz0W4n3ceuwMYglZlI/Wp/rFM3mqDCFA==
X-Google-Smtp-Source: AAOMgpd3QStLnR2gm6asDTKvyyVocOtbzFUzM3czm2OpxMPE+qmUnYSWn8erjyrr15auJqTxGzQBht8XZSUYOHpx0rg=
X-Received: by 2002:a19:7609:: with SMTP id c9-v6mr216377lff.73.1531363858873;
 Wed, 11 Jul 2018 19:50:58 -0700 (PDT)
MIME-Version: 1.0
From:   Vitali Lovich <vlovich@gmail.com>
Date:   Wed, 11 Jul 2018 19:50:47 -0700
Message-ID: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
Subject: rev-parse --show-toplevel broken during exec'ed rebase?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Typically git rev-parse --show-toplevel prints the folder containing
the .git folder regardless what subdirectory one is in.  One exception
I have found is that if one is within the context of git rebase --exec
then show-toplevel always just prints the current directory it's
running from.

Repro (starting with cwd within git project):
> (cd xdiff; git rev-parse --show-toplevel)
... path to git repository
> git rebase -i 18404434bf406f6a6f892ed73320c5cf9cc187dd
# Stop at some commit for editing
> (cd xdiff; git rev-parse --show-toplevel)
... path to git repository
> git rebase 18404434bf406f6a6f892ed73320c5cf9cc187dd -x "(cd xdiff; git rev-parse --show-toplevel)"
... path to git repository/xdiff !!!

This seems like incorrect behaviour to me since it's a weird
inconsistency (even with other rebase contexts) & the documentation
says "Show the absolute path of the top-level directory." with no
caveats.

Thanks,
Vital
