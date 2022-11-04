Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF67C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 19:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKDTHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 15:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKDTHi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 15:07:38 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A2043AFF
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 12:07:37 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e19so3069397ili.4
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uh+Tt7J6qPv3vn0z536JjautfYJfxfNIPGC8VVapHs=;
        b=NLSraF8RZU3rzT9d4JNV6qdOCtzGgvVNiEpTssU8LMHR7cPn5N3IbanRFRzF3Grpor
         IoO1OQx68KlD5UokvUC48DxnhUNvD2QTCzlg9oImFICz0N5dzE+0agfRNVrsGKISLq8d
         R7OjE4H8Yh76cucTyR1SDQ6MUiD7TVJGo2honm+RvxmGw2zE6c8po4glK3V8YO+tDaez
         x8uAMDg/iVFUd0Eepg1hl1DGF7xUHBddjchznf2m3Y/IQaEfM8ztjDUQh73uXrOLK1Ng
         7u0MGWnWuFU9psGQV/vrDt6q9qJm3MZIpJHzLW+BqpHAZe+UOh3d0YfG769BnTpXOXEu
         cIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Uh+Tt7J6qPv3vn0z536JjautfYJfxfNIPGC8VVapHs=;
        b=NfBlS5s1RV82HGqB6z2ZO9iC3hxyodmazGt3Oika6Ia5lpKN6c/zxBZ24nZYur5+yc
         Q0ct69Of1e/125Apv5JJKuYEPzEjhPy4p7GOngS3v5k1yyY4NfPtqGZkkrgwdTSTwM2Z
         1rjs2P8tYruAGfYiV6pFFs62iHsF0vMX9174OVXQGuVxz/NC4s5i78eoaYfybBO4SToU
         GsJUOdbl2wXs8gIXC4cDWWMuuAbo5TVP6BQ8wMMyHN9CELPIim2zyr4CJNJTaNK+2t53
         8vek00fixaCbh690U3TMkaLVRemrUVc1dzVekBoArR4H8q29eHkukNW9j4aPD9da8V+I
         rFsw==
X-Gm-Message-State: ACrzQf2mlR9xnMQRn5VCfg+MXlNozQZVZWCtZpQ9YLZUjtToo/rs17wt
        P88owfbslgycyjwsqquf2YRSBQ==
X-Google-Smtp-Source: AMsMyM6jssfEcql2+bta4gI2vDm5rnhr38y5uGLXRHl7Ana/iyNY05z9yWp/7vrJ0mbynq+HfTWP5w==
X-Received: by 2002:a05:6e02:1c85:b0:2ff:fbd2:89c2 with SMTP id w5-20020a056e021c8500b002fffbd289c2mr19864354ill.2.1667588856440;
        Fri, 04 Nov 2022 12:07:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a5-20020a92a305000000b002f9a7dc2e1fsm80320ili.53.2022.11.04.12.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:07:36 -0700 (PDT)
Date:   Fri, 4 Nov 2022 15:07:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 0/8] submodule: tests, cleanup to prepare for built-in
Message-ID: <Y2Vi95r+RqHPwbw8@nand.local>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
 <kl6l35ayy7ay.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6l35ayy7ay.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 10:10:29AM -0700, Glen Choo wrote:
> Thanks for working at this so patiently :) I can't wait to see
> git-submodule.sh gone.
>
> The only issue I saw was the out-of-date test names in [1]. Otherwise, I
> think this is ready to merge.
>
> [1] https://lore.kernel.org/git/kl6lfsezofk9.fsf@chooglen-macbookpro.roam.corp.google.com

Thanks for the review. I'll wait for a reroll on this topic and then we
can start merging it down to 'next' and so forth.

Thanks,
Taylor
