Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9518C1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755214AbeFNRc2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:32:28 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46433 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754783AbeFNRcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:32:15 -0400
Received: by mail-pg0-f66.google.com with SMTP id d2-v6so3223735pga.13
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YKsO9Jq8oNDd1+cOw/hseHv0wAflFXPlihONI5UY344=;
        b=byYiQjlxRt4t8caLAx/4SJg7fx2w5iZCz5+aBjCZ69ljcqsOw8LAu1ACQMMf6hRT8I
         mwOPwyp+5C1n9cJBL9jI7V21XHOgaDMj3DV/wfmeYXdxcHXh2E//FJ6tjhCdjpRCmdrC
         mWGVaDD/zImBo6tZVD8XsPbYfRDXTqmt0aYns9ppFyOFBZHg5A/msNoldmImaPNAu3dZ
         p92zllWZQsRBUad2Pt8Jt8EHBgNybTK3EYIRLNouB59Uo2RqMVFLHs+FinzqvRVR/iP7
         tJjGlzXXSzgLluocWNdLxF8I4Y8+6/hRyeYUtxrHWFx3HpaHZ/85Z5JlB5nzXCjcz8jB
         OyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YKsO9Jq8oNDd1+cOw/hseHv0wAflFXPlihONI5UY344=;
        b=G+eYCW4ZUtlfhuH583dfiPbyswB3TJCpjfGra3MvYhucD/sTFVBvI79wiifzFeGWzH
         ZatKgi5jV/7BnVKAocfkf7CT8EaxI6GYxEquZPBJEyRMjk3WRnuSxpSzL9iDqT0xnb4b
         SJNQQAp+PDZLYU3MwnEiwpJ9j8ZoEUZAkc1eGSLNtM7TB+Bahk01+2EfI9KdPyCGDeGG
         8hI40GETelg+WwFl97AE5nhRlb8Fs48fzkI/HUUQ7+L+vq5HE42nsSeJJvqVrAdKXnTE
         Syd8YUePDiCES4lBWwKtmbVTllTORY/c9hlqyXK3QdgVcwBV7Sgo1cNH60UA3u48vnc8
         9QUQ==
X-Gm-Message-State: APt69E09I0RXbpZM0fXgndSp0Ptw8oHIh6vbebee4XL2YBPgHbRirX4T
        Vi7Lgpr2Bb8MICBQ5P1abmYiWg==
X-Google-Smtp-Source: ADUXVKLfmeh0G6U1gORz9J5TGHUaN3gvfFmJojJhLpoJhR+H7TE35WN/9Xc05KJ+j3fYEV0znHGYNw==
X-Received: by 2002:a65:5546:: with SMTP id t6-v6mr3043912pgr.363.1528997534972;
        Thu, 14 Jun 2018 10:32:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id k12-v6sm7096337pgo.31.2018.06.14.10.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 10:32:13 -0700 (PDT)
Date:   Thu, 14 Jun 2018 10:32:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 4/8] fetch-pack: use ref adv. to prune "have" sent
Message-ID: <20180614173212.GC220741@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <cover.1528317619.git.jonathantanmy@google.com>
 <f12342fb2760eb0449c86c66bf44d39f5871be57.1528317619.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f12342fb2760eb0449c86c66bf44d39f5871be57.1528317619.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06, Jonathan Tan wrote:
> In negotiation using protocol v2, fetch-pack sometimes does not make
> full use of the information obtained in the ref advertisement:
> specifically, that if the server advertises a commit that the client
> also has, the client never needs to inform the server that it has the
> commit's parents, since it can just tell the server that it has the
> advertised commit and it knows that the server can and will infer the
> rest.
> 
> This is because, in do_fetch_pack_v2(), rev_list_insert_ref_oid() is
> invoked before everything_local(). This means that if we have a commit
> that is both our ref and their ref, it would be enqueued by
> rev_list_insert_ref_oid() as SEEN, and since it is thus already SEEN,
> everything_local() would not enqueue it.

Thanks for fixing this slight issue with v2.  Though maybe we need to
update the commit message here because a previous patch in this version
of the series broke up everything_local() into various parts so that it
is no longer responsible for enqueueing commits?

> 
> If everything_local() were invoked first, as it is in do_fetch_pack()
> for protocol v0, then everything_local() would enqueue it with
> COMMON_REF | SEEN. The addition of COMMON_REF ensures that its parents
> are not sent as "have" lines.
> 
> Change the order in do_fetch_pack_v2() to be consistent with
> do_fetch_pack(), and to avoid sending unnecessary "have" lines.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

-- 
Brandon Williams
