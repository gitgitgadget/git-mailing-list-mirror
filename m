Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFD1C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 19:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1D461288
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 19:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346840AbhI3TIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 15:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346866AbhI3TIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 15:08:37 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628ADC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 12:06:54 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y197so8901488iof.11
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ivZqpHBS3RGwd+vfydbmsL86Nn3S2COOeqLDmuyu2x8=;
        b=2vuPNq2BtoK9mV+eNyA/KGWkkvseFYOpYGRxIXLG7UeKbQOgXyzQgT86kPWke7s2eY
         N215uDYZfMSPZScRT3D33pH1r3JPDWPCDmbos+56QmPUj+v+UE47PkI68NF6f08ljX8V
         osazQFMsgYafh51s2rBDOnVhYKW0K7AWH5D3osa9dyP94UsBoWvOQEDaslp8M1IR+DW0
         xN6xCZhfAbmYp+1LpTBuOYrjsXapGKEj0IsXmDfbgkVNq07ZeQciLdlYcLjrgK1tp1IY
         X2GrgX/IVdqfPtNeMaoC08vPyDZ9e48bbuy5Xu0wkkw8grpWTgJwFznLtXHABz95SDAr
         Q27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ivZqpHBS3RGwd+vfydbmsL86Nn3S2COOeqLDmuyu2x8=;
        b=kKPa5h6QtVz+DPr90cKBnfJFGCbpc9RT1MhHjThCIgukQhFnD5vUiRxDMPbrG2Eciq
         8Rr344xC8gceIOvLWTkojGq+cpLl6XZ5BU42ucggGRbWKKK6ZBmfrYyJzAao/sNKNy9P
         5FuGJrn32dOyFdSHg7phdg76+Vj095ixP8W37ITSM5Ud4Kac4TufJJuZIA12ijr43ArY
         Mxq5Mcq2Tio7hyxUKNWnw4kLOdJnU6t/I8NuteWO6rO4p1VzBM5v20fG4fisIDHIAx0u
         TzmP8+4urkYZ3HsBVopP5eWnScpRFkHROu9dCcFeQfLs+Hm7rRcFBKz8v9OF+WN94MZh
         DLqA==
X-Gm-Message-State: AOAM531wSTIRDSlZRTbNjowFz9SAK18474IoAerCzBxoXyHP2Hmc0T+t
        DOXnSXxgqEQXfXT7DM9v9XC5TQ==
X-Google-Smtp-Source: ABdhPJynVveq4QHcLhwCi975MDljPDeHUusjvVaMuuQOasjUw3/bMhxn+fBgy3YW1H7efHEOxNJDdA==
X-Received: by 2002:a05:6638:cd8:: with SMTP id e24mr5973042jak.53.1633028813623;
        Thu, 30 Sep 2021 12:06:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v63sm2045823ioe.17.2021.09.30.12.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 12:06:53 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:06:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v9 00/17] fsck: lib-ify object-file.c & better fsck
 "invalid object" error reporting
Message-ID: <YVYKyzlYSbYrYy3J@nand.local>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
 <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 03:37:05PM +0200, Ævar Arnfjörð Bjarmason wrote:
> The only change since v8 is the plugging of a memory leak introduced
> in the previous 16/17. I've been doing integration of my local pending
> patches using some follow-up work for the in-flight
> ab/sanitize-leak-ci topic, which is already proving quite useful.

Good catch, sorry that I missed it myself when reading the previous
version. The way you plugged the leak is sensible to me, so I'm happy
with this version, too.

Thanks,
Taylor
