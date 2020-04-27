Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02ACC54EEB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 19:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A759B2078C
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 19:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iey2Q24e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgD0TkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725919AbgD0TkA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 15:40:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC58CC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 12:39:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so216723wmh.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xnxJOAxfEjJeM5h9n6yKSr9L9alT3cQ6nL1M559BvuE=;
        b=Iey2Q24eDm4UNSFjjhgFALB6hE5PmaWeqtb5W/9IPvSa3JUBm0+Sp5rjR9CSwfluG/
         zV86x+YPlHjZtCH1lyFEjrbIdDkle4D/Xgz040zyuUVIwvcfqTw3ak9RIzr5Uyd3VAHQ
         CrPR67TaVMAoOAXepKLZgya1zArHnG6dS39rGFVaa+Cdp+4L/e8C+WKAIH0GpKuCwZpZ
         xYq2sbLPB1z/VSWT+yZvnSCTOYkQvMhUo7+ytXwmvGS/aaHPXWxk8/8phd38120vejZB
         zijAWdzixlbKd3o507O8aAXIgC6Mepb0cw1Cedt1jYZGZrYMaehLKwZx8sPrZ0D0FGED
         TCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnxJOAxfEjJeM5h9n6yKSr9L9alT3cQ6nL1M559BvuE=;
        b=K0tiRPqiQqSfU36T8Kwa54RsJG7BRG0AX8Kj9le6w/vf7CO/WPFdQDQuJYYXDu1RFf
         hQ17ZdpydhPveg8Y3LzjVrbrCOTO6CdG/qTtD3tnfAu6aAz2LTkjWoQoE7ffj2w+S+xd
         5zj8GLpvdShBFU7A4U8gHCKXvO6Q/PU5FVCGbn0frSGhts1cUEMcGYZPKnKBjbt65U20
         1wrJ3TlGcFQ4mducWoJH3fd+pzqZW86N7YLqF26yOmA+5cJX+9E4dmuBT0ywa0zCi1rL
         bpIwZIdZ+GEjg6Lyc9FV4w+RC//8DnJtq0v5Nr1yC0UfrEClkjEqjkyejPDnNUaw7QIG
         1kJw==
X-Gm-Message-State: AGi0PubEfASesCoEbXE1LFqfZJje2zZMRlWgvoFxDIBBrQKeNvTKUYwE
        /md3UTMaeqEs/i3SNtgwyik=
X-Google-Smtp-Source: APiQypKxQRvoI2SIh+HUmMp7g1UCe++SyY6ZdkaUIj8MNqwEA2BPwTiKaKCwgJn15rpPeyUWjyZvAA==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr348304wmk.68.1588016398611;
        Mon, 27 Apr 2020 12:39:58 -0700 (PDT)
Received: from leopardus ([2a02:a31a:a043:8cf0:ca8:e44f:8895:44f4])
        by smtp.gmail.com with ESMTPSA id n2sm22815151wrq.74.2020.04.27.12.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 12:39:57 -0700 (PDT)
Date:   Mon, 27 Apr 2020 21:39:56 +0200
From:   Mateusz Nowotynski <maxmati4@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Matt Rogers <mattr94@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        bwilliams.eng@gmail.com
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
Message-ID: <20200427193956.GB2223199@leopardus>
References: <20200425235716.1822560-1-maxmati4@gmail.com>
 <CAOjrSZs33-CqV5m4wKROYJT8au1hup7bGZWiEaXMV7cU4p-J=Q@mail.gmail.com>
 <ff9a63d4-80e4-8090-c85c-03fd3ab43c55@iee.email>
 <CAOjrSZt7WJy1vv97Rw9MFJyTcB2Ehqq9BjGrXMtV95oB5p53SA@mail.gmail.com>
 <8992c1a7-a638-e823-1cb7-2c8f6b28d486@iee.email>
 <xmqqwo627xsd.fsf@gitster.c.googlers.com>
 <xmqqsggp98to.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsggp98to.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 26, 2020 at 03:32:51PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Philip Oakley <philipoakley@iee.email> writes:
> >
> >> Mateusz's original problem was with discovery of these env variables,...
> >
> > I somehow doubt it.  
> >
> > Certainly, defeating /etc/gitconfig should be a part of the solution
> > to the "I want a stable environment to run tests reproducibly,
> > without getting affected by random settings the testing user may get
> > affected" problem.  It is not enough to defeat $HOME/.gitconfig (and
> > its xdg variant).
> >
> > But I didn't get the feeling that Mateusz was even aware of the need
> > ...
> 
> After re-reading the patch that started this thread, I suspect the
> reason Mateusz did not mention GIT_CONFIG_NOSYSTEM could be because
> he was aware of the need to defeat /etc/gitconfig, and was already
> using it.  There was no discovery issue---to somebody who would
> propose the patch under discussion to solve "I want a stable
> environment for testing", /etc/gitconfig was a solved problem.
Yes, this is exactly the case, I'm fully aware of GIT_CONFIG_NOSYSTEM so
there is no problem with system wide config file. Anyway if you want to
improve its discoverability I can suggest moving description from
git-config to git since it's influences all git commands not only git
config.
> And unfortunately we do not have GIT_CONFIG_NO_GLOBAL; so there is
> nothing to discover there, either X-<.  If we were to add such an
> environment, we need to make sure that it is discoverable ;-)
I think it will fully solve my problem so if you are willing to accept
it I can do the implementation, it shouldn't be complex anyway.
Regarding the discoverability I think the documentation should be put
together with GIT_CONFIG_NOSYSTEM since they are very close to each
other.
> I still think setting up a directory that can be used as a stable
> $HOME replacement and pointing at it during the test, while
> declining the system-wide one with GIT_CONFIG_NOSYSTEM, is the right
> approach for "stable test environment" problem.
We have pretty "stable test environment" that is running in CI and it's
working really well and stable. Problem starts with developers machines.
We would like pose as low requirements on them as possible, ideally it
would be just given range of go, ruby and git version that we use. I
know that it will be ideal to just overwrite $HOME with some temp
directory but reality is even if it's not fully UNIX compliant there are
tools that will rely on user $HOME to provide those requirements (go,
ruby and git). I think that in such case it's better to add this small
feature to git then go and fix every tool in the world. Currently we
found issues only with go cache and mentioned earlier asdf version, but
I expect more of them as people come and go.
