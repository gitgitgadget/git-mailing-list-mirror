Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B014C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 15:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23B22078E
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 15:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+6F6Jo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbgDBP5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:57:35 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:35970 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389162AbgDBP5f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 11:57:35 -0400
Received: by mail-qt1-f182.google.com with SMTP id m33so3699588qtb.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 08:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=8L9xyqoeJ7FJWu8I2iW0ewNYWl37V3lqGUMeUaj+o5c=;
        b=l+6F6Jo3efd60jXKAavxdp4rcxYJNc5+mTGnQDegx8ie02j7mD0dXBPvO859QhKSpD
         19TbJ4JGvl9QzrVySp2zIGZsquboXT6BcXWmPLh7h8TL5F8/C/UzIVfUrdZJhJDCp1Sg
         fiUkNfFBe/fuKgKloNouAPe2R/OWNB4QwgWydoXgsMJFvNwCi11S8uCVGKc3tCTUfyd1
         gy8K8gUjo1a2lqEHxk48I/hQ82r42uRB2seSoYePM1sx0kQePUPzdvnpfnwkaOgR64It
         rT2+4LNJJUUv+ZDwgCVlCjwF7XT65z8FDsv3GPpNeldNI0lH0J88A/EA7Acit98sjuKd
         KGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=8L9xyqoeJ7FJWu8I2iW0ewNYWl37V3lqGUMeUaj+o5c=;
        b=MjZ+bGq0GcWG6nYWR/sUw/5otVZrf8UZHAmi3DcQ6Cvdn+bK5KmJ6E5TtCo+oZhdL4
         l7T4Txwb7NcHrYmrP23IyAHIv3kKXVGnaRQqUIfktiIQ32IGsEFxBKI5mVvqyRhPZQ5v
         lidfCzAIMzJiBwaG14PxGWps5A8WQON4Y6QfyTXfoNutYRZYbm+9aH5Y1jZoYelRuSnh
         kDiu1hsOo07RSlAyxYlBodiFRF9E6FDjTo5/yDnOP+8c+6p+SbmeewEkDKx0GFiL1SYc
         YN2AVCJXzGGfPdCvraUkbhFUZjBj2UqWvjyTH2YJyJ//2Qu3ocR7AwqYoCmqujhswkne
         FjZA==
X-Gm-Message-State: AGi0Pua2L384nsKO17qEWgbaYyxlbZoHH+nK316kGglLEERcas/teQAM
        wfV5imCTQHR1aowBnjXvv2EpoRUF
X-Google-Smtp-Source: APiQypKg8nr90v05RyOx0y071iSzAStp4B0H7SZeGouOzkLkBIklSEZvvXl76z8PyKuZpTMizcILLA==
X-Received: by 2002:aed:2a55:: with SMTP id k21mr3716134qtf.159.1585843054084;
        Thu, 02 Apr 2020 08:57:34 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x65sm3793145qkd.78.2020.04.02.08.57.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 08:57:31 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: git rebase backend change: post-checkout hook is not ran by 'merge' backend
Date:   Thu, 2 Apr 2020 11:57:28 -0400
Message-Id: <9945492E-1D97-4741-B999-F30CA561D4DE@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm not sure if this has been reported yet (couldn't find it), 
but I noticed a behavioral difference between the merge 
and apply backends that is not mentioned in the documentation:
The 'apply' backend will run the post-checkout hook just after 
moving HEAD to the commit we are rebasing onto; 
this does not happen with the merge backend:

    $ echo "echo \"Running post-checkout hook\"" > .git/hooks/post-checkout
    $ git checkout -b <branch1> <commit2>
    $ git rebase upstream/master --apply
    First, rewinding head to replay your work on top of it...
    Running post-checkout hook
    Applying: <commit1>
    Applying: <commit2>
    $ git checkout -b <branch2> <commit2>
    Successfully rebased and updated refs/heads/<branch2>

Cheers,
Philippe.
