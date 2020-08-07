Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1695C433E1
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 09:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A556F20855
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 09:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvdU+g/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgHGJZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgHGJZU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 05:25:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC13C061574
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 02:25:19 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b30so632403lfj.12
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bsej45XDikHDfZ7RzN2yvJvSPQfodjE6u7Cx76W2glo=;
        b=nvdU+g/Mn/jhy2M7efFct68lbR3ROJUPDLRllde5wrZXUENRIwDK1CCVCJB0035CLN
         4aN3wIfz/rEsh+if9CNcmr5RgpVtNoX8oETrEP1sokjuNEqKLTKblgSNaycOPJAy85/i
         l5rXEZ/RPybpsvIKzaJIf6XkG9Iy4qcAFq6PxpW3N9QRKjaz+FfzCIvJ/22R8jJGRx1F
         3voDxi/wajwPnGeiW0fKm2ehByOCsdnrIeOyUH+va/AYSI1zerzGqQ4uj8d7spDcBDuV
         qSP+5s9J5jFi0vdt6Zie2tOUliccQPVk0B6aoLTD8bvETR+3/x+0f2h5B4BYu72AqEHZ
         WNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=bsej45XDikHDfZ7RzN2yvJvSPQfodjE6u7Cx76W2glo=;
        b=UQ4QXX+1EMGbNDV6lDJ26TBBSu7AkO249DcESZezrvXhF0xdzy4n5LBm+jlzUJzbDa
         9PIAPJYbnsKMOoGy6yoXZVbzmLY85kEaFV3Z07l/txWTOfWkylbL2umiuZ2UbSeRQmrH
         e1Te/ChV6VCyTtJHnVfQKtz39IGrjKnz1UyuWmgEVkJ9EmqZtbnsduKZ8DcDBk7N3WKD
         am77YxUZFQK5FPcGfM1qSkVEZNrcU/Ek2Oa4hm9J6CwvL1uJTOGP2jLFHUjytLDPdbT8
         wXveQigitmRYXeXh6qbPd5KSIvmFIr/U0pVWNQGZWsIIqDNI1/zopRhbc9EgoXh/DvrA
         bbLw==
X-Gm-Message-State: AOAM533TF9/8fsmwnfa+kOPOWUd7yQoeYyKhvTklKGiaYLw8j62j/TE0
        KZhUGTGtwvlZh7z/2uz7BYTb9Crm
X-Google-Smtp-Source: ABdhPJyB1zmtHIqIwl/urvgfXyqc03yxJUVJFbw9LcM0TtBsPEHlnk/t12KVB72vGX2u/LWbMfoyeg==
X-Received: by 2002:ac2:561b:: with SMTP id v27mr5990494lfd.22.1596792318352;
        Fri, 07 Aug 2020 02:25:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y19sm3968318lfe.77.2020.08.07.02.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:25:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
        <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
        <20200807082643.GA34012@coredump.intra.peff.net>
Date:   Fri, 07 Aug 2020 12:25:16 +0300
In-Reply-To: <20200807082643.GA34012@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 7 Aug 2020 04:26:43 -0400")
Message-ID: <87k0yau7sz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 04, 2020 at 03:49:17PM -0700, Junio C Hamano wrote:
>
>> > I'm just
>> > raising the issue now because we'll be locked into the semantics of this
>> > option, which may not be able to express the full set of what's possible
>> > (so we'd be stuck adding another option later).
>> 
>> Yeah, but a good thing is that we won't have to worry about this
>> until much later, as long as we would just be introducing "diff
>> against no parents" and nothing else (or together with "diff against
>> all parents", which would make it easier to explain "-m").
>
> Agreed. My only question is whether the possibility of later having
> those other options might influence how we name the two options we add
> now. I think it's clear to all of us in this thread how those two easy
> options should behave, but if the intent is to eventually allow these to
> be mutually exclusive:
>
>   - no diff
>   - combined
>   - dense combined
>   - individual diff against each parent
>
> but orthogonal to the selection of the parent-set (none, all, or
> selected ones) then e.g. "all" makes less sense for "individual diff
> against each parent". I don't have a good succinct name suggestion,
> though.

I have "split" and "separate" in mind, the latter likely shortened to
"sep".

Overall:

--diff-merges=(off,none|comb|dense,dense-comb,comb-dense|sep,split)

-- Sergey
