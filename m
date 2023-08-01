Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479BC04A6A
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 20:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjHAU7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjHAU7F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 16:59:05 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4342B4
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 13:59:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-583b019f1cbso65979907b3.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690923543; x=1691528343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQLL5onkIfT9F556IfE8fSXfG7wlZZcZcVskIZWr0+Y=;
        b=qNF70Jq1nj0xXl7/IislPonWqcvZZp7fMu6zJyQ3qJH3QAhB1myGhXjs0j1lqcvcQO
         3guBjbThz7XS+bSh5g21pe4oxzhmaGGbNLA7cgUroTj6w+6ZACgUBMW0QlfIx9zV2D+c
         +EEdlnkxcB0Kh8evf7EslfNp/iUbeOSVbP/MSZb8X2p3QFHSBiNVdUNQ3YK+7lnjxjG4
         YnfVRxalLMU0by2dt93nbvEYVwFNh8fGj+2QnG5n6GxJoL010gG7pD7/BBZD6V6QswiW
         2JZa2BPw9cAE/aNga6HZvhEgpb65bG7QWHpg8bcxKv7JUV/klS1RSlns0UzsffdFeOHE
         Nhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923543; x=1691528343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQLL5onkIfT9F556IfE8fSXfG7wlZZcZcVskIZWr0+Y=;
        b=R1/NUUfW64/DaDqZH3/QCJ7MWSp6691ZYEkKagyLQ/5JHH81PLn7qXU74bSdMNc4Oj
         y22DkYV8Y/zHc+eaf4NK038Gvh2ioydUzubOEWyFqFIlDd5oaQParPwqN1z5tV/v9OUm
         lBn33iUrZGugE0938N8jTi40FI2l/qTiHYUTxJnndXiM2f0L0fq+Bo0hhoHyLhfBUMlI
         8vwpB0tjCDwBNXMMb8oHwb5XCoh0ssK8O8tfYziPVBzT4A1K2CuqeHBa7mM+3zlO1yIg
         CgC4DdIVe3fZZ6ff+vKb66Q8aniYFVZF+jXl/K5HeQhSVhxntDUi+CK5GUgPoQOTpItJ
         9BzQ==
X-Gm-Message-State: ABy/qLbBN5eNS486ArnQvK8hAdO+v4WmIDkBxw0zcDFqn416MGzpgwJk
        7UtPKEcku/K5P4SgBifTMsDj9Q==
X-Google-Smtp-Source: APBJJlGAbegnSSZYUFCgaF1mcRbKxgxJXo2wFOiTePCSyRcLrlnecEg9YKJevg46s+MP7JcXKwwCNw==
X-Received: by 2002:a81:4fd4:0:b0:568:8fa1:7a3 with SMTP id d203-20020a814fd4000000b005688fa107a3mr13641351ywb.5.1690923542756;
        Tue, 01 Aug 2023 13:59:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t5-20020a814605000000b005771872a8dbsm4037696ywa.132.2023.08.01.13.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 13:59:02 -0700 (PDT)
Date:   Tue, 1 Aug 2023 16:58:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v7 0/7] Changed path filter hash fix and version bump
Message-ID: <ZMlyEpRCPPNG7jQP@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1690912539.git.jonathantanmy@google.com>
 <xmqqbkfqbo21.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbkfqbo21.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 01, 2023 at 11:44:06AM -0700, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> > Taylor also suggested copying forward Bloom filters whenever possible
> > in this patch set [3], but also that we could work on this outside this
> > series [4]. I did not implement this in this series.
>
> I think it is a good place to stop, as it would merely be a quality
> of implementation difference and would not change the transition
> story very much.
>
> Thanks for working well together.  Will queue.

Thanks. I read through this version and feel good about the results.
I agree that queuing this one down makes sense.

Thanks,
Taylor
