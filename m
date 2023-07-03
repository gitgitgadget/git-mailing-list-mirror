Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002EBC3063F
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 17:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGCRH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 13:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjGCRHz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 13:07:55 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E885AE59
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 10:07:54 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-57012b2973eso58821517b3.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688404074; x=1690996074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTDVm0RIFl173SEOKsaFY86ouRYneQ/Ii0crfgOsaJ8=;
        b=gj9LagcqpXEFkwd6sIr6bCSPOm3PPEd9NSKU+J/5gXawjOLFji6aLHqHbxF5yJX+zJ
         Iy2izfLNMETY5GWQCre8E3CxkwFR5LwzHWvIhC3S3JFgReIOAFJ13cXhHig+haCEt6tY
         sm6WJOlukhcA//bW91inUQrEjKIGMPuKFUhEAAr/cyGkrdR72BtD78iMlDRvzknh6b92
         uFaO1HF2DB69kADxqc1x6PayP41RRabDsB4wcKk0YaWSzyuRiX+tGltLprhyvdzr/dUW
         4tOnPDXDgmxtnvV58Rx1REL0c0YQ61YFIOkl51nIhH3ZnBVpRNk+Qp27CpUDEq+KvIBZ
         2uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404074; x=1690996074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTDVm0RIFl173SEOKsaFY86ouRYneQ/Ii0crfgOsaJ8=;
        b=jlQL9OA+n1k7vetVfECH2dG7PceeAbG7K7S89GMAmh+elcMLFHZcp0XuSV0/R1rgl8
         qinggUHFon0p1E7e+Zx6L/Hz/DTqDlvyK4ZIRkb2oP1wjRgQ/tsEQyA2WF7dbf/POpv6
         R5UogILl4jtHfCDEzZ/fjTXVqr0fxyC8vx1HSSziPzjXTMR0I49xCp+LrdiwHK901T/a
         jY7UVe5KuUstP9MlojikI0oGiyEO/nP8OlN2Ew5yGWAo8DWzJfbZjDh57Ntwj0v7PpEK
         AFDGHHyzta1b73+D2h6/B6o4ypY6vpscgu6bbkS+KniZyMl091Bx2re3mrH+oAaH70UR
         gaMg==
X-Gm-Message-State: ABy/qLZQr2SmgdIkf9Nx37DLnDDFJffGC69hZ+9NovC/fIAODjEmrJce
        ewjejqaMNmkj2soVnjKkSMQPQg==
X-Google-Smtp-Source: APBJJlGH3C+XN9a4F1uDl8a7Qvtxtfrx3WETpk+AK6hhYzpUY3FSOPIiJHKtaj2UHBeyrsLZLpvvDA==
X-Received: by 2002:a81:6754:0:b0:565:a3e6:1b7b with SMTP id b81-20020a816754000000b00565a3e61b7bmr11940104ywc.18.1688404074134;
        Mon, 03 Jul 2023 10:07:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f65-20020a816a44000000b00555df877a4csm5102005ywc.102.2023.07.03.10.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:07:53 -0700 (PDT)
Date:   Mon, 3 Jul 2023 13:07:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 02/16] ref-filter.h: provide `REF_FILTER_INIT`
Message-ID: <ZKMAaI3I7NDDatXk@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <7ce82b6a5a451ff183ba8d35fc0f50acccee8972.1687270849.git.me@ttaylorr.com>
 <20230703051504.GB3502534@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703051504.GB3502534@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 03, 2023 at 01:15:04AM -0400, Jeff King wrote:
> > In the meantime, fix a case in test-reach.c where its `ref_filter` is
> > not even zero-initialized.
>
> This test-reach case scared me, but it happens to work now because
> commit_contains() only looks at the one field that we set. So we're not
> fixing a bug, but more like a bug waiting to happen. :)

Good point, I updated the commit message to more clearly signal that
this isn't fixing a bug, but rather preventing one.

Thanks,
Taylor
