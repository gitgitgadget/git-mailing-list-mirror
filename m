Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B291FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 17:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbdF1Ry6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 13:54:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32796 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdF1Ryy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 13:54:54 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so9016044pgb.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BN4PSPguoWbpuhKtI7PiD446a+L6wTji37jwHuRCeKc=;
        b=Umw1AllTtoGqQXQBZ1DNF6rHqI6oEQgQdPUnye2es+42FEamBCbIZCYggu6ro5bQRZ
         N2Rklyu9GAhaXE4WiN002YS8SYaLc0PqrRxhD8UzMtM3evxj8iz5ybnvzInb/7oso/6w
         YOnsVJSf6F12UPxi5sOHeqRlzi+gpLDs+8Z1K4rJS8tVJjV1AWU6Y1FZ6m1o9GLJxjq8
         zLVvR/Nq5qniZSr+bmTXVI5Ogsm0ZRvkXEgBMZHXyoteNWnTjNsj15QSkzNi25lDxnjH
         CSqcs4s13puOAzF1DoEo6j6bo3dExYdcdehMO5F6CzHucS+1WuBtM58ZN6p23d21g3/b
         6sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BN4PSPguoWbpuhKtI7PiD446a+L6wTji37jwHuRCeKc=;
        b=R1S2b/qgigiFX52wLAhz9stTuceB/W9x/SmiYSugaHuobIKqZp4cdmGsHAXoL0g/Vd
         y8zkAJFxcApNW0FWBGjEXseI64XYx3kEqM+m2ex7yhQWWicV82SrP1P1U5tTWxCAGxFr
         j7wBuzHLNR9s0gKa+IBJ6NjyTIjUar0i2qKidiXub+PK8OuC2iv6Cr/ZNYpufkjooBEq
         fgYgAqFiNBKyIRMJdmJ5lhnkK1GXNxCSMw8bSCedP01NKk+8kcuDaUoe2u+ismmgxWzd
         QpPCRfuF/ar0XYJVNaR10ukED50CtwR6W6lSogTmkABlBHB6k7Sb/aTMMSen8eKay+de
         Bttw==
X-Gm-Message-State: AKS2vOwMLQ+0v2uS87FVIkukxXqxGuHIqxaNuotwq1DaBEBjaZMjH/ol
        L/GKE47ciVUMGhGFqPw=
X-Received: by 10.84.224.75 with SMTP id a11mr13199314plt.286.1498672487394;
        Wed, 28 Jun 2017 10:54:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id i27sm6248462pfi.128.2017.06.28.10.54.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 10:54:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/3] list-objects: add filter_blob to traverse_commit_list
References: <20170622203615.34135-1-git@jeffhostetler.com>
        <20170622203615.34135-2-git@jeffhostetler.com>
        <xmqqy3scw06y.fsf@gitster.mtv.corp.google.com>
        <e2216ab8-5af7-4edd-16aa-f84a45e0cbd7@jeffhostetler.com>
Date:   Wed, 28 Jun 2017 10:54:45 -0700
In-Reply-To: <e2216ab8-5af7-4edd-16aa-f84a45e0cbd7@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 28 Jun 2017 13:13:22 -0400")
Message-ID: <xmqqa84svvyy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Yes, my logic was a little confusing there.  Jonathan Tan said
> something similar the other day.  I have a new version that I'm
> working on now that looks like this:
>
> 	list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_SHOW;
> 	...
> 	if (filter)
> 		r = filter(obj, path->buf, ...
> 	if (r & LOFR_MARK_SEEN)
> 		obj->flags |= SEEN;
> 	if (r & LOFR_SHOW)
> 		show(obj, path->buf, cb_data);
>
> I'm generalizing it a little to let the filter return 2 flags:
> () SEEN to indicate that the filter doesn't want to see it again
> () SHOW to include the object in the result.
> These let filters do "hard" and "provisional" omits.  (This will
> make more sense later when I get my patch cleaned up.)

It is not immediately obvious to me, especially without seeing the
actual patch, why MARK_SEEN is needed.  Especially given that I
think a call to show() must set obj->flags |= SEEN anyway to avoid
duplicate output, with or without the objects-filter mechanism.

But that question can and should wait.

> Yes, I'm including similar logic inside process_tree() to allow that
> and let the filter know about entering and leaving each tree.  So we
> only need one filter-proc to handle a particular strategy and it will
> handle both tree and blob objects.
>
> I want to be able to use this mechanism to do narrow clone/fetch
> using such a filter-proc and a sparse-checkout-like spec.

Good to know ;-).
