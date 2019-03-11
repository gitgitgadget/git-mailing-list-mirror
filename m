Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7284820248
	for <e@80x24.org>; Mon, 11 Mar 2019 22:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfCKWuc (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 18:50:32 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52221 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCKWuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 18:50:32 -0400
Received: by mail-wm1-f47.google.com with SMTP id n19so730427wmi.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 15:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJWvMYH8u4B0bGpD2H2tzYibz/yqWHvlc6GO7DVJ1ys=;
        b=Wgizq/b3xR7Cv353v8eErk+rHyZ8JavODdVqMNZQS7QDfJ6+5eFmwfqMqxWhfXAQUM
         LObV4F9CqwKiqY9avcy1+UM4tUteKynqY2tZWI/DLQsLK4Uyb5jI3CG9H3yb4kVzzI0C
         esrCkvT+QABaPlDwz2HdFw8TAbxhW13cfNaaIEs8kLsHWCaVt5JmQxrJqFoaERiiXjvF
         w6GOrQ2kLu0hHtxfGWIDBb96OslKtgd2hWQSazA++oyhTjOLkZL1UjFn0sgIN1zyxJ8R
         Zhy3KXxqIMbMVsr1MJHdmDXooAdh1QhwatV33wdHHrox9et91ZeEfQqSQZV1eTfeNSjK
         iqXw==
X-Gm-Message-State: APjAAAXUrbJtDRcb+M+PlFz3yJSZiA+4pKHKXhqOv41ILP1BkcjraBrK
        jp+oKrOsoWo6K7SmpWbY7G12fvQPmgjoqNWLuDiWPA==
X-Google-Smtp-Source: APXvYqw8+vmww0Uy2P6YvQm4ajVDkA9h73+0KegT+KwDSQa3DrgBAaQA2PUmvULnSmzP0a+daioC0XhglbLgeIFic7M=
X-Received: by 2002:a1c:cecd:: with SMTP id e196mr257559wmg.31.1552344630502;
 Mon, 11 Mar 2019 15:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <87k1h55bx0.fsf@sergiodj.net>
In-Reply-To: <87k1h55bx0.fsf@sergiodj.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Mar 2019 18:50:20 -0400
Message-ID: <CAPig+cS_NLgwr6F2OqMpMZ3GBO-Cyru3G3UBxiT4ULJ_V1Bqvg@mail.gmail.com>
Subject: Re: Possible race condition with git-rebase + .git/index.lock
To:     Sergio Durigan Junior <sergiodj@sergiodj.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 6:17 PM Sergio Durigan Junior
<sergiodj@sergiodj.net> wrote:
>   # git rebase origin/master
>   ...
>   Applying: commitX
>   Applying: commitY
>   Applying: commitZ
>   fatal: Unable to create '/home/xyz/dir1/dir2/.git/index.lock': File exists.
>
> The first thing I did was to check whether the index.lock file existed,
> but it doesn't.

What platform is this on? If Windows, I'm wondering if something (such
as a virus scanner) is holding the lock file open long enough to
prevent Git from actually deleting it (and perhaps Git doesn't notice
the failed deletion -- until the next time it tries to take the lock).
