Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A2C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47B820717
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wri/gTTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgKWUTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbgKWUTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 15:19:16 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201BAC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:19:15 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id j19so15292061pgg.5
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TqKfl2KvJggNFX+zvjZE8Xy6eLBVv3gvrJYUnaigVjw=;
        b=wri/gTTHRho1es/E79oIcuWYoKbrg61KUpPndM6DsJQcPDJxmFdwP1pi4BhV/xKcte
         vVAaz4GMTWJzLI3vANV/UswlbMIIHrn3+DCd4GAGrdN/ekxSy+MCShmQfJfGgoPElBc0
         W3PEmwdBzKlcoa55b5LqTMz2nOOIkRLHv8wUAdZcwq2W3KU3PpAAVs0gKj1PQ/2Q8HSt
         NJ+vntSM33GbU/2BsyWBEbOmQOPsWAZi6AD+wI/nIEe+dr8NDwC3q0YGsc5h5lue8CmE
         ylPXKOolZvh1E1ih4WWS5kCw8Igmop4Xp26gkuFDbupN3wWuJ0Zh+f5pchXDbyyRKXIb
         slmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TqKfl2KvJggNFX+zvjZE8Xy6eLBVv3gvrJYUnaigVjw=;
        b=PCE2s3D5mwa0HCzMyPG7qu4EN8DDxgx/LGO66pOhdZUH2ZmRikuSY0kwdFLxw3W6pd
         L3MZYIuffdO9gJEboyhTsO/OFgq3+Djaeh0yMEXWwtoAUx5uKIhbpddpRcjsrszBANLW
         y29B+TVrEKIqew8dHTLtLJsG9aRvhT1UL32vVDC7FM3NavM+YOoBJFRlOtOzOHV8XRzN
         C7SxYc+fqxhjBNRl4OmslPX5RKysyzaciqoEPAVQZYC26Jb1smZ2kM0d7YnstQouHuIs
         TrZWerqiYzGOFtHgjgd16GXB8iG3gJaspff+VWwddeBUDsVtUyk63kFwoI2OIF1qqHta
         KA6A==
X-Gm-Message-State: AOAM532RWr+SGj0XNJ/rVMDm5ClIIkc8k41FblRJsPsivSiExphtvdEG
        EdM0hHMenrvjKGv3kmhUA4MEhg==
X-Google-Smtp-Source: ABdhPJzBBNPrSq7P6iBtgPYkU2RrdAhlPZW8boZ102mVlox9pxTn6SBoi0DWP+DuRE1arT7t/64zyw==
X-Received: by 2002:a63:c90b:: with SMTP id o11mr957454pgg.453.1606162754681;
        Mon, 23 Nov 2020 12:19:14 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id s15sm4187084pga.43.2020.11.23.12.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 12:19:13 -0800 (PST)
Date:   Mon, 23 Nov 2020 15:19:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2 13/24] bitmap: add bitmap_diff_nonzero()
Message-ID: <X7wZP9HO1gx850aO@nand.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
 <4840c64c51d65ea7bf1ebe03cad4588267db0207.1605649533.git.me@ttaylorr.com>
 <xmqqtuthoxu6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuthoxu6.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 22, 2020 at 02:01:21PM -0800, Junio C Hamano wrote:
> I actually think it would be easier to follow the logic to replace
> this pointer with
>
> 	size_t common_size;
>   [ ... ]

Yep, much clearer indeed. Thanks.

Taylor
