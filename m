Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BCBEB64DA
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 01:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGUBiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 21:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGUBiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 21:38:21 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F253D1FED
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 18:38:20 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5704fce0f23so14908527b3.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 18:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689903500; x=1690508300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xkeMLU4PoDso5CeC98+3k9PBrX2UiDib/6uNA/PpVM=;
        b=FkQu8Zep5g6ztdiG6oPEUzCx6mxqZTDIASBfU537HQpUADRjxcrXgR9JqZ7XY1Z8dT
         0YyzVs/9SEjt0z+xWh4LKoTR1XoY3z1SmMokL+DvzxK4SIHMPcwp5zF4sM+dvNcJ7S5V
         8axFY5igPE12N/jqp9xDDKG9JSLMPBpr1aT5UMEZPCFg/G/JTnYPy4ypznqOM2J/93rJ
         NDmM/N9fuhSA+w042eOnlkqqGLQXap7peEmMAMkyEOfqsnbprLpRlYZPPybDc7uoU1uA
         tYRfMVVdT0jvVddpE1Py9YZmlX5gF1kfnsz9FmfZcyYt1snQYrmp7JzHJssOE9dU84VK
         MedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689903500; x=1690508300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xkeMLU4PoDso5CeC98+3k9PBrX2UiDib/6uNA/PpVM=;
        b=b6TVvnmTlz4m4/hP2fFQOyZv/jZQ4aEqrYvG92BKRmc2jNmrVEFR4kjAjTPuJFjxjx
         9JB2ABFI5nW011WujZW5pdEHhYOWyhVd+4mJQPJ8AMFs3vx/WA40IWzniUn4fAIS/KJk
         x2CUqijOeyRAaA2RSH3t9rEO1laesmV5lwFQ2RinwRuTHBQVGOi74L7Q7cLEIFEzOGdk
         T7+oAawfU6ajQJugJwb2Wh77ivJzW9/ryauxgsYFZO7fny3rJhEVKxg47PKocWRbxQsJ
         lzSsMBvW/ACFKqt1mMzDn1KTaZXGlc3YsfjdIx9r2CIXyyBE3qqbDCM+MC/C7hOl1iaq
         NhAQ==
X-Gm-Message-State: ABy/qLZAUCjkPxJHaL0f+a2W0kQy0u5OB37gxvspVIEmt0EfIR7J5dcr
        XjVdqGlWMj7xhPsUp4KSYRDxTw==
X-Google-Smtp-Source: APBJJlEUVZ9lt0jvRYcteA+QSz49XUT9vIZCVCocEh+xA45EEtazqiLJc+LHcJNuhVPpfEeynowmow==
X-Received: by 2002:a0d:d788:0:b0:583:9018:29ec with SMTP id z130-20020a0dd788000000b00583901829ecmr619269ywd.32.1689903500102;
        Thu, 20 Jul 2023 18:38:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w189-20020a8162c6000000b00582fae92aa7sm582582ywb.93.2023.07.20.18.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 18:38:19 -0700 (PDT)
Date:   Thu, 20 Jul 2023 21:38:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/4] gitformat-commit-graph: describe version 2 of BDAT
Message-ID: <ZLnhihfaRDUmlsi3@nand.local>
References: <ZLgcfvIrV3TapMAp@nand.local>
 <20230720202006.3815802-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720202006.3815802-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2023 at 01:20:06PM -0700, Jonathan Tan wrote:
> Having said that, I am inclined to not change this, so that the offset
> calculations are the same for both versions (e.g. in the test tool
> too), and as far as I know, we haven't had problems with this. But I can
> change it if people want.

Yeah, I definitely get your hesitation. I wonder if the test helper
patches that I sent change your thinking on this at all, since then
we're not relying on those scripts at all to compute the offset of the
BDAT chunk and dump its contents.

To be clear, I do think that this is probably outside the immediate
scope of this series. But since we're changing the on-disk format and
bumping the version count forward, I think that we want to make sure
that we're not missing any other format changes that we'd like to make
along the way.

I suppose that a theoretical v3 of the BDAT chunk's format would use the
same encoding for Bloom filters. But storing an extra 4-bytes of
information in the header of the Bloom data chunk feels like we could
squash that in.

Thanks,
Taylor
