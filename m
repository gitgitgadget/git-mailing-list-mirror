Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B59C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiKVSEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKVSEm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:04:42 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962AD69DF0
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:04:40 -0800 (PST)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 498663F367
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669140279;
        bh=yPbVLpLEq1PpoE6V2MrxnPfrwae2dc+Qpx8Fwba00Qc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=I+2Wd4TT4g44BuU/Xr5RqKI0Lj/AJikQpuF0ruCKWZAHC2l2R7Q8FmKzHGPtNAD3d
         RiiAzP7eMeK4HBL/3NLekcN9nXTLdWcS3Gky8uuNWOyUnrHUpOzZQpuplaKDI9hW5T
         mlHkwXcQcqsI2rFJxDRZx2GEBpTcCHudsGvB2RaiCWXqwCbY3pgZ9nvz9pA5PVNHth
         3tvFpv62lN4k6HTJpXHk0cLjMKVm8r1cpLYq+bm2DZhQDrKbqe3qPsMavcjtJn066e
         77DbhRYXkgCt4/WTznnrr4IEujXaOxhUgIfmM7KfrqePZSCb9IkeWV2CX12NMjdes1
         QlrGX3P7na73g==
Received: by mail-lf1-f70.google.com with SMTP id m25-20020a195219000000b004b40c1d5566so5758363lfb.4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPbVLpLEq1PpoE6V2MrxnPfrwae2dc+Qpx8Fwba00Qc=;
        b=yZX+bhSC6iAuu9L7PUiyTz4dX6ZlbxfGl9wJVg/pO0E4yAuJvAXUWv9i61McPvA++r
         mtJBIRxVKJDegkvCZA81jqnvg+3eQo79Mgkr/EsOigepytM9D4tMMLbsbYWCVYISqmfh
         3SSSDtstk0rPcii56sp+tGveii5AcIT1B7aN53mdixuvwaEd4f5UFwFmngAGQquEPFsy
         1aTxfVrg+EkCKFc8y9hUqQtPyI73QhPNsIQ01RIfCLygcXV/nwsggeT0fsm5TYBE85He
         pdSVJGjGemEFeLyOFn1kGw+qj+l9NzPW2UjwoDa9BYZU/kJ+UR2B0FemF7WYHT6xhMqA
         TkNw==
X-Gm-Message-State: ANoB5pm9CGSD4OoBADxesdx+zQixy42uSccyXIkzCeBnFDpqSfcDE1bj
        vJxTzRyVYaGPRA4JVr8SaSruWMrrwMb27pKTtvEyiTJ2swPjacTBiqnGeEVVHuzyovPZjaCg3MQ
        PHCcyg5VRGkIpgQhdgisvjvGlDyNzZYHUluV2eTkPsnwb6g==
X-Received: by 2002:ac2:5dd3:0:b0:4a2:6e1d:f996 with SMTP id x19-20020ac25dd3000000b004a26e1df996mr3216027lfq.114.1669140278610;
        Tue, 22 Nov 2022 10:04:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5mNRHO5bIjs4CS8ln3/XI9xifjao1AjzG76EVh7BWFB3ww8nCzL2Bh2nESoZKG86qJAbFwi0w76/DTmDQFcek=
X-Received: by 2002:ac2:5dd3:0:b0:4a2:6e1d:f996 with SMTP id
 x19-20020ac25dd3000000b004a26e1df996mr3216006lfq.114.1669140277723; Tue, 22
 Nov 2022 10:04:37 -0800 (PST)
MIME-Version: 1.0
References: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
 <CAPig+cQrXb-YUSzmfgJ2PRoiOP3goVACRCrX9C39kf3oDH+BHg@mail.gmail.com>
In-Reply-To: <CAPig+cQrXb-YUSzmfgJ2PRoiOP3goVACRCrX9C39kf3oDH+BHg@mail.gmail.com>
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Tue, 22 Nov 2022 15:04:26 -0300
Message-ID: <CANYNYEF+Gsas5s7u3rb3CQeFPL1MoCTweA4e3L90vCD0rPsNgg@mail.gmail.com>
Subject: Re: chainlink.pl /proc/cpuinfo regexp fails on s390x
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, Nov 22, 2022 at 2:57 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Nov 22, 2022 at 12:45 PM Andreas Hasenack <andreas@canonical.com> wrote:
> > git commit 29fb2ec384a867ca577335a12f4b45c184e7b642[1], present in

(...)

> We would be happy to take a patch if you're interested in submitting
> one. Otherwise, I can submit a patch to fix this case. Let me know
> your preference.

Can that be a simple PR in https://github.com/git/git/pulls?

Thanks!
