Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C621C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342F120731
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="dEplyGM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgAFXHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:07:09 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35858 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFXHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 18:07:09 -0500
Received: by mail-wr1-f48.google.com with SMTP id z3so51813468wru.3
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 15:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PM7QkNMBBUGXFiS6ScoqJJCeqf4J0sWMyPsoytvfUw=;
        b=dEplyGM3I5iWQiY5aCqZHu2gFu+CmyjqSKUWbtsWtkBeHT97FbRLff/LoqQDwxri1u
         MyguKceoxSpkYgpciyyQCl2ZO4cN2hSUtFTlxymhQmTCVbjUHU2bjnL1j+pCSdFPd3FV
         eCZKALkuuUCc7W6zkiEXZfks59kkYSjUF57/dGZlyBGKGId/uKJb6ssm/LyggxdNNTKY
         w9s+Ck5VwbUPkc+CYk6C75fNVshAdfudzbHTtopJemxyl6pWsLIh2umDRKmzF0t/DAgV
         MuAi9xNMD6KcV1lBd17U7G8eXHB6e4TwP2YZyUbQ5N+8LuN9vQ9+YAC4P64PRBCk43lW
         xvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PM7QkNMBBUGXFiS6ScoqJJCeqf4J0sWMyPsoytvfUw=;
        b=T0OkfXuxkpmjyVn4ozNIOgVAWnhbm6npJPOn9gSMnnrAqFOG9RLtA3HWDLBsFf2cx1
         +Wm6jHGJCCM6Y5Vv97GLUPMCLNAnOZf3XBa5/3XAdbPOAPJFaq323BRjr9GI6r3FtIIj
         lNlviG73XBAhQr/9Q8+zQl+cadb3DZR1JB5fzymIsIIX4OTAofr217f79wsoDWHItuqG
         /XC30ZxrOH45COMgKM5StIbtKIPGLN+FmoYZmrmo862FwH+z6JzCb5RIAxSCrmAhmHQg
         EInLcnpLvI00gjFlhFhHAVcr6PfcucBW89kHiePkLg8hfEt++zulgfHPvro6W2k5/Xin
         Xn/A==
X-Gm-Message-State: APjAAAW3YJFUkueUIVX55/ffe+m4RU5drjUErQMCmaKlqr7UirVCaP9E
        dRmeRCLOGrfV6mrhWRx/cdxLEyWKB/J5x6UxZbU7VyDFDx0=
X-Google-Smtp-Source: APXvYqzMpmaMHyEAlH8s5tLp9vo2dktPSes7pWKvIIW3Ny3lYe1Q1pKZsuSHHO+5rcQKxj6FHxvBNfH7cALWJK4wXMs=
X-Received: by 2002:adf:dc86:: with SMTP id r6mr111644124wrj.68.1578352026629;
 Mon, 06 Jan 2020 15:07:06 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEB=m94egho+1UOGeDSFjjzwXYA-HncM-9C7NLLP=E3U2Jw@mail.gmail.com>
 <20200106212343.GC980197@coredump.intra.peff.net>
In-Reply-To: <20200106212343.GC980197@coredump.intra.peff.net>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 6 Jan 2020 15:06:55 -0800
Message-ID: <CA+dzEBmZrecxSPZAXTyB1DfL_GAPkhRRJTFcb5A=pAVpFJANzA@mail.gmail.com>
Subject: Re: Reduction in blanks in `git status` makes output pretty cramped
To:     Jeff King <peff@peff.net>
Cc:     John Lin <johnlinp@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> (I didn't even notice, as I think it only affects the case where advice.statusHints is enabled

yeah this makes sense -- (unfortunately) advice.statusHints appears to
be the default

Anthony
