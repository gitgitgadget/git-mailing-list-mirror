Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4054C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 20:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLNUOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLNUNx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 15:13:53 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6908B2E684
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:05:07 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 3so4008756iou.12
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFfImfTodbI6kCVmew+OvrexGQNhiZb0ztCSz3YBnYk=;
        b=lYrXnCkCK3v4vg4Nw1kaQWGyLGFiUpsRYcZmX6is7TLUwnwJAMOmG7LTG/vTHsMF+M
         Qro2rC6Sz35nLcfmwrdOSfOx4PCIWGAJPoUf+I41oTr/MWmtEjtO81jerr0ITLzhP8C3
         q1/q5mJl/KIvbRX3tJu+sdni6TERB675OBPWBpg9CbEx7kum9yEpCts8QGY4D4OHgey2
         wcCv6GD6lcCjfIpsN5CmQoto1CDOA0BoER4kr6k/Ac9A9eOaIxLPtH162x2Vz8O9TkVc
         BdBbHnumAJjrRUDjvEMMLs2Z1ywmRUt0ObV7QsN7SHc5KI52RmyTuVL32GIZVtYHF57M
         3/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFfImfTodbI6kCVmew+OvrexGQNhiZb0ztCSz3YBnYk=;
        b=G8nnPIWzC3x8jf+fKehoDdGo+tPZM2Yecj7yrzamutV+HqnnxBBhFWBXupnQiosn9+
         X40UIuXUIHVnXDzm7+rvbrCS9uNtxW7JvaNBjbv1NrVweRlhAS6NzBXVDZlTg8v14bcI
         Dg+PD8EJ9pny1xIxPzUQMxT4qdN3c23pziavZeMCGVTgo/4Aut+AAN0Y/DprZsY5bYIe
         EnOzT90hQiGN2weqMQgcVO/cL8hdpWbGW54+mCJApR0PPtLno40F43OPqMQcw24to2wn
         O8az9pL4LnUTFNyoq56Z/Du3gsiJwMytyAT/BdNgXMVi331PYm4JSAnTQN6eksRowHA+
         TJCQ==
X-Gm-Message-State: ANoB5pnm0QzjLaV0BoyLm+rC7w/M2rtjzv7kneMtol7T9AzpwWqHlJQw
        aid/A1/zBpXFsXIB7jlRr/AoSQ==
X-Google-Smtp-Source: AA0mqf79jOnZmSyxK+xN06BrVjaD1NERAbt/ZVddxyh2gOJN4/h2coxaByvtc5EAedPitdJlDFovSw==
X-Received: by 2002:a6b:3c12:0:b0:6d2:5d6b:d33a with SMTP id k18-20020a6b3c12000000b006d25d6bd33amr17820942iob.1.1671048306800;
        Wed, 14 Dec 2022 12:05:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y10-20020a056602178a00b006dfa5af69f5sm285525iox.0.2022.12.14.12.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:05:06 -0800 (PST)
Date:   Wed, 14 Dec 2022 15:05:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/5] ref-filter: truncate atom names in error messages
Message-ID: <Y5oscak6T23G81Gu@nand.local>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
 <Y5n4mb/S/RORb+N7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5n4mb/S/RORb+N7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 11:23:53AM -0500, Jeff King wrote:
> It seems like the cleanest fix would be for atom->name to be _just_ the
> name, since there's already a separate "args" field. But since that
> field is also used for other things, we can't change it easily (e.g.,
> it's how we find things in the used_atoms array, and clearly %(refname)
> and %(refname:short) are not the same thing).
>
> Instead, we'll teach our error_bad_arg() function to stop at the first
> ":". This is a little hacky, as we're effectively re-parsing the name,
> but the format is simple enough to do this as a one-liner, and this
> localizes the change to the error-reporting code.
>
> We'll give the same treatment to err_no_arg(). None of its callers use
> this atom->name trick, but it's worth future-proofing it while we're
> here.

For what it's worth, I think that this balance of a somewhat-hacky
implementation against a more significant and trickier refactoring is
well thought-out and the right decision, IMHO.

Thanks,
Taylor
