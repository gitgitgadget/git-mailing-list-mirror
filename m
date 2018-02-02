Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80CE01F404
	for <e@80x24.org>; Fri,  2 Feb 2018 23:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBBXlv (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 18:41:51 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45626 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBBXlt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 18:41:49 -0500
Received: by mail-yw0-f196.google.com with SMTP id b16so11638518ywh.12
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 15:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4ylpXcGkSIkf5srlOvXlDN0bexMxTHaDsE9PpTiCcfw=;
        b=hqGLvGOdMNuHuo8b+8UuQmT6J2WUeqqC+Pu6ymFnsIPrLQrsEAk9hmP5zN6UGDOfcP
         M8OdrVG605YZkljZDauZUfeywqP7P+MdQi5dTXqbikG2iy9rjJVPlFo0+cR8u6vHC+3v
         99Gdo2wtFjKsLFuaBWGQDZUNk5lncwcEHc9/TLOCvFQvfBK3yiRHYUzECcp2x/IHLBaL
         wKgGInoxA5o8dY7K0a5habMZptTh1hnuRqQHOQDAwnDqwQNMxla1MGw4TGspiBkUqk6k
         ibFFqohMuy35Cura6y8XbDW5fTScWcTYz6YDvSuFUa4u0k1omRXMBvCzenwjsfCH9PSX
         /lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4ylpXcGkSIkf5srlOvXlDN0bexMxTHaDsE9PpTiCcfw=;
        b=phvkgaBCWHim91frHe+QQ+Pe1+VKFhjSMAlLQ36dL574COw7ribGeRMirVjhsemvF0
         ckIhs5tvt8QM0iItcTUWJMTeWOw6wjO29IxA4ihkWqLTr1Fn9Z205IgCK760I4zLgItF
         aT5P81TdktlruonYZPRJMSepFNoj+Cvcoi1CWIilYrkOL6U+X8LQjl9NGOU9qUOjxTdO
         00RdAEw1hik5EWeksKB9dHb896ctTjReyBVWrkCEAhka375ZtpVf8kFA3I4FQbzfvX2r
         x7hlfs4bLf2h5HAq4hsdBFvvCE17IB1js9pbt1gp4B72JiYseV/6JDZGnRYojdHh4XRT
         KRQA==
X-Gm-Message-State: AKwxytc46rHQQUezJuf3pXBPF+5YO1S1NA10996n29t0hAqWX7fkHYAl
        fDoaX9i7cIEvnggwUtAklwh4t241vn/uG5EBqwQN6g==
X-Google-Smtp-Source: AH8x225PtYRQszK5HXb5DFmFIVlX+buV6MxspkZUjj4TC7qsT4nGSn1il1kbiIbICyskMLxPDcvT0WdCCS6LtRNIlEY=
X-Received: by 10.37.219.83 with SMTP id g80mr28496183ybf.201.1517614908753;
 Fri, 02 Feb 2018 15:41:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 2 Feb 2018 15:41:48 -0800 (PST)
In-Reply-To: <20180130232533.25846-15-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-15-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Feb 2018 15:41:48 -0800
Message-ID: <CAGZ79kYdUOWp4AQAv+7bWxe6f2ewd3=L87CkRd6LKBLF_TroXA@mail.gmail.com>
Subject: Re: [PATCH v7 14/31] merge-recursive: fix leaks of allocated renames
 and diff_filepairs
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> get_renames() has always zero'ed out diff_queued_diff.nr while only
> manually free'ing diff_filepairs that did not correspond to renames.
> Further, it allocated struct renames that were tucked away in the
> return string_list.  Make sure all of these are deallocated when we
> are done with them.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Thanks for spotting the memleaks and fixing them in here.

If this series takes longer to review/cook, this patch
could go in separately? (with the last patch undone :/)
