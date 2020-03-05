Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2021BC3F2D2
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 17:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65CD20870
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 17:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0fk4YdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgCEREu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:04:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34749 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCEREu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 12:04:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so7967944wrl.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2020 09:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nunQ0252DE3txKVJwfAziaNv1Qo3b+rjD3zpSLCnUmU=;
        b=M0fk4YdClWAgxmv8/fvSuGhuHQg0z0x69N9FS5Sva3MzsCHTxFoTsPv3yWlUXZzq1F
         KnL46zRXWtqWRStd0n1Dr4qSgKbfyg9mnxr7ALjBg1ZlRg02WQpef+AQmjhbLF+Gv+Vu
         9Nbuw7i/y/ex7RVs7L72kQXz/g2/UpfM1VPynoUN6SB9EFpHirCEg5BdlpXBr5V2Son6
         cMdjN5aQ8+B7AVQNuOoPSJkmQiv52UZMGXAsNsj/LLTjTez57g2+fvZfedumlVFJH+ms
         cnc6j7CEuFny5gb6RKPfYFKh6ti5ct9cmHPoVkV1tV0f22S8uamb0IfYVEWo6xyjjew8
         46XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nunQ0252DE3txKVJwfAziaNv1Qo3b+rjD3zpSLCnUmU=;
        b=MyODuCpdlvCmfVl81nMcQ8huInq+3lNUSX/lbabkV1Lr7VjSwXXtcc+ZGjegklDciO
         KhGS5ely95jwuIuYlJWkXz5iXZUoK6125xpqfyTSqpjWXXE3qpXmiyoxYm3XdbyTJf43
         JA5PocyR41gJd0FmQaAq08GF8bjQcNw2P2EuNWSVs4ncAeZBaWq8kcCLjQFbDwaBxuys
         fxGclvntzt5T4w/P5Zw5YErufHFfmAJtYrrnHC1DoyjqvzYilHR4O/3Ke7MTAopFHrko
         lUVwD5T4dJsjSOz0a25rm2vuM8xUek91LiFHvbiuREvOO1BD5AaSrJuUyZ7K+Qqix/Gm
         z1XA==
X-Gm-Message-State: ANhLgQ0dc/mouke8L3JIQdpap9iA5tF30Eh9x3y3el1OkuAgSY6p3Grp
        zPRNeWdunESaMvkKnpTF7jw=
X-Google-Smtp-Source: ADFU+vvpIvu3FruoupPdMD0lq7ibe2OrKYn4i4pp3qruxQPJYs6TdBQL9lHNX0SV1/I8eQehU3Ve1A==
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr10839167wrn.86.1583427888612;
        Thu, 05 Mar 2020 09:04:48 -0800 (PST)
Received: from localhost ([2.28.70.205])
        by smtp.gmail.com with ESMTPSA id g201sm9849611wme.23.2020.03.05.09.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 09:04:46 -0800 (PST)
Date:   Thu, 5 Mar 2020 17:04:45 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Son Luong Ngoc <son.luong@booking.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v2 2/2] stash: remove the stash.useBuiltin setting
Message-ID: <20200305170445.GE1571684@cat>
References: <20200302181832.GA1571684@cat>
 <20200303174613.3557960-1-t.gummerer@gmail.com>
 <20200303174613.3557960-2-t.gummerer@gmail.com>
 <xmqqeeu98egp.fsf@gitster-ct.c.googlers.com>
 <20200304114909.GD1571684@cat>
 <xmqqh7z45bph.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7z45bph.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/04, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > On 03/03, Junio C Hamano wrote:
> >> Thomas Gummerer <t.gummerer@gmail.com> writes:
> >> 
> >> > +	Unused configuration Variable.  Used in Git versions 2.22 to
> >> 
> >> s/Variable/variable/;
> >
> > Whoops.  Do you want me to re-send an updated version, or could you
> > fix this up locally?
> 
> After reading your response to the end, it appears that there is no
> other changes needed, so let me do the honors ;-)

Thanks!
