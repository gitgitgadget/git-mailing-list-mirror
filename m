Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B8DC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A0F24249
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkMRwIeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfLESvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:51:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43327 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfLESvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 13:51:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id q16so1598466plr.10
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 10:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+pKMTRWWBICupQWc7JNCyLrx265UMjo9LavHDApUNdU=;
        b=EkMRwIehxW8RFFur8aTrWBcWidnWUHGfNwnYYQvjHg0NzTNxyLspB7Ch1Hf9Oz5PXV
         Zyi9pFVDIv0Av715MbJQ1lCnGo1RIrJpMhtLCu7mJkuJPOx7ngn2wPkwGObbtG+oVs7V
         bUAxOb7Q903aWzGxXztNlXj8hJOoLqEVXQTxnqIOvaEm1JPnHhvtrfzUmA7vIEg8fu47
         4K0l9Bv3mPYhg+6+9b+6eJDjSIw6t8ShykniD5Xgj8BhZLWSSDV8NEnqCxq5vJFXHln/
         0n5EjEQMHAGxVOd45r3B0i3975LNbaydiL4AL1ouan//JcFTwAARw5L0CS/Ro5RQ4kqp
         c7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+pKMTRWWBICupQWc7JNCyLrx265UMjo9LavHDApUNdU=;
        b=Lu3kV5QnGZxOYG+xfOpp3Tni6yFrfVmcjTEx8bB7+I3jFcXdcBV40/iRiV2W/7UBVV
         repwYwMIe8Jg13sF8qUJfoE1Gz7rrHYu1/CW2ZTGVVO6vOLPYukgfNqv7Zr2BtJGT9tC
         dBoFZWIbtY5Ym9gZCjwUcIp4kStHdEMTo6HHR/D+vJm9uvMSQmscIJ1vjjEK/gDYuzDd
         KdpJp0Ka1zOjurPqlxUUVYgdP3NJshzlYvfuy/cA16eqOEsYHfCixOrQ4ksF0MQJ3xyY
         6D48buI3M47dCoGyGUxX4wdcg00S8PkTqdP8lmB9LUgE1uNERxUXGQ0hCh4lPqq9QPVg
         yr9Q==
X-Gm-Message-State: APjAAAXHv+fdFYQaJOZ7NauWhIXc8LdUBJa+YmCXaYnx2gqPP4h7FFcS
        jgo/3qFadwaLxtLCBrGTAnA=
X-Google-Smtp-Source: APXvYqxwMaB6591id4zcXxIGlEjM9lQ8B9JiQ1KiG/BQ8l/KuV0ItPx8uzZJh3SLLpPz/9fsj6rJsA==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr11318508pjz.116.1575571877082;
        Thu, 05 Dec 2019 10:51:17 -0800 (PST)
Received: from generichostname (c-73-15-240-142.hsd1.ca.comcast.net. [73.15.240.142])
        by smtp.gmail.com with ESMTPSA id p124sm13310450pfb.52.2019.12.05.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 10:51:16 -0800 (PST)
Date:   Thu, 5 Dec 2019 10:51:38 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene <seraphire@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/11] git-p4.py: Cast byte strings to unicode strings
 in python3
Message-ID: <20191205185138.GA85549@generichostname>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <CAE5ih7-6EbEM4z5BtY87=82H_tLypiOPq4WY5mm3190QExTZWQ@mail.gmail.com>
 <be2a6839-aa73-dbf8-de19-823d3ae5265a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2a6839-aa73-dbf8-de19-823d3ae5265a@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 05, 2019 at 11:16:27AM -0500, Ben Keene wrote:
> 
> On 12/5/2019 4:54 AM, Luke Diamand wrote:
> > On Wed, 4 Dec 2019 at 22:29, Ben Keene via GitGitGadget
> > - There are some bits of trailing whitespace around - can you strip
> > those out? You can use "git diff --check".
> 
> 
> Is there a way that I can find out which branches I need to remove white
> space from now that they have been committed?

I'm assuming you mean commits? You can run

	git log --check master..

and git will highlight the whitespace errors.
