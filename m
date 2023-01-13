Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F0DC54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjAMQjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjAMQim (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:38:42 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3B7CDFB
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:36:21 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id a9so6328346ybb.3
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUQfWNs9rvx5i3byNwIO+DlTsvyMzjEVy3ZAcnn6JYo=;
        b=aE1pHAIiE6o9GCQFueB7J0Ky/UNsrv9ySp7fqDcPDUe5uatgFpfivPgsamrhSQ+SyG
         +jUaj8E8eyaLSKXK6HEMqZjipjCQFeL7KUPa0rXLNC4VA4DvzAeTXnHvNrPVuDlbTNiE
         qI//JiXnSSRbIIwidoaup6hEeVTBvBqFzXuYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUQfWNs9rvx5i3byNwIO+DlTsvyMzjEVy3ZAcnn6JYo=;
        b=Oohi+ir/xcy5tUzJ64EHYr+ullaDz1+5kV8SBRQrQkcmEv9ZsYPkz4UIgHjZglR1NC
         hRDa8/ToBLkM58V0L5txvfhU1Gg/UbTeYYIVPK2p/Iuh2okMj/svcSPqf9vUzxx/GgS7
         oXzOmUTQlhKMsMDFu3luXi3kUMiU6QeWQ6r5RcRJBur38Mr9i0cDN+hr0QZZm5fnIbKZ
         FyFe8QabCXn1DHKL6KXH6QqRkg/bDSdXuJNyZ95+Bh+JjNBhIk3AyszarviN4WV19Cck
         d99iInlDR7ewUuAMNpFJaK4ps+wGSZ5NAu0vNSQoDFo60LdIbkn+0kZvR77nyv3z7cNx
         l7mw==
X-Gm-Message-State: AFqh2ko7pSmSILoWzJbpeUGxLOWLsa2sHx0b9adQsyf89LfuSWm9gsmX
        cxBNGOo4RhkEwftRtowNsPEFxw==
X-Google-Smtp-Source: AMrXdXv5QdvggzGOm3weKUuMZiFbO9xOebI9tgtQuyEEv+j6LzAKKdamry/uSVKmxZKJcExx4bAThA==
X-Received: by 2002:a05:6902:91d:b0:78f:e3b4:f54c with SMTP id bu29-20020a056902091d00b0078fe3b4f54cmr50391434ybb.57.1673627781045;
        Fri, 13 Jan 2023 08:36:21 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a450500b006fa8299b4d5sm13100329qkp.100.2023.01.13.08.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:36:20 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:36:19 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230113163619.4ab5oyqyjrthxrwv@meerkat.local>
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
 <d087568b-919e-61f8-c203-e59a2e0572c6@selasky.org>
 <20230113160218.d3nsoxpbrxrrszhz@meerkat.local>
 <a2e6fdc3-fbb0-821c-078f-1ad4e55dc8e3@selasky.org>
 <5971b434-6409-8fd6-130f-f5b871a10f6d@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5971b434-6409-8fd6-130f-f5b871a10f6d@selasky.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 05:18:40PM +0100, Hans Petter Selasky wrote:
> On 1/13/23 17:06, Hans Petter Selasky wrote:
> > What's the point? Only so that one party can stay in control?
> 
> Let me phrase it like this:
> 
> You clearly believe in the zero-trust principle. I don't.

I'm not sure what you mean here, but git is certainly not zero-trust. When you
clone linux.git from git.kernel.org, you're very much trusting that:

- I (or members of my team) didn't mess with the repository
- Linus (or someone who hacked his laptop) didn't mess with the repository

Git is tamper-evident, not tamper-proof, so by definition it cannot be
zero-trust.

> Why can't git support both beliefs, and it can be configurable somehow then?

Well, git is literally built on the concept of unique hashes. It's not
possible to make this bit configurable, as it would be a totally different
project with entirely different internals.

Not saying such framework doesn't have a reason to exist, but it's not
something that can be built on top of git.

-K
