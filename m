Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D69C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 19:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiGOTKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGOTKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 15:10:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BAA3CBD3
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 12:09:59 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pg9-20020a17090b1e0900b001f076f7d15eso5666438pjb.5
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=9TI9L20yT8c6oF2huUx0tZF3u+N1NnPLMBRhU2Ha+Ec=;
        b=k7o6gOvP5C2Qan/wjTh3HbMmYPLoztrsV5d/c7Hd91lbGyIfT5ffSfgFwjC4dpR1+m
         AnS8c03ylhqRL7ozC5Ti2X9pU1Fd9VzkXxEy+/z6PiCl8CRgwY/oNmZddlBtm4OqgKHN
         OH0R6zGKWrHErJHUluZKvCoLZB7C/BvITYtiGl1Stm2W6Zu6Op1uQLlb3aKgeJUnLHvN
         +on+B0XTHPO22v31PJ5Mv5kWOa5ct21zuIJjCph3DOXkAY0nKOjK28Q/voIIoVathhym
         gSaaVOy351C3DU2lzMQfXJaXT1SgY7kYWI42/RxFrnad1RVmxkgxPZPuhP3z8Sg/SQp+
         v47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=9TI9L20yT8c6oF2huUx0tZF3u+N1NnPLMBRhU2Ha+Ec=;
        b=OeNt+I1/LmnweUZfwYWJAmRl0AmXzKfhKs9sp3llGKEd9JmBsz5M1xBSLF4/z0033N
         yuj1HRsPmOG57qj+aqxOzE+g1imNhqCjaXYLE7R7G+6ip+XIzDokwhZKxYg+BDMaNDLQ
         G1p1USsKyXTPUs1/8AG35q395c59/lLwVBA5GRZnc1iSrG5x/88HCwgY83LdUwz24Aey
         hA47ydw/+aUAvhcxvionfcwkpd3OxxjAGVCaTpxct2hCeorNYA2Mb0ksR8zLfBIS7R30
         ERbTNVw0uthfuFjyu9xvMxZbYX3rmdkhA13IVkAkYVxArGPzkt42ku3sQ9Sk1VJ9l3W+
         /BtQ==
X-Gm-Message-State: AJIora++xJ7tjsRDzUiGj4kTBgtZgVC4QbCSlAicX/Fr6T0cROlaQg1a
        6rV5Z4ET0YuAucXkQ5qoQbchaVD1zyr/muGRsFg5
X-Google-Smtp-Source: AGRyM1sIJlqOzdJSOVEre1o7v0eHnX7Dh8LdOnsr257nGmpda9HPh+FAgrsbWk9D3gvvGmZdaChCQaHzmKvFyez97Qq6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:181:b0:1ef:c348:6835 with
 SMTP id t1-20020a17090b018100b001efc3486835mr911346pjs.1.1657912199026; Fri,
 15 Jul 2022 12:09:59 -0700 (PDT)
Date:   Fri, 15 Jul 2022 12:09:56 -0700
In-Reply-To: <xmqqmtdaz0vt.fsf@gitster.g>
Message-Id: <20220715190956.2908637-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: Re: [PATCH] fetch-pack: write effective filter to trace2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
> > On 7/15/22 1:29 PM, Jonathan Tan wrote:
> >> Administrators of a managed Git environment (like the one at $DAYJOB)
> >> might want to quantify the performance change of fetches with and
> >> without partial clone from the client's point of view. Therefore, log
> >> the effective filter being sent to the server whenever a fetch (or
> >> clone) occurs. Note that this is not necessarily the same as what's
> >> specified on the CLI, because during a fetch, the configured filter is
> >> used whenever a filter is not specified on the CLI.
> >> This is implemented for protocol v0, v1, and v2.
> 
> Is that different to say "for all protocols"?  I am wondering if it
> is worth saying (unlike in a hypothetical case where we do not
> support v0 and v1 we may want to state why we only support v2).

I wrote it that way to avoid confusion with things like HTTP (which is a
protocol, at least in its name). Maybe better would be "This is
implemented for all protocols (v0, v1, and v2)". I'll make that change
in the commit message (after the other questions are discussed).

> >> diff --git a/fetch-pack.c b/fetch-pack.c
> >> index cb6647d657..dec8743bec 100644
> >> --- a/fetch-pack.c
> >> +++ b/fetch-pack.c
> >> @@ -392,7 +392,10 @@ static int find_common(struct fetch_negotiator *negotiator,
> >>   	if (server_supports_filtering && args->filter_options.choice) {
> >>   		const char *spec =
> >>   			expand_list_objects_filter_spec(&args->filter_options);
> >> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", spec);
> >>   		packet_buf_write(&req_buf, "filter %s", spec);
> >> +	} else {
> >> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", "none");
> 
> Do we show "none" anywhere else where an expanded list objects
> filter spec is expected?

Hmm...no, we don't.

> I am wondering two things: 
> 
>  - The lack of this line would be a cleaner implementation of a
>    signal to say "this client did not ask any filtering".

I think the presence is important to distinguish "no filtering" versus
someone using an old Git version that does not emit such traces, but I'm
open to changing the "none" to "none-specified" or something like that.

>  - It would be good if we keep what report here more-or-less the
>    same as what we can pass "--filter=" on the command line of
>    "git pack-objects".

My intent is to report what is being sent to the server in the fetch
request.

> If "--filter=none" meant "this --filter passes everything", then
> saying "none" here makes perfect sense wrt the latter, but I doubt
> it is the case.

--filter=none does not work (a user would have to specify --no-filter),
although it conceptually makes sense. I just wanted to have something
show up to indicate that we are using a Git version that would emit a
trace.

