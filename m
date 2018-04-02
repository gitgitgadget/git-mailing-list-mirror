Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ADCC1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 00:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbeDBAg2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 20:36:28 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:42143 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeDBAg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 20:36:26 -0400
Received: by mail-lf0-f43.google.com with SMTP id a22-v6so18582783lfg.9
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 17:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=qMl04UA5FNilMS7XK6tvDz1d3cBELfGvMI570Dc7PvU=;
        b=S3xHxMZu0J1sW9JSRixJhEZUcgwNW48oG1rJammhnA0NyoeVmmYYzk11bowF8QNtrB
         p7HXAO19RKF+EI4UPCa4adQgfaIzcDJ3RgG75FCPwEq/hRtUCLGMSHv/9kT8CKNXoGXt
         tbZHFNtfaJ/rhPPoTLPEQy5fuU9pvm2Dh0FqJK/sYd33eh1HA918z7RmN/WWoNvLHXxH
         /rEcfHUPhyR3qjpIDOCl79Bil4JTwXtWtn8JBtfLhuglbdFN+M3KIk8CGdFsNlZtLihD
         OJW42PiIc9pPXxyiZq2ez12RGpAuIaCKrisiYnClm7xkRk+hX6Yh4la3WIr7cVdmXalT
         aQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=qMl04UA5FNilMS7XK6tvDz1d3cBELfGvMI570Dc7PvU=;
        b=jk8joBeJhvlnPJwkGWw1w7WJfVLU92Kula0lv3gqbuXRANVNNnOXW+qfnGy+BvXyro
         JtUnglMjYwa/nIwytrMPz/ljnP+zqKokcKURSmBKbN1KWkV4Duf64zD2QgpgUy1cCDqu
         TQLrTuYNYH/RnsDrLjLgHUm5RsALAPWH+0n8woQ7u8cNIm6mcroEms7oEC/UF5aoMxFf
         h2WEw5aua10/UUtTOTn4EgBlhYIq+sdZvpCiaiquCRA4aQH43w8jyhfCl9OrGtOkF/Mq
         5LI3OtEnBVXrxwridoXKaqI+f4wFvRW73g6YpPToQsHkhnzqJ6LgqE3U/iAXSih/s11X
         jr6A==
X-Gm-Message-State: AElRT7EOwm8lsdrEOfN74phGXv3i11IJutieNtLL9DCz1gcaf64UDPly
        7+H1f2MWyjvjg2phE8mhGer9jrk+DCavRdOMi+CLChhz
X-Google-Smtp-Source: AIpwx4+ZhL24+DDVWzKXwhgVtzz66bzRvi9x6TjpZKvtM1cngNp+PtgJ9gyVkWcpKUIyitUnPJV+lv/EianKFAmfPNw=
X-Received: by 10.46.148.72 with SMTP id o8mr4437378ljh.74.1522629385275; Sun,
 01 Apr 2018 17:36:25 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.151.90 with HTTP; Sun, 1 Apr 2018 17:36:24 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Sun, 1 Apr 2018 19:36:24 -0500
X-Google-Sender-Auth: C0H7e28hzRPvwvRdMeXhKe2jUhw
Message-ID: <CAHd499C39sBTJy_AoCJxE2ZS4ECJju2jroY6_0E1MssCBtmC=A@mail.gmail.com>
Subject: Need help debugging issue in git
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm struggling with a bug that I found introduced in git v2.13.2. The
bug was not reproducible in v2.13.1. The issue is that using arguments
like "@{-1}" to aliases causes those curly braces to be removed, so
once the command is executed after alias processing the argument looks
like "@-1". This breaks any aliases you have that wrap `git log` and
such. I originally opened the bug on the Git for Windows project
(since I use Git mostly on Windows):

https://github.com/git-for-windows/git/issues/1220

After digging into the code of run-command.c some more, I have a
change that fixes the issue but it doesn't feel like the right
solution. Furthermore, the function I'm modifying doesn't seem to have
been changed in the diff between v2.13.1 and v2.13.2. I'll provide my
diff at the bottom of this email for those curious as to what I've
modified.

I was not able to reproduce this bug on Linux. However, the way
aliases get expanded seems extremely wasteful. Essentially if an alias
already has $@ in it, Git shouldn't try to insert another one. This
results in the alias being repeated multiple times. I'll give you an
example (Note there's a ton of detail in the github post linked
earlier, and most of this is already there).

Here is the alias being used for a test:

[alias]
    lgtest = !git log --oneline \"$@\"

And here is the command I invoke for the test:

$ git lgtest @{-1}

I should get logs for the previously-checked-out branch.

When `prepare_shell_cmd()` is called in run-command.c, it gets expanded like so:

+ [0] "sh" const char *
+ [1] "-c" const char *
+ [2] "git log --oneline \"$@\" \"$@\"" const char *
+ [3] "git log --oneline \"$@\"" const char *
+ [4] "@{-1}" const char *

With my modifications (again, patch inline below) I get this:

+ [0] "sh" const char *
+ [1] "-c" const char *
+ [2] "git log --oneline \"$@\"" const char *
+ [3] "@{-1}" const char *

The second version looks much better. I think the constant nesting of
commands inside each other that the first version does is somehow
causing curly braces to be removed. I don't understand enough about
shell processing to know why it would do this.

Essentially I don't feel like I'm addressing the root cause here. I
hope that someone has the time to take a peek and point me in the
right direction. If I can make sense of this maybe I can make a proper
fix somewhere.

Here is the patch:

diff --git a/run-command.c b/run-command.c
index 31fc5ea86e..39bab7f5b2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -261,10 +261,10 @@ static const char **prepare_shell_cmd(struct
argv_array *out, const char **argv)
  if (!argv[1])
  argv_array_push(out, argv[0]);
  else
- argv_array_pushf(out, "%s \"$@\"", argv[0]);
+ argv_array_pushf(out, "%s", argv[0]);
  }

- argv_array_pushv(out, argv);
+ argv_array_pushv(out, argv+1);
  return out->argv;
 }
