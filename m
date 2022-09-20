Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C00FC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 21:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiITV5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiITV5T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 17:57:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F6761135
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 14:57:18 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d8so3519899iof.11
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8uP8gCsWHaSiVjatF33DtVXQSVuSqiV9UCJ6Gigw8cw=;
        b=qrMHDx4nraWDan4K+IQHxskG/+xwk0IHAZoY0sRQpxnoZsuXWC1dizZMiqSaKHs4RI
         JYzvDQafcO8QLCCYLhBRbZowBF/hPe9u4TTlQlOiSJqB1iW/W9OmZCB+G9ZJWbMoTLdN
         BtWEcaQaBTQ9/1j1SCk+0LI+bwyORTg/erskto6GuS+ojF1n+n1IQulVHWOle/QaAH4x
         VjJGGsZx8AHWmhseNdsTRN5ltEstI5jDISy2A2quraz+3EWJyL6oDu3wFaxS3bxqIQD4
         KZ82AuiSBFsq+SHafaVZMq5GCKTcDjdBpGet9KYkHpqxSt2XXSSY1uP2U/TS3Nt9ctZ4
         dYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8uP8gCsWHaSiVjatF33DtVXQSVuSqiV9UCJ6Gigw8cw=;
        b=Wh3PmI89yfoQCGFrks0j8/sxyWv6JDTsgz8m1Zxxuhd+XYRrB5KCNbIX96lB3QLTx/
         sb0shbRsHEUdJNfBL6uMZmMTCYfKxmZGEv1XwjkyQPoH5tR+Xg7/7+oQOlFvtvCbWj4q
         7aylbU4euvDP7WZcTQfjtrWMcgNIQvWhd8+Vz/e9qxmaInLpxiAohvqHHKwJnLLs8Bog
         Ibs2iKgVWSIRh8otdRzIIARvB7gC0cDIH/ofSkfQIthpWuqVSOpvxjvmkLdX77W9xYMy
         yhl3bchGGTx3I5X3OTXEbiRjqUxcRg/zbnZ3g44d8qXu7ycvugLwTAznSkyfuER4l12L
         iKzw==
X-Gm-Message-State: ACrzQf2ktK7MqP+eoWIDPNbJpnXJ8ZxmY6z6YRHKh7oLLcccxDKPQo9k
        Y5N4057hfIVnNJtv1vSF2UUaSQ==
X-Google-Smtp-Source: AMsMyM5kb0YjuNk8AHCMmiGb4qNuyUePoNvJNEUkT/BZAV2D/kRd44CebIUektq1MjlzEmm+bypDDw==
X-Received: by 2002:a6b:7213:0:b0:69e:5f45:df22 with SMTP id n19-20020a6b7213000000b0069e5f45df22mr10226916ioc.180.1663711038103;
        Tue, 20 Sep 2022 14:57:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d5-20020a026205000000b0035a242f30b6sm328529jac.175.2022.09.20.14.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 14:57:17 -0700 (PDT)
Date:   Tue, 20 Sep 2022 17:57:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [BUG] seemingly-rare segfault in merge-tree
Message-ID: <Yyo3PF+dxrQ3Po/B@nand.local>
References: <YyopQD+LvPucnz3w@nand.local>
 <YyopmKNZU4WL2wrV@nand.local>
 <nqp61q74-1oqs-9n1s-q7s9-r8741n3r735p@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nqp61q74-1oqs-9n1s-q7s9-r8741n3r735p@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 11:24:00PM +0200, Johannes Schindelin wrote:
> I am afraid that there is way more custom code from GitHub's internal fork
> involved in this report than meets the eye. The `result.tree` that is most
> likely the cause of the segmentation fault does not actually stem from
> `merge_incore_recursive()` as the linked source code might suggest.
>
> Instead, it stems from the `merge_incore_nonrecursive()` call in the
> custom code that allows to specify a merge base manually (rather than let
> `git merge-tree` perform a full recursive merge). Custom code, I need to
> add, that is nowhere to be seen in upstream Git.

Ah, thanks. I didn't recall off-hand the extent of the custom code
GitHub is carrying to support merge-tree. If this has nothing to do with
any code in the open-source project, then please feel free to drop the
list from any more emails on this thread.

> I did hint at this custom code during the Git Contributor Summit, and
> there seemed to be enough interest that I had appended an item to my
> ever-growing todo list to upstream this.

Yes, that would be great.

Thanks,
Taylor
