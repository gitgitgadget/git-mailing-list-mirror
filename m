Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062C2C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 17:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiF2RD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiF2RD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 13:03:58 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39313B3E6
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:03:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f14so12594407qkm.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=98l4Valdm0qd/5MqtIIy8cX2oJ/sr+Z/60+LT8cOB0s=;
        b=bSgVDK+ck8RkTf6jB4b7tAFRjm/i9Unkvccl4qwlKxvZGNZYevO3Fw4Z4Gh8Nuk0sV
         6qSsv6SMFgVTM/rSLQQsAQj5h+YEYqUOUybYatKsx3zQFilAGQ3XEiZY85ppOgApQkv8
         syi5pcL/fziljVTbPltK/t4FzOXaxcHZdcXlSWdJ8uUKQ+wBk5WDbYnHmYK2l8JQormc
         kWYRDZbeQd9BMG/bxk0/d0JHLefxG9dnhocCmynSejiQkQnusnyul/8vE2BKIELUpI0V
         DzimCJGM+nstgXQoE+s3swTnPlOCNe4sAwPOJVIvC9/bHJ+05QTaeMccfh8wCg784o72
         tTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=98l4Valdm0qd/5MqtIIy8cX2oJ/sr+Z/60+LT8cOB0s=;
        b=sxe891suoUAS1juHRXN3nhwrHY7wll4g6gdC+KYEepJI8L+owASNYlKkfLZtXCuVLr
         5Yq6xkGXmieJQYrJ9hNct7rhs7/CBzVEr8fnYSMmJ6K/SGqwkLTS1PvjjAX5csTDeMIX
         IeyFOCXxdHo2s95dU0uMHhWj2nZBjM0wkRwqamQxwd9/xY8Lwj3EYZ28rgOe2vZOHu/q
         FDUkPNEnsH4yzlrS89EbDAmm4QE2BpVDA6UsvGWug5b4bsnK8WPeUTrpYqabQoqnD12X
         Sr8n0MVMlTrwJNha6AMZMbGYxj4QgaVz7aMHfxf5IFKa/cv+plyMztaJ+9G4DdOdy3nI
         Nxhw==
X-Gm-Message-State: AJIora/OOWSr+cs9LWiwIaa5Xf63kxwEwQRR6Zv31KZf7yuf/qcNddTV
        E491HpdFGvlvZpap94H3ovvMzA==
X-Google-Smtp-Source: AGRyM1scjAarK6EFHw4KoNIO/+FpbBTAHuHbcbrttXWqszHyhcUw6O4bFTVhRUwjMv9/fQOUxeK46g==
X-Received: by 2002:a37:5383:0:b0:6af:373c:ebfb with SMTP id h125-20020a375383000000b006af373cebfbmr2908764qkb.475.1656522235807;
        Wed, 29 Jun 2022 10:03:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9-20020ac85989000000b00315a5fa4bf6sm12011648qte.7.2022.06.29.10.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:03:55 -0700 (PDT)
Date:   Wed, 29 Jun 2022 13:03:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Gregory Szorc <gregory.szorc@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: Race condition between repack and loose-objects maintenance task
Message-ID: <YryF+vkosJOXf+mQ@nand.local>
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Greg,

On Wed, Jun 29, 2022 at 09:55:54AM -0700, Gregory Szorc wrote:
> 1. `git repack -A` creates loose objects
> 2. `git maintenance`'s `loose-objects` task deletes those loose objects
> 3. `git repack -A` fails to find the loose objects it just created and
> aborts with `fatal: unable to add recent objects`

This is a somewhat well-known race that occurs when one Git process
decides unreachable objects are safe to be deleted, but an incoming push
or reference update makes those to-be-deleted objects reachable before
they are actually removed, leaving the repository in a corrupt state.

I'm surprised that the loose-objects maintenance task deletes those
objects, though, since it just runs `prune-packed` or (the equivalent
of) `repack -d`, neither of which will actually delete objects from the
repository.

I see that Stolee is already on the CC list, so perhaps he could chime
in on the above.

In either case, my recommendation would be to keep those unreachable
objects which haven't yet aged out of the repository around for longer,
which will decrease the likelihood of seeing the race. If your
repository has a lot of unreachable objects (such that storing each
one of them individually as loose is impractical), I would recommend
using cruft packs (e.g., by running either `git repack --cruft -d` or
`git gc --cruft`) to collect those unreachable objects together into a
single pack.

See Documentation/technical/cruft-packs.txt for more information about
cruft packs.

Thanks,
Taylor
