Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EC2C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B8D20774
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLIDoEIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438333AbgDOUbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437621AbgDOUai (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 16:30:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACAFC061A0F
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 13:30:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u9so533328pfm.10
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 13:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nNsK0Kccw9GyhxD7f8DruxRSJPeXCpc9bsm5rCXI7kI=;
        b=tLIDoEIsWsQsr3zqBygs9UXoOX+kZxNjoFVoZcJmpkibneyBohqaCL+8OYnHzoCDNw
         KuVNE4Ub3UlXsENdk1oWeMazzaQgE8nGUmKDbtMMRdgua+YHG/RXPklca1RVXWEYzM4Q
         KTkhg5uIWEymJy4cubLGpbBoCFBhNNfCfB/5mbucUVJBZugBwR/NWLDkh+ncKe0rZh5j
         Wt+lnTZq+UUDL3OJuhBhuEuJY3fPg0yPVOyE5EDumyAoRt6L53WwY9xI3I5oOkv270X1
         3k6N+fdqaCLGYfIseKCnalCwU66qxLxk/yqZE3Ah5K1lebQKzNXJT2VIms2q99nOOqZ7
         Nsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNsK0Kccw9GyhxD7f8DruxRSJPeXCpc9bsm5rCXI7kI=;
        b=h55ageb02tSBXGfgX1bWBaJPLjCiX9Zq5XyvVu07gd35H2TicQbbBIEnHLmntAgpLc
         5Wa/gYsDzIcev9kyRMUdrKMuE4/3BbeKX8S4jCLfJ28R5ydc190L4pS2V/WaZZRkDJgo
         bNhLHctK6nwYue+YOwVOaU7i8vuOS3r1RBIV3ss1inVObotkcY3g8u+suxhhwEW1uZGD
         KWSXTbalCypo4giGfAp958OynDYciw8YTO9vsKHvbRH+SOwIjSutkcV/0kCuwOtzbRD1
         kkB6nM12e/I22SUiTFP0x7tiymAaRCq+EwGnML0soT1E9dqItgfAtFFzlkH4f+S6QjRe
         bd3A==
X-Gm-Message-State: AGi0PubkszxWLsTBCOyorU6DueuRa9+Bgt1UD/3EP+eD/g5FepGrjjAU
        Wiv3k3o6epgXXg7WDbyLudxi2Q==
X-Google-Smtp-Source: APiQypJRaJdogpslV7SILpwUbPe7o1XB52pLfqGj73gE51TjpB4fx4TxmA8joLUXmZTgXxUTtod3vg==
X-Received: by 2002:a63:af5c:: with SMTP id s28mr28275592pgo.21.1586982635683;
        Wed, 15 Apr 2020 13:30:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i14sm13555545pgh.47.2020.04.15.13.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:30:34 -0700 (PDT)
Date:   Wed, 15 Apr 2020 13:30:29 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org, James Ramsay <james@jramsay.com.au>
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
Message-ID: <20200415203029.GA24777@google.com>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200414005457.3505-1-emilyshaffer@google.com>
 <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
 <20200414203247.GE1879688@coredump.intra.peff.net>
 <0f661f31-ee75-15fb-0272-48d459176f29@gmail.com>
 <xmqqd088950d.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd088950d.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 07:51:14AM -0700, Junio C Hamano wrote:
> 
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> >> If you want to refer to commands in ordering options (like your
> >> "before"), then you'd have to refer to their names. For "my-command"
> >> that's not too bad. For the longer one, it's a bit awkward. You _could_
> >> do:
> >> 
> >>   hookcmd.my-command.before = git diff --check --cached
> >> 
> >> which is the same number of lines as yours. But I'd probably give it a
> >> name, like:
> >> 
> >>   hookcmd.check-whitespace.command = git diff --check --cached
> >>   hookcmd.my-command.before = check-whitespace
> >> 
> >> That's one more line than yours, but I think it separates the concerns
> >> more clearly. And it extends naturally to more options specific to
> >> check-whitespace.
> >
> > I agree that using a name rather than the command line makes things
> > clearer here
> 
> True.   
> 
> These ways call for a different attitude to deal with errors
> compared to the approach to order them with numbers, though.  
> 
> If your approach is to order by number attached to each hook, only
> possible errors you'd need to worry about are (1) what to do when
> the user forgets to give a number to a hook and (2) what to do when
> the user gives the same number by accident to multiple hooks, and
> both can even be made non-errors by declaring that an unnumbered
> hook has a default number, and that two hooks with the same number
> execute in an unspecified and unstable order.
> 
> On the other hand, the approach to specify relative ordering among
> hooks can break more easily.  E.g. when a hook that used to be
> before "my-command" got removed.  It is harder to find a "sensible"
> default behaviour for such situations.

To be clear, the examples listed (both numbered order and relational
order) were more for illustration purposes. At the contributor summit, I
think Peff's suggestion was to stick with config ordering until we
discover something more robust is needed, which is fine by me. At that
time, I don't see a problem with doing something like:

[hook]
  ordering = numerical

[hookcmd "my-command"]
  command = ~/my-command.sh
  order = 001

(which means others can still rely on config ordering if they want.)

Or, to put it another way, I don't think we need to solve the config
ordering problem today - as long as we don't make it impossible for us
to change tomorrow :)

 - Emily
