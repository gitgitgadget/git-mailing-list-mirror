Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65A5C4332B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 00:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BDA20753
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 00:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zvkoKjOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCXAJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:09:02 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:39140 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgCXAJC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 20:09:02 -0400
Received: by mail-pl1-f180.google.com with SMTP id m1so6637391pll.6
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 17:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8+BOhOHIzXW6oJDH8pgCTHivT5tTkAk+fA4U55FjIMQ=;
        b=zvkoKjOCMYV2G40fib7/isj4BUaAXVah56ZhXiK4/nmNlcoIQSgukEKW8rNiSIjZ4S
         En5CfO2kCnhmAtp3YyElWvsDjF82/k1q+1e1yRK8Ciem8S9euLvssU2aocS12Q4HMvNN
         IS78PkCEjPeF1hdsqLrzxaqP1NByJTCrrFbip2+r59XDmVtnD6bnzJA+NlAOkCO6etYI
         5WVQ4+NT6HqN8g1G/zMvujEGZqmkCpFzm73gkoZByr9PFSjQEzDbujn+v+sQ0AWGhXLz
         i8MKvwHg5Z8bxbejTpNqc92e0aB2xowZDvic7TkoyDTnPdyf5/kL2x0NB1AQ/G/nZBfk
         S/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8+BOhOHIzXW6oJDH8pgCTHivT5tTkAk+fA4U55FjIMQ=;
        b=KcjSEUMmpbK8Z1iOqQ0HK0x9l0OsAaoPAImQP1yje2+aDauREsTeGHAhhRUfz/2QCV
         3HOOrp0JMsXMB7RPvXGTqlXs6HCVv9Ql31pxtlLU63IUxtvEBgzMRBsgdt99uOLKOari
         VyrL1Z9rOqCw0QuG94A3DjyI8TOgEhFxxqYjs+1inV6MT3Od+gnXrADGzNEH57qYO3pC
         p99TPk7xOcg52b3R/HfXtqFPbMu6vGq+HQa33/487JGnhGQwutYaVSVX1q1W0RccAMKw
         du6MTG8XXZqsq27PpxsDGXSZqdgrtMw38+P0Y/1YuL9ESX2lBE1wDvDWklOo/x8a+1ue
         wrQw==
X-Gm-Message-State: ANhLgQ3xBCDXMdUa2PgtzQ5yKvEySfecki47qmSDzeh6Gfe3ayGMlmY+
        /QM/b1wZA3WnUuig6z5d5FedWw==
X-Google-Smtp-Source: ADFU+vtj2btXr3deekJ8o9wvpJOi4vtV9xbt2C+gDxFg3W6PZoGeFYbqzGZ7jD73icsMLTZUCfyITA==
X-Received: by 2002:a17:902:a40e:: with SMTP id p14mr24290408plq.295.1585008540798;
        Mon, 23 Mar 2020 17:09:00 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o11sm13077305pgh.78.2020.03.23.17.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 17:09:00 -0700 (PDT)
Date:   Mon, 23 Mar 2020 18:08:59 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: Season of Docs?
Message-ID: <20200324000859.GA5514@syl.local>
References: <xmqqh7ye3b66.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7ye3b66.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Mar 23, 2020 at 04:26:41PM -0700, Junio C Hamano wrote:
> This is a companion program to GSoC we might want to participate.
>
>   https://opensource.googleblog.com/2020/03/announcing-season-of-docs-2020.html
>   https://developers.google.com/season-of-docs/
>
> Many places in our docs clearly show that they were written by
> developers, which we may want to rectify.

This is a great idea, and I think it would be good for us to be
involved. I know that Stolee wanted some help writing documentation
about partial clones [1]. Maybe that would be a good project for this?

Thanks,
Taylor

[1]: https://lore.kernel.org/git/pull.586.git.1584638887.gitgitgadget@gmail.com/
