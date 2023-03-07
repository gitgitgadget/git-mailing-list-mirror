Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86309C61DA4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 00:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCGAg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCGAg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 19:36:26 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE645650A
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 16:36:25 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id b16so4810935iof.11
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 16:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678149385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr5v+XtwCFaMw7+Eg+X0RF9TNh8YYP+EKyxC0lKV4Xs=;
        b=cQo1kdRT8qIzjcmldqIo6QYnU3cN9xxDQcuhfACDVXfk1uEPEGzLOiRFKVz4qiE8dk
         7OrIswMDbNNfbAcK5S0yVhscPyD47VR/ejwvIzIlS1DPmL3/jHoPp19RIMiEUsMTz1Tw
         2///yEqR7XSqImDnZsNwbjBlfFbZ/dW3x9u4hwH3lueYHB4DG2cqJ3HEMiaq+QLiiT4M
         RwtGn/yZSwOzQbs2C+J14VzB62o7SRUIMjmqRihLHHKaXCxxVjdlfA9+3YOagEkigCf5
         ekIOXzvMqdWMn749xpb4rLBNudX7IBoog6TK2X/n9HK0T/EL0mwzG+BXUOTAn3Eoiukj
         X5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678149385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hr5v+XtwCFaMw7+Eg+X0RF9TNh8YYP+EKyxC0lKV4Xs=;
        b=UwP4LGIPOshR27DguVM93VDNX41fwDQEGeEwbObV6XhzNKk1dGt5m5IwKbjFARuCsU
         exoXuZygeCLLqKzHcKWViDJQESqfJJeE1Yr0KqpGKMGcuD+m4Bh+Up5iX+aJwVFJWQPT
         dMZbCg17opadLrfexDwpbIHNtqkICwRTsh2OrfxVznPajO5mrrhqh5ab5adjHcO5xVN4
         +QNJwePZdwcJzKl+ySOx37CqW/6U1+RHbW67NYqsakiplVe6UHUSE0dTuZkhAMeUxOOb
         7rORVObbn1ykam9Lr25BNzSWtTUQcwPfZ5BaO+lfViYqlrUSfJgkZpSIrx6Vl2vmaXEJ
         zrFw==
X-Gm-Message-State: AO0yUKXLPpqmGzrTY9xGRvrrBrEZd619p1TKbiGZ98MlAq1n0ai1oqGL
        YpWJo+vPWIt3nQoybP3RWIJ3Sg==
X-Google-Smtp-Source: AK7set9JqRHbDCnN3JwnkF7nPy3YZYZJ/f5HRgk9plzcL9L0tEiQsS7/i5Wzj4pDgx1IKJ4Ok7JubA==
X-Received: by 2002:a5d:8492:0:b0:745:c7c1:a12c with SMTP id t18-20020a5d8492000000b00745c7c1a12cmr7701019iom.16.1678149384874;
        Mon, 06 Mar 2023 16:36:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s17-20020a056602011100b00740694b5f43sm3664241iot.46.2023.03.06.16.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:36:24 -0800 (PST)
Date:   Mon, 6 Mar 2023 19:36:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/8] ahead-behind: new builtin for counting multiple
 commit ranges
Message-ID: <ZAaHB7XTz8HX75LD@nand.local>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <xmqqedq1ag8d.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedq1ag8d.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 10:26:26AM -0800, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > These numbers can be computed by 'git rev-list --count B..C' and 'git
> > rev-list --count C..B', but there are common needs that benefit from having
> > the checks being done in the same process:
>
> This makes readers wonder if "git rev-list --count B...C" should be
> the end-user facing UI for this new feature, perhaps?
>
> Of course if you are checking how C0, C1, C2,... relate to a single
> B, the existing rev-list syntax would not work, and makes a totally
> new subcommand a possibilty.

Yeah. You could imagine that `rev-list --count` might do something
fancy like coalescing

    git rev-list --count B...C1 B...C2 B...C3

into a single walk. But I am not sure that just because `rev-list
--count` provides similar functionality that we should fold in the
proposed `ahead-behind` interface into that flag.

On the other hand, I could see a compelling argument for a slightly
different syntax (maybe `--count-ahead-behind` or
`--count=ahead-behind`) that would fold this functionality into
`rev-list`.

And that is the sort of thing that we would want to settle on sooner
rather than later, since it's fairly baked in once we decide one way or
another and then merge this up.

My personal feeling is that we ought to avoid (further) overloading
`rev-list` absent of a compelling reason to do so. But I am definitely
open to other thoughts here.

Thanks,
Taylor
