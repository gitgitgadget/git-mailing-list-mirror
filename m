Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FBDC7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 23:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDKX7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 19:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDKX7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 19:59:11 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BF21BE8
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 16:59:11 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54f6a796bd0so74592057b3.12
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 16:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681257550; x=1683849550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w165FbynC8FcmF2mN7XAI0phBAkX9pED+y+KguMAnbc=;
        b=0T13SD2KQR2m8FTxDwUg7OhUVuxU9YRL+LyDvSPqy7f5nquoPTJymeRrdGLaIOVnY5
         hBciCI2xqy2QnAptwg/v0QGar3xrohLdrFyAy8aolaED/vRQMQEGVZGMmEa/LrhEKWZF
         cU+a7z1oT7u9zKzEL2QvmA8/7LLkXqe8MOYMo+zfS+NVr7GsGkPAHqUfn6TLmCBvsbDn
         YJLy1aRFkzLE5kH0EOe5bjTuQQx3bzZpOKl6Z2YZbjmJFtJ7e9yz+xJeIYZkPG0Pcc/1
         5FBhVF9I9kGiRDqkcVnKtZ73piNnOd9amCBsFa+ovFSxMHgUdJQ21gNLEXFZrSCVCWD4
         Nqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681257550; x=1683849550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w165FbynC8FcmF2mN7XAI0phBAkX9pED+y+KguMAnbc=;
        b=my5kqllZXf9VDxRXuGzRoiRYRjbpNNXTvzepzeEC+RaChfgehb5KjxtW7aSh3aijXg
         bA3WVRxt36nC5DVSdtnOHCVQXanxf0PZlaBoe6LPPvobY8+aD5kKJyRQxF3Bqa0R4pBi
         8GWGXNQCmtx09zYHU2+I0BIBhMDq18g4sOypW2kta6v6Ju8IV+M93Zzq1F7b2+iCMPoe
         VsrR5Y4SInSk/w/2KY79COEW5j5x2nj9cI7UnOELe6pKAJJj2ZCoukm8pBS3w4DJZ/8m
         PXR6ME8YjEqhW3OhhqkiSKyOX4MAmH83XYE8ZEVd0MrALT5B5YI2+4RNNfxftZZm57j1
         cqpw==
X-Gm-Message-State: AAQBX9c/l2oMPClUPFwAt3BTa3Bk6xFNQLrsY8NA419oPL5u6kqLVnsC
        53m2PXj3ErO8CdOGxduOiLmPDg==
X-Google-Smtp-Source: AKy350b6c0CQn2nO0h1avYVHg0EfxiNSk//9/vy5hsh2ZE+w8iuzyCqjrumltBtTAircf8fjCi+gqQ==
X-Received: by 2002:a0d:ddd6:0:b0:54f:859e:14d0 with SMTP id g205-20020a0dddd6000000b0054f859e14d0mr1474090ywe.36.1681257550156;
        Tue, 11 Apr 2023 16:59:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cd11-20020a05690c088b00b00545a081849esm2985921ywb.46.2023.04.11.16.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:59:09 -0700 (PDT)
Date:   Tue, 11 Apr 2023 19:59:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonas Haag <jonas@lophus.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Infinite loop + memory leak in annotate_refs_with_symref_info
Message-ID: <ZDX0SWLpPQGf9BPl@nand.local>
References: <39035D34-8548-44B0-BBBB-5C36B3876C4A@lophus.org>
 <ZDXCKecwxo36fALm@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDXCKecwxo36fALm@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 04:25:13PM -0400, Taylor Blau wrote:
> > I believe the bug in Git is in connect.c, function
> > parse_feature_value, in the updating of `*offset`: It doesn’t seem to
> > take into account that `feature_list` has already been offset by
> > `*offset`. I believe the update needs to use `*offset +=` instead of
> > `*offset =`. When I make this change, the infinite loop seems to go
> > away, and cloning via Klaus/Dulwich will fail with “invalid index-pack
> > output”. Cloning from github.com works, although I’m not sure if
> > that’s a relevant smoke test in this case.
>
> I'm not sure I understand. Looking at the relevant bits in
> connect.c::parse_feature_value(), it all seems correct to me, since the
> beginning of `feature_list` is adjusted by the current value of
> `*offset`.

Oops. This was exactly[1] the problem as you suggested, I was just
thinking about it backwards. When we write into `*offset`, we need to
take into account that `feature_list` has already been moved forward by
`*offset`.

Obviously the discussion can continue below [1], but just wanted to
correct my wrong here and acknowledge that you were absolutely right in
your original report.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20230411215845.GA678138@coredump.intra.peff.net/
