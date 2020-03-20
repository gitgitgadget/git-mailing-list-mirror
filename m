Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87432C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 01:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0C820739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 01:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/Eo7ONs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgCTBaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:30:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33723 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgCTBaA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 21:30:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17so1674395pgo.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 18:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Csc0PfAeCsTf08AAH42FME2WDpOzZhj6VJYE1pnfHJI=;
        b=R/Eo7ONsj0BCeRdLnm1msA+QefEvvBsuhkYx9hxy0tgsrJ56YsfowmURYxFSBlgX1Q
         BK1Py4vP9NM4Kr9Drd4N2ba6qBHq662Nwc+G70eamJeHt+UUT0uwAgkGZL1CiFHKW/2l
         X2+dT5jYIYbp1yo6BtFukVcFjn9QUdNirFjcpky+VKNe3bHSaoIi4PbbEtbbfeMlVeU2
         qE/NNGSwUs/YMojztr+chcQmwmlnyXCeSyIsOEwVQqp3LOPRoj3O+X397gy+APJbgt2s
         VMbkV9VKdUAEv9003BW/0qA0L9vr+3IIjzSxnmRsDdNBKLzG2InFzWNvJfiIYpFlHcU4
         arYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Csc0PfAeCsTf08AAH42FME2WDpOzZhj6VJYE1pnfHJI=;
        b=fU9FO1f3tSlYdfO31JjHQmxLWriipi1d4SKYQkBZ8d6kf7VGPxdqYYQ9oS1/peZYW0
         P4y223khDa2g13SK+clupawvsyLdETy54/Hmfs9jPwBSsHk4oSWx7Sq3gYQLOBpQThx8
         tq9g36AxtsJ/cRWBZpjT+3AR6xhz52yn9vnpzDFX9PaeH081SJSWef5ZQgNw9LhC0q1G
         RTTfUpivO2N+dbr8PWl5amyOYAp+khKwEp5gvyrY6liJXlhZDZ8EEyQXfLZt2zft0AMy
         s7wQKp9HllqiNKPRycccup7Fb+RgxywG6Nc2OY/FVsNTk84L36d5+zTspeoaIyZwTO2W
         CmJg==
X-Gm-Message-State: ANhLgQ3xazTgyMsWA8Grhnp/9CQ7oT/maGvifrcixEMwLgKzpLejGUo9
        Uc17/7bL5la+Nv4AkNvlWDoSU+rk
X-Google-Smtp-Source: ADFU+vu+b/yOm9MUIA6nRgUXpu9Z8H+ce0SwK1XhhjW6q6VyYLp9+Q183Wa+yRChykvMDhYgvHjFEQ==
X-Received: by 2002:aa7:951d:: with SMTP id b29mr7203373pfp.30.1584667799430;
        Thu, 19 Mar 2020 18:29:59 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id x8sm3740454pfp.135.2020.03.19.18.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:29:58 -0700 (PDT)
Date:   Fri, 20 Mar 2020 08:29:56 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] test-lib-functions: test_cmp: eval $GIT_TEST_CMP
Message-ID: <20200320012956.GD1858@danh.dev>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <7e184d97df8c673b0edfb6223c82385579777b19.1584625896.git.congdanhqx@gmail.com>
 <20200319160211.GC3513282@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319160211.GC3513282@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-19 12:02:11-0400, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 19, 2020 at 09:00:03PM +0700, Đoàn Trần Công Danh wrote:
> 
> > Shell recognises first non-assignment token as command name.
> > Thus, ` cd t/perf; ./p0000-perf-lib-sanity.sh -d -i -v` reports:
> > 
> > > test_cmp:1: command not found: diff -u
> > 
> > Using `eval` to unquote $GIT_TEST_CMP as same as precedence in `git_editor`.
> 
> Adding an "eval" here will subtly change the behavior for other shells.
> Right now they'd just do whitespace splitting (which presumably busybox
> is not), but with this we'd expand metachars, etc.
> 
> I suspect that's fine (and maybe even preferable, because if you really
> do have a space in the path you can actually escape it). So I don't mind
> this change.
> 
> I do worry that this whitespace splitting behavior could bite us in
> other scripts. Curiously, my version of busybox (1.30.1) doesn't seem to
> have any problem with it, though.

Ah, this patch wasn't meant for busybox.
It run into failure with both bash and dash in VoidLinux, and bash in
ArchLinux, I couldn't start p0000 in Ubuntu docker image due to
missing /usr/bin/time (even if I have /usr/bin/time installed).

-- 
Danh
