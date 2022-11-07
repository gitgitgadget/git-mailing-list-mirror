Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A039C4321E
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiKGTwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKGTwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:52:24 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44D31FF8E
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:52:23 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n191so9762669iod.13
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQQGgGh9YRa260h+zMNKDkQxkxBZsYJFTsWg9OcoVxo=;
        b=zoAuoc8OCsH5NpNZ8Vxf5VTJsNfeuyOndwRzGIxwbiEcfZ0o84t7F2eLwMUx+LmmhO
         bG5Z6k72n9KiduKDUZtis0N4ekfWoyr7hPLxOZ+iGxFjyNu4CftO0TzoOUObyFp07x63
         comIqM6HLsIvctO2cHu5GmNdB6tAa4/GUPdqkPUm2M8V+ydmmPncKrH3GIe/zMbaEwu/
         kZ9aYdJjhfjpUQOlp/B2OS+rUjScb7pvt7iXZckGFTlsiS1pekyZ0Ga9sBu7UxKhSCiu
         eXRUApw5KpCRhXXupEoG2CDwNi+CkqMdn/kPNLIpp0I85pbAKOCQ65fbooWFFlZXw3Rp
         Twuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQQGgGh9YRa260h+zMNKDkQxkxBZsYJFTsWg9OcoVxo=;
        b=PJtdPXeD2bfoTywIZg9ThWyzCma6Nh4mRII/uHXZvndvUjC80WSUAuX0d83gq5+q5R
         k2H1pvo4ZoCGOvw4f+szbgrKoO8P0J818lHTexKWQYiyWl1PT19/ysKFH0M9V/StAa8i
         c5COqmoWMIz2BWf0qsGtBD3X41bTkTWdB5ye2d1ch7wPyTeXIv2oCpAAe/OEYK2UqD8O
         65kdXOpAbaLfET9gHij1PPb2zCfSRpj4X7iqqj1nHfAqhgt77UlkiksQt0q47K9e14ny
         YZpjPMfyxXqObHYXCE5z4ikJ4imr5TLHKQnz51f7N0ad5lkdDHFO1ieG0u3sArZoB9VC
         O+Yw==
X-Gm-Message-State: ACrzQf1SIQaACYUi2Ok/AbTUdDFvPws4qY5w8rR5wMeXKw/gE59wFyMy
        iYIhN7Lt96CGTbt2PmF5+ddybQ==
X-Google-Smtp-Source: AMsMyM7S1BBdF6D3yyZoI9YXuMTZmKPO5fxelDLuyGKr8buH8A3Cu8xzMsUysKEX+ngCLXEbQbQo1Q==
X-Received: by 2002:a6b:7d4d:0:b0:6bc:5e30:eff1 with SMTP id d13-20020a6b7d4d000000b006bc5e30eff1mr31185083ioq.208.1667850743089;
        Mon, 07 Nov 2022 11:52:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q2-20020a02a982000000b00363e61908bfsm3069608jam.10.2022.11.07.11.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:52:22 -0800 (PST)
Date:   Mon, 7 Nov 2022 14:52:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/4] builtin/repack.c: implement `--expire-to` for
 storing pruned objects
Message-ID: <Y2lh9abWORNkgp50@nand.local>
References: <cover.1666636974.git.me@ttaylorr.com>
 <6376d15c9c9adce883dba86ef5e5219f803aa9bf.1666636974.git.me@ttaylorr.com>
 <21e870f7-0f86-7021-d141-9e83286adea7@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21e870f7-0f86-7021-d141-9e83286adea7@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 02:42:52PM -0500, Derrick Stolee wrote:
> On 10/24/22 2:43 PM, Taylor Blau wrote:
> > When pruning objects with `--cruft`, `git repack` offers some
> > flexibility when selecting the set of which objects are pruned via the
> > `--cruft-expiration` option.
>
> This patch looks good.
>
> Creating these cruft packs in the expire directory does help
> remove the main problem of the race condition. This currently
> requires some external system to check that no races happened
> and it is safe to delete the pack in the expire directory.
> Also, that external tool is needed to move that expired pack
> (or preferably, only the necessary objects) back into the
> repository.
>
> Some future series could find a way to handle those situations,
> perhaps within 'git fsck' to pull missing reachable objects
> from the expire directory. Definitely not required for this
> series, though.

Thanks. Let's start merging this one down.

Thanks,
Taylor
