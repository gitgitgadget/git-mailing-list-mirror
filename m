Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3365BC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjDRTks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjDRTkq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:40:46 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ED6659B
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:40:45 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54c12009c30so579256497b3.9
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681846845; x=1684438845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SX9GZRq4P18vZF1oj8GB1Hgx0PEsZRWTO0ciVkor+rE=;
        b=2TKXpl2VuZQK8nGwmrtP7Nhuf6jb99g5YIS8efjcmy0bOShUPBjyFT0MwRVq3lJrmb
         K/jSU4C3LklNH047El/eyj267ovsd4Tpy1/szlkqgwSCbe1kUMzF2RWoapgjJiPEwWlI
         64PjifrYj5zfglmNo3X+cegNMVfxjVsi05nqB2+5JH5MWmazICuOjra7sFPn3DU8Y4Mn
         kRFizh3wpKgYamb7zbswOtZdP7W926sBM7aUyTgpOsPhGO4e6jK0cmlKd+dsLIcsPTlo
         ndsMRi/Iomg/nUBXd/0V0P9SkSWxOkFvJs3FAoApI90Zrd9iZ4mYFfdlWulZ4bbTcrg7
         4o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681846845; x=1684438845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX9GZRq4P18vZF1oj8GB1Hgx0PEsZRWTO0ciVkor+rE=;
        b=fpX8aMwH5XFK4Ixmb9i9zmSitkXV8tw63QmUbS9hi8htRmIsdjSh/WPFzFHNmdyT/+
         ruj8jMVd7GiWrp7VyF+xMWkD/MfBtZIk5nUA212vItWls3Br4+EojpaxBSFRfF0e5M3X
         TQfB2D0NNQRtIE7KVVote2IbTNNzIFxuNZoFRqwI9V0VgloLVmPm4kUzVFF4etnbX9wh
         94TIesFtseW3/VUjWGJlXvUCxeMnhHdQm4wYc0HRAB5ez97yodQmFyaiNvpOpgcv6CSr
         3pk+eLHfExnAvqrV1I/Q/pPitkFdAyxXDnKzNSu/qGnXpt4+URDa8GEYQ/6wiuMdCaFW
         kv6w==
X-Gm-Message-State: AAQBX9eNEA5E24pwMRPg+oqIbUA9gE3MT/gvhI+++YrH8JeMClQOLKEb
        RE3BT0K9XMihzMCHSiwvNy+Osw==
X-Google-Smtp-Source: AKy350a4S5dBhLyC18+ayZX7mTzBdIqqtXaGaMYUTxaep2BOZubwczwBh5SDwBBtnx78XJ40cLoVOA==
X-Received: by 2002:a81:9185:0:b0:545:acb:e5da with SMTP id i127-20020a819185000000b005450acbe5damr911916ywg.28.1681846844974;
        Tue, 18 Apr 2023 12:40:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dy13-20020a05690c270d00b00545a08184b9sm3549168ywb.73.2023.04.18.12.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:40:44 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:40:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] pack-write.c: plug a leak in stage_tmp_packfiles()
Message-ID: <ZD7yOyC7axl6utEZ@nand.local>
References: <cover.1681764848.git.me@ttaylorr.com>
 <65ac7ed9b843a83f7b4cc0acd7b4e70d98ca20aa.1681764848.git.me@ttaylorr.com>
 <20230418103005.GC508219@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418103005.GC508219@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 06:30:05AM -0400, Jeff King wrote:
> On Mon, Apr 17, 2023 at 04:54:15PM -0400, Taylor Blau wrote:
>
> > The function `stage_tmp_packfiles()` generates a filename to use for
> > staging the contents of what will become the pack's ".mtimes" file.
> >
> > The name is generated in `write_mtimes_file()` and the result is
> > returned back to `stage_tmp_packfiles()` which uses it to rename the
> > temporary file into place via `rename_tmp_packfiles()`.
> >
> > `write_mtimes_file()` returns a `const char *`, indicating that callers
> > are not expected to free its result (similar to, e.g., `oid_to_hex()`).
> > But callers are expected to free its result, so this return type is
> > incorrect.
>
> Makes sense. I do think in the long run that it might make sense for all
> of these pack-write tmpfiles to tempfile.[ch] (either directly, or via
> register_tempfile() after creating the file). And then it would be safe
> to pass around the tempfile struct itself, which contains the filename,
> without worrying so much about ownership issues.
>
> But that's a much bigger change that shouldn't be part of your series.

Agreed on both fronts. I'll put investigating something like this on my
list of things to-do.

Thanks,
Taylor
