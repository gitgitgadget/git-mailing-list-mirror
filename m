Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF69DC74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 16:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCUQUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCUQUR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 12:20:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD7A2CC41
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 09:20:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id ja10so16578731plb.5
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679415610;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ANhmHUuaQfI7Q1woi0O168sFjW91RIzpOIQAOQb7I8=;
        b=kRd+oj8CmoUTxPdVX0SJL7QS41h0J2cuV5SjfG9+YTQjhhd6dqBTj4Ggw39tSN3zFG
         Sex9DE+QDiIJ00IOMyuuYpoVNUIDTtyOryC9bBy9rAeoPHqyThJ++AXHmU1YTJZ+3CCZ
         VWCjsunRY6GVF5qCsc4vxQjLm4L5TvT3s3mooPj/nUc17URJgn1laSvwCaI/+GWDwFPE
         RHvZrAECteOTWJ7FEUBaVCtR2yClDzu/kAwTiVjgYbGmvnAZ+igZCtKcolnMnxL82lNA
         H0tW7W0MzHopG147qCw7xWV9oGnQCoIeyfTBYhjIFl3nOo8YWbBKIjRDOjVOuHepq3fJ
         of2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679415610;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ANhmHUuaQfI7Q1woi0O168sFjW91RIzpOIQAOQb7I8=;
        b=n9kvUK0143slfrzlNc9TLXji2BYHdKwf9H366P88I+p1vehu/M/NQHnKbmXqoxCZv4
         rrCTFv8kLz5czfo4teEoTbH7Qm7TEZFb358d9ku9nJjntRQvTX4bqC+gfgeyHQ3gpEg6
         VPqI12OOc4P1EdOel/v4j84kuztxtolEPrD1UULC8rulueoBw7W3YAbl95au/zaWzeGJ
         zeOV6YVPbPCpEXgs01k0LyHV84pXt8gb1bcvzi2SwAO2DVrnOup1TD6XkUuY1UMV/1to
         FYeXW4mPgfA8XFa4WMZvEyz4B1So9qt8yAujb2qGA5mnQznj0M0Uur98RJBx5zYNOrwb
         le6g==
X-Gm-Message-State: AO0yUKX//ipGH/F1CKjhVR/zQ24VGo89jUPc6k70WXgMzUvmHUpNdZwp
        pXHzxpXhuiZE7N+WaBuIN60=
X-Google-Smtp-Source: AK7set/cABpn+GMP5Ah/+G5LB72c46inbsR4CCL6C2Pqa36agwv43iMnjjnPmoqiOXkVCRR2x7VytA==
X-Received: by 2002:a05:6a20:389e:b0:d9:d8e4:4cad with SMTP id n30-20020a056a20389e00b000d9d8e44cadmr2771485pzf.16.1679415609878;
        Tue, 21 Mar 2023 09:20:09 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b00571cdbd0771sm8427473pfo.102.2023.03.21.09.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:20:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Eric Wong <e@80x24.org>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] git-compat-util: use gettimeofday(2) for time(2)
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
        <20230320230507.3932018-1-gitster@pobox.com>
        <f78fd970-cce5-0a38-5ada-94ccb5bce592@cs.ucla.edu>
Date:   Tue, 21 Mar 2023 09:20:09 -0700
In-Reply-To: <f78fd970-cce5-0a38-5ada-94ccb5bce592@cs.ucla.edu> (Paul Eggert's
        message of "Mon, 20 Mar 2023 16:21:40 -0700")
Message-ID: <xmqq4jqekreu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Eggert <eggert@cs.ucla.edu> writes:

> Thanks, this looks good. As a matter of fact it almost precisely
> matches what I was about to email you. The only significant difference
> is that yours has "#define time(x) git_time(x)" whereas mine had
> "#define time git_time". Since Git never takes the address of 'time'
> the two macro definitions should have equivalent effects when used in
> Git.

That is a valid concern.  Writing &time would not be caught by
compilers, and you would not notice such a mistake until you run "nm
-ug" on the result.

On the other hand, straight token replacement will risk renaming
variables and structure members, and I was not sure if we have such
use of the identifier "time".  As long as people do not use "time"
and "git_time" at the same time as such identifiers, that would not
be an issue (except for perhaps expecting to see them in debuggers).
Writing "git_time" and "time" at the same time for identifiers not
related to the time(2) function would not be caught by compilers,
either, but it feels much less likely mistake we would make in the
future, so let me drop (x) from the macro.

Thanks.


