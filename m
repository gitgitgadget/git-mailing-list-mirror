Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778EB20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 03:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeLNDUs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 22:20:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33361 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLNDUs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 22:20:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so4044014wrr.0
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 19:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vRmgPlNlbw55unbVJe34RkcKXGSNrPCF3Kt+RqcZW2I=;
        b=lbVCy4Vk83tdUYhEoJalXuOV0WK3rLMEnvkf1wLs3Fj0d8vqTgRJia2yN33MTH6mrK
         fHXltx/BXTtRkfXDLvccamA0QRQM5dFZwFebdPZ3bEGpr5XR1wuVc1HiaOOATJWUKPXU
         Yxc8bC7BYwuswHQoubAMep3WxWWq8yLKRj2+u9ZphNgdcbu9u6e+rL4qXPJ2cA9/K7cL
         YzFu7s6lbDZaTHA6VY5JQveOdLJtnKl1wnez1cfu30+TUTA1X7eK3hJ6mE8exQ8VOVpL
         s5Fr29yD243idNL+Jk4QvOSTaQjai32VNsbxTOoVxG1o/o0z4blGHnZvO4IdNWXcd2Jp
         hnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vRmgPlNlbw55unbVJe34RkcKXGSNrPCF3Kt+RqcZW2I=;
        b=TfDNX4Rkq19nOothKGDeIdKLJdPahLxWA11B966VDBdRUBbcSikBVinZn0ODDvkc3J
         NPOlQXGpX7kNFCtz56gtzTj5FpZSToPigBonuJWEcRNqjQYAIma4bw1fMupSS1aguTty
         cFe+axuhY5DwC+WqaMP4PYFKWriTSbH1hZw3R8RGZBoHcEOOrCxCjsYFaj3uMwdEJdjY
         rlmOOTEuv38X83V+Yp2M3EY3IE0uIgjuqDzBA0/e0w8s7W6HwwBjj9gyTTDhghOwJ4RM
         FTr9lgFsswaH61Iz9SHDe5mh7urGycP8dh7//4DY9CVVs23pelLPVOvId4XvzAtRAmtU
         o4eg==
X-Gm-Message-State: AA+aEWZe1bqfJ+JHwCaI/w06isa+Wcp3CNkeUHdWAx7eIBgdZS3IlFJ2
        KNxH2VPObeDSFTnOFi0Ih2s=
X-Google-Smtp-Source: AFSGD/WI3658SfEAtsc7EnDVHl1WApGkr4b0FEhWkePz0UdwBjNrfb+tCeaBiNn2+okfqdXpV6bXgw==
X-Received: by 2002:adf:b649:: with SMTP id i9mr1128116wre.70.1544757645983;
        Thu, 13 Dec 2018 19:20:45 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v132sm4386395wme.20.2018.12.13.19.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 19:20:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com
Subject: Re: [PATCH v3] revision: use commit graph in get_reference()
References: <20181204224238.50966-1-jonathantanmy@google.com>
        <20181213185450.230953-1-jonathantanmy@google.com>
Date:   Fri, 14 Dec 2018 12:20:44 +0900
In-Reply-To: <20181213185450.230953-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 13 Dec 2018 10:54:50 -0800")
Message-ID: <xmqqk1kcdcab.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When fetching into a repository, a connectivity check is first made by
> check_exist_and_connected() in builtin/fetch.c that runs:
>
>   git rev-list --objects --stdin --not --all --quiet <(list of objects)
>
> If the client repository has many refs, this command can be slow,
> regardless of the nature of the server repository or what is being
> fetched. A profiler reveals that most of the time is spent in
> setup_revisions() (approx. 60/63), and of the time spent in
> setup_revisions(), most of it is spent in parse_object() (approx.
> 49/60). This is because setup_revisions() parses the target of every ref
> (from "--all"), and parse_object() reads the buffer of the object.
>
> Reading the buffer is unnecessary if the repository has a commit graph
> and if the ref points to a commit (which is typically the case). This
> patch uses the commit graph wherever possible; on my computer, when I
> run the above command with a list of 1 object on a many-ref repository,
> I get a speedup from 1.8s to 1.0s.
>
> Another way to accomplish this effect would be to modify parse_object()
> to use the commit graph if possible; however, I did not want to change
> parse_object()'s current behavior of always checking the object
> signature of the returned object.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This patch is still on master. Junio, let me know if you would rather
> have me base it on sb/more-repo-in-api instead.

Unless we all agree that we will abandon sb/more-repo-in-api,
rerolling this on 'master' will force me to resolve similar but
different conflicts every time.  Unless we fast-track that other
topic, that is, but I do not think that is what you meant to do.

> Change in v3: Now uses a simpler API with the algorithm suggested by
> Peff in [2], except that I also retain the existing optimization that
> checks if graph_pos is already set.

OK.
