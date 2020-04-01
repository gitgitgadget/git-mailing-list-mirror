Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A2C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 09:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D65220772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 09:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcK8V5AT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgDAJFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:05:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34292 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDAJFO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 05:05:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id 10so21010333qtp.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nwe7g0NjK1szX0mgq17tGgEAvSSWVMgxiX1WYzU8XvU=;
        b=ZcK8V5ATAfif9mhv9CwxQMUMwMRDOq4g0jIL2W+cIGFOuqSBlVy0YwtSrcuyso1293
         r4WRonez/XUgfnN2JKd7xhbLqIdG1SLY3TdpZjv58k7PCpwPQ8o5LWW8Pet1XrB3QhZJ
         b1H9hGUOZHjv5IY6+nSG3YhpCt657lWvgf+SBvYgSHUqJEYncK0kQ2xoXJtwTsXCWb74
         gdCblgsVkeDsjvCAv47R71ybwu1zeNt+DwBwSabL1r1YnkuOwBNN2PhZAfsC4VsYtnGT
         vUVY67kpIe1h9bn4/Nby9qDL1KPSRVCK947qeGMQff4c68q2rIqJLkvRCC5rU4s5jOOW
         qitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nwe7g0NjK1szX0mgq17tGgEAvSSWVMgxiX1WYzU8XvU=;
        b=sFUFyRkokhl73SaBZHJuJ2ZOGmAqF3TH3KpJdbvUvM/KNvyTVKOSMfsPODlhMjP7QF
         ycPSyiMQPAueDvxVGfWE2RKITKCF9P8rokFOK5ky0hz2sUsPht0vPk4qyHtzw2kehT7W
         78vPr2phaNIys4yXfSfrLRxQ2XEBpSFQIMywvlI0/jl/zmS3UWoudX07HgWPoXOei988
         6YI5j6d4Sw2KRGhe5oyP5yHedL22ERKuJCvH9+Cp45xTxtVtFJLSs3RuSyRFRWhW/qc7
         MyFO978rz6vWR1cdnoBN68dPumb2tBuxZ7RGoSDs3O02NPr+Au13/aayKukBN1yai4D4
         VheA==
X-Gm-Message-State: ANhLgQ03gYWJZ4G2BkS/SvVw4vw9v4eOhXE62QuS0m4w8UYgzZYv2zNJ
        4jqmLWtTKiFB3U6ZBf139n0QbTmV
X-Google-Smtp-Source: ADFU+vvN1RkK/CJdChFHK8HlLqW27fx3IG1/KaWrHL4K0jmLtR1lqt1NqOXFuZaNzqDZ5dGNSZ83VQ==
X-Received: by 2002:ac8:2f23:: with SMTP id j32mr9561560qta.120.1585731913317;
        Wed, 01 Apr 2020 02:05:13 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id d72sm1058990qkc.88.2020.04.01.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 02:05:12 -0700 (PDT)
Date:   Wed, 1 Apr 2020 05:05:08 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix -Wmaybe-uninitialized warnings under -O0
Message-ID: <20200401090508.GA828142@generichostname>
References: <33984eeaabbfbcfd4b9d3903549d8b7d6c4ced7e.1585726172.git.liu.denton@gmail.com>
 <CAPUEspgBkmxszgBee8C9hZnEwqztf-XKEj7LB_jWVFJaJCge0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUEspgBkmxszgBee8C9hZnEwqztf-XKEj7LB_jWVFJaJCge0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlos,

On Wed, Apr 01, 2020 at 01:01:41AM -0700, Carlo Arenas wrote:
> On Wed, Apr 1, 2020 at 12:31 AM Denton Liu <liu.denton@gmail.com> wrote:
> 
> > Nonetheless, these warnings block the compilation process when
> > DEVELOPER=1 is enabled (which enables -Werror).
> >
> 
> you can also alternatively use DEVOPTS=no-error

Thanks for the tip. By the way, it seems like your message was sent with
HTML so it didn't hit the list.

-Denton

> 
> Carlo
