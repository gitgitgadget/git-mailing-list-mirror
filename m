Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5C7C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 22:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFB021739
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 22:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TU7jwuRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfLPWkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:40:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33095 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfLPWkA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 17:40:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so4541100pgk.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kWBsoU5muXtaVbAyQXZWD2GqEDQ/ciCvOsFA4JHBDiY=;
        b=TU7jwuRe6BfubmLUBBzLcQ3cM+CaBFjpJhMNr+Eeg83sXTePiWAIY/SBn7NGt+P7B0
         vlu5qSPSYJ+wVnn3EfSnZQIcCZg+oudrhOb8HQhhxfbOzr1HduyjOOUTsHexKjI7BiNH
         Q3lUBsuXSPN3+sMY2uAJpPn6ERuKsEoEBtq8stbjNKCcDYPCRMgzIiQYe9TyXB5zrIUx
         hBxmpwB7dlShL36hogx5e8lHyFmC6CNwby+oIxcnNSD3Lrc2HJsGturN+6nwANWRQDS8
         seJal4K0PDRJDoRNa4gjCbPhaZezjtjVatiO3GnOtE+TyRtHezYHgWP7uRZpwu10O8ZW
         XMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kWBsoU5muXtaVbAyQXZWD2GqEDQ/ciCvOsFA4JHBDiY=;
        b=FnhOHcmk6J73rLF5DjMV+5YAXM7Hx/5mcLloWtENsODtDKIGFSXNNmhv9JmhkiOZjz
         kkjGhGCMSB1c2RuPZiTd3tN2HUzCZ82J110oHYh02oSsGwpX/PRuoda2TCDGg1yzlo1E
         KG4IHeRAf/XW4iTAZof+710l5Q6hHiZh29iuiNEd2vwTVg8cehet7jg1wFgncKvY9EEA
         IR+dw3uF11OGQYW4NOSTF4e1cgqWfo8auu7tNNECbQ/c1MFZOHuYEbCj7o/+V9G53tca
         pTwh+nrkNTtWK8IUOdtgNxf1jhXMfbyNxwDU5RJBeLYcyoFS7ExJIgMjOmGL2xnJ9mG6
         sklw==
X-Gm-Message-State: APjAAAX/vrUk4G2zLtRFrVZ/M9iXlMjY4P2KS8OCBaN/IzClkTR82OKA
        E9FlReHXTmtjFHiqwKVYBz3uhA==
X-Google-Smtp-Source: APXvYqzoqsUlkTSvNHVcz59SU7Bc1BkDrryBL99oaR2BqxcxG9VB5hrLti6GUXg5/LJZE1eFYBTjdw==
X-Received: by 2002:a63:e0f:: with SMTP id d15mr21175861pgl.255.1576535997989;
        Mon, 16 Dec 2019 14:39:57 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id k13sm24700567pfp.48.2019.12.16.14.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 14:39:57 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:39:53 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 06/15] bugreport: add glibc version
Message-ID: <20191216223953.GG135450@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-7-emilyshaffer@google.com>
 <xmqqimmjj557.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimmjj557.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 01:18:44PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > To help pinpoint the source of a regression, it is useful to know the
> > version of libc which the user's Git client was built with. Let's
> > include it alongside the other versioning information, which is used to
> > identify how the client was built.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  bugreport.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> 
> This is the first iffy one in the series.  It is unreasonable to
> assume that we can dictate that Git can be built only on glibc
> systems, no?
> 
> Making this conditional, perhaps make "bugreport.c" depend on
> "extern void get_compiler_info(struct strbuf *sys_info)" and require
> the function to be defined in compat/; the glibc variant that uses
> gnu_get_libc_version() would become just one of them.

Interesting. This sounds like a good approach - thanks, I'll look into
it.

 - Emily
