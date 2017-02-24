Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB392022D
	for <e@80x24.org>; Fri, 24 Feb 2017 01:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdBXA7n (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 19:59:43 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:35157 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdBXA7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 19:59:24 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so5304770ith.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 16:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6uTQN3aqg1lnZHynAAlhjKdstviuMQc4LoVrG80is0A=;
        b=JrAbnZ7JX9xljt0DjpBf7w2Mjg/LJjeNVK0pQ6ynHsdl78BxhZkN0WdPvCxUQV+NjL
         Gd+Ke+acBJ4R6KZmNfJfkxWRhQH9S0wjZeEcUGM/aostRuYEke6IP7s8BWY83hBSTu1L
         6AXXHHdmmbJvXjm1z7qDkEGvzQNtqSQbhMiLM9EzvxuosCmNmY7K/90K85LlIZFYCRvL
         kAebLfZTmo1r51Nn0YjSFo3tlFBiKwJPe10/1V+rhW9G7UsOWIxXfi2srZBvXH1tiGBC
         a/aVQCNcImC09FONe6JTJ/JLPbhmJu/O05/fyiAfgNFk5Y9yqIYmbhchP7xU6Bz3onFW
         ORog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6uTQN3aqg1lnZHynAAlhjKdstviuMQc4LoVrG80is0A=;
        b=tN15+iiy0WL/cUNDguhYlTeeEHrltwbscudz0YRtE1aiyaDWAwtOhj93ngrUej4u5R
         lC/mNMHQkD9z+8qscVwTaglkpEPtq9hDkyo8Hqpdl7W7bdP4gAecVZRdE/Qlo1nTCTFw
         URTgRNO/eBBYP4dmxegjJ1dXvBpuU/C+nY6bKO/diLy5hw06RSNv6RLyjxoxbycRvPCa
         1nKcW3XLpeOpn8bTUbV3eE9FV5qGLvMYvOZ680/qw/NWTcd96x3JThSn4bDLHXKUYc3U
         ZxKIXRDJdBvCeAmrenetCD8pexXGkIAh7Kc4eqtIiwKy1oxbNKPjuhlbNLE07xWiGuno
         tPqQ==
X-Gm-Message-State: AMke39nREaDpQH1jsnOOpUK0DStPT6X9e7OfEbWlDD6fdunvdsTd6u30s5loEZIPX/qWWIlxVk5PZMYSPHBjeOsK
X-Received: by 10.107.37.148 with SMTP id l142mr460334iol.159.1487897935949;
 Thu, 23 Feb 2017 16:58:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Thu, 23 Feb 2017 16:58:55 -0800 (PST)
In-Reply-To: <20170223234728.164111-11-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com> <20170223234728.164111-11-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Feb 2017 16:58:55 -0800
Message-ID: <CAGZ79kYmmeVOYSPTvAbGpRQn1YL9yjPOkT5xCoSDmtNzQ1t2fw@mail.gmail.com>
Subject: Re: [PATCH 10/10] submodule--helper clone: check for configured
 submodules using helper
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 3:47 PM, Brandon Williams <bmwill@google.com> wrote:

> @@ -795,14 +794,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>         }
>
>         /*
> -        * Looking up the url in .git/config.
> +        * Check if the submodule has been initialized.
>          * We must not fall back to .gitmodules as we only want
>          * to process configured submodules.

This sentence "we must not ..." is also no longer accurate,
as we do exactly that when using sub->url instead of just url
below.
