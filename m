Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31577C432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0E620733
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKKpFpGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKZAXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:23:30 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:37020 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKZAXa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 19:23:30 -0500
Received: by mail-pg1-f169.google.com with SMTP id b10so8050805pgd.4
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 16:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=spQyEiEJ6muXgIu1zpAPgYi90FG0ghcmknvivaZGrXg=;
        b=qKKpFpGSbuue6wplQNxEuzj4y5yVp6/WrFz4TxTIzCbUh1GUmos4IwdRXJ7zOjudWa
         uqb4yHhBsOY31c7AtFV3yVjzlXkSbBbzerBCVxW9ypiUaShSiR91+NaMiSoy19n+8G8g
         I3bNKNyX1Ot6MfqtzSzOVFFYiISK0G/pfb5YtqPGE3Ifjj/MNaSGxYWRjC1+JrTK9gnq
         xkjWR1Kh0C61XzsYIZyj/KTFO7FFfrgwx4igrhM7ZPK4rjvGfoM98+rdH7VLgjPpOw1o
         gK9/ytluqJPLqe12s6vLm3Xnitie1l3BZfMiOkrjwYyb5NgXQx6n6GY2JdmTth1QjcRX
         0iHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spQyEiEJ6muXgIu1zpAPgYi90FG0ghcmknvivaZGrXg=;
        b=S6vgrkYc27KzcMzkvBVXyGNU9VgwzVTEa3Ddy3yIF+B2TqmBHcKvE/3fdEmd4fcTtL
         o5/b99sfr7/14CF8mpt2nzFuvD7BbMDDW0F8KuTGl4TSZFM1S94u93Sg1VwFoyvQ9iMa
         MrVyYL0g7bKNhoLEMoNnkKYPOlSukXgJJJqh5yakCXnYl9GFPaqbiifdy8vYG549T7rG
         /dIuqowKTXEBJKvd21pNQabM/ZXRM832q+sfqD79XjhzIYOI8x3o7Oe7UvMXBiadrZum
         7NwtFAZNiz7u89mP05H5/NctfgLJfE7tTkKhKASn7qsJWpOKgp4nrrn1fF1Ig5f93p9S
         p1jg==
X-Gm-Message-State: APjAAAUjr1UKi1gKTq8hJlwb34kuELA4StH2ppXWWS8ZBi29D75buKfa
        u8WrsuXRfAVOd1HjAC7R7T7vRGvd
X-Google-Smtp-Source: APXvYqx4yNSfXKh4BWjwUFRLlUZZ4+zwb//BhgKgZxP8VdoLWwR5ntGfaIetV0k9hCOdBy3rmE6lbw==
X-Received: by 2002:aa7:982c:: with SMTP id q12mr38465551pfl.83.1574727808948;
        Mon, 25 Nov 2019 16:23:28 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id f10sm9604487pfd.28.2019.11.25.16.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 16:23:28 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:23:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Timing this week
Message-ID: <20191126002326.GB14157@google.com>
References: <CALnO6CDvGjVo=s2QDwXU_hEoYQqGgPXu=fqroN5Rv2iaxvwXqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALnO6CDvGjVo=s2QDwXU_hEoYQqGgPXu=fqroN5Rv2iaxvwXqg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

D. Ben Knoble wrote:

> I'm still drafting the mail for this information, but when I have it
> ready, when would the list prefer to see it? Should I hold it until
> next week? Or would you all rather see it over the holiday weekend?

I wouldn't worry too much.  Send when you're able and when you're
comfortable receiving replies.  Some participants in the Git project
are not in the United States and are not having a holiday right now.
Some like having an excuse to take a moment away from family to see
what other people are up to.  Some are completely disconnected from
email and won't see such a thread until they come back.

One of the nice things about email is that people can respond at their
convenience.  So fire away. :)

Thanks,
Jonathan
