Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D2C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 12:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2CB20857
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 12:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/XtPeNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDIMRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:17:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43298 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIMRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 08:17:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id j16so744441oih.10
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h0Rd5Y/R5j24Us4V3wxRkLYgKDvPufjsq5cC/+RlieQ=;
        b=a/XtPeNGLxAm3dt1/7RAp9rpzUrY9yH4/Jarz1gIlDGSPDmDh2zqjVFUXoSXd+Xup+
         IsTp4hXhWX9eQGTCb9WxwXanhYJlR077/pKeAO76/iDwryUc7NWHR47Kvmw2xs6J6Xf0
         py+Hvih8b2kmJoc3BLKZvYGy9MPZFvkHIGkry3QZiLNw1I0N8Yu8nW7ihYocP/72CW49
         3xv27XsrBUgbCvJJude3vtoxudD8IeAjXXDeJjOWtqDpeZx0a0IzJiu1CUwM2lhkYRgI
         MlgbOhBN6fOU15HW/H868L6qYY0k2kQM+hoTiIZy5R/Z5rQFiUto6YpXp7Ka435nwNmZ
         UFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h0Rd5Y/R5j24Us4V3wxRkLYgKDvPufjsq5cC/+RlieQ=;
        b=eJ8Q61jnXyqnIAPDgQYhtsdHOnn6gzB4GTdllI2RmWA/1Jf5Btwpx9M0g636gS9sI9
         HQAbMZiEjAzop3r1xLgzWu+aYFVH+K/V3AxlIEomGQKQ3n5iN7Fi2W3y+Xx9TegV/s7O
         cNFLaL3KXifUbH5UgYjAnFMhxWImmzI85ntQUDviht0c0ItIrWAYrohRanw6XEMka4l9
         akFWuzTMge6ldxPHanvrXrixza/OlIQ1utJeGc0/s68MgC0O0TPmS+YxVCHc9zs3PCnF
         7Ep2y9torF08y2P2YR9bGSrfF/yxhsrEglTzHH3yA8+019K4R1wEVJltUwRgZ/09GKCw
         wOuw==
X-Gm-Message-State: AGi0PuZqX5qVG4GFP03wgUJfA+mh8rp4icE5mHyEI3/2fTEC/PWoRy5a
        It01CYqJwuS3wkhCISxyi+4=
X-Google-Smtp-Source: APiQypI/hs6kDj2K0MqRRhcyJsEnpNMf/jOkWJ1TvsHZ8Lv+Ya9QZCQ1WuKp2x8njjLJeyV6IqTmHw==
X-Received: by 2002:aca:7213:: with SMTP id p19mr5790455oic.44.1586434665017;
        Thu, 09 Apr 2020 05:17:45 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d23sm1472378ote.70.2020.04.09.05.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 05:17:44 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] line-log: towards a more responsive, incremental
 'git log -L'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <459f2978-03f1-a58f-0dec-d0376fec5201@gmail.com>
Date:   Thu, 9 Apr 2020 08:17:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20190818182801.7580-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2019 2:27 PM, SZEDER Gábor wrote:
> Line-level log performs a preprocessing step in
> prepare_revision_walk(), during which it filters and rewrites history
> to keep only commits modifying the given line range.  This
> preprocessing causes significant delay before the first commit is
> shown, wastes CPU time when the user asks only for a few commits, and
> does parent rewriting with no way to turn it off.
> 
> This patch series addresses these issues by integrating line-level log
> filtering into the revision walking machinery and making it work
> together with generation number-based topo-ordering (though for now
> only in the case when the user doesn't explicitly asks for parent
> rewriting, which is probably the common case).
> 
> The first two patches are quite straightforward (and arguably somewhat
> unrelated), but the rest deals with history traversal and parent
> rewriting, which I don't usually do, hence the RFC.
> 
> 
> SZEDER Gábor (5):
>   completion: offer '--(no-)patch' among 'git log' options
>   line-log: remove unused fields from 'struct line_log_data'
>   t4211-line-log: add tests for parent oids
>   line-log: more responsive, incremental 'git log -L'
>   line-log: try to use generation number-based topo-ordering

Hi Szeder,

I was taking inventory of our issues especially around history now
that the changed-path Bloom filters are close to wrapping up. What's
the status on this RFC? Looking at it now, I understand the situation
better and could help review a bit more than before. Do you have more
context as to the situation on this series?

Thanks,
-Stolee
