Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C99C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 20:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiKHUIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKHUIh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 15:08:37 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2591C10F
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 12:08:35 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e189so12376544iof.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 12:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TqP61UXnZSWKBIO4nPkA+m1aG9HLb54k3BN5hLiXIn8=;
        b=wzT0CthucP2af+500l+Dt65r0e0WRAoa5R6VlRBtc9g2iT6y0O3nlCi4meiT1eIqbF
         Li3zPKk87thecvs5pgDQZ73Gjs40rPIfTFQqlix12qy/A5oSAK5Q2t6cQGt2ex7tX40h
         aBahssuR2u3955N+XEQAkApGRsU5+WYyrclT+onqRVBsOFG3cN3KCFrM5K/hkaH/hG00
         1BGK7W2UDGZqyJAVf/NA1q1nM0p6ckw85ZAcYmknJjSIjIzo3cbt99djPfOUu8oE/ADI
         Ri/zeWtamBkvZiJFASIu9FeyrCwQbd04gOJteZyK/txR8ctt82zkFV+Neau4St8a5yg5
         g8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqP61UXnZSWKBIO4nPkA+m1aG9HLb54k3BN5hLiXIn8=;
        b=VKpRZm6MvojA6UZOxJcJuIT8m2IAqVfNYP7hWAHOq4RUUG0ulgvo97iAoxSwCYmXmn
         2Q0PKKZKH5UBCZ9EFMd+psjoAX3L5tUKXDNUealm/6eBECldX3kguBktZGINGK/D2Juh
         egAHHtrqxC5+YzZbyHJkQuquYHP0KYVkYhEKemCmH6VBob01bVw9EWFKWiXlQcAk8ZZW
         VVZium3WIs1H+8lg46phrfIalmU+6NYZ339tbNutpp+e0aKb+g3hUN65VcVMzORMXFF8
         rQWeNxBbmKAqdcsJGcLUdMiop6QvaUtXLJdSCNADPQF4GvjDa41r6PJ98vrzczRGwFyC
         Xizw==
X-Gm-Message-State: ACrzQf0tCa+GwMjaIKsLE4LYWySWP6cQ9a/0kU6CPDEgajkTftyTBPx4
        Xccz8B3/m1aWj8BETX3zcH89tQ==
X-Google-Smtp-Source: AMsMyM60maw3V01Hhg5MnQssg5HmzeE+g1kQFsyQYcbQ6qcDwACS3L1nMAfP3RcQ5hT0sS+uxQjRmQ==
X-Received: by 2002:a02:a518:0:b0:375:59f0:a0f3 with SMTP id e24-20020a02a518000000b0037559f0a0f3mr28471609jam.24.1667938114903;
        Tue, 08 Nov 2022 12:08:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b7-20020a92c847000000b002eb75fb01dbsm4119352ilq.28.2022.11.08.12.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:08:34 -0800 (PST)
Date:   Tue, 8 Nov 2022 15:08:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] ci: avoid unnecessary builds
Message-ID: <Y2q3QZDxuywzCexn@nand.local>
References: <cover.1667931937.git.me@ttaylorr.com>
 <ff172f1de982f6f79b598e4ac6d5b2964ca4a098.1667931937.git.me@ttaylorr.com>
 <221108.86r0ydqmts.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221108.86r0ydqmts.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 07:52:07PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I don't know if there's a workaround for that, I'd think it would be the
> logical equivalent of e.g.:
>
> 	group: sparse-${{ matrix.nr }}-${{ github.ref }}-${{ needs.ci-config.outputs.skip_concurrent ? github.run_id : "" }}

Hmm. Did you mean the opposite of the last part of that expression? IOW,
shouldn't it be:

  ${{ needs.ci-config.outputs.skip_concurrent ? "" : github.run_id }}

That is: if we're cancelling builds when others are in progress, the
group ID shouldn't contain information about the specific run ID. But if
we *aren't* cancelling builds, then the group needs to have the run ID
in it, that way we're effectively disabling the new behavior altogether.

> But the docs say "The expression can only use the github context."[3],
> and I don't know if such a thing would fit inside the syntax...

That's at the workflow level. When you specify a 'concurrency' block
inside of an individual job, you can use any context object excepts the
secrets one [2].

Thanks,
Taylor

[2]: https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idconcurrency
