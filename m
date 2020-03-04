Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF4C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0994021741
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="og+kSqkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbgCDLtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:49:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37497 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbgCDLtM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:49:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id q8so2023965wrm.4
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jGtJbaZpfMV2k9tWw9PCi+rZDlmDZfO7Y8J0iWxYNbU=;
        b=og+kSqkI8+e8PE8QSrSqFEBBnCbM2bYgD3KCgBWfCOUYh2i1l3U20/t5keH8PQKB/0
         AaI+FRtC1GhQFuwqIScoDyKpqEhsMs9urm1m1UdlRtd2j/idcEGvav7/aLBTIWhtg4qA
         1Folz3APDOAptmjCVc4rsIki7Rlp8OM7rOFP9vkm552pxIBeg2ws7TG17+eErh/oPDmm
         Sq54nouTf282SPfCSn80yfKwZsmYoC8UOWwGb6cyMmUDOs4sQTrHdCifI7BJmprWWJxh
         dN8nxR/f8MmjtdDvSdjS4sK4MjhpM3yybx6OLTH+tafYg0WFQid2HECoQRot6lgyuafs
         ZLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jGtJbaZpfMV2k9tWw9PCi+rZDlmDZfO7Y8J0iWxYNbU=;
        b=FvlpnJjE/btaVfVoehl2neWfO+GA9BFeVkaHGxmRsaJBuL63ev2wYP+LHEhw0vOVEm
         03BeqJuMEP1yG64lPvgkFk+DGcXerf5Wu4qfgPBotiKsCpUFNNKos31t1GarxoGC89lb
         rxJV+TdecnOY9TIilBRgQCW9m2IBDSuXvTZCfNmujr6oGQxtuEyQMSOPkLiNsZQQ0DcU
         66Y09n3kcLfmmGkB1lUySyQdXSYY2k/qSCluAFXKk0D0HJL/f6D1walZCpd/ImZCvCIy
         RX70YQUwEvpy8B2loGQjhkAoEgtpOJIY5QRY6hFfvKE/ZeRHo2/0N0e48naFyM3eHnQN
         Ap3w==
X-Gm-Message-State: ANhLgQ3YpP1Drtf6NGvLVVusyKGgnl+TU5nhQO4eaAYQ/Lncamr4g481
        GZpPj2ydDAhDLoDWLINUwfXPx+Xa
X-Google-Smtp-Source: ADFU+vueWoojbGlPIexjr4Z64+/yJ0OvEGX/TlxkQ6t5BD00S0vW3Q3gyQHR0mD3G94F+TiCyA09yQ==
X-Received: by 2002:adf:f18e:: with SMTP id h14mr3665879wro.51.1583322550522;
        Wed, 04 Mar 2020 03:49:10 -0800 (PST)
Received: from localhost ([2.28.70.205])
        by smtp.gmail.com with ESMTPSA id t10sm39429966wru.59.2020.03.04.03.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 03:49:09 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:49:09 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Son Luong Ngoc <son.luong@booking.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v2 2/2] stash: remove the stash.useBuiltin setting
Message-ID: <20200304114909.GD1571684@cat>
References: <20200302181832.GA1571684@cat>
 <20200303174613.3557960-1-t.gummerer@gmail.com>
 <20200303174613.3557960-2-t.gummerer@gmail.com>
 <xmqqeeu98egp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeeu98egp.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +	Unused configuration Variable.  Used in Git versions 2.22 to
> 
> s/Variable/variable/;

Whoops.  Do you want me to re-send an updated version, or could you
fix this up locally?

> > +	2.26 as an escape hatch to enable the legacy shellscript
> > +	implementation of rebase. Now the built-in rewrite of it in C
> > +	is always used. Setting this will emit a warning, to alert any
> > +	remaining users that setting this now does nothing.
> 
> I am a bit torn between "just document it here as a stale variable
> that can safely be removed from your configuration, and do not warn"
> and what you did here.  Even if we warn for a few releases, this
> entry cannot be removed from the documentation for a lot longer
> time, if ever, anyway.  It's not like having an extra entry that is
> unused in the configuration file would hurt users, anyway, and it is
> not obvious that the warning helps more than it disrupts them by
> bugging users to remove it from their configuration file.

Hmm I'm thinking of the warning mostly as preventing the "I have
legacy stash enabled, why do I see a new bug all of a sudden?"
question, as opposed to it helping removing this from the docs.  I
suspect we have very few people in the wild that did enable legacy
stash, but if they did it might be better for them to know about the
config variable not having any effect anymore.

FWIW we went with this same approach with removing the
'rebase.useBuiltin' config, and I don't think we heard any complaints
about it in that transition. 
