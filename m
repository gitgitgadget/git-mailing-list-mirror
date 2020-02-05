Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7B3C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F0521744
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOu1+hCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgBEAav (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:30:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41230 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgBEAav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 19:30:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id j9so219436pfa.8
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 16:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iqcAMldUAlw0WHlQuETNBaMcfqq6tRgiUiRovao/dnQ=;
        b=UOu1+hCW4z/1ve9WtECNaTVwG0E9Fwv5nZM4YsE8xePEogRyl8KYu/6kizcDjIWuFp
         eHA5yCJsbK4P1qrnk6GiLk3Tx5K2N2E8m8R8f6mFa8PC+94hQNoKY1Ox47fMWZeyoN+O
         TyYISLVB9NyAlgeBLB1ZCsxIAZjJwyoRq1gBdpADmz8T/tiH65LoAZEiBTBk0T30x5GM
         KpGyqBJExMv0+qRQothZGlCzXce+huv9soyz45OG4hxqW89TwwoZ/DUI6Uj6ePC+7w9d
         1ehjJMPU91f5wSGGcT9ru0ILXUPxUU+O37s7wAcY/RHAUop6BfvKRpNtzxB94lWafCEb
         8tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iqcAMldUAlw0WHlQuETNBaMcfqq6tRgiUiRovao/dnQ=;
        b=ta0BG+qlLdwGbs7kCpZyXV9WWY8KwnIslFTHZ3RQwzo5v+ZrmgkS1Pn6Jr9Jm6Hxkg
         1sXexafZKtGJIZHGJ1Eqk8jS8QeP023PeuBWdAnGNf3ftuHY6k11/kj28rH0dkRN1yPk
         HnTVFHOK/odtgGa1ZrtWG1f0ZRMhzcpWmKVOsV/ztPjZKKf3bYLyqIDpO2S1sIwY8jCr
         TBKwajqvGZGwVu2HnS1ssDo8ecvIQxI0CIGEt67T8LThdpXt79G3mnX464RC+z05ErQG
         weSTH4D3MdkBgifs6UEL8RQ4rzHrBfKIvh7FD+h9xxgjbNWg+2RGZyL2sVu21SY1vZ40
         zQGg==
X-Gm-Message-State: APjAAAWO7roAbCwuJMv93hiBqvQTX26NvvhgUxFhakGvN5lCKIzFcadO
        k3IK1PSX83iFKK5R7qW0TPu8xetWrfA=
X-Google-Smtp-Source: APXvYqyIPhTeeHRAsScnqtZ4xmFve+7m+jDEmV5UQ6T7n2EOaP7ACi4ypuRRSgQ1OnXOKHcOeL3O+w==
X-Received: by 2002:a63:778f:: with SMTP id s137mr35317317pgc.49.1580862648919;
        Tue, 04 Feb 2020 16:30:48 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a17sm4898637pjv.6.2020.02.04.16.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:30:47 -0800 (PST)
Date:   Tue, 4 Feb 2020 16:30:43 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 09/15] bugreport: generate config safelist based on
 docs
Message-ID: <20200205003043.GH87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-10-emilyshaffer@google.com>
 <CAN0heSo2ujJr_Mi5xPv86NneLoXT3DM3dnRmTACs2VQERBq76Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSo2ujJr_Mi5xPv86NneLoXT3DM3dnRmTACs2VQERBq76Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 10:20:05PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 04:35, <emilyshaffer@google.com> wrote:
> > Add a new step to the build to generate a safelist of git-config
> > variables which are appropriate to include in the output of
> > git-bugreport. New variables can be added to the safelist by annotating
> > their documentation in Documentation/config with the
> > "bugreport" macro, which is recognized by AsciiDoc and
> > AsciiDoctor.
> 
> "which is recognized by" sounds like it's built-in. Maybe "with a new
> no-op 'bugreport' macro" or something like that.

Sure, I'll wordsmith this a little.

> 
> > -sendemail.signedoffcc (deprecated)::
> > +sendemail.signedoffcc (deprecated) bugreport:exclude[x] ::
> >         Deprecated alias for `sendemail.signedoffbycc`.
> >
> > -sendemail.smtpBatchSize::
> > +sendemail.smtpBatchSize bugreport:include[x] ::
> >         Number of messages to be sent per connection, after that a relogin
> >         will happen.  If the value is 0 or undefined, send all messages in
> >         one connection.
> >         See also the `--batch-size` option of linkgit:git-send-email[1].
> 
> Do we really need to list includes *and* excludes?

Need? Nah. The exclude markers are not even acknowledged by the current
implementation.

> I could see the point of adding an exclude here and there to signal
> that "this might look innocent enough, but trust me, we really need to
> exclude this" in order to avoid future commits to more or less
> accidentally over-include.

This was more of my line of thinking, along with the thought that some
folks may use bug reporting internally, where they have A) more control
over which extensions/tools are in use, and B) less concern about
sharing things like remote URLs, branch names, etc. and may want to go
for a blocklist as opposed to a safelist, to make it easier for their
support folks to diagnose.

> Should we add some internal documentation and/or a remark in the commit
> message about this? As an example, is "sendemail.signedofcc" sensitive
> enough that we need to explicitly exclude it? If someone wants to come
> along and include it, they don't just need to argue for an inclusion,
> but also for lifting the exclusion. Hmm?

Yeah, I think this is a good point. I'll try to figure out how to reword
the commit message, and take another look at the sample include/exclude
change I made to see where I can omit entirely.

 - Emily
