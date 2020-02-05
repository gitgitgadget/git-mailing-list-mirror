Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43568C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2762082E
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hWYlXYqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgBEDAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:00:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35906 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgBEDAX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 22:00:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so221118pgc.3
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 19:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JuVPUj3i/sgRxMt8B/40Yb3eJJQDKJBAMuxppbh/bv8=;
        b=hWYlXYqPo6XZv2P/xnsGR2f6VsdM4O/X62dJGc+dihisSADQW4yic0gmhz5R5VwYxl
         B7rnm3G2vSLXwEs6OMumDJrnGVVrngABUde8b1SLc8cJyCTzKWV52/3mTTJqMVAyVi0M
         p52jY1BWx4mZJOAC1xhgEgPTnWYj9jmAKOaMlL5rl6q/QIZtYBTpI6T2JYLiQ4Fsl18P
         g/PKrmPK6nz8n6mi9gWBCZ3Ya1lQi2iGjb0/KZ5H+G9v3zZi8ZSpl8RdUv7m3aWdWmhO
         6p8NJREHyYHSvsNddpKpcAV/0l3qHu0vLf0AQLS148diupuo/VH3ws270zGiJKY3dy6Q
         vFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JuVPUj3i/sgRxMt8B/40Yb3eJJQDKJBAMuxppbh/bv8=;
        b=rFB6MwCjVL6+dPcrFq55ue1fAIiqW260bfvhp2YFv0JjwDDTqWP8JWWtOc8K7tgJnw
         nWZ9euqFP9jW7ZAomIaGAKjdNIGWegCW6n+0/KVNXL8dE9NT+6Sc0wTBzfaZMXFu9/Rz
         JB7Qd1ApSawhgmN7xkTrEeU4it7ABwsq2ueIXSkOzI19qPmCvGUmC/ZfBJ3A0QAhM2hL
         DsEvc8tuT3BIE862Vz9ttUzFQD9xBg3fQ/POJfQmOr7zDBKAf/cdYPkUC7wNsnEjZR4P
         WS64v20gc+vdOVqBLWZccZbo80e4A+VpzOVpCeMLXDa//p7IYgZemZDYdqFDp1zjrbkB
         Q2cw==
X-Gm-Message-State: APjAAAWMFJLXrFZ3+meBQ+zhTv902O9gq8yuBGRXxUVAi3MRyZl8Ftfx
        ze8ogSvoXQUOHGLKjt/GjeRa+Q==
X-Google-Smtp-Source: APXvYqxYZa8ljGr6fhh9NqA4oJl/LcWiQJRRKTs0kj8XTraHjhot6aIuZJWyK+Qbg4j1bUh0ZuM4dw==
X-Received: by 2002:a62:e40e:: with SMTP id r14mr34045817pfh.115.1580871622072;
        Tue, 04 Feb 2020 19:00:22 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id k3sm25696127pgc.3.2020.02.04.19.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 19:00:21 -0800 (PST)
Date:   Tue, 4 Feb 2020 19:00:16 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 11/15] bugreport: collect list of populated hooks
Message-ID: <20200205030016.GO87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-12-emilyshaffer@google.com>
 <xmqqh8068a5k.fsf@gitster-ct.c.googlers.com>
 <20200205024859.GM87163@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205024859.GM87163@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 06:48:59PM -0800, Emily Shaffer wrote:
> Well, with Martin's suggestion[1] to use annotate:bugreport[include]
> instead of bugreport:include[x], this kind of change becomes a matter of
> course to just use "annotate:hook[x]" and write a script nearly
> identical to generate-bugreport-config-safelist.sh, and add it to the
> Makefile.

Bah.

[1]: https://lore.kernel.org/git/CAN0heSq_i4EitqYH-qrZyXBU+=PUNcSXOOJDHLSnJ1ufV0WtaQ@mail.gmail.com
