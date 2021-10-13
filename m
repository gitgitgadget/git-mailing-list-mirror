Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D194CC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A526A6113B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhJNAls (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:41:48 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.28]:64927 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNAlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:41:47 -0400
X-Greylist: delayed 31930 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2021 20:41:47 EDT
Received: from [94.228.207.246] (helo=[192.168.2.206])
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1magTX-0005cq-GE
        for git@vger.kernel.org; Wed, 13 Oct 2021 17:47:27 +0200
To:     git@vger.kernel.org
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Suggestion: "verify/repair" option for 'git gc'
Message-ID: <e288dbe1-b7c7-5a2e-5271-404a14de836a@syntevo.com>
Date:   Wed, 13 Oct 2021 18:47:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suggestion
----------
1) It would be nice if 'git gc' had an option to also verify
    (like 'git fsck') the repo and report corruption. I think that it's
    a good idea to have it in 'gc' for performance reasons, because
    'git gc' already reads things.

2) It would be nice if git could automatically download blobs from
    remote if local blob is corrupted. Maybe it was already implemented,
    see story 3 below.

Motivation
----------

-- Story 1 --
Just a few days ago I encountered another secretly broken repo which
caused some small bugs in the git UI I'm using. The repo worked mostly
fine, that's why I had no idea that it's corrupted.

My git UI invokes 'git gc' sometimes and if that detected the
corruption, I wouldn't have to spend time hunting the bug in UI.

Specifically, it reports these errors on `git fsck`
   error: object 0189425cc210555c36383293c468df5da73acc48 is a commit, 
not a blob
   error in tree 1d571d7354f99b726bbcc0cb232b3f47846c71a1: broken links
   error: object 0189425cc210555c36383293c468df5da73acc48 is a commit, 
not a blob
   error in tree 2808b286c2a933e88735d97416e29b9514fc6af2: broken links
   error: object 0189425cc210555c36383293c468df5da73acc48 is a commit, 
not a blob
   error in tree 604f6f6c4fbf8da7a593708e863e68f8c5a27d07: broken links
   error: object 0189425cc210555c36383293c468df5da73acc48 is a commit, 
not a blob
   error in tree 6a2c4a5ef0b0ee7aa85d88c3147b7558a6a7c29f: broken links

The repo is not confidential and I could share it if needed.
I "solved" the problem by cloning a new copy.

-- Story 2 --
A few years ago, I had another repo that wasn't used for a couple years
and had corrupted blobs. The repo looked fine until I tried to clone
from it. Unfortunately it was the only copy and I had to write some
code to "guess" the blob's contents to repair the repo.

If 'git gc' detected corruption, I would have known about the problem 
earlier,
when I still had other copies around.

-- Story 3 --
Also a few years ago, I had a repo with a single corrupted blob. I don't
remember why, but simply re-cloning it was a headache. I managed to fix repo
by issuing a command to re-download a blob from remote. Git could totally do
that itself, I think.
