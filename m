Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C2EC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A3C208A9
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2njcow8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgHDNDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgHDNDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 09:03:41 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D7C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 06:03:38 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s23so30744706qtq.12
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UKB9eT/XOdSekN/p4PkVrEky3DroWOFuM9Rwun3z7lA=;
        b=j2njcow8b1j3+wXSTF56Yi9cFK5PZB2iun+LqwtigqLLdhZ9ECEBPiu6H9xrOPZorQ
         YecNXZ6kOPAD5ifYkhTkT5OD2OWUqzAhSyon3dixDieYxHDwJxK61mFITPPntxYGhDvS
         6HngINcof6oXe75XmIekZW+Yvyz57fNRVIlWOBq1iMpoXSUTNjZ0AR9XlaFW1Ee/PK0d
         ZL1BeiGq0iiKDSuV7RPPvkCW/qre8c21BXQb+j/wqWloZinFlspMp3XC6kmMPVdraEiU
         hTR1vhPdI1Sa8ESl8VcQeREYdUfUpoX2N6/JhEGub70sXVKSwtUbqK7hZGrkp6yGL2h2
         ntog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UKB9eT/XOdSekN/p4PkVrEky3DroWOFuM9Rwun3z7lA=;
        b=W656luHC0kODkRHi2LxDDcWwAPzzcCazi5FeWTiy1xe6pkbDTQsO3/9WSqPAl6GHhq
         mbsaEwNqnRy/1p6dpu4gvwZ0pO4CBiAVfZcouzWEzBvGhX+D3e8BjopaKXBErOpwY7xK
         +oNKzrEaXDVXYb3URALfJzE8p7TcR7Bo11dp+TB1KXveHUPdIwj7GccjcHMHUy45Rfol
         SmGoyKoQNiSiNAnaDzUIA9LSWX7by8anleiRvWaG0Zlqrk7Z6KCCD0zQS2MbkYWbqO1o
         g+pEUszo9z9JKtvMEivZznDADk23A5zQVUJN5LUCU3GViLRcgB+QYEhuOIZneammDZhM
         V2Ww==
X-Gm-Message-State: AOAM5321OS4pFb84KC1h0iWS+FlA18YStBOoSHnnqvgT3X1QEORZ8GcL
        REButguAOM4srHdJok5fRkY=
X-Google-Smtp-Source: ABdhPJxTmlO2hmkQyMOGH6aWcMHieQKyT4RK15GpzXAPL927vV01QDvemoHXgzQygaTl/8winzEnCQ==
X-Received: by 2002:ac8:4558:: with SMTP id z24mr22395250qtn.241.1596546217265;
        Tue, 04 Aug 2020 06:03:37 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id y50sm27191149qtk.29.2020.08.04.06.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 06:03:36 -0700 (PDT)
Subject: Re: [PATCH 10/10] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
References: <cover.1596480582.git.me@ttaylorr.com>
 <8b670571dc24973cc5e894b866a68236d8fbfa4f.1596480582.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1c2e841b-4b04-30ba-6c94-96f8bf0cf449@gmail.com>
Date:   Tue, 4 Aug 2020 09:03:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <8b670571dc24973cc5e894b866a68236d8fbfa4f.1596480582.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2020 2:57 PM, Taylor Blau wrote:
> Introduce a command-line flag and configuration variable to fill in the
> 'max_new_filters' variable introduced by the previous patch.
> 
> The command-line option '--max-new-filters' takes precedence over
> 'graph.maxNewFilters', which is the default value.

commitGraph.maxNewFilters?

> '--no-max-new-filters' can also be provided, which sets the value back
> to '-1', indicating that an unlimited number of new Bloom filters may be
> generated. (OPT_INTEGER only allows setting the '--no-' variant back to
> '0', hence a custom callback was used instead).

Other than the commit message typo above, this is a good patch.

Thanks,
-Stolee
