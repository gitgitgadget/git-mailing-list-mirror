Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EA7C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF2C2075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkHqQhak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKZBPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:15:40 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:41040 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKZBPk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:15:40 -0500
Received: by mail-pj1-f53.google.com with SMTP id gc1so7452003pjb.8
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AOMtp/DahXlxMPfhmZ0n5IdMHImmfCeFHWhMyMkMQUA=;
        b=RkHqQhakO7b3tfBQXfGWfrh6JwBoM2TO5AVOGooEUjgosdpvi4KNfoidI9FqSommN0
         ftvfdmM46klkLK/TRqUGLBFW/HG/CbXNEzvupD7bGpxhDQQjjCmRvLrHQCZflzN0HozD
         WbgNpQYBR9kFXEkR7pjVZ6dEcw3r52nrJjw+UjfniS2Ibhvm54N31/h1wirvd6ydZLq/
         MiAkVBmlDEVTp2GOxPtzCTJ7GKCG5W+uHBnNbGDoDih5UMZBqFdvltU9/Ac2qAv0GG+v
         SsDJEHXeC8L7AV4/680yldGshDV4bg/lKpwzUcgJKzgkDaneAqD5BQDz1COxJd+MPWoN
         k2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AOMtp/DahXlxMPfhmZ0n5IdMHImmfCeFHWhMyMkMQUA=;
        b=SQeIburRmV9uhzsFJLZrLqWNc87FIg7VRwCgobwsVkhR9ZaLvMrz+rkkOJ4H9IjT10
         cax9eQbhX57RgpKPeZSO3plY+Za7KTz7fAu9XJcrW/JnDYj7lKZs+kkMB20d1Mc/V71l
         RDnZtlNGqcEU3FZvSk9bZPs/OhTrfrE9LVata0n9nphTH1aPejUPPFW98PzMe495aCty
         DJANV9IVQ1VuC82f9StTa2/U9XZpk5UcRFH3rcZSlEYOQwgXAlqe/4T+LCis6NE/sof3
         ip0BAmypRzAf4K4zUm8B+UG6aYFmzZKdYCRBO2wPrl/OqbxweS0jlG45TaZ8ggd9vUzM
         cZ4g==
X-Gm-Message-State: APjAAAURq6A3fTpKO1gDA/wquJ20QlP8W7xP1My1XA7MibahUGu4qSkh
        ITbhmqSYXg5IcHbls5VQ/xMjYqfT
X-Google-Smtp-Source: APXvYqxaImV6KGAURPIt/xCYoZ4f23gA8Ka4ZmQB/C8CGcpJ7p/WH3gq2vHo7KmC/KrrchWgtbfRCw==
X-Received: by 2002:a17:90a:9b87:: with SMTP id g7mr2802692pjp.64.1574730939342;
        Mon, 25 Nov 2019 17:15:39 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id a6sm7130143pgg.25.2019.11.25.17.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:15:38 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:15:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Travis OS X gcc job is broken (again)
Message-ID: <20191126011536.GA30006@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I couldn't find any threads addressing this yet (which is surprising
since it's been happening for about half a week now).

It seems like gcc-8 doesn't exist anymore in our gcc OS X Travis job. As
a result, that job has been failing consistently recently[1].

An old similar thread here[2]. Not sure if the failure is related.

Thanks,

Denton

[1]: https://travis-ci.org/git/git/builds/616541763
[2]: https://lore.kernel.org/git/9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com/
