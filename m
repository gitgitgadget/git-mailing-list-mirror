Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6227DC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449CC60C3F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhHDViQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 17:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhHDViP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 17:38:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA5C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 14:38:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k2so4504829plk.13
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=J/e213B4idfz7DUGFpV2dKw64V70fYgeFsF0NgQfm8Y=;
        b=PU1iJYWjYZ2HPmEUsuNVAQzkbfnLhcIPRymXqdODjoGu/Tpnsri5OtgoXmfBVqLvd0
         KPf+JgyyGJenp0zBc9j6x0LsoVyw0w5/6H54AKNS+NqRvBpra7gUpBnlt2ifW4z2j2Vo
         X3gZj9/49qhDrI/Rc6q85FsQgwXPNdswHEuIBYQSFSCgkJMYhJfirEmDp4S5TC9oWFvM
         VMD7EaXZy/NrNWLUsY8AbFqs8WxzXvIXHgEinhVsbi7QijfCx44yQI+EXNIQL2fU3GWw
         WuowQBBvWpgleh2SrfnOHJYKMsTY45HqjmGwTstmWYEnNH0cLduYt+U/uHJeoCErhnpL
         Omrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=J/e213B4idfz7DUGFpV2dKw64V70fYgeFsF0NgQfm8Y=;
        b=q5ywXq5c66VRF2g4p3/sKoG212sCvjP57cFI0gXYRsiPB28GCkTScQH7R0MWRydXUv
         /M6Tb2uygS7Ap/B5e4gV03H6BXlb+zjy0h+zGZbo+qCWHnusPJoGHGV35/FHHniVUdsA
         4V6sfoaS7UparoMCBBCcKnNCzwx23PsJOUTJq6HmklIZ1nSrIG+iXh7rr9hvkeBmFViA
         oZSVP9AIep+qwv4cXZlEYBNADnLL1TFNTahDtJDWHb7cJMMsLuFYlgIwbXarNcJYQ7+g
         CGaXg1IvoqaH1ZTcVCSDFkrJPikG7QySFmz0Xe2wWmC6wRymTcrwTjMdLlfaQ9CAKmIg
         kTKA==
X-Gm-Message-State: AOAM533JKCdkRL/luDknG0Pwl6Hu/ZbVPeM0Wcdpb4ReiTe0ctd1MJhz
        cBacSQLnAFRJonsg5KV7IW0WqQ==
X-Google-Smtp-Source: ABdhPJyRybEc0qmX3D+s0q56r32pfdOayXWTUvGBa/zvv4EMDbxxB0h1WNLfDi/1c6T6JihuVOd4Tw==
X-Received: by 2002:a65:4386:: with SMTP id m6mr1077441pgp.430.1628113080874;
        Wed, 04 Aug 2021 14:38:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:9758:1083:3c28:c541])
        by smtp.gmail.com with ESMTPSA id z15sm4644428pgc.13.2021.08.04.14.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 14:37:59 -0700 (PDT)
Date:   Wed, 4 Aug 2021 14:37:53 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] connect, protocol: log negotiated protocol version
Message-ID: <YQsIscghtbpKI/OI@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <f79ab95af6da3da710da2112cfcae4a042b7f7fb.1628020616.git.steadmon@google.com>
 <YQmxSxTswHE/gTet@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQmxSxTswHE/gTet@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.08.03 17:12, Taylor Blau wrote:
> On Tue, Aug 03, 2021 at 01:13:02PM -0700, Josh Steadmon wrote:
> > [...] Therefore, log the negotiated wire protocol version via trace2,
> > for both clients and servers.
> 
> Seems useful, thanks.
> 
> > Do people have a preference for logging this as an integer (and
> > therefore having "unknown protocol version" show up as "-1", or should I
> > add a protocol_version_to_string function so that we can format it
> > properly? For now I've erred on the side of having a smaller diff.
> 
> I probably have a slight preference for converting the protocol_version
> to a string and passing that along to trace2_data_string() instead. That
> would let you more cleanly log "<unknown>", without needing to expose
> implementation details like which enum has what value.

V2 will include a format_protocol_version().


> > diff --git a/connect.c b/connect.c
> > index 70b13389ba..6e23e3ff2d 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -164,6 +164,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
> >  		BUG("unknown protocol version");
> >  	}
> >
> > +	trace2_data_intmax("transfer", NULL, "negotiated-version", version);
> 
> Small nit-pick, this could come between the two switch statements, not
> at the end of the function (since we know what we are going to return
> before we switch on version.

Fixed in V2.


> (I was a little surprised to see that these functions now have the
> side-effect of writing to trace2, since I would have instead expected
> to see new lines added at the callers. But this makes it more
> convenient, and I do not feel strongly about it)
> 
> In any case, connect.c:discover_version() is handling the client side,
> but...
> 
> > diff --git a/protocol.c b/protocol.c
> > index 052d7edbb9..3791d8499e 100644
> > --- a/protocol.c
> > +++ b/protocol.c
> > @@ -89,5 +89,6 @@ enum protocol_version determine_protocol_version_client(const char *server_respo
> >  			die("protocol error: server explicitly said version 0");
> >  	}
> >
> > +	trace2_data_intmax("transfer", NULL, "negotiated-version", version);
> >  	return version;
> >  }
> > --
> 
> This function is used by discover_version to parse the server's
> response. If you are trying to log what protocol was agreed on from the
> server's perspective, I think you are looking instead for
> determine_protocol_version_server().
> 
> If you aren't (and are only interested in the client's point-of-view),
> then I am pretty sure that this latter hunk is redundant.

Thanks for catching this dumb mistake. Fixed in V2, and added tests to
make sure the trace message shows up on both client- & server-side.

> Thanks,
> Taylor
