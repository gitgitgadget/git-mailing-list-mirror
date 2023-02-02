Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638FFC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 01:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBBBud (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBBuc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 20:50:32 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49BD77534
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 17:50:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z11so619370ede.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 17:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p44yOJbRhoulwuQ+Ft2rSlSyRyHNTXyDqlj6EIekRQ8=;
        b=QDRH0Jja3dCW+XSHyskUi0328iosqetzYwMJX/EjR/SzcgHj+fkcemUyZ7leNCgBW6
         IxeuKNe+elCTA9p9JM7orA7UaQjYOe5kDR+rgVuhVdO45X6wdJVSMAWami0zL3vd1ctG
         5PEWbmxLCFwkkHLB3r1FGdNDvZP/sV1L1Hi5+eIabXMwybB3kmALjOHR9rxOFILi1Sor
         BVkvbl/0oMCF6MGd8EoLyr7S4xn/ODvPpNC9MOyik5dRDVa1BFHdX9hR4G/N3u4QKTmJ
         SWJ7skvtaGMfOTm6oMxiMU9FtfNqxKraAL2ehH+U/Wzwrc1Sw//FAEL1TLZ69iZTX8Sk
         tt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p44yOJbRhoulwuQ+Ft2rSlSyRyHNTXyDqlj6EIekRQ8=;
        b=4LW8dItkEeVkC23ovHiT29DAo5PYk85TvwRhi3goNQQpk8bDQRkKDzRFVOX/m9rjG0
         veR1toKSujEqKfh87eulC6/6G77/hxD/cT9A0uoYrodDa5BDJ72U4fwhSFc71wLDredq
         mxTXXHlOxJwrrEEGXnjXzdQ6+HgBSVDwkYhoiC+IyhxsUVD/TsMgvUSwS+lnfN2hIjCH
         kS1CJC85LMAKOZE4xmspyHqvV9YsgYjAxq5UGZqYgVfmWgv+jQMFhh9F+aYQfW3tru0n
         NyIpOB4vWFR1uk3u/d6FFMja4XjS5EYObjctE/hWVBPsG//JDScllsMgvo3T1T+rVJRe
         Ln9A==
X-Gm-Message-State: AO0yUKUm+ZxeF+id35RQS7ITE+k1Cu0gAeUgOdAG8Ckh5ghrhItt5kQB
        /ASx0ECyRPDUMNURISD/uDKr1CyJXhDaYMLA
X-Google-Smtp-Source: AK7set+f7Qn90ak0nIPUGyYUDsRL0SpWsUE45WMsAUyay8H3jiZOrYYA68f2MZj//UYovgF17Edqyg==
X-Received: by 2002:a50:bb27:0:b0:4a2:3612:40c with SMTP id y36-20020a50bb27000000b004a23612040cmr5009651ede.10.1675302626301;
        Wed, 01 Feb 2023 17:50:26 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id f9-20020a056402354900b0049e9e9204basm10442000edd.21.2023.02.01.17.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:50:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNOk4-002PyB-31;
        Thu, 02 Feb 2023 02:50:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] delta-islands: free island_marks and bitmaps
Date:   Thu, 02 Feb 2023 02:45:30 +0100
References: <20230202010353.23391-1-e@80x24.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230202010353.23391-1-e@80x24.org>
Message-ID: <230202.86mt5wq1i7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, Eric Wong wrote:

> +	kh_foreach_value(island_marks, bitmap, {
> +		if (--bitmap->refcount == 0)

Style nit: if (!--x) rather than if (--x == 0) ?

> +			free(bitmap);
> +	});
> +	kh_destroy_oid_map(island_marks);
> +	island_marks = (void *)1; /* crash on unintended future use */

This seems counter-productive. If you just leave it free'd then various
analysis tools will spot a use-after-free earlier, won't they?
