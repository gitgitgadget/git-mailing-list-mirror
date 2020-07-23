Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E29C433E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0E5207BB
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 14:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZdijqf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgGWOmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWOmM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 10:42:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BD2C0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 07:42:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n22so6666227ejy.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jHWd5lCTRmfq1hKlUYko8kE/v+E58bZViEwlE1R+OlI=;
        b=LZdijqf4mjAm3a8D+b28brDSms0P8dS3yghwpOVV8eVTM8HY8hkwqO11N8uMFlMvVr
         eA/qYXufAANy5KLQXsL1+PKxy2fOfbB9Ze1wrgXScoP51daphTOPRgimzuKyZ7/Bv4dK
         TuqNDlXqPd3/SKXl/TXbG+C9qrRWE5bP3YsBuF9pdLUMo0r8X++S32+NuUU9D3MTYURU
         Qa7+aFOFYUxw9rqd3juYLDcUKPjq11GXO1JseLoJLJ28xFcTsFtY9xaZOr4H6XK9PQhO
         M0G7Sl6jtbxH36rCo7siYHGZAtitqvGXJzjNVK3NoYLgiK5rEkCHU1d+AUgq0NuKUv+S
         vm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jHWd5lCTRmfq1hKlUYko8kE/v+E58bZViEwlE1R+OlI=;
        b=kFLWXvvaaZtt5yVKc6F9H8CzgOup+0SI4fEnwZ/FgAq2xU2+6ZTUI0TD8MAHsxqkQ/
         GkVHRzpuMoavjc65IRBstXHYDZ0UQ8v65SyoGVixG4/XzwSDODZaEsH9dqh5MEalAa/O
         9gdmjsMqOtf3EPBlRYmyDKrhY4ZBHXhU0j+NMSvgQhRFKI4yLZf2/n4hFXAxDTfz/0o4
         vNkrKeKsnIQlcPqO0Hxhlk+r7DAkJsFN0IdlzmhYsh5z3qZlD9XGch0K0M6egXn+uAOo
         Vf+cewfuR9gziRGKFLNi6PP9O3cLODz56xpR4jCqRVhibq9wJHfDRgpfTnBZYYZsxX4M
         Yg0Q==
X-Gm-Message-State: AOAM533XNKCuHFuviJmPKI7n3Zo649STUCRUd56Ypg6UO9/XFKuyZtfd
        dXgFwuPaRWQzOKDRvZ0EJakwAqUv68E=
X-Google-Smtp-Source: ABdhPJzHMQhhTxdPJY5kwzZN1woCDeVphGx8IcQoGMsg8L88a8SQ3+ASt7xxQmDTEgrqwKvNuBLVZA==
X-Received: by 2002:a17:906:140e:: with SMTP id p14mr802234ejc.430.1595515329509;
        Thu, 23 Jul 2020 07:42:09 -0700 (PDT)
Received: from alien.lan (p5de031cc.dip0.t-ipconnect.de. [93.224.49.204])
        by smtp.gmail.com with ESMTPSA id z101sm2223164ede.6.2020.07.23.07.42.08
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 07:42:08 -0700 (PDT)
From:   Tilman Vogel <tilman.vogel@web.de>
To:     git@vger.kernel.org
Subject: [BUG] git-cherry false-positive on upstream new-line change at end-of-file
Date:   Thu, 23 Jul 2020 16:42:08 +0200
Message-ID: <2639321.dTF8K4C05n@alien.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report! 
Please answer the following questions to help us understand your issue. 

What did you do before the bug happened? (Steps to reproduce your issue) 

I was working on two branches "master" and "feature". On "master" I  
"git cherry-pick feature" in order to pick the latest commit from 
"feature".  

What did you expect to happen? (Expected behavior) 

When I run "git cherry master feature" the picked commit is 
marked with "-". 

What happened instead? (Actual behavior) 

When I run "git cherry master feature" the picked commit is 
marked with "+". 

What's different between what you expected and what actually happened? 

Because the commit has just been picked, it should be marked as "-". 
The actual behavior claims the commit had not been picked. 

Anything else you want to add: 

It is important to note that the only change, I did on master after 
branching "feature", was to add a missing newline at the end of the 
file that I changed on "feature".  

If I replay the same scenario with a file that has a newline at the end 
and I am only adding a newline at the beginning of it on master, cherry 
gives the expected "-" after cherry-picking. 

Please see this simple example: 

> git clone https://github.com/tvogel/cherry-broken.git 
> cd cherry-broken 

# see broken behaviour: 
> git cherry origin/master origin/feature 
+ 26f77def8f1380cc3fd08ebc3f70652da79f1a2e 

# check that patch-id is actually the same: 
> git show --patch origin/master | git patch-id 
ca5d666a572ec32bff9cec17b97d611316f89236 
0725b090dd82f2e6f9949ce853778391e60b08d1 
> git show --patch origin/feature | git patch-id 
ca5d666a572ec32bff9cec17b97d611316f89236 
26f77def8f1380cc3fd08ebc3f70652da79f1a2e 

# see OK behaviour: 
> git cherry origin/master-ok origin/feature-ok 
- 7ce2c0ecd3024c04bcf7b78d332841b2e791e06f 

In the "*-ok" branches, the file has newline at the end from the beginning 
and "master" only inserts a newline at the beginning of the file. "feature-ok"
has the same change as "feature" (content-wise).


Please review the rest of the bug report below. 
You can delete any lines you don't wish to share. 


[System Info] 
git version: 
git version 2.27.0 
cpu: x86_64 
no commit associated with this build 
sizeof-long: 8 
sizeof-size_t: 8 
uname: Linux 5.7.5-1-default #1 SMP Tue Jun 23 06:00:46 UTC 2020 (a1775d0) 
x86_64 
compiler info: gnuc: 10.1 
libc info: glibc: 2.31 


[Enabled Hooks] 
not run from a git repository - no hooks to show


