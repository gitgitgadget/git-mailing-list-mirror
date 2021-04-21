Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34753C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B1261439
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbhDUSOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhDUSOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:14:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F30EC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:13:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id g16so5253666plq.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qyNQArpUIpQxYGX6uVVpZ00Zvt9IdQLHtVsalydJIHE=;
        b=tWWYMRjkfoNPAjlgmQT/wWIIyKDIk+LvpH2hTyhaV3iGfsM4yNZxM+rb5f6iUm5x60
         Xq4n/b9tEEnvWDyLtOqrEHBpiz0eCSuZNFptJ0RPteFpkp3gMkWIDp48ZPy68h8+Hk0i
         ZwH2Q4ulrEMXi2amBJSB5SZIQ3ak/+pshV31S4h94KF2Lh7wD4Cch0VB/TmWpaovHVg1
         iZgg9e8S0BwTG6bkbZAp+SZzlRsMN8sZL2fwz2zvEUZQW2+2vGNRAUNNr21jjQf6BnDG
         Sf934SfnYW6RL3e0pQkb5I3PA0XzEJEogEYRnK8iVic/j+ReSAPNatCYA38IK40n2kmq
         6NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qyNQArpUIpQxYGX6uVVpZ00Zvt9IdQLHtVsalydJIHE=;
        b=HyhP9Ml4rfYEYPhHh0EM2AzbIeCmbVVMKKQvWFIFh/RYQuMXDm/Zmakzygjal34h1l
         shtQv4nrS1ptpOahauCSyXpmEbLGF93uYKQgxV6xl8/u+jLniHRRGfar4M48Az1sKtYi
         GR7sUUA9XqtzRErxm3Mop09vvQDAO0ejVF0bPEyKPY60rpYzIVEXyzn4S5tya4JQufUa
         7vTJeHyj79yoZUMFyXHEyGl8YKuKaxUXtU4iaV9m6qEkvgP/5Rv6WoLoEFZ6OwQ3hcn3
         ZnTZQxtqSrbaqYB2kLEsFJrfDkThAMhAK900d+SP506scjWqeT5GGyuNchEcixF+Lhcm
         fVxw==
X-Gm-Message-State: AOAM5311PJWAiEOCj5zq88ws/4c2T3/KnOAapbqBkXwgPXhGJfq7+lVV
        GimuQJx2fDyRAcIwHkQtJxgBIbUepxa3Ag==
X-Google-Smtp-Source: ABdhPJwSkGF/OZHTkR1i70dkq8cKTKzKImbgIZMr6gStlIVKIfHtFiAaQN/gHsMruIIreKnP0yR9Rw==
X-Received: by 2002:a17:902:a38d:b029:ec:8faf:2007 with SMTP id x13-20020a170902a38db02900ec8faf2007mr23404443pla.75.1619028828460;
        Wed, 21 Apr 2021 11:13:48 -0700 (PDT)
Received: from [110.32.98.18] (c-73-158-43-156.hsd1.ca.comcast.net. [73.158.43.156])
        by smtp.gmail.com with ESMTPSA id n11sm35040pff.96.2021.04.21.11.13.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 11:13:48 -0700 (PDT)
To:     git@vger.kernel.org
From:   Count of San Francisco <countofsanfrancisco@gmail.com>
Subject: git word diff bug?
Message-ID: <2f6fbf1d-a3b9-9766-9593-44ac69ba4e83@gmail.com>
Date:   Wed, 21 Apr 2021 11:13:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

Here is my "git bugreport":

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
   git diff --word-diff=porcelain file0.txt file1.txt
     or
   git diff --word-diff file0.txt file1.txt

What did you expect to happen? (Expected behavior)

   I expected the diff for porcelain or default word-diff to be clear on 
which lines got removed and which changes belong to which line. I 
explain more in details below.

What happened instead? (Actual behavior)

   The diff was not clear.

What's different between what you expected and what actually happened?

   The diff made it looked like all the removed text were on one line 
and a later change in a line look like it was meant for a different 
line. When in fact, the later changes were for the same line (i.e. the 
first line). More details below.

Anything else you want to add:

Here are the details to reproduce and more details on how I interpreted 
the diff. If I am writing a script to highlight changes or to do extra 
processing for my specific use case, my script would get confused as to 
what really changed.

file0.txt content:
*** Begin Content *** --> this line is not in the actual file but just a 
marker here for clarity.
The fox jumped over the wall.
Blah1e32
q432423
qe23234
  233
253
345235

53243
afsfffas
*** End Content ****

file1.txt content:
*** Begin Content ***
The fox jumped over the river.
   He made it over.
*** End Content ****

git diff --word-diff file0.txt file1.txt produced this:
diff --git a/file0.txt b/file1.txt
index c8756ba..3413f10 100644
--- a/file0.txt
+++ b/file1.txt
@@ -1,11 +1,2 @@
The fox jumped over the [-wall.-]
[-Blah1e32-]
[-q432423-]
[-qe23234-]
[- 233-]
[-253-]
[-345235-]

[-53243-]
[-afsfffas-]{+river.+}
{+  He made it over.+}

The diff above does not make it clear that the "{+river+}" is really to 
be appended (or related) to the first line.
I expected the first diff line to look like this:
The fox jumped over the [-wall.-]{+river+} and the rest of the lines are 
delete lines.

git diff --word-diff=porcelain file0.txt file1.txt produced this:
diff --git a/file0.txt b/file1.txt
index c8756ba..3413f10 100644
--- a/file0.txt
+++ b/file1.txt
@@ -1,11 +1,2 @@
  The fox jumped over the
-wall.
~
-Blah1e32
~
-q432423
~
-qe23234
~
- 233
~
-253
~
-345235
~
~
-53243
~
-afsfffas
+river.
~
+  He made it over.
~

This is more non-discernable. The git diff --help documentation says 
that "Newlines in the input are represented by a tilde ~ on a line of 
its own". So a script would see the '~' character and interpret that as 
a new line. The script would have mistaken the "+river" for a different 
line. The git diff --help documentation does not explain what to do in 
this scenario.

I expected this:
  The fox jumped over the
-wall.
+river.
~

Is this a bug? If not, how do I make the distinction that the {+river+} 
(in the first case) and the +river (in the 2nd case) is really for the 
first line?

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.3.0 Darwin Kernel Version 20.3.0: Thu Jan 21 00:07:06 
PST 2021; root:xnu-7195.81.3~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.28)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
