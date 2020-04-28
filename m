Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42383C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183D0206D6
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5o5uXF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgD1QmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgD1QmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 12:42:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0587C03C1AB
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 09:42:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s8so366325pgq.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 09:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OMUjkAvam+JAy7MNjWhxNttlsTtUHfrbv4OKavPwVOk=;
        b=b5o5uXF919vs8DxOyOlmsl/7SixZiMA22JoDe6xk5TsVq/AMY9ocjKqu4dTbY6XSk0
         lha2O437rBbBoIYsmruUJhp3c6GsKUzSVZZaaw4zHh1+50TwUUPA81wTAix4BvL7aQFt
         kly9tso+Xac6daNp5TMEgLalcRNggVT31fNCnmsPLvB8bCjh3QHaSvknueLgdfwzJ33r
         Ml9wSAo0Y3qB9BeTlnjOPvCxf5y2xMZGVrY2OtaQgeP7MW76KL9EE8PECJL6L/ni/Tfm
         FJOhJjWqwgsE0bKT4WCXE5USEZ84YnKBBit88+yEYLNvPwWvJaizqo2euJs/WnJTApbP
         M3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OMUjkAvam+JAy7MNjWhxNttlsTtUHfrbv4OKavPwVOk=;
        b=S7h8btJwPR6d8gdNS5aAHyY7NOJFe4tB8UwKlJYCeDYEYORaTsX2qn6HQmY1Ci0RTf
         yFUF2qJ4dV2/QA3hdGjCzAhvoODa9R3D/R4mgvAB7S1ioqxTptbnm4ToqdwFon7zyj0B
         8SPp/PSv4V26y6c3iO5efw7l6cgM+pMycMbjLmuJgaEsfKbXDr+jvSKlFSYjSgYDts01
         FQJrUhaa1NmDuw4r0GsDVgCSBC6KCJ1LvYEHquL+nNGxOMNIdcdDZjpX0eglarg5kPB8
         T0D+Rm1NqSby2MVqiD4bngNZ89t7byNX3J2WPHBkumYLMh+mpMGdBOJ3BS5wbw9qmyyS
         Lhcw==
X-Gm-Message-State: AGi0PuY2DLBHEtKutsKtWwLQkm6JuUh0LJZ4nlZc/UNBf/x/g2fu+xuZ
        ag6TtdHjErDVdROhpWI/6pxsfbZ9
X-Google-Smtp-Source: APiQypKhNCSghoCUkc8Kq7yMlkm44d21ekCFMHzIvWXaPyeN7mTCxQsPUl0xNwZsv87ahrByJb4EwA==
X-Received: by 2002:a65:5509:: with SMTP id f9mr29685003pgr.70.1588092127090;
        Tue, 28 Apr 2020 09:42:07 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id a16sm2983384pgg.23.2020.04.28.09.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 09:42:06 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:42:04 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Dirk <dirk@ed4u.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/4] git-credential-store: skip empty lines and
 comments from store
Message-ID: <20200428164204.GA56126@Carlos-MBP>
References: <20200428104858.28573-1-carenas@gmail.com>
 <20200428105254.28658-1-carenas@gmail.com>
 <20200428105254.28658-2-carenas@gmail.com>
 <CAPig+cR8YGGXLcdiv1SHF5wQ305RgG1S0JhheVgF9fYstKxaQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cR8YGGXLcdiv1SHF5wQ305RgG1S0JhheVgF9fYstKxaQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 12:09:50PM -0400, Eric Sunshine wrote:
> On Tue, Apr 28, 2020 at 6:53 AM Carlo Marcelo Arenas Belón
> <carenas@gmail.com> wrote:
> > git-credential-store: skip empty lines and comments from store
> 
> I don't see anything in this patch which makes it skip anything at
> all; it only introduces a new test.

my bad, forgot to fix the subject when rerolling; does something like:
credential-store: show "regression" when bogus credentials in file
make sense for the reroll?

Carlo
