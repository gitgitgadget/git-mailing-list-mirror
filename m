Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58479C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A5060F9B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbhI0Rv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbhI0RvT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 13:51:19 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E16EC0611C0
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 10:42:40 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id h18-20020ad446f2000000b0037a7b48ba05so73277645qvw.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vS0D8QxVa3j3ArNxNDMGF6qerEEmSoyMQ0oLMvfLUHY=;
        b=jaCIOnFP3RXpD5clyrmtk8LJF8QoN8g8N0PKt/bZYKrbUaCEuBTTLmbj2TVfDpTPto
         q5QzOqFXs7bBgWRXeBhDYGbdnYllc66Pv+AAVUmWaFnF7LXcbUoHV9AkQc//6qu9dzAE
         DFMdhSGGRAjobseyxIhZSZr9o4LCUWkQqkCS+r7AciOY28JY0MhTwGx/R0BkKcb1ZqCs
         3T6ErduqILiV9OsRqxjs4fwkSA/Bb6iEJF2I8ZUemGeFGjR8ZKbfPr/sOo5imtxpvv+v
         NafraX3YqCI5mgxyyzVQ7s94iQWIowmVA9Mi7D5bwGDwgOi3HZ8PYYgUsGP+PB2N7Kiv
         h3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vS0D8QxVa3j3ArNxNDMGF6qerEEmSoyMQ0oLMvfLUHY=;
        b=7kJofW9HyLXY3YqcrGrJ5M7DGkEWKXWFwMAZ53KkoS8sDh3cP98OrUFJ8lJLpOSaBW
         bDnEc3kfgob1rrC/ekTBouHeOo5UG5OMlWIYNOOkylDcwRqjQTyK75suA1psKGfOILRq
         26Q9t8zeFmy7jL+bNpt01+JsAHK/WYWyyvCNKYYtsJxty1aLAe1BGnvp6XMOCpPTlhZV
         sdc28FIHBkqNLrwPIuOG0dQDVs6FJH0sLK7a20GArO0dQiYZemMDAUm2St1tviNGv6Jv
         a/bwPQLZQ1vGmqYPI/jwdyhTWbNcS21jXeMkP/abnJZAt9zQt9cD9wFA0ZEoI/9PkmsN
         9/hA==
X-Gm-Message-State: AOAM533yeLKxvVm1w8P1QxyLuByOylK6k8acWd9yOwyH00N2mkhK2rnl
        6oNY5aEkG4TIU0RShNzoaQTAt2KLoSeqH0C49LbZ
X-Google-Smtp-Source: ABdhPJxMIqNJfiammHZazdeHj16oLT6Z5ymnSiJIagWe+tCHtwU2C/TnXqz71GKFxuGMIXv6k2G11v/2ITLUhflnvSrJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:140c:: with SMTP id
 n12mr1057668qvx.39.1632764559372; Mon, 27 Sep 2021 10:42:39 -0700 (PDT)
Date:   Mon, 27 Sep 2021 10:42:37 -0700
In-Reply-To: <YU4c9S6jypbS4YCK@coredump.intra.peff.net>
Message-Id: <20210927174237.529476-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YU4c9S6jypbS4YCK@coredump.intra.peff.net>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: Re: [PATCH 12/16] refs: turn on GIT_REF_PARANOIA by default
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Deleting a
> broken ref now actually tells the hooks the correct "before" state,
> rather than a confusing null oid.

I believe that this is due to write_head_info() in
builtin/receive-pack.c now advertising the broken ref, so that the
client knows what the old OID is when pushing in order to delete the ref
(verified by running the relevant "git push" in the test with
GIT_TRACE_PACKET=1, with and without GIT_REF_PARANOIA=0). If rerolling,
maybe this is worth adding in parentheses (e.g. "(because such a ref
would be advertised to the client and the client would thus send the
"before" OID when deleting it)").

All the patches up to this look good.
