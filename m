Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15195C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjDTTaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 15:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjDTTaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 15:30:08 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9115940CD
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:30:07 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54f6a796bd0so54521937b3.12
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682019006; x=1684611006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UMoepDnNhxgLuCU8QCPO778UbX1wY6YoWmZvqJn3OCQ=;
        b=iijTIKsAfwDwPyokBQHWwZ+/9KgkHMVpQTsxQrEcJcMv4ZNTiqOdwUfWpgbK+p6og7
         YqBxt46ZbCtroANK8yoLI4CzRBThfnur8MnnHqzvN7I0wiKBu7JPR9mBmh7FVHuKGcG6
         mLztTIu2LJRpHiXkBGY0aRxTLy03KDyTGJ37PjcRd7E8H2UyZqcc223w7tmP+2tuByRI
         5OzC3mW8S8yY+DcAVtHcBpv5lyBuMWkic/FVZu9d7ewSxKE+ttp9szqMjtkYqnk+Pbf5
         fKhvI16VyLdshUhAdwalaoJSRpYbn2ECaYtR88KBLaBHzLg9BsBW03HwwEJXEIL6NRjW
         JcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019006; x=1684611006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMoepDnNhxgLuCU8QCPO778UbX1wY6YoWmZvqJn3OCQ=;
        b=JtKTEwH9yxdQJ0HJ6vxYA/L73jbZQQA/+gUQtTMmdL8MlsBGHqMP88RVhaJD2RpaY1
         j5NgxkNVUHexLudXC8IM0WJRKst7aSzj8z93g0pQFKStU0/sdVMtsP5htkgFaWfwND7U
         PwUO+RVpc3wB/3YqEUL//qrnny0Jr0FyzMDw1fFlTsUeSpdiKQRhBcJ8WOhgC9YyXfCf
         XGrnTPty8xD2sT6IfYzeDfwQCjEKlfykSV6xuzLv6NsVi3mdMUITm3ViGd7MYzEulQRZ
         lKEknGXJ5l4vR8vzQUqtBPxD7q628fYSNGYG37JR63AYOngqNxPZvhmSwzxl57aXAHNx
         oTAQ==
X-Gm-Message-State: AAQBX9chdCwufZ6WoSr6PNnU4YIXF4MOTZg4AJj5q9WSRRLgT9rL7YBX
        fmDnX6OM2pDQPJrQzHUD0xjnUA==
X-Google-Smtp-Source: AKy350a9ZqpurWCsfDY6cAOjA+pO0rjNyyT6AZ2nQ9iIime/SP1xYXa8QAF44Nb+vDREUdz38KGBZA==
X-Received: by 2002:a81:4e43:0:b0:54f:b112:7680 with SMTP id c64-20020a814e43000000b0054fb1127680mr1658670ywb.41.1682019006562;
        Thu, 20 Apr 2023 12:30:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d4-20020a81ab44000000b00545a08184b0sm498059ywk.64.2023.04.20.12.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:30:06 -0700 (PDT)
Date:   Thu, 20 Apr 2023 15:30:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] builtin/pack-objects.c: introduce `pack.extraCruftTips`
Message-ID: <ZEGSvfEkE5PhokKv@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <xmqqzg72zalp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg72zalp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 11:12:34AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > This patch introduces a new configuration, `pack.extraCruftTips` which
> > allows the caller to specify a program (or set of programs) whose output
> > is treated as a set of objects to treat as "kept", even if they are
> > unreachable and have aged out of the retention period.
>
> I can see why this would make the implementation simpler, simply
> because no existing codepaths that determines if an object is still
> live knows about such a program hence all the codepaths by default
> keep considering them expungeable crufts except for a very limited
> set of codepaths that will pay attention to the program.

Right, this is about band-aiding a situation where there are objects
that we want to save for whatever reason but which do not (need to) be
reachable via any reference(s).

> But it makes me wonder if it would make the life of end-users simpler
> if we reserve a special ref hierarchy, say "refs/crufts/*", than
> having to write a program for doing something like this.

Ideally, yes. But I think there are certain instances where there are
far too many (disconnected) objects that creating a reference for each
part of the unreachable object graph that we want to keep is infeasible.

Another way to think about pack.extraCruftTips is that the program
invocation is acting like the refs/crufts hierarchy would if it existed,
but without actually having to write all of those references down.

Thanks,
Taylor
