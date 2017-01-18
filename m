Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 184731F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 20:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbdARUUR (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:20:17 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:33394 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbdARUUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:20:16 -0500
Received: by mail-io0-f178.google.com with SMTP id v96so21370244ioi.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OEJcJeEyAzAR00Gpg2BA8Aw2y/yCKv2KC4PswZKCzBc=;
        b=hREThA+QRRiCUhkPIi74ZkOQXtww6I5RnQuKhEljy03+mVxRI4bJxboiPr7jnsPgWG
         rnHIEnGMzKQ6mVVTauzuOkYPkNR+lyHRuPny6SnaHywVausclASb3w0Gg4f5wNvhZzHl
         gyOZ0htCJBDkotxhMKXk2mILsqgJWChf2HO+SiAdASw480u8g+vgkuEM0Joi+Gxtr7OT
         w5OOsix3DAkB1mtl1erPWQILLtNZLflZh0sHtkvw0kj/cf0Ixo1kBGRGbvc1/DI1gD3o
         1gO4CSZjA0oK7f12uLNk8shK5uKqX9omHRNHojtItTweKMoMQpXc8jbNT/ve9ETV78ng
         E27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OEJcJeEyAzAR00Gpg2BA8Aw2y/yCKv2KC4PswZKCzBc=;
        b=aNuZpcSCztghwGwQSHywSmw7Do/MGl4GwixW8yEF2r86hOLkBawN33PaWhfL80j/LD
         z3dAbheSf8xcY0uFX/gd0ZhqgDVX8av+8iv4j9uLJxBLk+BsFNmt6maKrLj2vLJvR1g2
         4SDjsG4/axN6qgO3d+9YwxkcxBrNAajUAg1I7xgrUBrtfzhR/7QpTMAfy2gi596Fi/bE
         JpSQGG6TkVZ60itVJFF8+PWP7Ff/LocrOh7KV0gotmeyp61gsHgrNEJUFqFMbW5ecYz8
         8268yMDzFGWr5Mb6l6mciH0FRadz/usVEVQossBAxg2YV+CB6vAe9lG3XdfVfYNMZvPu
         I4Eg==
X-Gm-Message-State: AIkVDXKBuUFH2m/X664F7Mafs8KJp9kZm24Qmq3BzlXa4Jw+35hw8xxdMyTxza4WuAgzpwUE8nlVMhL2oXctu4p0
X-Received: by 10.107.3.160 with SMTP id e32mr5399833ioi.52.1484770815836;
 Wed, 18 Jan 2017 12:20:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 18 Jan 2017 12:20:15 -0800 (PST)
In-Reply-To: <20170112235354.153403-22-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com> <20170112235354.153403-22-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jan 2017 12:20:15 -0800
Message-ID: <CAGZ79kYdcVNK9KJgM0Na0MJ4QuGM+8OJxFb1oQ+VoDL--Ay48Q@mail.gmail.com>
Subject: Re: [PATCH 21/27] attr: use hashmap for attribute dictionary
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2017 at 3:53 PM, Brandon Williams <bmwill@google.com> wrote:

> +/* Initialize an 'attr_hashmap' object */
> +void attr_hashmap_init(struct attr_hashmap *map)

In case a reroll is needed, mark this static please.
