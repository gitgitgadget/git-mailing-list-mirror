Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7A091FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 19:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753783AbdFMTrd (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 15:47:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33673 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753448AbdFMTrc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 15:47:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so13285087pfk.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=icBO3Nhczn++l4Xk7GHGa6n69HOjfRgSfTPtMQbFIqU=;
        b=KDzbYujD0TC+gNtS10uBRjBFElr3Ow3bDv0P0T98/6n8JfP8iAtiqSh8ap56GuESx8
         KYGLctebsP5exAjZeZ/pHsC0P6Y3TMA0Mxg+MbORW5fFC9b74srQ9iXPvX3uxKrymGVd
         yN2XeYP2gfhGoaUCZRKmivcMTAoJ81FmL9ybsvaIMzq6rsD27cvqTVcsKAOUvh8mEV2l
         R2ys9sS9/UORMbPWSCn+d7BLtchfsPJcDo8wd2tcm0f7Zc441r91ivRU0c9bti1lXqpm
         QmzVPn29R0Bif4hYv+HJuOlIPWRl0OT5id40gkCGxHc5sClxwvJF7hnLz9eHGT8zXuRG
         NzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=icBO3Nhczn++l4Xk7GHGa6n69HOjfRgSfTPtMQbFIqU=;
        b=KOxuMv/U+xcCqm0NDbYmbFJ43Gat+XWFULvgzjZkVGAV+sd9tiOY+k7pMNYStHnMoU
         KNvrBViyg/c6t4+Or5mXQosBI6OUNdpmWSjTyY4hHrcMSh0v3CUIbErjt+fFO+4gLn5J
         IkGahRQr/rqXD9yY5y768r9tTPDw/UfAB+OnDRpBnIIR5aY5C2jiKgiRX+5LW37VVj+5
         skzKb2zFgbUXgUA1ZkTpcmHAZDVY4eYUXMW0zPAnkyVHAX09VBSlSanZRmqUJRarWC1G
         WTIkxvWPAZhL+lpLCDcw/dKIc4/3yGvlC2flHnY0qwQLh7WfnFK4wbGkyT5t7sc7dYef
         eQ2g==
X-Gm-Message-State: AKS2vOzs1DUPSfDwTpc0OxZ5Y1RN5HNJM366aMxLoQYmgBPqXdjKu2Kc
        /G26V8Z+Tsz/wg==
X-Received: by 10.99.98.6 with SMTP id w6mr1154643pgb.207.1497383252077;
        Tue, 13 Jun 2017 12:47:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id b65sm29012453pfm.29.2017.06.13.12.47.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 12:47:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 4/5] merge: close the index lock when not writing the new index
References: <20170608005535.13080-1-joel@teichroeb.net>
        <20170608005535.13080-5-joel@teichroeb.net>
Date:   Tue, 13 Jun 2017 12:47:30 -0700
In-Reply-To: <20170608005535.13080-5-joel@teichroeb.net> (Joel Teichroeb's
        message of "Wed, 7 Jun 2017 17:55:34 -0700")
Message-ID: <xmqq60fz6565.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> If the merge does not have anything to do, it does not unlock the index,
> causing any further index operations to fail. Thus, always unlock the index
> regardless of outcome.
>
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---

This one makes sense.  

So far, nobody who calls this function performs further index
manipulations and letting the atexit handlers automatically release
the lock was sufficient.  This allows new callers to do more work on
the index after a merge finishes.


>  merge-recursive.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index ae5238d82c..16bb5512ef 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2145,9 +2145,12 @@ int merge_recursive_generic(struct merge_options *o,
>  	if (clean < 0)
>  		return clean;
>  
> -	if (active_cache_changed &&
> -	    write_locked_index(&the_index, lock, COMMIT_LOCK))
> -		return err(o, _("Unable to write index."));
> +	if (active_cache_changed) {
> +		if (write_locked_index(&the_index, lock, COMMIT_LOCK))
> +			return err(o, _("Unable to write index."));
> +	} else {
> +		rollback_lock_file(lock);
> +	}
>  
>  	return clean ? 0 : 1;
>  }
