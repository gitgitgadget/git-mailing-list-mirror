Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B41C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8132B206A5
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kr9AZutz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfLKWAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:00:45 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36232 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKWAp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 17:00:45 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so126940pjc.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 14:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gfa419aee33AsxVDQnKOPL9fYsIy51uA1GuLH13sloE=;
        b=Kr9AZutzYIQpxTPSMwsfOLMwfAS41Dw5PUzAUeeHkB2mO+8DQle3fWD2Ak4BqnmYSN
         5a2LqpDUc/Kcjg2N13BHYdVEj7PZ+AYPIYMoRQcAmg5ViLBLxBoO6zITOBvIWFflTx+N
         l4EpQcbi1RcvuRmgpb0T0bXjqFtigcxgRLFY9xELDGhF5IRC4l5R3CpE/xO/r2wldznP
         w3x6LnCNiryxlHD7CX6saNFOigQhC2swMabiAedD8ECSRMo1SeBMOyyZv+Z3IpI1I5ZF
         3EeopfhJ/QmpVkNIi6jU4SP68/wRfRgCk06ILu8Sbn6VJusx8HyaMp8byGBaLAtXJwxu
         ZyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gfa419aee33AsxVDQnKOPL9fYsIy51uA1GuLH13sloE=;
        b=rEINCuvZUZjTgakIdOZ6foNDYu0iYu6AmxytsM43mKiSRWZLo8JKTlswPIWDYeXl+8
         3eYI67gcopyH3UrlDdG7nV0PgvL24uttzn0Jkzd9H1Qg/UXGv42lPyuslw2plkl2GuCE
         58dbm11iBxtRXbkOSg5xJE7xCHtrEYWTS6DZyL0yOEY/I+py53fpSXBxH1n0H7Mtsq7w
         6I2o44aK8oLdjX8HwV1wF7f9FfVjkzwuzyGIDdcfNPV/FTWAw+PTiiFffbA+IX8gNayk
         rWoHIDk67Z21C1mLoH3qr3IB1yZYfupvX4EEL8vXLx53NbcnYr+ISayYy3D7Y1gHHVef
         zl5Q==
X-Gm-Message-State: APjAAAW62wBZQ8PRdqQcIP4Hv2ntuzTo+6yy3kz9EbQgqnBD3F6Wd6mH
        kOWPvU3xZXZ/uxChbWyCCMse3cAlZuY=
X-Google-Smtp-Source: APXvYqxg0KobHLNN1NXFGdhVLTcX2MTpJXHrrZiTzymfdd55V8aIq9BtyXt1O+ecbpwBslfLWRMHNQ==
X-Received: by 2002:a17:902:6b0a:: with SMTP id o10mr5622808plk.15.1576101644454;
        Wed, 11 Dec 2019 14:00:44 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 100sm3693643pjo.17.2019.12.11.14.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 14:00:43 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:00:39 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] hook: teach --porcelain mode
Message-ID: <20191211220039.GB8464@google.com>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20191210023335.49987-7-emilyshaffer@google.com>
 <xmqqimmmodwt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimmmodwt.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 11:33:38AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > It might be desirable - for a user script, or a scripted Git command -
> > to run the appropriate set of hooks from outside of the compiled Git
> > binary. So, teach --porcelain in a way that enables the following:
> >
> >   git hook --list --porcelain pre-commit | xargs -I% sh "%"
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> 
> > +--porcelain::
> > +	Print in a machine-readable format suitable for scripting.
> > +
> > ...
> > +static int print_hook_list(const struct strbuf *hookname, int porcelain)
> >  {
> >  	struct list_head *head, *pos;
> >  	struct hook *item;
> > @@ -25,10 +25,14 @@ static int print_hook_list(const struct strbuf *hookname)
> >  
> >  	list_for_each(pos, head) {
> >  		item = list_entry(pos, struct hook, list);
> > +		if (item) {
> > +			if (porcelain)
> > +				printf("%s\n", item->command.buf);
> > +			else
> > +				printf("%.3d\t%s\t%s\n", item->order,
> > +				       config_scope_to_string(item->origin),
> > +				       item->command.buf);
> > +		}
> 
> So, a Porcelain script cannot learn where the hook command comes
> from,

Not as I had envisioned.

> or what the precedence order of each line of the output is?
> 

They're printed in the order they should be executed; the explicit order
isn't provided.


I suppose I had considered really just the one use case listed in the
commit message, especially since other inquiry into the hooks to be run
can be done against the config files themselves. But - I'm of course
open to use cases. What did you have in mind?

Maybe this can be solved better with a --pretty=format type of argument.
