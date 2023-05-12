Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E88CC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 20:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjELUye (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 16:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbjELUyc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 16:54:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A32361AE
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:54:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba22ced2f40so15227832276.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683924870; x=1686516870;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QpfRmVYR+r/8j83e+uUeUNL1PdAsBdOrpqgERHsX2i8=;
        b=yvclC4awpDSSAOAJpYxUP/VcK8vdn8IwSZaLplVIu/ZxF9zpmv9RXc+nnlo1WP8brw
         p4HRnqwBTildBu5Qn1N1iM5eL2AJumzqvgDTZGA7hSoH1cTqUoczX5NoINbFSh3hATsG
         gswQtojYDbkKVDOVBxlml1J/JKbp513b0Lljq30gJJpLUcvaN2SUTjWavWec8d0nRGfc
         +6ZfT5x3bziSK8Hjdjw1mAeOk5XyJ8vejK+N6x1/WupvY3cVrXV/9pgus6iq3gD5lcpp
         QJlc6xf+rIpW4Aq5Md6iuwmQH0iSpKF57smYxIUba81SIDzMbqAE/ysaLjJOi9PfgdQk
         Yn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683924870; x=1686516870;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpfRmVYR+r/8j83e+uUeUNL1PdAsBdOrpqgERHsX2i8=;
        b=dv5MHoksjqArzgb3PGkp5r54TvCYFJpcJ2B5mnw3PfSo7VXSfVBeP1IMuED34glT16
         KZ2MPi3uDk6NnIpYkwW53NlYbagWdjeAuLAaaoroBtcJ705zbfYqszzdF4O1RzXLDA3e
         HViT4Fw30/KfP3yR+Mxpe+sXUOD11TUo8AjLtgZHBAvpF0Z0GXxcWld8wKZpzFZkMzwG
         6s+EC4eqvviwoJ2La84F/yufGttIh0MjBRDW/x6YGqv/ylhHU+t2p7ByjLma1JaMsv01
         3NPY4rVziymENcA/lyP4kXGrg1bq9QDkWqnz+8hFejB5FdXUX9gpmn2ivL9UTqwWBlKM
         /n0Q==
X-Gm-Message-State: AC+VfDybP75yn34ZqvQsRt10VSuuEp2VtARZWL21nM06OEC2teH/srLV
        5dTeTYsFLMl1kr4AgV1bL+DfbJecOYh8F3mR/KkI
X-Google-Smtp-Source: ACHHUZ54NjS12d8ShgB4P7uaeVn7mVne9KmzIQLEDsBQ2is/mQQuq8zFSGScImY/5r2UhZpU1daNp5+r7K3SxN5jGVcA
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:fca5:20a4:493f:ac3a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:e:b0:ba6:af30:21c2 with
 SMTP id l14-20020a056902000e00b00ba6af3021c2mr4069782ybh.6.1683924870301;
 Fri, 12 May 2023 13:54:30 -0700 (PDT)
Date:   Fri, 12 May 2023 13:54:27 -0700
In-Reply-To: <xmqqbkippca5.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512205427.1090937-1-jonathantanmy@google.com>
Subject: Re: Changed path filter hash differs from murmur3 if char is signed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Yes - if the bloom filter contained junk data (in our example, created
> > using a different hash function on filenames that have characters that
> > exceed 0x7f), the bloom filter would report "no, this commit does not
> > contain a change in such-and-such path" and then we would skip the
> > commit, even if the commit did have a change in that path.
> 
> Just to help my understanding (read: I am not suggesting this as one
> of the holes to exploit to help a smooth transition), does the above
> mean that, as long as the path we are asking about does not have a
> byte with the high-bit set, we would be OK, even if the Bloom filter
> were constructed with a bad function and there were other paths that
> had such a byte?

Ah, thanks for asking. Yes, the false negative I describe above only
happens when the path we're querying for contains a character >0x7f (so
if there is no byte with the high-bit set, it is still OK).

> > I don't have statistics on this, but if the majority of repos have
> > only <=0x7f filenames (which seems reasonable to me), this might save
> > sufficient work that we can proceed with bumping the version number and
> > ignoring old data.
> >
> >> Better yet, we should be able to reuse existing Bloom filter data for
> >> paths that have all characters <=0xff, and only recompute them where
> 
> "ff" -> "7f" I presume?

That was my assumption too, but Taylor can clarify.
