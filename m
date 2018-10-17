Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA131F453
	for <e@80x24.org>; Wed, 17 Oct 2018 21:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJRFTL (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 01:19:11 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:47011 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRFTL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 01:19:11 -0400
Received: by mail-qt1-f202.google.com with SMTP id j63-v6so19790018qte.13
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vqZswKYRCsu6hhpLGTsmBk21mZCLm5eALX1eXNi+qSk=;
        b=PQLgutIYJ6FpHtl8QmgQKsPx4sr1lj+NYazLqBEcbdREPqnpIIdg3jJ2sId50mU3N6
         owwZ58ogccPH9FlNidE6bqGVf59xJhUXVYecLpAKqBfBiXF2pUNCwOx3U3K9xQjCH9UB
         j/ETr3gdVusek/uih9GH3OMeqOApnVYWoIFBFG27BUfEk15u0JGO1f5hcuiNjV+fZXN3
         pTUDLC9YulCBMvKrKSLCfNPH89rS6zoCW+r3MOvO1fNRQ+N8eIhl68PNYlSpeadCm4ZC
         q9i1Z1NSqcos3fa+7nZFxkfOjDEoUBeU79gQjneNR7L38IAOKsZ90Ct9PJcDHo7pzY7e
         OgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vqZswKYRCsu6hhpLGTsmBk21mZCLm5eALX1eXNi+qSk=;
        b=BbtB3/NWLDIp3WppMywBLmad84YmOHSY16JJHbrLcByQ14nW063qOaaEMTOS1NZupk
         ydsgeT/jwbCOB+WfYzfYYL4yS74otPvM4mDDX3JqoFIdIaEGZrzHIRTyGHqEOjD69rX9
         +tNi05qvB3zoh1AVo1ChWYyvgNyhPbDf6TO9gHZmz7EVSMj5q9cZBurrgY9L2qr/6bUt
         D+ZYXOwSxddALzBW088LKpGTGZ8bYnjzHd5CGCICgmWCRcPVM9BKIjUjglu/ShXz2cuN
         M6EkCOTSt9N03DUntgPHw162+nW/OESL1V/wIHEU1g8fKaHRw2j6Y/qGe5kd8Q6N2qmX
         rGTQ==
X-Gm-Message-State: ABuFfohXa+9AdZAexYRt41DAZyeJQmITs6fihnRDfq42A2BF1oUiUf39
        Wkesp/szMXPW44UT0kLgnFKw14xwq2PtZ2UNcPrL
X-Google-Smtp-Source: ACcGV61BfSqFS4toZPdSf9QkH5sOoarhyAcCwK0SqJcwinrVWzs416oVD5t8j9L/YDB0XF8gwts2+wLyXVLvQjez55mh
X-Received: by 2002:a37:2711:: with SMTP id n17-v6mr2749619qkn.2.1539811297428;
 Wed, 17 Oct 2018 14:21:37 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:21:33 -0700
In-Reply-To: <20181016181327.107186-4-sbeller@google.com>
Message-Id: <20181017212133.195680-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-4-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 3/9] submodule.c: sort changed_submodule_names before
 searching it
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> We can string_list_insert() to maintain sorted-ness of the
> list as we find new items, or we can string_list_append() to
> build an unsorted list and sort it at the end just once.

This confused me at first, because neither function is mentioned in the
patch.

> As we do not rely on the sortedness while building the
> list, we pick the "append and sort at the end" as it
> has better worst case execution times.

It took me some time to see that you were rejecting the two solutions
you listed in the first paragraph, and are instead using a third (that
you describe in this paragraph).

The code itself looks fine.

In the future, I think that it's better if this type of patch went into
its own patch set - this seems independent of the concerns of this patch
set, so splitting up keeps patch sets small.
