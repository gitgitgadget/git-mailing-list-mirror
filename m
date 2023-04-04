Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533BCC761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 19:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbjDDTAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 15:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjDDTAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 15:00:07 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6701AB
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 12:00:06 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54606036bb3so468100727b3.6
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 12:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680634806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+x80pvmG6jHyw8E1WvhsxTkUxoS2o8SnG4qgFwPLH8U=;
        b=FPqJnsnHi5DWrmocklYKjop7Cv7/1lQVDcIuDAnpIESt/c2LkXDA/gXKDWAiEGH5ED
         bhgTSoHGqWLkPeTQCPlGeAJmAjl0IzAH9UuW69AOWsjBZ31VoZxG8vwfr01O8cdlt71k
         Zv6RgYM9+YHIPMKZHeeGefMHAM/SxFlQ02t7MUwpkWvNp+E9cxf7y+DkyQTNEf7v/8Ck
         lSRiFuRxV3E5aLApS3WudTE30kbuUYAXNdt9a+fOJe6I6l6M9RdaHNya37ua+YOr+IrM
         vOqkTwp4KGdIr9IU37R9sCBo3X6iAEvh/qlTzyDEvFZUoRs9A5jfqF0qf5GzafkVfual
         rA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x80pvmG6jHyw8E1WvhsxTkUxoS2o8SnG4qgFwPLH8U=;
        b=s/K2giuKQid5tadB5lcQtdW6eWISw3g4BOfZ2YG29RH3dLWt8GIqVZZmR9WgFQ8maa
         fbE5VF4AKfVtGALyR1ypePjW8yRRucQ8qvm3Q6xDwtEYG9zgTtk3JJMTEH8yM7/Lg/gb
         EejnNAw9TUO4KXM63snDIUafkOW6TUu5imx0FcEn/2mXwnHFZngOZDA7AfTlqaPeOv8U
         c7GwaserkvwC4zG+6swmaGg+7/CaRQ3/hRT5GnUy/2CLpW0e8JNUkSYxQv92yx1Cr5Wa
         hjjGjKrVximpl+sFvvD0WMYyeAMZyggPtqLVWm8+yPtuzk0uLTuQZMkka+3Yrnc2bqMU
         yHMg==
X-Gm-Message-State: AAQBX9cSSqJFrhde0r3fXNVcCwUlw0JSDwqcUDkSchzQIwX0PoX/BvaN
        8MLM3ja/6uCeIIYApMp3uBVLKA==
X-Google-Smtp-Source: AKy350aBtWBcTSJQ8yFtRyZlxVglhwPu2K9lVeedkYE7SJTGWbzI5ZgJfZibx4S9gBxD7rMjEGveCA==
X-Received: by 2002:a81:46c2:0:b0:538:93d0:ab71 with SMTP id t185-20020a8146c2000000b0053893d0ab71mr3089150ywa.47.1680634806120;
        Tue, 04 Apr 2023 12:00:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 125-20020a810d83000000b00545a08184c9sm3365003ywn.89.2023.04.04.12.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:00:05 -0700 (PDT)
Date:   Tue, 4 Apr 2023 15:00:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZCxztCEq0sZygZ25@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCxytq1esQWvjIz/@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 04, 2023 at 02:55:50PM -0400, Taylor Blau wrote:
> I think we reasonably could do something like ignoring non-local packs
> in `init_pack_geometry()` only when `-l` is given. That still runs into
> problems when trying to write a MIDX or MIDX bitmaps, so we should
> likely declare the combination "-l --write-midx --write-bitmap-index" as
> unsupported. For backwards compatibility, I think it would make sense to
> have "--no-local" be the default when `--geometric` is given (which is
> already the case, since po_args is zero-initialized).

When summarizing this message to colleagues at GitHub, I came up with
this TL;DR, which I figured may be useful to share:

  TL;DR: I think that this is a (much) more complicated problem than
  originally anticipated, but the easiest thing to do is to assume that
  git repack --geometric=<d> means git repack --geometric=<d> --no-local
  unless otherwise specified, and declare --geometric=<d> --local
  unsupported when used in conjunction with --write-midx or
  --write-bitmap-index.

Thanks,
Taylor
