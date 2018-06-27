Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95DF91F516
	for <e@80x24.org>; Wed, 27 Jun 2018 20:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966576AbeF0URj (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 16:17:39 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35047 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966066AbeF0URj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 16:17:39 -0400
Received: by mail-wr0-f182.google.com with SMTP id c13-v6so3245388wrq.2
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S4RNzuieQ6KTv88lE42IF98Rgf1UFHxedjK9n/6LTUU=;
        b=ivCKgDwTt5Xko8xJPmowvFQ09LgioV9shKBsBk5EiZKJSlxHdIQZC9/E+byGPxR7sw
         BVrWsgGqyFLApG8R351czfPAr0F7UxWyEaFIu06XnR/ZrR8pkMUKVkufBGhSHkXNtoer
         0wPibQPJoR1ouTOx29oUUKML7LH9WTwH3WmqN84skLTMwhR1TOWhCDT3EPCBjjmDYn5o
         RpnSXEvHutZwrxdk4h3bXHokpqRo4Amxa2fDjLB+tK12e1QNJQo4CcTrWEAaGif1Lc7e
         Gb/oa5lzs+jT9FDYRw2C29RRMrndFYircOQqc0NN00rfgdzi7PNRf4LsmNYtxD4zanAJ
         OMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S4RNzuieQ6KTv88lE42IF98Rgf1UFHxedjK9n/6LTUU=;
        b=HmVrwzZIrFsl/+dn3OxTHqyAxX2EwUcT3yRe0SindC/TYvC1OHsYQKvhJHYNJjFVgI
         ClP2aGwbD1JDKU362jgBj3vJUR6DTHSns/HHBewlvuz052saXM5AjF/m+wbEYt4S6ESL
         4P+lhdWvVhBwIZccJNm/iMXV00v++3Axlvcn2G/71ECcclndNiuaTnZj/VNUl+gG/TSF
         GbIb6Ef7QikfWGzT33Epbt5gkISYbkuIiM7xROBvcCedJkeeQUC8tTxhXMUDhEOUZlN1
         kiyJy7iSj67WrJDye0pmJjI+vfI0e2YMgMqgEkE3TbIYlRDAmKI/lcfsKWZdvhJIdVUG
         DfSA==
X-Gm-Message-State: APt69E1YRSaOKgxtr0R1V3A/xsoxdWm9adQZ22cR0GBY9k3YJ61oiPAX
        O08Lt2mO2IvxQGisXqnrVXRceYSU
X-Google-Smtp-Source: AAOMgpcxfteR3qmZfv8S5rhWuO5VsY8mZG2f5opP+2Wvintd+6B1K7Np3+Rj8zlhhLVrSh9Z7LlDEw==
X-Received: by 2002:adf:e590:: with SMTP id l16-v6mr5993439wrm.190.1530130657520;
        Wed, 27 Jun 2018 13:17:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e188-v6sm18190890wmf.21.2018.06.27.13.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 13:17:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: when deepening, check connectivity fully
References: <20180627173237.25620-1-jonathantanmy@google.com>
Date:   Wed, 27 Jun 2018 13:17:36 -0700
In-Reply-To: <20180627173237.25620-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 27 Jun 2018 10:32:37 -0700")
Message-ID: <xmqqa7rgdlwf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +test_expect_success 'shallow fetches check connectivity without stopping at existing refs' '
> +	cp -R .git server.git &&
> +
> +	# Normally, the connectivity check stops at ancestors of existing refs.
> +	git init client &&
> +	GIT_TRACE="$(pwd)/trace" git -C client fetch "$(pwd)/server.git" &&
> +	grep "run_command: git rev-list" trace >rev-list-command &&
> +	grep -e "--not --all" rev-list-command &&
> +
> +	# But it does not for a shallow fetch...
> +	rm -rf client trace &&
> +	git init client &&
> +	GIT_TRACE="$(pwd)/trace" git -C client fetch --depth=1 "$(pwd)/server.git" &&
> +	grep "run_command: git rev-list" trace >rev-list-command &&
> +	! grep -e "--not --all" rev-list-command &&
> +
> +	# ...and when deepening.
> +	rm trace &&
> +	GIT_TRACE="$(pwd)/trace" git -C client fetch --unshallow "$(pwd)/server.git" &&
> +	grep "run_command: git rev-list" trace >rev-list-command &&
> +	! grep -e "--not --all" rev-list-command
> +'

Hmph, don't we quote these in the trace output, requiring us to grep
for "'--not' '--all'" or somesuch?  

I do not think of a better way to do the above without a huge effort
offhand, and the approach taken by the above may be the best we
could do, but it looks like quite a brittle test that knows too much
about the current implementation.  "rev-list $new_commits --not
--all" is a so very common and useful pattern that it is not all
that implausible that we may want to come up with a new option to do
so, or more likely we may want to do that with an in-process API
without spawning an external rev-list (hence making it impossible to
observe via GIT_TRACE).
