Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E022C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB2F601FD
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhCAVyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 16:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbhCAVwl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 16:52:41 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A02C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 13:51:37 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id r5so12408329pfh.13
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 13:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ohUhm/kS+3AIZar61V1RECmT6DfuQepvU29lqSiBNIc=;
        b=OrqE4kCRqaUr8ddUZWjAYCkAC7uXMBkLARTn17WvTTa4VLqaAMfk92AMuX7y6vsTve
         LtT51/SOiA/J5Qau+X510W3qBjorQyHBR4KEeEBXjd2O6CJQC5+4SrMOQChnlUNQO2M7
         68iOMwpttD7RgvhXCSdDQiSPK3JI8UFNG7ohpkfUEcKpqB5P62/HW4wsxB8j22mNuIE9
         UlPULBTHYlR4csjMUlu+m9vxT8+ae2gBOU5ZtHzOKUoQDEAWWQpUlGw/NqISYfVYo1w9
         V7anPi2xLEjqJcqvMSY2qWvDEEv3bP27rGC5TbdUn3IelS37Ui2MANrLxRSoPiAR3Xzl
         3pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ohUhm/kS+3AIZar61V1RECmT6DfuQepvU29lqSiBNIc=;
        b=uFWFBfj8xeHgJCYCQEt6R/AbkzVlwoWrxAIaHsp20qgwkl4BLovD25+qxpyZ7mAMND
         hl4dU8Gm8qKQCZ+1EZMXCTnJF+/cpINmPdLKy8+wzvCDvJG5UFBhi+zD/jfz38Hxtmxk
         Vk3w3+DEtpLaoaO45MLu+DB3UwOjCnOhvsIGJ08VuKMm3irVA6W+3jkGxC/L7lX6jx3C
         wOjS5OW208D11fimrVhmK/Oung9q2AXN1s6qOhGAbz3pZ5wXZoKuctG0uwTtGIuBxWdi
         DyLEXd/adHTmqYcya7EW+UrN/3zv0WefoIWis/VRMT1JKsWZ/P2jIynIcB29xPY5pF8d
         EtXA==
X-Gm-Message-State: AOAM532FtgFxyO3J7FqBLTnGRZlzcySsNrsyWsSgCaIvw1yFUvXC3qxF
        RrXjsRG4zD479BQVM05F01HrHw==
X-Google-Smtp-Source: ABdhPJzP4Eh74uxaPLsFrrOy+a3gdn+59CqAJhC5crW3fl3l2Z2V5YKLydeUIfUaIpQ9vnDm5z0QXw==
X-Received: by 2002:a63:4f56:: with SMTP id p22mr15637790pgl.224.1614635496613;
        Mon, 01 Mar 2021 13:51:36 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:f06f:1607:6adf:4b8])
        by smtp.gmail.com with ESMTPSA id f7sm356146pjh.45.2021.03.01.13.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:51:35 -0800 (PST)
Date:   Mon, 1 Mar 2021 13:51:31 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 00/17] propose config-based hooks (part I)
Message-ID: <YD1hfZqfu9bcMkra@google.com>
References: <20201205014607.1464119-1-emilyshaffer@google.com>
 <20201222000220.1491091-1-emilyshaffer@google.com>
 <YCwhA6VIs16uMnJG@google.com>
 <xmqqy2fnocjc.fsf@gitster.c.googlers.com>
 <YC2IzVxLgvC7N8qd@google.com>
 <xmqqlfbmi99f.fsf@gitster.g>
 <xmqq4ki0udu4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ki0udu4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 11:50:11AM -0800, Junio C Hamano wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Josh Steadmon <steadmon@google.com> writes:
> >
> >>> The topic branch has a lot more commits than these 17; I am
> >>> wondering if the reviewed-by applies only to the bottom 17, or as
> >>> the whole?  I recall that the upper half was expecting at least some
> >>> documentation updates.
> >>> 
> >>> Thanks.
> >>
> >> Just to these 17, sorry for being unclear.
> >
> > Thanks for reading them through.
> >
> > I am tempted to say we should merge these "mechanism" part down to
> > 'next', hoping that the "rewrite existing ones using the new
> > mechansim" part can follow soon.
> 
> I said this on Feb 17th, but since then I think I saw you answer
> "I'll do that" in responses to JTan's reviews in the past few days
> (e.g. <YC7o2rUQOEdiMdqh@google.com>).  Would I regret if I merge the
> topic down to 'next' today?

Bah, I'm sorry I missed this - I had a broken mutt config and wasn't
seeing replies, my own fault. Argh.

I have some pretty significant changes from JTan's reviews, so I'd
prefer if you would wait since it would be tricky to turn them into a
patch commit now. But if you'd rather merge it and see a patch instead,
that is fine with me.

 - Emily
