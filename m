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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71201C4BA06
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0937B24687
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7+HY+3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgBYX0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:35 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52947 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbgBYX0d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:33 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep11so426490pjb.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 15:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gnLakP5da4v3NWLdJFMyCL1L2JCkDCkiNcdS5YnOam8=;
        b=h7+HY+3nBNdWDX9T+D/kLSfTwHQu8IDifdYru1j+Ke0AgbLwOv6T9MZ3EQN564N2Ay
         1m0+9/jETJxi3b0w3ScdiMmNZ2wgI+al2AJc1b32wBYdeuXDYeHrfOUKw3mJ1mWyREB4
         WO4yssZGy07qXCleQDJE1FL4sOtV17GFS26m6A8bU6v7Tl1W1Bo18pdtqHM7FT6TWazZ
         aCPtyeLusktGZUjwN8/ZWhFgQLpJcvTdedey9aBji74+sOPSNf+825HPAaEh9k32/IDa
         J3oU0vK6RLTYllefNH49X5CL9w1VsDcekem5l63ObxaT8p0Ye4rbmZ+0Xn+EHVYTSXd1
         fMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gnLakP5da4v3NWLdJFMyCL1L2JCkDCkiNcdS5YnOam8=;
        b=brCW4juikso4pI/QnXwORtmH1gVGbrrDSNWgJ1Bo0uC60RwQxQ3gyXm30qu7f2qHtr
         6cTpeEH+IS6WLjOwTkpA+s90ke1NIyApAwoUhY4XEHdaJSRqaMGqJJYeO0AMMqgfqPVu
         dvbph//0e7t0jzLLn008EbBZ00aIjVubA0GxLtOAZ6fsfWWsT8nS0ELeFbamVMJdEpSM
         RF747NExCrc+uHNFQyUugClJPuJRG8yjCzRUzjEHP9cNjyM4Tn0/yTZXnA/2kS8r1V+H
         3WAIhjcoFpCqj+y3tWkDK8JoJvc8qyjaansJ1jTfjTu+PWB+/5gQRZfe+sOrk33eA2/s
         AFew==
X-Gm-Message-State: APjAAAUlTpZfZKJAHzFxjWT/EJ9zYV7mjFyejzYgd3hk0EXTH+vgtqIg
        fX/u9BypsrNO+TLtoceY5MiUqg==
X-Google-Smtp-Source: APXvYqxp5mv6TdFcMVr4O9HBgSBNiTpPU0y8yLu3rPyAEVuWV747FEu3g94UxFPCxmAf4PbhSUdWKw==
X-Received: by 2002:a17:902:9b93:: with SMTP id y19mr926103plp.89.1582673191781;
        Tue, 25 Feb 2020 15:26:31 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id f13sm177062pfk.64.2020.02.25.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 15:26:31 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:26:26 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 12/15] bugreport: count loose objects
Message-ID: <20200225232626.GE212281@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-13-emilyshaffer@google.com>
 <xmqqa75d9di6.fsf@gitster-ct.c.googlers.com>
 <20200225232200.GD212281@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225232200.GD212281@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 25, 2020 at 03:22:00PM -0800, Emily Shaffer wrote:
> On Thu, Feb 20, 2020 at 01:04:33PM -0800, Junio C Hamano wrote:
> > Emily Shaffer <emilyshaffer@google.com> writes:
> > 
> > > The number of unpacked objects in a user's repository may help us
> > > understand the root of the problem they're seeing, especially if a
> > > command is running unusually slowly.
> > >
> > > Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > > ---
> > >  Documentation/git-bugreport.txt |  1 +
> > >  bugreport.c                     | 52 +++++++++++++++++++++++++++++++++
> > >  2 files changed, 53 insertions(+)
> > >
> > > diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> > > index 4d01528540..4fe1c60506 100644
> > > --- a/Documentation/git-bugreport.txt
> > > +++ b/Documentation/git-bugreport.txt
> > > @@ -32,6 +32,7 @@ The following information is captured automatically:
> > >   - $SHELL
> > >   - Selected config values
> > >   - A list of enabled hooks
> > > + - The number of loose objects in the repository
> > >  
> > >  This tool is invoked via the typical Git setup process, which means that in some
> > >  cases, it might not be able to launch - for example, if a relevant config file
> > > diff --git a/bugreport.c b/bugreport.c
> > > index b5a0714a7f..fb7bc72723 100644
> > > --- a/bugreport.c
> > > +++ b/bugreport.c
> > > @@ -10,6 +10,7 @@
> > >  #include "bugreport-config-safelist.h"
> > >  #include "khash.h"
> > >  #include "run-command.h"
> > > +#include "object-store.h"
> > >  
> > >  static void get_git_remote_https_version_info(struct strbuf *version_info)
> > >  {
> > > @@ -128,6 +129,54 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
> > >  	}
> > >  }
> > >  
> > > +static int loose_object_cb(const struct object_id *oid, const char *path,
> > > +			   void *data) {
> > > +	int *loose_object_count = data;
> > > +
> > > +	if (loose_object_count) {
> > > +		(*loose_object_count)++;
> > > +		return 0;
> > > +	}
> > > +
> > > +	return 1;
> > 
> > What is the point of returning 1 here to abort the iteration early?
> > Wouldn't it be a BUG() if this callback ends up gettting called with
> > NULL in data?
> 
> Hrm. Wouldn't BUG() throw away the rest of the generated report?
> 
> Maybe it's better, in NULL case, to indicate an error occurred there and
> write that information into the report, and continue gathering the rest
> of the info.

Oh, hm. Now that I look twice, you're saying "bugreport gave its own
callback a NULL". I guess it could also be that
for_each_loose_object() decided to give a NULL context instead of the
one we gave...

Even so, I dislike the idea of BUG() called from the tool you are trying
to use to report a BUG() message. We do already report if 1 was returned
"(problem during count)". I suppose I can try and make a more specific
error if we know the callback data was definitely the problem.

 - Emily
