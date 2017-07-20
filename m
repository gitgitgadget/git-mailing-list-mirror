Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013C520387
	for <e@80x24.org>; Thu, 20 Jul 2017 10:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934412AbdGTKhO (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 06:37:14 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34954 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934409AbdGTKhN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 06:37:13 -0400
Received: by mail-ua0-f171.google.com with SMTP id d29so10271949uai.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=eGPls/7AsLQzeyX7zkMMT/nOteNqHMIzC/A2JWgRCeY=;
        b=GoVXHoM7N2MtYpnIACUta7AYhZYdbs3cZNlsvsfyI2mUNmUZTKdiPvIqiOeTE+o+V5
         dmBy7dWD1JbdB48o/bdVNdEk0wq7JHC6ojXwXHI6Qn9TP5EsiEIfR871vx++CikSf+47
         oYllH/UZmrk9trtuHdpzv2xnzzIBXmboEVNP2qRu+Sg1bgMyDZeNz2D4LUi439r6oySp
         Glz4a2/BFQlnmeEAut7YyWwshj0j/3gXgV/1CmXyw9FsT7WCNOZ9VgKnuLILWUqIMlTa
         eGAeSNAmhw3JWubeSc373bzqtGe9QepgXic8/5MhUjoakM0sMwBXKLD28mMiCn5l8Hhn
         45vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=eGPls/7AsLQzeyX7zkMMT/nOteNqHMIzC/A2JWgRCeY=;
        b=l6lzWN6B39C02MyiX2H/OpYuRi9BfVhARssgu3ahlefhmPS+ftJdVq/+F5O8Y/e26m
         ip8Ewt2YxPSRsl8bIOmgxn8a/2Xab/X45wZVUnfKdylveeMYkml+90Nsv29DhQxlL4uy
         AiR5C5FTBhdBdhjr+ss9RC6yO0/mYn+2Wz6/T0RkdduPHfZcYEjT9WTqI/7LrFpwbMK5
         EG4tTbir9xm83BkGwMwrwKKYAhxv2zoqLjbAlifJZV2YWVXJSKRxIjRJ3oNGkWJmuuoH
         NMS236FGiGfPYmHGfXjXztcmenz/+BN5L++lCuU/98l97Eklb0jjuDpe2RhHnTD5Ak1Y
         B20A==
X-Gm-Message-State: AIVw112tBXx3kJmMrD5S45nWBIgRXOR1NkqZsIgnAB9hiSFLKmFYdYSp
        qMdkd8hA/FDR1TlpgRVOpIOkPZuvryE7
X-Received: by 10.31.66.141 with SMTP id p135mr1784997vka.85.1500547032342;
 Thu, 20 Jul 2017 03:37:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.42.7 with HTTP; Thu, 20 Jul 2017 03:37:11 -0700 (PDT)
From:   John Szakmeister <john@szakmeister.net>
Date:   Thu, 20 Jul 2017 06:37:11 -0400
X-Google-Sender-Auth: 1XQ29U2Hxy7b4H80viglkR8qtcI
Message-ID: <CAEBDL5URsbMazLBy-kWLJzECTEQ=61DN07xuu5NaO2Hw6r=j+w@mail.gmail.com>
Subject: Expected behavior of "git check-ignore"...
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A StackOverflow user posted a question about how to reliably check
whether a file would be ignored by "git add" and expected "git
check-ignore" to return results that matched git add's behavior.  It
turns out that it doesn't.  If there is a negation rule, we end up
returning that exclude and printing it and exiting with 0 (there are
some ignored files) even though the file has been marked to not be
ignored.

Is the expected behavior of "git check-ignore" to return 0 even if the
file is not ignore when a negation is present?

>>>>
git init .
echo 'foo/*' > .gitignore
echo '!foo/bar' > .gitignore
mkdir foo
touch foo/bar
git check-ignore foo/bar
<<<<

I expect the last command to return 1 (no files are ignored), but it
doesn't.  The StackOverflow user had the same expectation, and imagine
others do as well.  OTOH, it looks like the command is really meant to
be a debugging tool--to show me the line in a .gitignore associated
with this file, if there is one.  In which case, the behavior is
correct but the return code description is a bit misleading (0 means
the file is ignored, which isn't true here).

Thoughts?  It seems like this question was asked before several years
ago but didn't get a response.

Thanks!

-John

PS The SO question is here:
https://stackoverflow.com/questions/45210790/how-to-reliably-check-whether-a-file-is-ignored-by-git
