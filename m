Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7ECC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 01:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiFNBP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 21:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiFNBPy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 21:15:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873F21900F
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 18:15:53 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l3so3824136qtp.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 18:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LCLk7mBK3ImKXxaSGE9EVtiOdQU1fdF4ZBCau0tiUm0=;
        b=6FfbFjz/5Y+jEPZl/ZslDC6Yi06ng7HEL2t3CEou3BiSdSQEdnmqOHHLVwoycXh/d5
         5J2Y362H+Z/31ORDEUE8KU7471BtKsyPTzrOs7DPxB7aOk+3qSbmkaSmGnzdRtx5fDBZ
         lAEFJkHzTA0cyBY0MX2XMgAAT6vM0v0MSMypkPBYqon1EmrcvAuueWW0U97EhB9nxLvx
         Lodno0Q13kKYjc4nXhdHgK2mMWjYCQOFfUB86scy8esEdF/m/4cwKvVDbgtZrKvmuMo/
         bPnajGaeRv8DBgSt/N+PqKCntEvTd2dYIp25pGBjelbvPBp2pidteYPwGzIkTcDXDgmx
         Eydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LCLk7mBK3ImKXxaSGE9EVtiOdQU1fdF4ZBCau0tiUm0=;
        b=yEjLS663YmUs0wfxOPOc7CJsJ8JG/JskKVvuiuXrThWohUSYXDVbE7jhuPfGGiABpl
         y3uwoeA6KFJbVHn88DFhMa6i1TOJnZJQ8DC35oeqfefkoJIzc2gwmC3g9oYRGrzI+S0M
         jN6Y/Nb5EawU5SSSuHByYwlRh5BxDoP8z/x9d+FISp66Sh0+7h9mx94BThv8AUw46+0P
         hzWG/FJ15NUSYUJYCmt/ucP9cg0BYNAPRDnMQ0okU792Szky8sJJvXD52Ii5rLtuK5Sq
         wjVNbdmshbSijP6KDdJndg4igWWsaUAG+jFGkb86OkE7F8oM6CG7SFtyRRDJX6tMBIFn
         pv3Q==
X-Gm-Message-State: AOAM530oGzfLa5z/bWIbpSWlQmr93nfGNDBYq+4tw9KSjBZapv0uWZLY
        6FDbuOgAyBiLEmOGpbv9kTwyHg==
X-Google-Smtp-Source: ABdhPJyKS2VRb+FELgPV4ErsqivfbKEMTsNyExAwMQ5GAiTrvKq2nl69j7dyb4DqCRskN0hb6KpnGQ==
X-Received: by 2002:a05:622a:64a:b0:305:205c:18ed with SMTP id a10-20020a05622a064a00b00305205c18edmr2273525qtb.380.1655169352627;
        Mon, 13 Jun 2022 18:15:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t5-20020a05622a148500b00304e90f66f7sm6082433qtx.70.2022.06.13.18.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 18:15:52 -0700 (PDT)
Date:   Mon, 13 Jun 2022 21:15:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 4/5] pack-bitmap.c: using error() instead of silently
 returning -1
Message-ID: <YqfhR/PV6HhGyhT5@nand.local>
References: <cover.1655018322.git.dyroneteng@gmail.com>
 <72da3b584490467c2492578a8125cbcfe05aad9a.1655018322.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72da3b584490467c2492578a8125cbcfe05aad9a.1655018322.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 12, 2022 at 03:44:19PM +0800, Teng Long wrote:
> @@ -323,7 +323,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>
>  	if (fstat(fd, &st)) {
>  		close(fd);
> -		return -1;
> +		return error(_("cannot stat bitmap file"));

Since we are handling an error from fstat here, the errno variable
contains useful information that we should include in the error via
error_errno().

> @@ -361,7 +361,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  	bitmap_git->map_pos = 0;
>  	bitmap_git->map = NULL;
>  	bitmap_git->midx = NULL;
> -	return -1;
> +	return error("cannot open midx bitmap file");

The other error strings are marked for translation, but this one is not.
Was that intentional, or just a typo / oversight?

>  static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
> @@ -382,7 +382,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>
>  	if (fstat(fd, &st)) {
>  		close(fd);
> -		return -1;
> +		return error(_("cannot stat bitmap file"));

Same note here about using error_errno() instead of just error().

Thanks,
Taylor
