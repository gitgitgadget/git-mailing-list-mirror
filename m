Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97BC41F42D
	for <e@80x24.org>; Thu, 24 May 2018 04:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeEXEzV (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 00:55:21 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42588 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeEXEzU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 00:55:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id w10-v6so523369wrk.9
        for <git@vger.kernel.org>; Wed, 23 May 2018 21:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jq05QTnteg8LkF6ytEGYAyAGirssWQ0AJF1fczUxGcI=;
        b=dKVkSgbBH6SEqxw+iSiC9BOL9gZuXQOq5VPB6HEsCpVAvet3pSueoY9LRX42FeD+Go
         EjTM6cyfy76r79Vy/xtR7zsr2tELa4moQPnjZkrcIj/diMnOUK0edhAh3NBYIfVCm8vC
         dpi7TCNCHpuZIzh/zAs2hK1JCv2nB7Tj/rvLm23CKL0562vXuAbBwAB5KPzYnMSsIrz3
         zA6kzb6RJlYblxS3QKzg0SzpvMRm8PhcPZZwE+7iuDdyKAZSO3/mca+vC/vMZTVRBro6
         oQ3IL2Ya8u3FdMK7SMFN++N2LiacjyWKw8aJK/U1tkmi18sU5Kc5IEUJ60zFMCR/uO8W
         lPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jq05QTnteg8LkF6ytEGYAyAGirssWQ0AJF1fczUxGcI=;
        b=mXdMMXrcheLyTg9MiM6ATPDrqn5ER2Gb5s8wjbhIuS9qvaoqQNFLyBl95qVdDxroW+
         87JQaqyXrzjgu04NJOeVDiU813vIecYEumdiYvwsXuuI6Guj0BX4oxNy82BOE+16RPte
         A/wZRpoUcrfFEQ2/GEeebL+6GwpWKsYezJByYSDq6EE5dOg7FLPqeFiCpNEXG9dUKznB
         rXu/01DU44Wp6vFkpDx/meXTDfOsXOce+yXmNfEGZrkvLUzoh9CZq6wxPrrlb5eL+7cB
         998UH2ZpAVEFouY5gWVRsXj3bhODAm0/+NWzPEy7w/NUhIPOeS1hJxelKmoY9BR3wys4
         QHzA==
X-Gm-Message-State: ALKqPwdiv9X/drQwGmuJoYtjyMTlrtTFtHApyOAmIa7uiOJQ471L9Y9A
        3kOIvjCu400uR0ynku7Zvdtj04va8lQ=
X-Google-Smtp-Source: AB8JxZrbwxwl+wxKl88y0HZYV2G49T0HBsJ8WH2lTPqKW/uuUM7BUEQcqo3B3NSneVmND0p/i1geiA==
X-Received: by 2002:adf:a185:: with SMTP id u5-v6mr4410474wru.262.1527137719499;
        Wed, 23 May 2018 21:55:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 32-v6sm13289562wrf.33.2018.05.23.21.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 May 2018 21:55:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "peartben\@gmail.com" <peartben@gmail.com>
Subject: Re: [PATCH v3 0/7] allocate cache entries from memory pool
References: <20180417163400.3875-1-jamill@microsoft.com>
        <20180523144637.153551-1-jamill@microsoft.com>
Date:   Thu, 24 May 2018 13:55:18 +0900
In-Reply-To: <20180523144637.153551-1-jamill@microsoft.com> (Jameson Miller's
        message of "Wed, 23 May 2018 14:47:29 +0000")
Message-ID: <xmqqa7spsle1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> Changes from V2:
>
> 	- Tweak logic of finding available memory block for memory
>           allocation
> 	
> 	  - Only search head block

Hmph.  Is that because we generally do not free() a lot so once a
block is filled, there is not much chance that we have reclaimed
space in the block later?

> 	- Tweaked handling of large memory allocations.
> 	
> 	  - Large blocks now tracked in same manner as "regular"
>             blocks
> 	  
> 	  - Large blocks are placed at end of linked list of memory
>             blocks

If we are only carving out of the most recently allocated block, it
seems that there is no point looking for "the end", no?


> 	- Cache_entry type gains notion of whether it was allocated
>           from memory pool or not
> 	
> 	  - Collapsed cache_entry discard logic into single
>             function. This should make code easier to maintain

That certainly should be safer to have a back-pointer pointing to
which pool each entry came from, but doesn't it result in memory
bloat?
