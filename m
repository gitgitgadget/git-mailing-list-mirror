Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722181F516
	for <e@80x24.org>; Wed, 27 Jun 2018 22:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeF0W6X (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 18:58:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33434 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeF0W6W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 18:58:22 -0400
Received: by mail-wr0-f196.google.com with SMTP id k7-v6so55147wrq.0
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3Nz6OrvgU8CnKTBgZd5s7i3O+6rvuFcpx3IvUhMZMN0=;
        b=QnIxkPK7wFnMRPzrlramNjxUmQQakAKtpdGJXzEMHQzCp9D9q5dD9ZtGGGjAxkDG0C
         0peK2vlh9SUqanw1GtwZcLJ/bcWKu5v8TmjbxMn+f9cugYv4XwHldio1hWfKqIBbROW7
         qobQbIW4qi7m6c1AJhVI/w6Si9aclk5goxtsyQK+1B9WkdGr0F72+tL3WQUnT8VmAVyy
         7qp157wb5Ja9fxg+iofthffrTzu5faMJVGYZ2PC0FpoSuTHQEQtxgkCsyZUtpyCWTCtk
         q4DnWdwjtszVH0e8nKmI2LDNfSXq7RWGY/9zzJT6UTgv2F3ne4xj3+HYPWzDfyLH3Cx3
         qJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3Nz6OrvgU8CnKTBgZd5s7i3O+6rvuFcpx3IvUhMZMN0=;
        b=p5egCqeMFFiC4TvadkT6T7rr/AKSeZnv/TykcC5lAH4lrq8feeyufpaPYXYbij8OJb
         rZqiupHyW6J3dtDnxj+ABA7RWXJMAzLzbySqTX2U5+dQA3u7s7/XuGzTFmz+k/OlfN0H
         yGOcq1zTcJBYiKZNV1+kLwvt8Q1KWjHiF9vGtdfC8tTCaHGeo5oJDkUfL0U8lkXUVqa0
         7c7gpv18MwpkMdb6ZEdLeMOiZG1eQtKVPBpv3KupSWlCiSXFuFqpm3zPiBydoM4n01zg
         Im0mA7DCfGEmF86b3z/xB5JCQ1oHcd7s+hoaQaXsLyEa/9NzG6KVQjqNcdy4HXVyN/f+
         DzKA==
X-Gm-Message-State: APt69E3u1+uHFZkIgXpmYLvHWr2g9J6tDV8KHBvPa80vzPQsE5qqKZi/
        tWB6WmvUZHXnoIEpdJ9pdik=
X-Google-Smtp-Source: AAOMgpc2SvFINoIODYJQrXsljvwjlejuxlByuDmFiyRcyMRmeCCU/tMFPCj/UM2CPCde552iehv1Fw==
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr6797541wrq.58.1530140301304;
        Wed, 27 Jun 2018 15:58:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a184-v6sm6583456wmf.30.2018.06.27.15.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 15:58:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: when deepening, check connectivity fully
References: <xmqqa7rgdlwf.fsf@gitster-ct.c.googlers.com>
        <20180627225105.155996-1-jonathantanmy@google.com>
Date:   Wed, 27 Jun 2018 15:58:20 -0700
In-Reply-To: <20180627225105.155996-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 27 Jun 2018 15:51:05 -0700")
Message-ID: <xmqqsh57degj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Hmph, don't we quote these in the trace output, requiring us to grep
>> for "'--not' '--all'" or somesuch?  
>
> I thought so too, but this was changed in commit 1fbdab21bb ("trace:
> avoid unnecessary quoting", 2018-01-16).

Yup; fortunately or unfortunately, that and the "partial clone"
stuff are among the differences between v2.16 track and newer, so we
can just forget about v2.16.x and lower and target this fix to
maint-2.17 and above.

