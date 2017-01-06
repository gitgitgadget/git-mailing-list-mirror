Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D485320A93
	for <e@80x24.org>; Fri,  6 Jan 2017 22:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940848AbdAFWqM (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 17:46:12 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36775 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968461AbdAFV4j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 16:56:39 -0500
Received: by mail-wm0-f44.google.com with SMTP id c85so40805914wmi.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KBldjUuZmdGTv8J0Hu2FNZOMfeTaX1KJT0pglEu1JaA=;
        b=gCst73lVj36fbyfoEpHMwuypMqOXzByjsRLRnrxwxAeJzi1gSyoFPLc86I5GlI2ucC
         hbV20cy/EhWIOXo0aO2CgT2t/SIewlyBPlzzzCPVb6JM9cdti0ZYwyyfxqAfhiudopCP
         LsC9YyMD2DMHiXQusKoe2rwAO5QQkEZq4wU9YA7W39voD4p9O1jgCJ6ssVYUlIbxWzC8
         30PprktBjxX2tGJNCzm8jvuy2zv9OJkUlU3YETR04jUn+AXWebTPBzkY6xiKEqahuttp
         a/OejKS3isvg+RQR8HUWoW9dbyRsts7zRaJdqUxwEL1b28fgmaWergbGJcsx3oN09prQ
         QLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KBldjUuZmdGTv8J0Hu2FNZOMfeTaX1KJT0pglEu1JaA=;
        b=qEhhSXdBnLXbK+Va9PFV6qqJtKUbe+NF+va8q0VoXzumFMLLA+1mBg1+XcRGDhxF+k
         JWudDqmvd4BZPmDl6rVyptsTelkhnMHHiFsbIdedr3wGnvl8Ps/jajDjyqRpHCgjrN0R
         jlGoH6iD468Yo+LyZICDNNbQAiItnv7MOKszu1gSagZB2NwE6GznEl3+2zp2pgZ0Ot7y
         rYp1e+FRGqNUDTRZRAYyvNHQDka7+A3T+iLEvmKmm+guSwLONN0tLDnkrKtcxR+UqaqS
         +Cb003vetOi36IbXzCFyV6tsUH/Eb4vO0UvzsDHsffxkQ9Ysvme+nvPeEJbPijrJZC6w
         qRRw==
X-Gm-Message-State: AIkVDXLzsQqyRj93AtY3Ux24XQx1QQJwo0VQjXJmxJTEzaZIdAUquKGZv5S3NZlapXg1+szPYvYMsOUhFqU5NQ==
X-Received: by 10.223.131.193 with SMTP id 59mr2748858wre.186.1483739797246;
 Fri, 06 Jan 2017 13:56:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.94.16 with HTTP; Fri, 6 Jan 2017 13:56:36 -0800 (PST)
From:   Steven Robertson <srtrumpetaggie@gmail.com>
Date:   Fri, 6 Jan 2017 13:56:36 -0800
Message-ID: <CALwf_moJFqCKcc5Q=CC6aSSUAGqXEFDKrJUkdwov8shqBRK=yg@mail.gmail.com>
Subject: Git filesystem case-insensitive to case-sensitive system broken
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I was doing development on a linux box on AWS, when we found a code
bug that had me switching to running the code on a Mac instead. We
discovered that we had accidentally named two files the same when
looked at case-insensitively, which made git commands afterwards
display the wrong thing. It looked like this (ignoring some things
that aren't relevant):

$ git status


   modified:   tests/test_system/show_19_L.txt


no changes added to commit (use "git add" and/or "git commit -a")

$ git checkout tests/test_system/show_19_L.txt

$ git status


   modified:   tests/test_system/show_19_l.txt


no changes added to commit (use "git add" and/or "git commit -a")

$ git checkout tests/test_system/show_19_l.txt

$ git status


   modified:   tests/test_system/show_19_L.txt


no changes added to commit (use "git add" and/or "git commit -a")

$ diff tests/test_system/show_19_L.txt tests/test_system/show_19_l.txt

$


Those two files are different in our repo, and as such git thinks that
we modified one of them when we try and pull it down from github
again.


Thanks for looking at this!
-- Steven
