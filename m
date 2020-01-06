Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9BDC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1D820731
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eoVusq+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgAFXNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:13:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44108 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgAFXNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 18:13:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id 195so26766393pfw.11
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 15:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KniBhbQnDF0BbOQfoNQjm5twYuJmPU3yal9WEFRs278=;
        b=eoVusq+takPFB5aDPHsvDPz54/oOlxUMX2thKaxpDKbX/D3qcYYBJ5Pp45Eo6mby78
         dkEipqCyUTluJ2FR6CFYGXZvdwkOw3aZtfgHjiMfcJeDEc9lkrY8VcTGawCvO2FaaogK
         t3X0mJJuK5JLVawuBz853FfQhgG1SFTYiL1Ldyko+wZ1l4wsykGx1G31leM1+KUNv+Xq
         2TchNvA6zqes4zAAOTaq1MiY7V1WD9+7L4q5uqdAVhwUul/eR737BZyME/WEic0VzL7F
         nlQphilnYDA742Zz+HDj8bcytZ7Y8lZoepODhE4X9fJF4wSdxDmrqvf54sKDevkxQXdV
         lmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KniBhbQnDF0BbOQfoNQjm5twYuJmPU3yal9WEFRs278=;
        b=cfNzl/E+U+QeVbVS/s+71yMSAg6vF8J/m8opUw1UJ4dqEtkIZ/WFY1VkzqniMjq/U0
         M/sm6DWyGnl1ZG5xbZ9F2r4XAAdrQ5zN9nTpVdcgejb/sv8Ob6IK2lauLqqAv3pQinMe
         2/KEbMiCsBXhSYcqzIZkcFlbLnFVVDzzNG9HF02inS6oqkeQWXxqm0N7TNoo1D7ex4Hz
         KIPTtrpYXWWbJgR916FcppUtOcmhF1hFVEaG60w2J6h8A1uNWUWo9BdWUJDUDNdwhGp5
         nb792vOibwhkeOYCLZHqQ5iDGkLvqt25ar6dCTnZ1zQ8osPIJA1SoiKqrwLm9D3q6x0o
         I/mw==
X-Gm-Message-State: APjAAAVsK5gE607s41rdmRaHXowqRHPMzzdm13XPIKuPJ6AekcbE9qHv
        Xos0HBmB+9DICNGfkiu8AYPkog==
X-Google-Smtp-Source: APXvYqyua+X00JsfPG+BBNc3yd/py6nFVh8661gV5/0dvJA4laANLkyvsdS+PsnCerQP/BvXgYXslA==
X-Received: by 2002:a63:9d85:: with SMTP id i127mr108467917pgd.186.1578352412163;
        Mon, 06 Jan 2020 15:13:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id l21sm59570487pff.100.2020.01.06.15.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 15:13:31 -0800 (PST)
Date:   Mon, 6 Jan 2020 15:13:27 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 1/1] add: use advise function to display hints
Message-ID: <20200106231327.GB181522@google.com>
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
 <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
 <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 02, 2020 at 11:54:11AM -0800, Junio C Hamano wrote:
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Use the advise function in advice.c to display hints to the users, as
> > it provides a neat and a standard format for hint messages, i.e: the
> > text is colored in yellow and the line starts by the word "hint:".
> 
> Use of advise() function is good for giving hints not just due to
> its yellow coloring (which by the way I find not very readable,
> perhaps because I use black ink on white paper).  One good thing in
> using the advise() API is that the messages can also be squelched
> with advice.* configuration variables.
> 
> And these two hints in "git add" are good chandidates to make
> customizable (perhaps with "advice.addNothing"), so I tend to agree
> with you that it makes sense to move these two messages to advise().
> Unfortunately this patch goes only halfway and stops (see below).
> 
> If there are many other places that calls to advise() are made
> without getting guarded by the toggles defined in advice.c, we
> should fix them, I think.

Maybe this is my C++ habits not dying when they should :) but to me,
this begs the question, "why doesn't advise() check the toggles for me?"

Are advice messages 1:1 with advice settings? Is there a reason that
advise() doesn't look up its corresponding config for itself?

 - Emily

> 
> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> >  builtin/add.c  | 4 ++--
> >  t/t3700-add.sh | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/add.c b/builtin/add.c
> > index 4c38aff419..eebf8d772b 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -390,7 +390,7 @@ static int add_files(struct dir_struct *dir, int flags)
> >  		fprintf(stderr, _(ignore_error));
> >  		for (i = 0; i < dir->ignored_nr; i++)
> >  			fprintf(stderr, "%s\n", dir->ignored[i]->name);
> > -		fprintf(stderr, _("Use -f if you really want to add them.\n"));
> > +		advise(_("Use -f if you really want to add them.\n"));
> >  		exit_status = 1;
> >  	}
> >  
> > @@ -480,7 +480,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
> >  
> >  	if (require_pathspec && pathspec.nr == 0) {
> >  		fprintf(stderr, _("Nothing specified, nothing added.\n"));
> > -		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
> > +		advise( _("Maybe you wanted to say 'git add .'?\n"));
> >  		return 0;
> >  	}
> 
> The final code for the above part would look like:
> 
> 		if (advice_add_nothing)
> 			advise(_("Use -f if you really want to add them."));
> 		...
> 		if (advice_add_nothing)
> 			advise( _("Maybe you wanted to say 'git add .'?"));
> 

Hm, I guess this answers my question above about them being 1:1. But I
suppose it doesn't necessarily preclude advise() from associating a
single config with multiple advice messages.

 - Emily
