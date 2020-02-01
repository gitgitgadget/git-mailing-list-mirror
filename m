Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9469BC33CB7
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 00:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4FE20663
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 00:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mcgwiz-com.20150623.gappssmtp.com header.i=@mcgwiz-com.20150623.gappssmtp.com header.b="P/Lfz9t1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgBAAuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:50:15 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44765 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgBAAuO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 19:50:14 -0500
Received: by mail-lj1-f180.google.com with SMTP id q8so8909547ljj.11
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 16:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcgwiz-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54UjsSAtrVKScriaQHfVhS7oSxppMS++FwVJgYy2nnI=;
        b=P/Lfz9t1RE6bcDd3jtYrMjKLvJmiEpMU5JNnYZN3cETmG34Ov5CbAcIsDEzUtMXHB3
         d8r1kU4nkmjNBReMd36E0HFjDjjTdZiXRaaGGob/iOsOg+ZlQe+YDnjGEAovXuJT6Y36
         SGBNzCRaUb4gr/xFGsSQFnOCBS9RGqK1RbP0lVObL2TvYTGMPOyNC32Dh9dSmDEJjA2u
         z0h8F8jldtCv+KNeX58EQdjgE6lU8WZx0k4Pg+Ko5599mflms5gEqqa3rO2rzNFh3PtX
         CifY3lYzMlHzTYO3HHTLARRD0nRLJUiM4DqDl29Ya5cN3phi4cXYbM0Bsd+aMBiVX/9d
         h9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54UjsSAtrVKScriaQHfVhS7oSxppMS++FwVJgYy2nnI=;
        b=jLvZeLVLHBpJOYj1qJ4bOEXdlHpRS+b43wiqHv2oVQ6ShZErNDkl0ymrNPv8TG4ApD
         qAgFpVxUchY4/jTlgJJxG6SdjbdshtztA5PN3JzOQ1qGaCGy/mLdqkJViaLjyNseAfBE
         5C05eBZM1FzrQx1//aRbFQt0/7Jm1AecVUdmTKBdrRwMLy9kHxP2B68DHaYwSh1ClkYf
         acZ6i3Z/vwcTlUV3OrAuShJ59wt0otBU7iPHpKMKPDHuNNh7guqMtO7krbRaD5pgYfAN
         hoG+7PErhtZ8aVrqUz6u1pOvOEuMVEr6YN6FO73jCWj76Cl7oWTRjJMBrmdH18GBUbS5
         IGJg==
X-Gm-Message-State: APjAAAX9si8J2QqqVdMI80RV2piMYqNDlmb0i8ASdD6Zcji5kwsZwEqc
        TpHww4yr7ZBSoFyM8E3smBPeONSzfXY=
X-Google-Smtp-Source: APXvYqxZx9AbyGwf0mcKXdUwwWVfl3J9LXR8MMDfSvjHNPTlWvEd+0maTaumOsv2WPPdbCcPoQ04bA==
X-Received: by 2002:a2e:9587:: with SMTP id w7mr7330172ljh.42.1580518211019;
        Fri, 31 Jan 2020 16:50:11 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id j19sm6232959lfb.90.2020.01.31.16.50.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 16:50:10 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id f25so8900229ljg.12
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 16:50:10 -0800 (PST)
X-Received: by 2002:a2e:9207:: with SMTP id k7mr7413584ljg.175.1580518209015;
 Fri, 31 Jan 2020 16:50:09 -0800 (PST)
MIME-Version: 1.0
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet>
From:   Mike McGranahan <mike@mcgwiz.com>
Date:   Fri, 31 Jan 2020 16:49:57 -0800
X-Gmail-Original-Message-ID: <CAK7jxYiBPjcLBpNKy5k1jf116EWr4HB9B-2rzUxiCG+m-Kyzeg@mail.gmail.com>
Message-ID: <CAK7jxYiBPjcLBpNKy5k1jf116EWr4HB9B-2rzUxiCG+m-Kyzeg@mail.gmail.com>
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 4:37 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Well, let's first try to get a preciser report, to make sure that we're on
> the same page. These are the commands I ran:
>
>         mkdir add-p-ws-error
>         cd add-p-ws-error
>         git init
>         git config diff.wsErrorHighlight old
>         echo "hello " >README
>         git add README
>         echo hello >README
>         git -c add.interactive.usebuiltin=true add -p
>         git -c add.interactive.usebuiltin=false add -p

Those commands do indeed reproduce the behavior I described.

-Mike
