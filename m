Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D934C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 23:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjDJX3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDJX3d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 19:29:33 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C316211B
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:29:31 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54ee9ad5eb3so122821097b3.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681169371; x=1683761371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZ0ia5sRDGQkAwof+Od4n2KCtDiYQDl50wcfod0xRW0=;
        b=GFNBgQogteLvsMmPHtQZeD1Unq5azZbqo3xWfF7T8Dd8VV9KTeMlTR6q7mg9NsWzVz
         /1mWkdZKGXnk1a1SeFWSuEn1jOQg5uqMYZZc3KDz3MYpS3IKg7F0Dxa9ShdatSLbCPD9
         CrWDvz8+2rr+2RjVZ0qoriFkDkUWZDdPOj7cqqhavkbixZhyz3eHM8LEnEy206COolOJ
         1ekvVHPrjFc0yjhWkcwX1O4YflMjK0O9D1AsBmJ9+3swf3esFlZArsbPJRPKyH7Rigay
         wG1lt9ZiGCb6oRft0IaW59/xRxr1SM6bWk+2XkwPuXxdYK3rIAuMwn4hrxwnSSsdpyPl
         z27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169371; x=1683761371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZ0ia5sRDGQkAwof+Od4n2KCtDiYQDl50wcfod0xRW0=;
        b=PJEciPj5VuqRFUm/U/388ChwRuFsI16wqiC4exTA/eM5FXZpevluQpMKckIISrVE7J
         jFmsjGUfmWsilMO49ZXKXrLN3I54HOoAHPxrSm/vv3X6QCNOneBlM5gaMJicuJVxCU1T
         yD3CxbvQANE3rA9gGlHZ11tpAzUoNzsP9fnTwuWk32enPDAqQtQWGLD8yBPt1FIsukmE
         HNvYgplNPSURt+7Q6e0V5oYIpeolRpKh1NQ8iJfUncJ/Hcgq12B9wlDMdPBIPDmwWBxb
         ztHuCU3jKpg+9JB0DGr7b7DJaaEHLpMUly9vCru8fIL8SJcMyVpjH1sLB5n/hW+ilXxq
         AQCw==
X-Gm-Message-State: AAQBX9dYRl7L13V+czb6KtDq1EzHJmzVTT5n3nYDRbRUCvNiEelRVcQk
        /VpgcST2OiK1KziDqT/Zu5ovWw==
X-Google-Smtp-Source: AKy350YCUNx+Qxry6s2zeRltqPXoxr6pMKIQhFIpV3CepqleTRt3iCw+dXztFP704t4yhEI6HyglgQ==
X-Received: by 2002:a81:4844:0:b0:549:104e:8f70 with SMTP id v65-20020a814844000000b00549104e8f70mr9006896ywa.48.1681169370752;
        Mon, 10 Apr 2023 16:29:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p191-20020a8198c8000000b0054eff2f2bdesm1476330ywg.10.2023.04.10.16.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:29:30 -0700 (PDT)
Date:   Mon, 10 Apr 2023 19:29:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZDSb2T8v6lvaqOyL@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local>
 <ZC0eY8q6ushpfkrQ@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC0eY8q6ushpfkrQ@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 09:08:19AM +0200, Patrick Steinhardt wrote:
> But I'm not yet sure whether I understand why `-l --write-midx` should
> be prohibited like you summarized in the follow-up mail:
>
> On Tue, Apr 04, 2023 at 02:55:50PM -0400, Taylor Blau wrote:
> > TL;DR: I think that this is a (much) more complicated problem than
> > originally anticipated, but the easiest thing to do is to assume that
> > git repack --geometric=<d> means git repack --geometric=<d> --no-local
> > unless otherwise specified, and declare --geometric=<d> --local
> > unsupported when used in conjunction with --write-midx or
> > --write-bitmap-index.
>
> The newly written MIDX would of course only span over the local
> packfiles, but is that even a problem? Ideally, Git would know to handle
> multiple MIDX files, and in that case it would make sense both for the
> shared and for the member repository to have one.

Right, I don't think that it's a problem. But I don't know how well the
MIDX-over-alternates thing works in practice. I know that the feature
exists, but I don't think it is as battled-tested as non-alternated
MIDXs.

So I think you'd have to ban MIDX bitmaps when the MIDX spans over
multiple repositories through an alternates file, but otherwise it
should be OK.

> But that raises the question: what do we do about the currently-broken
> behaviour when executing `git repack --geometric=<d> --no-local` in a
> alternated repository?
>
> I'd personally be fine to start honoring the `po_args.local` flag so
> that we skip over any non-local packfiles there while ignoring the
> larger problem of non-local geometric repacks breaking in certain
> scenarios. It would at least improve the status quo as users now have a
> way out in case they ever happen to hit that error. And it allows us to
> use geometric repacks in alternated repositories. But are we okay with
> punting on the larger issue for the time being?

I wonder if the larger issue could be simplified into (a) honoring
`po_args.local` when doing the geometric rollup, and (b) dropping the
non-local packs when writing a MIDX.

> Thanks for your feedback and this interesting discussion!

Ditto ;-).

Thanks,
Taylor
