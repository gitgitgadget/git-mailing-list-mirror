Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04153C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5A7610CD
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbhIBMwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 08:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhIBMwI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 08:52:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2451DC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 05:51:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 2so1559227pfo.8
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DixOuvj6e4uffYD7Y71zRF7I1YAcI0/uJuatbO+zbnk=;
        b=gEnTMlruhEGvRenmH/YbsP0IgzHb6sBRATEmy+aRKKlcazhIYdAN6gE0NVx/4JwdNk
         6EkPz78uKebHPm4AGs40jLWp+1hWnqFFr4Bq2bFNJJx5ASqTfff2z4z9Tc4jfFFN/b7J
         B1Jsjn05bW9jwNfayKnXSkmjPjEdiUHNFaoeYt3nk9R78IQOuxtc0Y+jNyreFoLBfZoE
         8Jn9cJ79udgjLQ9rFCh4sYgaAT8Z2x9uRDvzZzjASMsrkGgIOToL3s5uUUBtSREU6AtQ
         BeFDOJkXLkZBzWcw6JPhcoj9s8yq/bftdSelzzAWW9+lNEpq1BvAuYEKEGG0SwLzmTUl
         Fbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DixOuvj6e4uffYD7Y71zRF7I1YAcI0/uJuatbO+zbnk=;
        b=TnoHRQO0tMy87aTcHiElVnJ94pLXBggebseOfwNPo4AowtQSiKWIrUN9SCMqVfup+l
         PUxxJLHofDnkJYdoxGlt8AHW3GoqmNcig2pEQcV87D6qNRIIff6c3OzbnhDk/36vJ/mI
         ffi+NAVTHT5Gj8nHSvJP37RNs2xaNZfcUa9/8vENkRZr6hyFBbIqqyYIwOAENghOZjmn
         Ze9rfPdgB0abh8tX9Vu9+GWiiULwKJ2ZhlFiEUzGDG6S0D29gbZvbIJnyZOe4NiIfx1y
         tje6HpSCDNZmlKwVyfH1MK7d63OLi2q9FTwcSilVF/Mao66vHzWyalsx++hCcrxkWxTn
         h6/A==
X-Gm-Message-State: AOAM531Vefp+lVLlOkObARr84qCdot4fmIaHuvxF5dCdR9QBssHm4VHH
        mdg8jnA0UAuYiTyXP0SFuBs=
X-Google-Smtp-Source: ABdhPJyufWZx12w5o/AECuLXOz3p4Dv876OshIBq+f4aeZ4SJjtu+GkgaUZvNvcpz17H+mneSHNWEg==
X-Received: by 2002:aa7:9a06:0:b0:3f4:1f0a:4fc6 with SMTP id w6-20020aa79a06000000b003f41f0a4fc6mr3253516pfj.58.1630587069587;
        Thu, 02 Sep 2021 05:51:09 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.145])
        by smtp.gmail.com with ESMTPSA id d8sm2336558pjr.17.2021.09.02.05.51.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 05:51:09 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH v5 03/14] packfile-uri: support for excluding commit objects
Date:   Thu,  2 Sep 2021 20:51:02 +0800
Message-Id: <20210902125102.78016-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.g1a7c4c5894.dirty
In-Reply-To: <xmqqfsuwc4cl.fsf@gitster.g>
References: <xmqqfsuwc4cl.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano wrote:

> Whenever you say "which means", e.g. "We do X, which means we do Y",
> think twice to see if you do not even have to say X.  In this
> particular sentence, I think you can simplify the description
> greatly and you do not even have to use the word "recursive".  

Forgive my English for another accident.

Will be fixed in the next patch.

> Also, because this "exclusion by a commit" does not work like the
> usual "reachability" relationship Git users are familiar with, it
> would help to highlight what is special that is done here to the
> readers.
> 
> Taking the above together, along the lines of ...
> 
>     When a commit is specified to be excluded as packfile-uri,
>     exclude all trees and blobs contained in its top-level tree, as
>     well as the commit itself, but not the ancestors of the commit
>     and objects that are reachable by them.
> 
> or something like that, perhaps.

Agree.

I will use your suggestion in the next patch (may be slightly modified).

In the next patch, I originally planned to introduce the exclusion of the
commit and with all it's ancestor objects. The problems in the current patch
will also be fixed in the next patch.

Thanks.
