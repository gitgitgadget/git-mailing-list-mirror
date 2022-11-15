Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0A8C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 19:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiKOTkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKOTj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 14:39:58 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8726E8
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:39:56 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id 11so11540933iou.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IsMll3U7/xLaVHk5H58yg8ISo+HB9X4ZtwT9pZkPVuM=;
        b=FM7okDwGka/0MQc+DZWum2Qlzd8nY3ADwWk2czxRlg+31k2YXMg/2qNF3kSefqcWJL
         rPMdw4bGkimwF3SwHLLMl1vqqP68CooHAoamOMw5uUHelMTAKHsc+i4xiaZCK2g9cKao
         dRAoOzarTGVxuxely2H+f9mW7u+6lNIW4/QpwWlUpDcSlcHuFW1HNpHfNlE8FdlSELDE
         gw23e100SbQe1BKKelHtFpHRNseCBEXnvPNbYKYhrYDDQRESLUT0jaa0TToGbq+N44jJ
         IWwLbsW/9Hugc5WIMPTUh8iIl1nSJ0ogp055JCOqg1+FfMtklOqRhZsa4dk8dkeLB4Zy
         7kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsMll3U7/xLaVHk5H58yg8ISo+HB9X4ZtwT9pZkPVuM=;
        b=pDDTVlvTlSk7OxTCaeFiMnrIVFMIc26rNk2GOy8P/836jyAA37Ib8dUePOR61ZPxAj
         tJnK9xVrRsxJh5CbAbR0fkPYvfsq1blLvVMzHHoM+nF7HKqu9zasXSG1C5r/hgaPZ6cJ
         epwDP8JuTLeJtyxiSTY9qtFbEfS3sLItPfO4FSrrTQmW9aSkxYmOx9+JW+pHIq8F7plV
         CrtXdfpsQ+yHoIsItW6I96PNftMwuBBidx0VpNM4cx1J7PpR0SKSXxy9XY2UlsaROxva
         4xa5jozh/ryU0JvNhsOnjmqQzrLOLGnLxBVkSyNHAp+w75/bz9p/XACIlo5a9RHVlZM9
         4b+Q==
X-Gm-Message-State: ANoB5pmLdHwch+AiQSBiaGMGFFjkvt4dlBV52RVKrc7yDYwltk/1qZH5
        ZlkQw0lc6gnOLMJEycF+yh0HmQ==
X-Google-Smtp-Source: AA0mqf59fFtgJwYq7ASYaKKvtLBFBsAHrJg5HeYqZVjY0OL6lwmJxqo0hg907VNfdDVKn6IZe7L3iA==
X-Received: by 2002:a02:aa1b:0:b0:375:61b2:825a with SMTP id r27-20020a02aa1b000000b0037561b2825amr9045923jam.147.1668541195884;
        Tue, 15 Nov 2022 11:39:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c6-20020a02a406000000b00374f99a3de5sm5118279jal.63.2022.11.15.11.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:39:55 -0800 (PST)
Date:   Tue, 15 Nov 2022 14:39:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect; remove unused "git-bisect.sh" and ".gitignore"
 entry
Message-ID: <Y3PrCX7W7gL1Z0CI@nand.local>
References: <patch-1.1-7be23b6faa0-20221115T093130Z-avarab@gmail.com>
 <Y3PHOpIqMC9ZT4pg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3PHOpIqMC9ZT4pg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 12:07:06PM -0500, Jeff King wrote:
> On Tue, Nov 15, 2022 at 10:32:42AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> > Since fc304fb52f9 (Merge branch 'dd/git-bisect-builtin' into next,
> > 2022-11-14) we've used builtin/bisect.c instead of git-bisect.sh to
> > implement the "bisect" command. Let's remove the unused leftover
> > script, and the ".gitignore" entry for the "git-bisect--helper", which
> > also hasn't been built since fc304fb52f9.
>
> A small nit, but it's probably not a good idea to refer to merge commits
> from 'next'. They may be meaningful now, but they aren't part of the
> long-term history, and will get gc'd eventually when Junio rewinds next
> after a release. Which will leave this reference useless for people
> looking at "git log" a year from now.
>
> A better reference is probably 73fce29427 (Turn `git bisect` into a full
> built-in, 2022-11-10), which will remain stable as it gets merged
> eventually into master.

Thanks, I updated the reference to point at 73fce29427 while queueing.

As an aside, I am a little disappointed by the quality of what has
recently been hitting 'next'. There was no chance for me to find the
issues with t7610 without a Windows machine, but this should have been
caught during testing.

Thanks,
Taylor
