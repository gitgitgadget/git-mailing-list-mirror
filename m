Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFD7C43217
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 21:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiKKVwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 16:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiKKVvs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:48 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56B7377E
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 13:51:47 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id b2so4473446iof.12
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 13:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DNfFoj/uTDPdBqJtPKgvN1YcYFkA0euE+fmp2hkWzH8=;
        b=WH63qDnr3IvYZveeNpgzXyMOx2OqMkpp81FTLYO+sF+48ty7aVOHE0zxWp2K7g+gwZ
         7Rs4x+L9Sv4Or93jrXNzXnvFC6p6PlJKwPAYUqnYnSfEto4W0DPODv2vZC0wxGhjkuWI
         Y12St8WmriLun2PWzzTFi0qX9omjY6exigQbgRzWI13SWYIiMZ2MCPdHIO2D9jmYildn
         TiyVmgAJ1rKGZRJThEnO9BxL73wpBSbjDXlTU1cCD2iFbC4tYRsvTrsCK57tk41QGZBm
         AQQe2MiuXAY1t61TSc4RNu3NrCLnk/bsUlVmdH5B0JRTRgIMSPk4d3wvdxv1VwKS7/DP
         ovLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNfFoj/uTDPdBqJtPKgvN1YcYFkA0euE+fmp2hkWzH8=;
        b=u1IaakaAMZntZ4+awQrG/qc1+r1h+GL7uM84Xg3y0pJ5/H8/Q6YTjR+8daQdP2O+rL
         5/28eJ5mob5PYF52K70LUUWcgwFAuhkvZMi5Jkhoua0Qy9zf1hB2KSYEg4aXt/Io48Iv
         d8Gxq47T7Jpy01e4rtnhPmI0S1Im3x74u3Qta/V+OYuFQCR5z5dWlBolYS+JIgDcVnBO
         ses69Qtch5IYYyodHHUYMK3+Ch3Aiq7lqi+NEdjYsP9XQOv/0zzEqP2c3wScU5aMuKd+
         hMhF/8zDWjF+Z/CiPwa0WxRQR5VVFVbb+2/d8R4ryGNsEzyFZ1k4Sp3+6OgtV4wZUsSV
         8E6Q==
X-Gm-Message-State: ANoB5pktWKhNnVPbMIEanENNe/LEblPkSYeKiQyzWssbUETuTjR3Xwle
        s3CvArtadigXyFhxulKbi5OLi7jEmEL1/w==
X-Google-Smtp-Source: AA0mqf5FBDSKz/6+kgVJZXEDj7Za9eldpawsYY6YLDTJKxK6vlWu0fXCoDzYBwF9fQ3BjtPdNmPbqg==
X-Received: by 2002:a6b:ec0c:0:b0:6d3:e744:3429 with SMTP id c12-20020a6bec0c000000b006d3e7443429mr1821958ioh.193.1668203507054;
        Fri, 11 Nov 2022 13:51:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d7-20020a92d5c7000000b00300c5a4f014sm1256950ilq.39.2022.11.11.13.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:51:46 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:51:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
Message-ID: <Y27D8QUl3I2d4xNe@nand.local>
References: <20221109004708.97668-1-chooglen@google.com>
 <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221110.86zgcznjah.gmgdl@evledraar.gmail.com>
 <kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8nl1h19.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221111.86fsepmbhe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221111.86fsepmbhe.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 10:17:44PM +0100, Ævar Arnfjörð Bjarmason wrote:
> If you can do that and address any other nits/issues you find that would
> be great. I don't think I'd get to it before next week otherwise, but
> it's earlier in the -0800 TZ :)

Thanks, both.


Thanks,
Taylor
