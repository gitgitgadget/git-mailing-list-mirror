Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDC0C1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 02:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJRKdv (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 06:33:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37955 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbeJRKdv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 06:33:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id a13-v6so31837136wrt.5
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 19:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kfH/euFu5dwtB+FCWVsDm63fEZ1rS62Mzm6g3RvwWHI=;
        b=fS5sEA1JnlMNiYtrdrXWvo2bNDAEpTtEY72ITSTJSIWKJjwNgLfmq3cMnyh7zo7S1F
         UqPqjmD2H3+DLqwRhuXeGiBT/1sHqRaQz6DTC4F0sBvbZg1IVBDho7OydNCBREu4itya
         vr0w7Woq9ycofebpErkQtQDO1v1x3UNfpuqboIgtn7rZaiCveYnU9RfY78jIGXN5QMN8
         6whV/GxewjxHPDwSTOdOtNtZCtIcRyI2VAbbhtCXlqJCBfz8HOns76f6Vhdf95tU/pfg
         28zST0dV7x78gy6RSnq4xEtsXCHhtbVOKJHI5BsrCQvcCYLLzCmU/LxE3M5m5Kk/sCm6
         m6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kfH/euFu5dwtB+FCWVsDm63fEZ1rS62Mzm6g3RvwWHI=;
        b=NvSPVPgsyb7rj9MuS43lh7pp0FP4myVKx+RuizuwBijzbeNa2KWPg92Of1Sm0uNlQO
         oJFm1CZ3wk3kp/jsrRZsMgyuvTLfnLvkGgWWg1LYJ+05csA6zACsQBcoXb/pjZz9g4Nq
         ipoL3qxSAXCRQaL33ztZJue+y5VUoNhmzHZkDTEF1ghAmqDOLvk4jCI6EpCckXq4D33o
         BzLRBsKLlAlpu2s22ZiubXLMYeedzDfbjM86vedlECYFjhh+EPChFnJdRy7Z5QJvOej9
         nFQw0lGGridi++K3B7u9sgLMWLk1qpAQogfa28TXySEh3F/t4AgHZw3NYoX3KoSPbwHi
         pvDA==
X-Gm-Message-State: ABuFfoh4k/pFXPe4TSrimUPS7rjrQeAEyjTnBfrhU9W6XYhIswXCMmmM
        iEqoanqkn+JmjaCQWORNluI=
X-Google-Smtp-Source: ACcGV62zXFy0ti9NmCeKbm09f+EJzbWMQasnraWBp6Eae6Q5JQgJTxthsLWAfWi2pzmjD3ZMFEqkBA==
X-Received: by 2002:adf:8bc5:: with SMTP id w5-v6mr27604718wra.110.1539830110150;
        Wed, 17 Oct 2018 19:35:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h2-v6sm14963280wrs.34.2018.10.17.19.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 19:35:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     sbeller@google.com, git@vger.kernel.org
Subject: Re: [PATCH 5/9] submodule.c: do not copy around submodule list
References: <20181016181327.107186-6-sbeller@google.com>
        <20181017214534.199890-1-jonathantanmy@google.com>
Date:   Thu, 18 Oct 2018 11:35:08 +0900
In-Reply-To: <20181017214534.199890-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 17 Oct 2018 14:45:34 -0700")
Message-ID: <xmqq7eigvv6r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> By doing so we'll have access to the util pointer for longer that
>> contains the commits that we need to fetch, which will be
>> useful in a later patch.
>
> It seems that the main point of this patch is so that the OIDs be stored
> in changed_submodule_names, because you need them in a later patch. If
> so, I would have expected a commit title like "submodule: store OIDs in
> changed_submodule_names".
>
> ...
> This patch looks good, except that the commit title and message could
> perhaps be clearer.

Thanks for a thoughtful review; not just this step, but for your review
comments on all the other steps in the series are very helpful.

