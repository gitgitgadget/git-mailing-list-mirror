Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C8DC433F5
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 07:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhLYHrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 02:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhLYHrm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 02:47:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABB7C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:47:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q16so21327795wrg.7
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j7M+t+OeTvOAlPxt4K6w7wDwptP5jn6+owA9YTfAyCU=;
        b=TronR3JKB4/ffZaZpbxpRbUUVl+e8Gl4vIsM6maisnUif+R+x+TgtoFkw69c7kMts5
         wMg8WYpYxFIBWed1mYfr9igV4Na9bPR2Ql2jaeP297+Z0Z0Da+oN8si6puPsxY0qLd4C
         oVMqi4tQd+NSoVwvuSSUeXWAcHLkYQRBLLWRHmn1uoXvRG6YYWZ9c3Rx2slCLTTlrrR3
         8sv6Fx7dQbmx5WdhF1XcNnQktsN2fC0bBay8QGn0h9e6MHsnyDYhk6CkS7kOlJqHf9U/
         amp++x6Cc69TXw8v9kcW7dsmi/l09scKgwqxG7qrIZzys1Bi2QHEDig/sYJe0OLCHKYL
         WpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j7M+t+OeTvOAlPxt4K6w7wDwptP5jn6+owA9YTfAyCU=;
        b=d4paPKlotrqZNH6QIf+ILb9cy5PzeLct4t27KR/mqR9wcjuxPJCe8FCJUlp0MQ+kXl
         7am1CiiL+yXjZoQZxQfJcdl4Zhcniyu7YL7NOx/ACrK4YTWPKSgu0EFaf3HbMQSSWtRY
         7rGCLyq1Q8n0xe43wMLTnNWV8RqbgMnoWgZgbYwin/TF78Fpi9BXZf2Vdg4AZ0xCq4kW
         xkWwKyw0XBlQuaUuDFvL/NlO3A+ROcJagp8uAnLFH4MHxUJusUVTu4KD3Cww3Q9QgR4V
         matcVLAy622jdvF7N5abSCp92vjb+j4Dh/JyCs+a5xfFCtzDJTPZ7CQy4LcHq1aAindN
         Rm9A==
X-Gm-Message-State: AOAM531Qq/ISfBUyJ1A4lKhO0knJiKt5iECa5h/5PqiFA6Ftix388bFQ
        0YXTThA33Sblplpu1fBkwdgzqyjXYxd2+A==
X-Google-Smtp-Source: ABdhPJyYgv/6FYnPTeu8B09HKM6X5DfWfftGGyzH5yNKeeUXsIKEnyrs4MedTFxgIAeVK6BE4FzytA==
X-Received: by 2002:a05:6000:18a6:: with SMTP id b6mr6365266wri.675.1640418459720;
        Fri, 24 Dec 2021 23:47:39 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id n41sm12292417wms.32.2021.12.24.23.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 23:47:39 -0800 (PST)
Date:   Sat, 25 Dec 2021 08:47:36 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH RESEND] t/perf: do not run tests in user's $SHELL
Message-ID: <20211225074736.ozxhbb67pzpaud6g@gmail.com>
References: <f22f978a-26eb-8fe9-cab4-3fd60df69635@web.de>
 <211220.86bl1bwkp9.gmgdl@evledraar.gmail.com>
 <20211220131121.mdxe7o6p3y25fzbw@gmail.com>
 <xmqqilvjugu0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqilvjugu0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 01:06:15PM -0800, Junio C Hamano wrote:
> Johannes Altmanninger <aclopte@gmail.com> writes:
> 
> > On Mon, Dec 20, 2021 at 12:56:58PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >>     That was added later in 3f824e91c84 (t/Makefile:
> >>     introduce TEST_SHELL_PATH, 2017-12-08). We will always have that
> >>     available in perf-lib.sh since test-lib.sh will load it before this code
> >>     is executed.
> >
> > yes that's a good thing to point out
> 
> Care to redo the patch in a final form, then?

Of course. I should have acked that earlier, sorry.  I waited until I could
send my updated version but didn't find a quiet moment until today.  Anyway,
sending the updated patch now.
