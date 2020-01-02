Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ABCC3276E
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 22:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11A420848
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 22:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cOYhOVHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgABWTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:19:24 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:37911 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgABWTX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 17:19:23 -0500
Received: by mail-il1-f171.google.com with SMTP id f5so35209309ilq.5
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 14:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+L24/L5qWERv5Q2U3D/swBXqaSeV97kgfJG/IQ+oVmE=;
        b=cOYhOVHuzayu560IsSaD3FtulgBYqlVYtk4RmBAnjGMHMUphHQrDGWa9YwPNQoEqbe
         8VnjUF0hEgpbTwVt9UUKZNo2YK9RM2GH4yO0hLIRvtYUT/GX9tpGeq+eheT6YFIXmEbO
         MPyvmnW2DbqF5ya2aNFj5qc/OmIkETfRJjXTvr5e6PbyfKWC2eFfWCWCnDrj+BxaNf8W
         k4/7ob2PQNjn0kp37llJZxqrKomRPPur0fEn5l2sdXKxnusLz8DsMQiELuSQKZIFoc7T
         Dtlh/M4ZOH60746i1Um5pQ9KSTxh3B6xxZL2NUOh1dV9p5qW1ALMn1G5liMqWSR9muGN
         Ic8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+L24/L5qWERv5Q2U3D/swBXqaSeV97kgfJG/IQ+oVmE=;
        b=A2/FaO8HhAyN1xIhiZxX2UfE3pAaKclfBTg8i/TLsXZdq1qfl1bx/2kREYhQ/SlbZF
         Yvb+LsX23KuWn2Z6WlKsKCoVVPI7UgJEIHwNr5pN3WfaiS8xvfq4aW9v1HUM6pEKWB11
         0NHsKZGAgDqV7QJ0zSgoYIHNNfOp7kMwwmXwBgGy5dhtU3TaPpBWpYFkkjGHbPX7NZjf
         KXq3fc4xlsFJtt2h7OgwCgQiBerLDaN1RtoROAF+G8B66NJOkettZs6KqLUjukOo8X3Q
         PRcPw6irAQuiv+vwKc6Zu+6qY9bOqgeXPVnA7TkKs2x3QEoQAx9CAwDAB00nZT7AWJne
         5qtA==
X-Gm-Message-State: APjAAAVblk4S0pGDGTBSZW9vCHZYsLCj/yKzpDpd5WjIqX4kqsuPKRiy
        n2qrhF1HYwWBlcLEI+wgN6EeKg==
X-Google-Smtp-Source: APXvYqySov/lJ2kk/xqLVSgrgQcGKisMx5cGs1y1x8cBdZKQTElXVpOMKc1Eer/qJVXyU8xZTAGu6Q==
X-Received: by 2002:a92:d3c6:: with SMTP id c6mr75231545ilh.228.1578003562854;
        Thu, 02 Jan 2020 14:19:22 -0800 (PST)
Received: from localhost (75-166-236-123.hlrn.qwest.net. [75.166.236.123])
        by smtp.gmail.com with ESMTPSA id g62sm20257500ile.39.2020.01.02.14.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 14:19:22 -0800 (PST)
Date:   Thu, 2 Jan 2020 15:19:21 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0-rc0
Message-ID: <20200102221921.GA81596@syl.local>
References: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Dec 25, 2019 at 01:44:54PM -0800, Junio C Hamano wrote:

>  * The beginning of rewriting "git add -i" in C.
>
>  [snip]
>
>  * The effort to reimplement "git add -i" in C continues.

I noticed while preparing GitHub's blog post for 2.25 that the work to
rewrite "git add -i" in C was mentioned twice in the performance
improvements section.

I'm not sure if this is intentional, or if this was added twice during
the merge(s) of and f7998d9793 (Merge branch 'js/builtin-add-i',
2019-12-05) and 3beff388b2 (Merge branch 'js/builtin-add-i-cmds',
2019-12-16).


Thanks,
Taylor
