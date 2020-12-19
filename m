Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,ZIPFILE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CD2C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB1623100
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgLSOoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 09:44:32 -0500
Received: from mail.vivaldi.com ([31.209.137.20]:34212 "EHLO mail.vivaldi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgLSOob (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 09:44:31 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Dec 2020 09:44:30 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.vivaldi.com (Postfix) with ESMTP id 038301F825F
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vivaldi.com; h=
        user-agent:message-id:organization:from:from:mime-version
        :subject:subject:date:date:content-type:content-type:received
        :received; s=2019; t=1608388647; bh=+Q1C+Jv7pDLEWEiN4uRq0IYfxmuC
        Udtf52KYsw7e1aw=; b=gar+7CWrkUObTz4LAkiAfiO2vGauMvooc1sOE5ZSPWvF
        sI21ula7pje1rhvxCgOT5HfhIP+CvLDmk5KxibZxWfnUYiN3C4YhuzUykyCz+xsG
        OAVVYkEi14mWjdAZ/Tcc+ZjFT922m4U5Mm+dlGTaWTnSq3+UnMMNDB/4EjhYGzJt
        MQpuI3TwckjyWaNKJxYac6Ssga1s1sDhT40iPyVDTmW27OhefI597+NKs9RiPv5V
        5WY9blFFBjQtGD0IeFMjcaSNz/zNIQ4Zeve42Ld8755JRBuPJmzOEAAvXQDkn6sY
        LsKKPpXhp0S1m8y1vVLfb4D+6vkptLQfjlUliLCmtw==
X-Virus-Scanned: Debian amavisd-new at vivaldi.com
Received: from mail.vivaldi.com ([127.0.0.1])
        by localhost (mail.vivaldi.com [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ql_UgvDW5RCO for <git@vger.kernel.org>;
        Sat, 19 Dec 2020 14:37:27 +0000 (UTC)
Received: from damia (ti0182q160-3926.bb.online.no [62.249.179.132])
        by mail.vivaldi.com (Postfix) with ESMTPSA id 7C04F1F825B
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 14:37:27 +0000 (UTC)
Content-Type: multipart/mixed; boundary=----------wyFjHysXxvSE0t9nQeoET3
Date:   Sat, 19 Dec 2020 15:37:26 +0100
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git fetch failure in submodule if deeper submodule pointer updated
MIME-Version: 1.0
From:   "Yngve N. Pettersen" <yngve@vivaldi.com>
Organization: Vivaldi Technologies AS
Message-ID: <op.0vvmwohypvqxoc@damia>
User-Agent: Opera Mail/12.17 (Win32)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------------wyFjHysXxvSE0t9nQeoET3
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hello all,

Recently we encountered a git fetch issue similar to the one I have  
reported earlier, <https://marc.info/?l=git&m=158979416620251&w=2>, which  
AFAICT has not yet been fixed.

In this case we had checked out a submodule, but not the submodule(s)  
below it.

The full submodule chain was like this:

   top->middle->bottom

The actual checkout was

   top->middle

Because only "middle" was needed for the cron job script used to push  
updates to "top" and "middle", "bottom" was never checked out (and it  
should not be necessary to do so, either).

When the pointer to "bottom" was recently updated in "middle", the cron  
job failed, because Git "could not access submodule bottom".

As I said in my earlier report, this kind of issues should, at most, only  
trigger a warning, not a fatal error.


The Git version on the system is Git v2.25.1 (Ubuntu 20.4)

This problem is not occuring in Git v2.17 on Windows.

Attached is a zipfile with a script that reproduces the problem.



-- 
Sincerely,
Yngve N. Pettersen
Vivaldi Technologies AS
------------wyFjHysXxvSE0t9nQeoET3
Content-Disposition: attachment; filename=generate_test.zip
Content-Type: application/zip; name="generate_test.zip"
Content-Transfer-Encoding: Base64

UEsDBBQAAAAIAFJzk1Ge/R+1fgEAAG0GAAAQAAAAZ2VuZXJhdGVfdGVzdC5zaK2T
wXKDIBCG7874Dlt7VifJvce+QB6go7KJTMV1AKd5/CIgJlonpuNF2AX+/ZB/39/y
krd5Wag6juJICkjlBUhevyR2pAD8wOinVVpiIYZtCjWkeBum4ptxOR0YE/fB7HDX
q5qNG65cA2/NJ03LQqJNHzKT/XvpuL50cksddSxUmbjcmaqhFiHLcpvLQzHQ1MVR
xdyIVU2QmClcuFTafBtM4MOOh0zfPEDB2DyldKH7sRYJMRAKSD6NjK3hpOJoRhOA
whVBcMYa9Nfw0Ujmon3hnOYK3xzxZBFL0pqmFw3xiOnifTGdps8nbtNQHdLevDW/
8hZEoTTKOBqt4FX7UhDrGxxKmjst7hF4fLwdZpLuO1Zo3IIFa1wLCwQuH2/gchv/
xRVe86FnX2keu3dR2zTq0K9mea1Bc3v60fBPvaWwopY9mOu4NNfxqbnOVmfVXWv/
6iXPuBpbTLPmmJes4Mrt7YXhlcIrnGvqGwYtGSFp1CsElJKkgRnlm+Ze7RdQSwEC
PwAUAAAACABSc5NRnv0ftX4BAABtBgAAEAAkAAAAAAAAACAgAAAAAAAAZ2VuZXJh
dGVfdGVzdC5zaAoAIAAAAAAAAQAYAD5wuJIK1tYB18ipnQrW1gE+cLiSCtbWAVBL
BQYAAAAAAQABAGIAAACsAQAAAAA=

------------wyFjHysXxvSE0t9nQeoET3--

