Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B35AC433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 11:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbiEELTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 07:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbiEELTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 07:19:53 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689153B56
        for <git@vger.kernel.org>; Thu,  5 May 2022 04:16:14 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p3so1251724qvi.7
        for <git@vger.kernel.org>; Thu, 05 May 2022 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aEwyJAuFyNTqlqPG5TTR/KUcL9VX6nkovn7htiW9KuY=;
        b=PJIKklEsgbHiBj3DX4pRT5F5mF1kXUqL/M5mCwYTgBY0UIupde+WFPY10V1tt/YCNA
         riisKb4joaQUj4v/MNejEDWcVSQ9ggqToBU5hBltL+58hZHO6RdPaG+3UWyCzQbyDc0T
         Iv5GUJkswHj/8v9oHW10v5th7XgQ+ttkrNTacGI3rWAJyutn6qJ8cwYL0ixiPGk5o6+2
         HDHCk9/CLkG2jpOtIh1I6AWuPMjsWAk36gNWZp1kbCEoIoXDBbQA6whcnJieqZ6xVFPw
         t8Vgjc3wiX43ZpopXP/HXkS9BsWF3oERhRIEk+5BZLivELNf9v9NdTzRJNlIcJ2+S/z9
         14vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aEwyJAuFyNTqlqPG5TTR/KUcL9VX6nkovn7htiW9KuY=;
        b=Bl1TpwcDNwjXAbAhCqak8Sh8utNOMCH5wHRQhBICmcS6j2oKumD2Qr/gpKSlQmSOCQ
         nvszOrMZAD0u0pWwXD5K2WdsTyTsc3O+InTSQSLinhnT51Ho9dpQO76znF93S3H2ESQP
         bM8Q27ClJnoAoQAZ1Zc0hJGKiP3wNFEfhjGnD067qRe4RuE7ztEq+UzG891fR1ZAdQs3
         9q66yRe/mV6R2lnvnx/CdwVeUMNeknMTL1j+ljJZYZfp0jsB4ed5V3MbVi/XGdh+KhPJ
         w+PAbg16504kdCglZrHrNvYxJohpjdyM9L50vQ44p9YkHQ05CHAJP0+70tUQ5tRUpwXt
         fzmg==
X-Gm-Message-State: AOAM533Zx+DqQ1tWr5bKraRogmOWcgddAHaRXvDXHWq5Wkjpyn5iwFoc
        rdDSlkDeOfnGl3PiI0yavs4=
X-Google-Smtp-Source: ABdhPJzrpH7FIZR9otDGqWOY6bMJk/3dKZoV72pOdKduQtVyAaj5Qm2XAKEDj13YEHclSUsPUAvYXA==
X-Received: by 2002:a05:6214:20e6:b0:446:779e:6a16 with SMTP id 6-20020a05621420e600b00446779e6a16mr21808332qvk.81.1651749373639;
        Thu, 05 May 2022 04:16:13 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id z11-20020ac8100b000000b002f39b99f683sm680474qti.29.2022.05.05.04.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:16:13 -0700 (PDT)
Date:   Thu, 5 May 2022 04:16:08 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: Re: [PATCH] http: add custom hostname to IP address resolves
Message-ID: <20220505111608.o63obxrifoqz6j5w@carlos-mbp.lan>
References: <20220502083639.610279-1-chriscool@tuxfamily.org>
 <xmqqfslrycvp.fsf@gitster.g>
 <CAP8UFD0hWUudP6pZVGS5yOVCjbBCm1LdK_EbrsQp9KiVPPMCyA@mail.gmail.com>
 <xmqqzgjxnz73.fsf@gitster.g>
 <CAP8UFD0V6scSD8LuUiRQ0BWmG2mFATVFNQ2DgwaWFp6bigBkZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD0V6scSD8LuUiRQ0BWmG2mFATVFNQ2DgwaWFp6bigBkZw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 05, 2022 at 12:48:50PM +0200, Christian Couder wrote:
> On Wed, May 4, 2022 at 4:34 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > I am also interested in others' thoughts about this. If no one thinks
> > > that a config option could be useful, I am Ok with making it a
> > > "--resolve" command line option that can be passed to any Git command
> > > similar to "-c <name>=<value>":
> > >
> > > git --resolve=... <command> [<args>]
> >
> > Absolutely not.
> >
> > "git [push|fetch|clone|ls-remote] --dns-pre-resolve=..." that is
> > *NOT* git wide, but is only for transport commands might be a
> > possibility, but even then, you'd need to invent a way to do the
> > same for non cURL transports (we want to be able to pin the IP when
> > going over SSH to a certain host, for the same reason) if we promote
> > it to an officially supported command line option.
> 
> Ok with renaming and implementing it only in transport commands. I
> don't want, and I don't think it should be necessary, to invent a way
> to do the same for non cURL transports though. I think it should be Ok
> with the doc saying that the option has only been implemented for
> HTTP(S) yet and will have no effect when other transports are used.

I think it will be better if git aborts with an error if it is used for
a transport that it doesn't support, instead of relying in the documentation,
though.
 
> If there is a simple way to do the same thing for ssh, then I might
> take a look at it later. For "file" or bundle transports, I don't
> think it makes sense, and the "git" transport is not used much in big
> hosting services where this feature is likely to be used.

This seems definitely useful also for ssh which is also used in big
hosting services.

Ironically, I think would be even more useful for the "git" transport
specially because it doesn't have other protections to rely on that
would help prevent spoofing (like TLS), which might be also why it is
not that widely used anymore.

Carlo
