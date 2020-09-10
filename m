Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0FDC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8770D20829
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaUIAynn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgIJVBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbgIJOp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 10:45:29 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D535FC061756
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 07:45:06 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q5so6311052qkc.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DU6xrMXpo0cd1DRsClnQNXCBI4byFrryT3Djdhp3qoA=;
        b=qaUIAynnGKQAUx58TikHghembXCPGYNSyTH4x1a8xebjqMuwfsgtsIGxphi6us0Om9
         slhqpDUzaIAIoTlCUrgIrrLDWbjiSPpLV2+FNHXodqbSeZ44EaCjFIQiKHp7pCGbuYkP
         V59H+tdTVFEqxxnuVvAMMV5UXez7J1OyrLEcpF8vN5VFJBHBa6CGPIwuPwXanRdp1LiW
         yReYDmMXwxAhRGuhWpD0I+mK+/0bcgEFmFHhD7bbe7++c9IX7SMMk+iGIuwyLZ6Ptj+O
         g29bCRtOF+oEIW8Bl7jCoYvA4HtuDyuI+sboLoDkrni5j4SsvQrw7IYr0EAVrlSAUuEy
         ktMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DU6xrMXpo0cd1DRsClnQNXCBI4byFrryT3Djdhp3qoA=;
        b=kZYoP7WDYCQN0YEY/ghhpsnAJM1mfZH/Sv+S8+WM594enkuYNuhtc3JkgEZkpowJ83
         XiJn7NQtG58dSRvjpQtbXcb1SCp3ghIDHogXVGXtOa72Q9KzlHFlQfwFF/MvjxyOFsQE
         AKjDgaxVbuTH+2nJBokocOG+BC6qLfZ6EnCZwICH/WndnwcKWMgYBvH1tmhTm8T7cdtK
         siN9RtQj4GYVnZUYkWPymxJYqFITvCUk75xJOD8tB8iAq7cWaSoEn66CeiR5Gpk8SnHi
         UX1BnrGekw6xFtqFKi2u3q6TPNJSnvxJ1AwF4ESNsQl37cdekGAuKHSoE70gatCDeyYe
         gY2g==
X-Gm-Message-State: AOAM533uvHtYyMPQFHpVU4fY9ZwjmQdHkI5NFexgUqNvteGtDcY2EiXs
        rNOP4hVz+kbiEIN+nsE0DXA=
X-Google-Smtp-Source: ABdhPJxpR9OWZHUVG18HdkeOHfZVf0AiqgNdXUjYKCEtxPmE/wJrG3SP34nznh6P9KkynZzVwBoF0A==
X-Received: by 2002:a05:620a:955:: with SMTP id w21mr8054829qkw.69.1599749105164;
        Thu, 10 Sep 2020 07:45:05 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.38])
        by smtp.gmail.com with ESMTPSA id g45sm7426732qtb.60.2020.09.10.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 07:45:04 -0700 (PDT)
Date:   Thu, 10 Sep 2020 20:14:56 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
Message-ID: <20200910144456.GA25125@mail.clickyotomy.dev>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
 <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
 <xmqqr1rcxdsu.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 09/10/2020 12:22, Johannes Schindelin wrote:
> Hi
>> [...] 
> Maybe `--force-if-incorporated`? Originally, I had in mind to call it
> `--safe-force`, but that might be too vague.

That's nice. I haven't been able to come up with a good name for this
option. So far, I have: `--check-updated-remote-refs` which is really
long and is probably confusing.
 
> BTW I think the patch needs to cover a bit more, still: after I run `git
> pull --rebase`, the local branch will never have been at the same revision
> as the fetched one: `git rebase` moves to an unnamed branch before
> replaying the patches. So I think we need to see whether the remote tip
> was _reachable_ from (not necessarily identical to) any of the reflog's
> revisions.

Good catch. Would adding in_merge_bases() along with checking if OIDs
are equal for each reflog entry in oid_in_reflog_ent() address the
problem? That way, we would check if remote ref is reachable from
one of the entries?

Thanks.

-- >8 --
+ static int oid_in_reflog_ent(struct object_id *ooid, struct object_id *noid,
+			     const char *ident, timestamp_t timestamp, int tz,
+			     const char *message, void *cb_data)
+ {
+	struct object_id *remote_oid = cb_data;
+	struct commit *a = lookup_commit_reference(the_repository, noid);
+	struct commit *b = lookup_commit_reference(the_repository, remote_oid);
+	return oideq(noid, remote_oid) || in_merge_bases(b, a);
+ }

