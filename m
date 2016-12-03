Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2AF1FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 01:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758004AbcLCBxt (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 20:53:49 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33067 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbcLCBxt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 20:53:49 -0500
Received: by mail-io0-f173.google.com with SMTP id j65so512686157iof.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 17:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=Oxi2MAa3Q5ZRBIP1Gv8pSob0Qu+pSZEKBBPcej+Qsz4=;
        b=KRoKIpIoTR8X8TRPP++yslAoKm9CKa5ZkOf+9hjnptyvZ/QBn+DiLAeP8UuDEF8tU+
         OY4T8+ktfdRtrmUaxcG6seCXKxTQyArGV2n3+BAJ3lJo6AJLJapIoIeTs06Xt2I+8ClM
         EfKQDdIHJ6TE3aSbcfZdDUL5vBkkBcBeFO092PM8iUEMxYpiOJirmT6VV5fDY7Dx7Its
         QhdYN7yr5yQBmgKuQ3lqk1d6OjxZ3Zl9R6XGwGtebeKNAAwtdQzWkBDTYHn14OXLJPZf
         9FneudtFVk171Dhb1jjHjnFf3ZsPD8B2ydw1hN7ob7WN9gZlTB3gDVPPcvIlUtcTuv98
         PB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=Oxi2MAa3Q5ZRBIP1Gv8pSob0Qu+pSZEKBBPcej+Qsz4=;
        b=D4DVm+fQY/T6i73iGjwTA2/kzneAhk7hx+eV/CApxjufhudaPupCsHR9Fd3V8E7SjH
         ew87IroTyDjtkeSgcxZFjWZe1EJlWVVCK+JTDjPwxGZ0AIFQOb9QrOtY8svUYwPW/0Dl
         ngR29vCm2RL7hMVI9q0MGUd3QIGPCM9UEdVRZp7W7ZOnkwPcXNP0zW9AHsYD+NuJC//P
         /Kph7SJvEgaGMMgA3ti2pEPZxvVK7R/dos2IcUZQC869bVWSOEK8yQeEiMBPw2PBht5H
         f0g2c0FAugVlovgMzt0CUTQLhwbBPbSpGyXLmc9eebUzXgc7nyUqyriB/oUM1s8yUb24
         kXFQ==
X-Gm-Message-State: AKaTC02ngLQ+HgOLkyhyqowW/XJ9U9+xvAgsiqWs6WUzS26Wh075py1HIZGch5ps/5DtgFJoFcSZ2IzQr0tmhFMv
X-Received: by 10.36.250.196 with SMTP id v187mr82792ith.91.1480729935951;
 Fri, 02 Dec 2016 17:52:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.150.65 with HTTP; Fri, 2 Dec 2016 17:52:15 -0800 (PST)
In-Reply-To: <CA+q_oBdHytoeSD-hmLx_N473M8XinjqckvE35Re3eNpQRWYjHQ@mail.gmail.com>
References: <CA+q_oBdHytoeSD-hmLx_N473M8XinjqckvE35Re3eNpQRWYjHQ@mail.gmail.com>
From:   Robbie Iannucci <iannucci@google.com>
Date:   Fri, 2 Dec 2016 17:52:15 -0800
Message-ID: <CA+q_oBc77Z7YW0yqPPB-R_HkAUtno1bDDTx3tR22ScRpC96ZcA@mail.gmail.com>
Subject: Re: [BUG] Index.lock error message regression in git 2.11.0
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apparently I'm not supposed to send attachments >_<. Here's the script
in non-attachement form:

--------

#!/bin/bash

make -j 8 2>&1 > /dev/null
if [[ $? != 0 ]]; then
  # skip this version
  exit 125
fi
git=`realpath ./git`

rm -rf .test_repo || true
mkdir .test_repo

cd .test_repo
$git init

echo HELLO > a
$git add a
$git commit -m 'initial_commit'
$git branch --track new_branch

$git checkout master
echo HELLO >> a
$git add a
$git commit -m 'second_commit'

$git checkout new_branch

touch .git/index.lock
if $git merge --ff-only master 2>&1 | grep -F "index.lock" ; then
  echo OK
  exit 0
fi
echo Message is missing
exit 1

On Fri, Dec 2, 2016 at 5:44 PM, Robbie Iannucci <iannucci@google.com> wrote:
> Hello,
>
> I just upgraded to 2.11.0 from 2.10.2, and I noticed that some
> commands no longer print an error message when the `index.lock` file
> exists (such as `git merge --ff-only`).
>
> It appears this bug was introduced in
> 55f5704da69d3e6836620f01bee0093ad5e331e8 (sequencer: lib'ify
> checkout_fast_forward()). I determined this by running the attached
> bisect script (on OS X, but I don't think that matters; I've also seen
> the error message missing on Linux):
>
> $ cd /path/to/git/src
> $ git bisect start v2.11.0-rc0 v2.10.2
> $ git bisect run /path/to/bisect.test.sh
>
> (my original version of the script also includes some other makefile
> parameters to get a modern version of gettext and openssl too, but
> they're not relevant to this ML).
>
> I'm not certain that I have enough context to propose a meaningful
> patch though :/.
>
> Cheers,
> Robbie
