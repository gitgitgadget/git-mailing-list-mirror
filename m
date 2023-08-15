Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BD3C41513
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 22:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbjHOWLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbjHOWLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 18:11:11 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7E1FEC
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 15:11:09 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d645b95c7b8so5097675276.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692137469; x=1692742269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8wuaTzcZIkuIqjtgAVuxTYWKbBNvowWYxFT20STKdo=;
        b=gFb2Dvqn0S7JYSRfU0uY5frrkPRBK1lSUVB2NfyTiaIGjuQuazUvk8jnKiO4US39mA
         E2KuMoAaHCS4qkNTDwo+S3zrCpVYHa8iXVO90Sy7uHlvuGmpjNRKMwQi0ZFRI6hZLpa4
         PuYW1eWzEv2UyN4rUVuEFPsQRcvXYwq9MJ8T86VsSipF9Hbfh+MHtOG3BniK1IcReMEQ
         NxBl3atS8CNomI4eFnpxTpUHyE0RFtoFvcb4mNNPOfTw1Ds2KVWpc9ebg3u8/GQXagi0
         OGLiiYcn+pmKgn2RpS4h+1xDlhe838tDhVt6IdjDt19ht/DRf6n+O+F/75oT49uJTfNv
         sXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137469; x=1692742269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8wuaTzcZIkuIqjtgAVuxTYWKbBNvowWYxFT20STKdo=;
        b=N5VmyHDTMeCDfeIt3Py0H0uDSpwJKuKxZtfTzBszgcXBEkwtfO+k6DUyD7wWd9o3rV
         oXO0HvayjJd+gcaHq4n2TsJZwQYTdH+lQSbXracPf3DntW4+vn3iCtFK5pBv82e+/FkX
         ZAulTMgHhB6jODRGhHQrU+BVH0hvcG16tfyNSsWcyenWhTBx7THQMztM6wWUyfgeoqzq
         Diu4biYlhpJm+MjgRMOX7n2XTuUyknBK+SFlVPt34ChSvErBUnCKIAGiEGco7LD+I7kw
         XClAHScDbYo+XXHuVC6PKU1uYFHp6nX8K4lvMQB1cbzbRkTFln0BuT6Uj4Kf7sSlFwsy
         HQcA==
X-Gm-Message-State: AOJu0YwfqdztwFlnfyG1899Y5OGry/uF9DdPq3YqGC/BkM6Q33GqlMJ+
        zMqHXd3w6GJdOnliA9EQOVyD9w==
X-Google-Smtp-Source: AGHT+IFZEZ+d5MTo6nNfGU194w38cSKfdNWr5+8unVafBneGCfLuBCjvf/MiatsFDeo8JK9cs9B8vw==
X-Received: by 2002:a25:50c4:0:b0:d10:7acb:24e0 with SMTP id e187-20020a2550c4000000b00d107acb24e0mr53794ybb.41.1692137468697;
        Tue, 15 Aug 2023 15:11:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p185-20020a2542c2000000b00d1890dac6a7sm3181135yba.29.2023.08.15.15.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:11:08 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:11:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug] In `git-rev-list(1)`, using the `--objects` flag doesn't
 work well with the `--not` flag, as non-commit objects are not excluded
Message-ID: <ZNv3+xOCi920StXO@nand.local>
References: <CAOLa=ZQmjroDiOcUsu_MHtQ-88QHU9qeZPOPh+KJJ3dFoF2q0A@mail.gmail.com>
 <xmqqttt0hzl2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttt0hzl2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2023 at 12:31:37PM -0700, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > If you notice here, the objects
> > `8baef1b4abc478178b004d62031cf7fe6db6f903`,
> > `086885f71429e3599c8c903b0e9ed491f6522879` and
> > `7a67abed5f99fdd3ee203dd137b9818d88b1bafd` are included in the output,
> > these objects are reachable from
> > `91fa9611a355db77a07f963c746d57f75af380da` and shouldn't have been
> > included since we used the `--not` flag.
>
> For performance reasons, we cannot afford to enumerate all objects
> that are reachable from --not objects and exclude them from the
> output.  So it is a balancing act to decide where to draw the line.

As a hack, you can exploit the existing bitmap traversal routine to
build up an exact mapping of what is and isn't on either side of your
reachability query.

IOW, if you run:

    git repack -ad --write-bitmap-index

and then repeat the rev-list query with `--use-bitmap-index`, you should
get exact results.

Note that this will only work if pack.useBitmapBoundaryTraversal is set
to false, since the boundary-based traversal that is behind that
configuration option is susceptible to the same one-sided error.

Thanks,
Taylor
