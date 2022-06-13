Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3131C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 21:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiFMV1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352159AbiFMV1S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 17:27:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378FD1DA55
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:18:27 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 68so5009804qkk.9
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l6Rebofvf+BH+ynqcTptaZjBmwB1DqSuTzBwaJKSqe4=;
        b=MX5gIXXXrZNdPW502Da4sngaUc2BNjribEz0OdOK2wFe98mPPLHHk6SqnATAXLsQff
         Z9tEpD9LCj9NkMpbpL0BSBD8hT5agggMZ6DkBOsNWB1Xb5j/2a4B0mXSqyRR+S2O1lA4
         wiIqj/wwGzF4IDIK7HdGSb1ajHXfOFL7ei0QPC+9TaciKYPyN4cYNtB8EspP5KnN9/od
         OZuE0tozuBU2HsZHHwkZRjb7HUdpPBzwSvmd+3b5FtPbZ1Iib/kFfulUXkvH5fw0mQ7h
         eyKNBAhpSEnfuZ1qq2qIzeG1onm0NYvyEEB4+3fpfGZeOnuWsfHLS184gI5LjbsVva/2
         rLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l6Rebofvf+BH+ynqcTptaZjBmwB1DqSuTzBwaJKSqe4=;
        b=w/aH98Cf6Vt0yUconfAQoHYh3e4bW05Y0AnKCeyla2xSYMELfhRl7Wi7O92SveuzgT
         hqkCwue3Sv7fl+hiClC5V5foEf9/znYkt5YBfZ4hiooGQg5kkaifYNog1CXDGlZ0Ur+G
         kN/zN9p7lXLf7rBhtEpfyH3k51TdKipow69ICa4eVDJNQpaBcGT6TJqb77H/qRq/c32y
         dkOWESkazq6gUiZegih7uZ8OvL2eQVFj/xZTeWCHiql4odwKkjAmJfkKXW6EaK1TSYjk
         nwPkaEdRZ8VXUVxdtY1mkw803isAt6jnq4Ra3yN8YkMSIqQc30EzrnF4Dah/qSKVi25k
         a8Kw==
X-Gm-Message-State: AOAM530jzTyv5ChJGUuZKaOhEEp4hbo78t9LVnUYDC6mtsLewzH3hFUH
        eo4oNd0V7IZdOzy9e/hofBspYQ==
X-Google-Smtp-Source: ABdhPJzEQ9n4hxpoqswwOlalM/PVjlpZU6/Qdt81d5LmX+bQO1PrTwdACGcdfmt0NyVKGUHENKu71g==
X-Received: by 2002:a05:620a:1989:b0:6a6:afa2:1700 with SMTP id bm9-20020a05620a198900b006a6afa21700mr1690203qkb.189.1655155107047;
        Mon, 13 Jun 2022 14:18:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q129-20020a378e87000000b006a6b564e9b8sm7334618qkd.4.2022.06.13.14.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:18:26 -0700 (PDT)
Date:   Mon, 13 Jun 2022 17:18:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Repository corruption if objects pushed in the middle of repack
Message-ID: <YqepoUMb3rkKgWqB@nand.local>
References: <20220613203145.wbpi2m3ys3hchw6c@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220613203145.wbpi2m3ys3hchw6c@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Konstantin,

On Mon, Jun 13, 2022 at 04:31:45PM -0400, Konstantin Ryabitsev wrote:
> As far as I know, the maintenance steps we are running shouldn't result in any
> missing objects, so I'm curious if it's something we're doing wrong (using
> unsafe flags) or if git isn't properly accounting for some objects that come
> in during the repack stage. We're seeing this happen fairly routinely, so it's
> not just a random fluke.

Interesting. From what you described, it does suggest that `repack` is
deleting things too eagerly.

But I would be quite surprised if that were the case, since `repack` is
*very* careful to only delete packs which it knew about at the start of
the repack. Likewise, when it cleans up loose objects, it only unlinks
objects which can be found in some (non-deleted) pack that will remain
in the repository.

So I doubt that repack is doing something weird here, though it would be
extremely interseting if you were able to pause the `repack` process at
a specific point, push new objects into the repository, and reliably
demonstrate the corruption.

Thanks,
Taylor
