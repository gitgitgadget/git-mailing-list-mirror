Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6ABB1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 01:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJJIjF (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 04:39:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41868 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJIjE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 04:39:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so3753602wru.8
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 18:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XyQb0vW8kJhXaLEGTccYAknreIOGrIANyurfstZnKVE=;
        b=Rn3VAjKQx4+Qx7eDA6+nu+3IenSIunAlY5prVeeW+fHcgEqf2F5kJl95tS5lPjILrx
         UlwyLqJURmtQsVUS5PE6TDJB6c0wl4LHWgN2wWVlnsf1u0kxOWL3NrFGfFduRZuEiB38
         OV1rmO0O7cX1qIqJP97bMhMk3O/kjQnBNcmfT6wLJedPIVr1wLwXtJDPfw/b1CFopKyl
         jhURI9AMMA9xR1+XoRP8288AvtwcJvHk+ysWpA3Oo22RZ4IbD72ChIuHOcWc1rvcxVKk
         tHbfgDcQJCO85tnfCKBnfQR1joW9qw+aUGl/T57ZcNtOKwOCjNAJhPPPX0s4zEWMmwN7
         A93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XyQb0vW8kJhXaLEGTccYAknreIOGrIANyurfstZnKVE=;
        b=kx81bpDuG9SyxPsCV+dJKkT4y9FAkBz8CevvET7T3tg5op3UUXfZYXLjyhgaNhNa63
         qKAxmm2YZfNxExcXUxN8YlC2unEMXWopA5WAn91OVb5P1UhBLla1BtMcGQFzVmTkEllO
         oSNkJPuouw4/3wcPPBCIUMzQcak8h8DrqV4ZSKLEN1WG7XU2np3oc6jj7iXRfPbpQurq
         mO0H4ByMa/vKkqCHqoTQqJ5ITu2X08CIyjQjR2CJpP2QvHXYmYHGxhkvJzdhcog03k63
         ZjYetnXLsbB2gKm/N6kIim6YrbCCKcUZuVIs4hUjS1lcWYtiCQ8Z/Ah2Eum95CCOwU5K
         PMxA==
X-Gm-Message-State: ABuFfoho9haVNLZtqoqGTaloG4OhMip6lR/LoyuO/WOjYw6WubWmI8lJ
        aZU87K0Turlzggq9gcNmNWM=
X-Google-Smtp-Source: ACcGV60HubiltAr4g5ewezKEF55xZm4sgv3Uy4x7QuefPFfNgwzkYmsT06VWJNJGWGPPM8uWo1OTDg==
X-Received: by 2002:adf:f043:: with SMTP id t3-v6mr20736056wro.92.1539134360679;
        Tue, 09 Oct 2018 18:19:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b124-v6sm9196876wmg.47.2018.10.09.18.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 18:19:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com
Subject: Re: [PATCH v2] cache-tree: skip some blob checks in partial clone
References: <20181008214816.42856-1-jonathantanmy@google.com>
        <20181009184037.246871-1-jonathantanmy@google.com>
Date:   Wed, 10 Oct 2018 10:19:18 +0900
In-Reply-To: <20181009184037.246871-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 9 Oct 2018 11:40:37 -0700")
Message-ID: <xmqqh8huoay1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> After feedback, I restricted this to partial clone. Once restricted, I
> agree with Ben that this can be done for all users of
> cache_tree_update(), not just unpack-trees, so I have removed the
> ability to control the behavior using a flag.

Makes sense.  Great.

> I also took the opportunity to simplify the missing check by using a
> variable.
>  
> +		ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
> +			(repository_format_partial_clone &&
> +			 ce_skip_worktree(ce));
>  		if (is_null_oid(oid) ||
> -		    (mode != S_IFGITLINK && !missing_ok && !has_object_file(oid))) {
> +		    (!ce_missing_ok && !has_object_file(oid))) {

OK.  "An attempt to check out null object is bad, and otherwise,
unless we determined that it is OK to lack the object recorded in
ce, it is bad too.  By the way, the way we determine if it is OK to
be missing the object is given above".  Easier to read than the
original.
