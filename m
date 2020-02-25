Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06916C4BA04
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA50F20732
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXyivD1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgBYXWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:22:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38502 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgBYXWG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 18:22:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so395393pfc.5
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 15:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oSNraGuzWUg7vUsCcSV6nJEupj1zrJiY+IYULOcffcQ=;
        b=ZXyivD1+IHF5W4UeIFl99Z5L9qkkPOexW+iTD2xkaWMPYe7GKUbs0Ynu/b1LgltVDG
         KsuOgN8VBc5Z+1J8/aWQw/yoACDwWXOUN42ay339JkzQmFQbRsS/r65XmjYlXu7AGsU1
         mdhwyHWI1xFht/4QlY7/DjcgAmrom/+7rwxOkq+1DpLRcww6HXsA6CyJst0rPk0n54Z+
         +O9vdyoOU9Fk6CKm5SxTzdp4MvRszZe/BB3BSpCSQsLW3xpY3X+FWtVU5oIlTlD0Xa37
         w87Bv6tbY5ea5GvIJkJHyIbrO1Z4FUWKVMlfmXoHZiOrJ6ExfyaIHP9cBfFwBEiSjfNi
         juAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oSNraGuzWUg7vUsCcSV6nJEupj1zrJiY+IYULOcffcQ=;
        b=QxmFygL2nSI13aYIAWZtzbR+k3uWAOmehwn4T7e5loMeltAQhfxCqXqcNqDb4Z83bT
         eeTwzQxcduAHUvxR+c8eTD/Hg3/8Pr0Rh5jPvytAcNp7JtVDwOCA7na6YeidrufoJTHj
         EmEguzP51mlxBi8gANziGgAJIeVN+5l1SA9M06HL48kyWngDOfszawLBpPxJFz9/YW7C
         eQHWJnd0XykeHw2/U47BXiBDVnVXy9ZSYJurcwnd7llZoCswYbeyQ4FrGB6zzcB1hppP
         aHSja6+9F8QGa7IrbU0Xxz4CHLQ+N3n7vMruUjDwqlAFLw0tjTAFXrEtS9K8ME0emQM3
         RY0Q==
X-Gm-Message-State: APjAAAV4chLzv/3octOWZEiDECdTHqyuwvK5E6C3VV+1KlQbEEWLzl7M
        BZLxb3vPHGiOE7qxn3+zeJTmYGSUfI4=
X-Google-Smtp-Source: APXvYqxKBK9D8UaidEofdwLiDrmDNDgHcG0BzisqDD7z7zRFdP1CnrlieYG+9Xm7b9txkyHocwUxdw==
X-Received: by 2002:a63:d710:: with SMTP id d16mr808585pgg.393.1582672925018;
        Tue, 25 Feb 2020 15:22:05 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w21sm79732pgc.87.2020.02.25.15.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 15:22:04 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:22:00 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 12/15] bugreport: count loose objects
Message-ID: <20200225232200.GD212281@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-13-emilyshaffer@google.com>
 <xmqqa75d9di6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa75d9di6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 01:04:33PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > The number of unpacked objects in a user's repository may help us
> > understand the root of the problem they're seeing, especially if a
> > command is running unusually slowly.
> >
> > Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  Documentation/git-bugreport.txt |  1 +
> >  bugreport.c                     | 52 +++++++++++++++++++++++++++++++++
> >  2 files changed, 53 insertions(+)
> >
> > diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> > index 4d01528540..4fe1c60506 100644
> > --- a/Documentation/git-bugreport.txt
> > +++ b/Documentation/git-bugreport.txt
> > @@ -32,6 +32,7 @@ The following information is captured automatically:
> >   - $SHELL
> >   - Selected config values
> >   - A list of enabled hooks
> > + - The number of loose objects in the repository
> >  
> >  This tool is invoked via the typical Git setup process, which means that in some
> >  cases, it might not be able to launch - for example, if a relevant config file
> > diff --git a/bugreport.c b/bugreport.c
> > index b5a0714a7f..fb7bc72723 100644
> > --- a/bugreport.c
> > +++ b/bugreport.c
> > @@ -10,6 +10,7 @@
> >  #include "bugreport-config-safelist.h"
> >  #include "khash.h"
> >  #include "run-command.h"
> > +#include "object-store.h"
> >  
> >  static void get_git_remote_https_version_info(struct strbuf *version_info)
> >  {
> > @@ -128,6 +129,54 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
> >  	}
> >  }
> >  
> > +static int loose_object_cb(const struct object_id *oid, const char *path,
> > +			   void *data) {
> > +	int *loose_object_count = data;
> > +
> > +	if (loose_object_count) {
> > +		(*loose_object_count)++;
> > +		return 0;
> > +	}
> > +
> > +	return 1;
> 
> What is the point of returning 1 here to abort the iteration early?
> Wouldn't it be a BUG() if this callback ends up gettting called with
> NULL in data?

Hrm. Wouldn't BUG() throw away the rest of the generated report?

Maybe it's better, in NULL case, to indicate an error occurred there and
write that information into the report, and continue gathering the rest
of the info.
