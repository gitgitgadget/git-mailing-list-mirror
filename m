Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2580C4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EFB20767
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtQtQ0bV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgCVADF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:03:05 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42750 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVADF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:03:05 -0400
Received: by mail-qv1-f68.google.com with SMTP id ca9so5240672qvb.9
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uGcsOHHNuxh2t+8gTwcNieqM0O9paF6Z5nWefVVae5s=;
        b=rtQtQ0bVterC52O7ynFZs43GX3oUNUd6LO8KPTfbJFNkHowYrBLcS8y2LbcecaR7xT
         ybBINn1gCU9747RNBJ86P4bVHhln0KMqq1Fl5VwKtufAtIUHELh8d/g8+Fduzfm1tZud
         LTY7ryxJm4tZDw7PuJaAAEMx0HxIPUh4OdlS/gBXa98/q6dqPGTYV94TksxPET/Ecs1E
         kyg2SSbNhrjRxs0jSlOEU1dRnviePzk5DCM3w/xD8BzvKaBsyWgz0FE3HVEBjJryjICc
         qLQI5VXe75exA2e7jIBzPyXi+HoCdVOGAu9pbheHsZVSVj2tEM1FoNZyS+O+FZ7rZsm3
         Ac8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uGcsOHHNuxh2t+8gTwcNieqM0O9paF6Z5nWefVVae5s=;
        b=Sh03IMcWMTr3eXPVEi9O5F+PIpe613F8dDA7hOHDWJHOUPLfeU7QUd5WsiaHjaJKf0
         WIyS8cpjxqvxtDVhgl7HfMIviaOFdRLxHLDZhnhXGXEPe3EYsCeaAXrI0iGOVfIkknJ8
         wVGUQ9f4zdmzHFxnU8RpZbzKsmIFmUG76zjKluKXXdoZdL3o+Tu11U1KO+5QH0sssizo
         ILzxeBFxnAjcBowo8nxknsOfyENzQcyUs3m90LwB54gVWAQDOqhNt0+1UJpvyvhAT+4P
         IoPqK2oCCnJ0Ng1OIGexuIl2GWxcnUxJ5xCRpPMoxV1JLXzYAyUwsI4v5DTfsveLrPDs
         8uvA==
X-Gm-Message-State: ANhLgQ0hDS/b80+bf9rlyyB3ZC4oJwMS9p9MLdFn973rbFM8ukmzKy5P
        GwNEoq94sfzbNvXQ69ghQNA=
X-Google-Smtp-Source: ADFU+vs8wQumICG5745uoJ8xIScIrgVGdw35bAGBlIz6WAFyAgIbkmeYjzdfFi1P0C2KhNivyzjVTw==
X-Received: by 2002:ad4:4766:: with SMTP id d6mr13938329qvx.136.1584835383891;
        Sat, 21 Mar 2020 17:03:03 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w21sm7624521qkf.60.2020.03.21.17.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:03:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
Date:   Sat, 21 Mar 2020 20:03:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2020 2:50 PM, Junio C Hamano wrote:
> Do we need to worry about INFO_QUICK and SKIP_FETCH_OBJECT in this
> codepath, by the way?

I was coming back to this thread to bring up these exact flags for
consideration. The good news is that in a partial clone with any
amount of filtering we will still have all reachable commits, which
are necessary for the commit-graph to make sense. The only ones that
would fail has_object_file() are ones removed by GC, but they may
still exist on the remote. So without SKIP_FETCH_OBJECT, we would
generate a network call even if the server has GC'd to remove the
commits. This gets particularly bad when the server returns all
reachable objects from that commit!

Thanks,
-Stolee

