Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02827C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBEB613C5
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbhGNPe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbhGNPe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 11:34:26 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB13C061787
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:31:33 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so2851138otq.11
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=onvc5/bG+2hpP8pCyDCESJlZBb2/RVD7tnl0S2EmDlE=;
        b=OyZgsJCmLg1+de5yDr7Tkfq7lgt+BOUwqWMBdXSSNl67uS0Dsc6ArAgJyj++FJ/0Si
         9oOfgAOje4Xw43Qht2fxlQjI+LMBzbpKmHtbGu6LQcnwdjEuXHxu7ZjKWE3BY+BgiO85
         YwJX0Q3Lb1LuJuILFbUJe11vBy/hqx7o3mH9gSp7Ch+OrwR2MkLUGCQnhSxZ20BPq1Cg
         Dv5xaPJbNDNxJc8tksSq4i7AVfbttn15+y89t+jIjallQSDEYzsZo1szNuWM8y/gtTK+
         npqhWWJxOI/ZSxF7ZsBZJ3sgtHI5ZgeDf7J51Cxk0P3rgNL3i6JugfNRGBvsAauv/ot8
         vDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=onvc5/bG+2hpP8pCyDCESJlZBb2/RVD7tnl0S2EmDlE=;
        b=TAKlDTbQwy3YnP047HeBnX3zDxvOjPw7NeXkip+QUnehDifmC73jB93ahwyeTdGoYs
         SPXekpUJ6Kx4xHCalVcFo+eKlnE8KGW7B9pYNBaG4UElPDb2hXrUuD1uLCQbxoG0sOBT
         3GeMCU9r0jF7I2n+9YFVVQA+tvTM4pYqGEEMhmKTd1yvtu0Gvzq+oiiEhiqbWRAsLKR+
         8VisNedYZ38D0Gcu6LWLcv/6Fqaor065eFtkdjPpa7wHGEK542OabWpoj4YvOCP5jcgH
         KOqiGS/kgFhLeqb5yMGvO3GmLpVj8jsBhZIE/4nS4fmkM559Fyf34WnqYAQyEpAD62I7
         cVcA==
X-Gm-Message-State: AOAM533UPJIvvX36d/iDXXrgwTZTrVI4+PtVHNrDBg1C47jc20g/Z/FJ
        m4Y+NwpUZNHKq5rifgXbSuQ=
X-Google-Smtp-Source: ABdhPJz2q5obK+m/jo1ckq0mszm8BGGjDbxaswNErNCOPSA3OeXZILqKtnHCvr8s8p7KLpacYMuTFw==
X-Received: by 2002:a9d:5f07:: with SMTP id f7mr8647257oti.183.1626276692840;
        Wed, 14 Jul 2021 08:31:32 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id v4sm82739otk.75.2021.07.14.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:31:32 -0700 (PDT)
Date:   Wed, 14 Jul 2021 10:31:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathias Kunter <mathiaskunter@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60ef0352705ca_261120866@natae.notmuch>
In-Reply-To: <7a97ac78-f405-2dca-2998-f03637cc8255@gmail.com>
References: <7a97ac78-f405-2dca-2998-f03637cc8255@gmail.com>
Subject: RE: Default behavior of git pull
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mathias,

I hadn't seen this mail.

Mathias Kunter wrote:
> Wouldn't it make sense if "git pull" would by default also pull the 
> branch with the same name from the remote, in case no upstream is 
> configured?

I agree.

In fact, back in 2014 I wrote a builtin called `git update` to fix all
the problems with `git pull`. That command worked exactly as you
suggest.

I recently sent a new proposal for `git update` [1] asking for feedback on
how different arguments should be handled. Nobody has suggested
anything.

For the next iteration I will implement what you suggested, in my
opinion it makes sense.

Cheers.

[1] https://lore.kernel.org/git/20210705123209.1808663-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
