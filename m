Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E0FC77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjDYSca (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjDYSc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:32:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B4AC173
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:32:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5465fb99so5125634b3a.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682447547; x=1685039547;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fz+LORfNwOmzOrcEZ6+tO1QYwEN9HC1yLSMrK8b6Xn4=;
        b=LcOcvSSc5a2nadOf9eqOWM0tYRuxNvP7nCgRov5yh2oys664B7A4RIf4BLl0hLWBRu
         GzZbQBSdYRo5m1O/kU9NFS4k0fParjeUzKcoXatX/tiBE3niSnMa3foeTpCd8X5/JlIW
         IlXADCxeRl9u+MWLi++LUEJRqhqmJr5GRROH1+NbtEs3OapSQGLM03p8ML/g56iC5ouW
         jTDvTrDx/TnHxmp/MWBrnFZmxrvKPCvXm7xv0KqQdigiVxBde4EDtIZpxoAe7qWRda+D
         A2BFiAoGhOOCTqgT3bzYpi99o+PGCyRoDKR+X06bL9Ao+ANNavZ54pYf9vpS4WpfAkKd
         DKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682447547; x=1685039547;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fz+LORfNwOmzOrcEZ6+tO1QYwEN9HC1yLSMrK8b6Xn4=;
        b=QIuqX5Hua7Wxn+zkyihH8sjJQ8RtLdRUiKP2OoLBq+Snp8d+UaxwsP+Yk+ch13bkae
         o9P0Ytp7FWLDAD7hZurVKp3/FuMmBgcz4he+QaLu7HjCdykd9oPjRyPpz+RBFTa9zZ5m
         6+pmg7NN786yJ4ddKzMPrNN43K8MoNRCcjFC/dsplZzNX9FhbG/jPfUN43RQQTMcorOf
         +PNtzCXNW69Ng2Wkgi32RIfGXh9va7JilWobHhu5U4PQHbXbRX4WCqJpuvMKF6tMNRBY
         TdieaZ3kfU5wZFoJTDnxEPsOj8ntv3lDrSRSGMBGoNziMOV2YzQnpRP0T2ncZEDhUWKl
         hsQQ==
X-Gm-Message-State: AAQBX9eoNELe7/wwr4Hj7aMgqphLd4T1knkoB3k/ygsx6egCZewRu+5U
        R15h9o4d3NVTsws6MUYzgLY5R4gyHgc=
X-Google-Smtp-Source: AKy350ZmmGdGxevPgKNtdZVQ0+clXOxalScYGny2kSc9ztcCBrIb+EdtV/OoLgm/595HzKqFPr6XOQ==
X-Received: by 2002:a05:6a20:a10c:b0:f5:7035:99fa with SMTP id q12-20020a056a20a10c00b000f5703599famr7512310pzk.57.1682447546695;
        Tue, 25 Apr 2023 11:32:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e7-20020aa79807000000b005ccbe5346ebsm9576031pfl.163.2023.04.25.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:32:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/3] pack-bitmap.c: extract `fill_in_bitmap()`
References: <cover.1682380788.git.me@ttaylorr.com>
        <7624d3b5ba0415588a924aad2b855088e3d2028b.1682380788.git.me@ttaylorr.com>
Date:   Tue, 25 Apr 2023 11:32:25 -0700
Message-ID: <xmqqmt2vzubq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> To prepare for the boundary-based bitmap walk to perform a fill-in
> traversal using the boundary of either side as the tips, extract routine
> used to perform fill-in traversal by `find_objects()` so that it can be
> used in both places.

What is done is not a literal "extract", though.  Worth mentioning here?

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap.c | 66 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 29 deletions(-)
>
> +	if (base == NULL)
> +		base = bitmap_new();

Style?

> +	incdata.bitmap_git = bitmap_git;
> +	incdata.base = base;
> +	incdata.seen = seen;
> +
> +	revs->include_check = should_include;
> +	revs->include_check_obj = should_include_obj;
> +	revs->include_check_data = &incdata;
> +
> +	if (prepare_revision_walk(revs))
> +		die("revision walk setup failed");
> +
> +	show_data.bitmap_git = bitmap_git;
> +	show_data.base = base;
> +
> +	traverse_commit_list_filtered(revs, show_commit, show_object,
> +				      &show_data, NULL);

The original uses the variant without "_filtered" suffix.  In a
later update when the second caller is added, the new caller may
need to extend it, but shouldn't that wait until that step?

Thanks.
