Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E0BC54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjAMQKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjAMQJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:09:16 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C0A60CD3
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:02:21 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d16so6426820qtw.8
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5PhIjODYSbVSjnvqOhFgzmNYKBTXnLsImearfIjpyEU=;
        b=CaYhsr5ekqN43Jelm2SxEMBSChnV23uV/39VNgnEEhfBCdm2RoNpYJF4HU/kdj6H2k
         rCjScQX9YXkW5XKtktFOom616TIAy4jRFBuMe+iHuBi2903+dK2erN/W/yzi59rCmhc2
         C38RADyVYa4bqfcpzoS9SL3q4WCeU83ISUptQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PhIjODYSbVSjnvqOhFgzmNYKBTXnLsImearfIjpyEU=;
        b=C6WQcn0dV1gw6NTMlsmynME0b6/j8N6IQlEr86VyVKgA6R+aeVssVdMkQOHkgKayVh
         Ej/BrrF017zLehBwLpQpiu0A+l+8JJIMz1ux7S8d96LNpc7/yRal2nhR5I8nubgC4tV5
         kf/xYBMPQsziF5kU1IHLx2iRnLiDENrTOtE24JIlwZhozaPKQi6eXtm9JpvBVcj9ciut
         wNzFnOZ6fTkHBXDIG8eJ4IrZIzSnBGWN6HYOlRB7z3TDtRnliRym0Y8AOREw49XkzIah
         fsnefw6ZKidHbLxSjRBzjbDBn/ccRLdqiUKMymqrNbjt3OwHjlbU1B/yR/wctfrc3gDS
         zJ2g==
X-Gm-Message-State: AFqh2krTljfTf2aMpoNz10tTE/DJ7t1wZqrQsjQKnXdn4jMpwYTC6LA9
        qH7rT9ZsjJQsJzOeIUITJNQ550/Xt16UHp/c
X-Google-Smtp-Source: AMrXdXs/r9rQGfAuFfuOyBiF07Dh9VOV+2cE+b+4lDWC8dvBUi9haRmUvOyU1VMoTIEwuNkUvajtaA==
X-Received: by 2002:ac8:4454:0:b0:3a7:ffe6:dc60 with SMTP id m20-20020ac84454000000b003a7ffe6dc60mr113006140qtn.42.1673625740229;
        Fri, 13 Jan 2023 08:02:20 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id fw13-20020a05622a4a8d00b003b1180f40d7sm3593054qtb.40.2023.01.13.08.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:02:19 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:02:18 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230113160218.d3nsoxpbrxrrszhz@meerkat.local>
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
 <d087568b-919e-61f8-c203-e59a2e0572c6@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d087568b-919e-61f8-c203-e59a2e0572c6@selasky.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 04:54:39PM +0100, Hans Petter Selasky wrote:
> On 1/13/23 16:45, Konstantin Ryabitsev wrote:
> >   If, for some reason, Linus ever needs to remove something
> > from linux.git, he will do it and just give a heads-up why and for what
> > reason.
> 
> This gotta be a joke.
> 
> There are 46K forks of Linus Torvalds Linux kernel on GitHUB, and if Linus
> Torvalds one day decides to do a forced push, it will for sure be a
> disaster!

No it won't, and I speak from some position of authority on this subject (I'm
responsible for git.kernel.org).

If Linus has to alter the history of linux.git, it will for sure be an
extraordinary event -- it's never happened yet.  However, it will be widely
publicised, the reasons for it will be made clear, and everyone will just
accept it and move on.

Git history edits occur all the time. Most tooling expects this to
occasionally happen and deals with it correctly.

-K
