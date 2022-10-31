Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA30ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJaXyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJaXys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:54:48 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A457011C31
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:54:47 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e189so314429iof.1
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wYOamJzOmO1e/KeNCUnIoc7S1s/YHRy50q5Dy2bvFHk=;
        b=zFbBjuvqOT669tHZd9WNRjOzTe9Qw74syVYwTqlfr3HeU6phQvhVXwBziiu1AkpsFB
         af9wnSn7LlVDTmC4/cN/jqnpcIyKN1a7Hbv73uQUfoqfIG1gvK5rPGPwrMJxtc6ZSaPU
         lc5rgb1r33efFCSkLiaiVJSMdeSfkoIFtc0pIWorxBKuYfHttd1JVwc6CNgN++wd8I+J
         qyK/l4trC2jICRM8z+EE3W1/QM36idFnB/hFbkfHUYF9uJRyhHd26ciSgoyhX9T/V87H
         CwgM/hnUGZMhSYDYeTleNc2mKTDlqQanf317iZ3fsBmo9hkzyb8+QgqdR+t5NkLgLxm8
         KHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYOamJzOmO1e/KeNCUnIoc7S1s/YHRy50q5Dy2bvFHk=;
        b=xYBHxNApRPCNJQ3/eWd3awBPouBuUcVc8/KO7khh4MDdZNj13ljWw1NqmMTVgloBTw
         Y441C16g8qMR1FwXVAJud1ylrTsW7jtkXSgwnYNtZpN0eLAjPkJ9+c48Wy5JyUf3FOoQ
         Tm9gQhfDezltLvcejIcizKAKNHMv0p0Q/+YOAgKkQ6sAjnK/dqFA49ATS4/DnPYuDwHW
         a7F8tB74Ey2fW2LeAmDRTKuvWyh1iJP0AbsZ3igjb0gtLC5yXhHtVIT8JknC5Il5NIpN
         +4sPyjHnapPK3RmQypyhPLSVkH24YUu4nnSeDuCGytvlwCon1asWFYXio767oCE0F9WE
         D+Og==
X-Gm-Message-State: ACrzQf0uq7lM8POoDN+F86T1iQlR86E9ZiV+X5I/Z9dxDBRDIpJLgKDb
        KA6TZEUJnW4p2QQJYdP3k6FmMw==
X-Google-Smtp-Source: AMsMyM6ncmbj7MpxwqE9Dy2dzIotSKb0D8vpzCUA+S1gZWW0yxINIjgeaFBvE9KADyFi5YnMSd450A==
X-Received: by 2002:a6b:cd43:0:b0:6bc:aef8:f968 with SMTP id d64-20020a6bcd43000000b006bcaef8f968mr9386172iog.195.1667260487033;
        Mon, 31 Oct 2022 16:54:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c23-20020a023317000000b00374fd1572dasm3235405jae.112.2022.10.31.16.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:54:46 -0700 (PDT)
Date:   Mon, 31 Oct 2022 19:54:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/4] Makefile: untangle bin-wrappers/% rule complexity
Message-ID: <Y2BgRU+HnJjWPzkn@nand.local>
References: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 11:28:05PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Ævar Arnfjörð Bjarmason (4):
>   Makefile: factor sed-powered '#!/bin/sh' munging into a variable
>   Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
>   Makefile: rename "test_bindir_programs" variable, pre-declare
>   Makefile: simplify $(test_bindir_programs) rule by splitting it up
>
>  Makefile | 70 +++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 51 insertions(+), 19 deletions(-)

Thanks. I replaced the earlier round with this one and pushed the result
out to ttaylorr/git.

But having read the topic over again, I have to say that I also find the
pre-existing behavior to be as expected. "make bin-wrappers/git"
produces its target as expected, but the target is useless because the
relationship it has with "git" is a runtime dependency, not a Make-time
dependency.

So I'm not inclined to pick this one up, honestly. Perhaps other
reviewers feel differently.


Thanks,
Taylor
