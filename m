Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E6FA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKABa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKABa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:30:28 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5A4319
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:30:28 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id l127so11239406iof.12
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQRQkOcYofpYCBxo/uFA6LcxsPZys0u5s2pexJ62JO4=;
        b=UfihJddU4Rf0QLSE2gS/dvpjynQLQJYRG6cYuT77fQavnG7YaEirn4yfP73umoOvMn
         ClvET+dml1zpxw4AStPhSELZtmrpvrjyS+EeODud/uMjMeiyizgOcFYAWtafzshyZYzQ
         1MVlglgNpXJo6UM6L2ZT0HAAhVBjSZ7xptOa2vvtNQ/hYn7cd0NS63wJnx2LffrgB1Wb
         PugESRHlOaiNx0CZysKNSipw4fUS9gtY9i0CODxX3dikJNGdOn1KaeF0TyZS9bdP7Xt/
         Kbs2Ze8OSMx6uwT/b1Z7j4wtC3LBuNvVmiKCVUg/nRAjjD3VbNacfVH8nA1xMNY6wHP+
         7OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQRQkOcYofpYCBxo/uFA6LcxsPZys0u5s2pexJ62JO4=;
        b=ESih+qW9ML53R3efjywNopY6CwN+X7I9SvEo+QFkKa6A9nXzCEK8d5BQ7GlHWMuveH
         LyNw6H+D7KopB8wTBWNRPSUskXRKqWBAgNvwffOjG2pn3tG6HP2XXfgIRFhjCYCv7j2N
         fSt98TivzR/K5bUm99ouhj0/d63Qo8l9AZSUDlS4GMJrTroMPhLEdlf/d5jrLNkKVyBz
         QTu4rELnCNKaEBXgUmuwHxZGpUlUqJ4B3EhGHCU0fhlxpmaV00DKRyt6XZFjcZSJ5PlP
         4/2A0a7FL9q99dn1bREpZJl5yMTILU1hG7K+BgIlmDr7TI9EuR3UprBg/HKfvGfet54C
         HfYQ==
X-Gm-Message-State: ACrzQf0JzKqx0LllnHVJRCxh7lKENIcEUC3TF/johbxtWg+ayFL1NbQa
        CVhA/GUWzoyOtFRMFOSkS1ax10qjoCp8gpt7
X-Google-Smtp-Source: AMsMyM4XQmesXAG1Y1Dc5h7JjTGmbsqacAYgvgR09e27DpPIQOZUMuYJ9qIDLj9Ck7HIfw3MTwgfNw==
X-Received: by 2002:a05:6602:14d5:b0:6bc:ad1b:c991 with SMTP id b21-20020a05660214d500b006bcad1bc991mr9308566iow.168.1667266227771;
        Mon, 31 Oct 2022 18:30:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q3-20020a05663810c300b0036368623574sm3332788jad.169.2022.10.31.18.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:30:27 -0700 (PDT)
Date:   Mon, 31 Oct 2022 21:30:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y2B2sttQ2fDF/ocf@nand.local>
References: <cover.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666967670.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 04:42:19PM +0200, Patrick Steinhardt wrote:
> this patch series improves the connectivity check done by stateful
> git-receive-pack(1) to only consider references as reachable that have
> been advertised to the client. This has two advantages:

A third advantage which I didn't see mentioned here is that we have a
better chance of being helped by reachability bitmaps here. Because we
aren't likely to cover hidden references with bitmaps, we would be
paying a significant cost to build up a complete picture of what's
reachable from --all.

That will inevitably involve a lot of traversing from unbitmapped
reference tips (i.e. the hidden ones) down to either a random bitmap
sprinkled throughout history, or the root of that line of history.

But if we limited the negated side of our connectivity check to just the
non-hidden references, then we will likely end up with more full bitmap
coverage of those tips, without having to do any additional traversal.

So that is definitely something worth experimenting with.

Thanks,
Taylor
