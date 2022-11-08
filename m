Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85513C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 20:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiKHU50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKHU5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 15:57:25 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F435D6B2
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 12:57:24 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id l6so8109575ilq.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 12:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qccqjQDPs9zkH0++YGHtOPeim7sZ+t4BwwmGrdraucg=;
        b=lhBOyOJ3w5t3NK0xVl9RDwUa51H20k6KcnHd/juqS8fcoQ997zX2j2Rl2z/zSNDY0c
         vgucd52VbIni82l2aO/gX48Q/GSMNyJ8tUlBO3nI6u72S7xdRqIg1hhBFVFFMQld1z5w
         LmXlsSz6c/N+06gBJdpJ9YX1gEkTlfDo82bv0sdxI7YfRoKQ4d1Uh4ro9txVSKXXrv1G
         NSUC4YAxY72KxV9wu1N3qb92twv6i8MYCvANwnbL3YywoxFclUs5e/yqnjLvdQmd+v5p
         ifEQ4LHq5iBXTD67eeGqVBlXh0KuWyen6mMPR9a6igFDgqPHl1w6QXFBPGI/4zoP+P7q
         Y8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qccqjQDPs9zkH0++YGHtOPeim7sZ+t4BwwmGrdraucg=;
        b=MXjgXfSOO1HqGY0Gh78Ax687KgU/v7KxmiGOhYm+PulRCRznfplvIAFzuaTxqLiB3g
         oGyKqUXWtoLkRUmoGrsymiNnrLIcx0eTrecds+TR+X1siRSTceFhEOgFKOaHS5aPcWNQ
         ac92qBO2Hso5cdEDgCfZrkU1HEuBNyabgQVKKXozkE3NZ9ZBShlFy3iRZ51cKOVDQaW6
         +7hU1z+UJfOLJERMBDOG4XpKOup9rkuWIs6PC+XU1ZACXlYS16vD4QOjOa65DM3mG6gZ
         8tQWP8l+osj//NyNTdTiuO+hIJOQ0Xa1rK8KVBw61s3Qmru5stt9gSq4IKVPJghcrnOF
         R+BQ==
X-Gm-Message-State: ACrzQf1743l0FiqNbRUHilfz4msUOzW7aRAcpHFRF+n8rSMsXmXuSRSM
        igvF5JNGJNFbYwEckq6rYdclxQ==
X-Google-Smtp-Source: AMsMyM4Rq4tLl2rS+ibKxT6MaEXDgn7g7K5HO1YRPFbAUaFBogLwPBZKMfaMuZW8n1uFSUyoaedLwg==
X-Received: by 2002:a92:cb03:0:b0:300:c605:5270 with SMTP id s3-20020a92cb03000000b00300c6055270mr986142ilo.199.1667941044022;
        Tue, 08 Nov 2022 12:57:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ck22-20020a0566383f1600b003636c5dcf29sm4023757jab.176.2022.11.08.12.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:57:23 -0800 (PST)
Date:   Tue, 8 Nov 2022 15:57:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org, me@ttaylor.com,
        derrickstolee@github.com
Subject: Re: [PATCH v2 2/2] maintenance: add option to register in a specific
 config
Message-ID: <Y2rCsq5y9TuCfrKC@nand.local>
References: <20221108194930.25805-1-ronan@rjp.ie>
 <20221108194930.25805-3-ronan@rjp.ie>
 <448cc6ed-c441-85a3-2780-0c07e56f53f8@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <448cc6ed-c441-85a3-2780-0c07e56f53f8@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 08:38:51PM +0000, Phillip Wood wrote:
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 24ea85c7af..1709355bce 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -1497,12 +1499,16 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
> >   	if (!found) {
> >   		int rc;
> > -		char *user_config, *xdg_config;
> > -		git_global_config(&user_config, &xdg_config);
> > -		if (!user_config)
> > -			die(_("$HOME not set"));
> > +		char *user_config = NULL, *xdg_config = NULL;
> > +
> > +		if (!config_file) {
> > +			git_global_config(&user_config, &xdg_config);
> > +			config_file = user_config;
>
> Here we need to decide whether to use user_config or xdg_config as the
> config file. In builtin/config.c we do this with
>
> 		if (access_or_warn(user_config, R_OK, 0) &&
> 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
> 			given_config_source.file = xdg_config;
> 			free(user_config);
> 		} else {
> 			given_config_source.file = user_config;
> 			free(xdg_config);
> 		}
>
> We need something similar here (maybe we should create a helper function to
> find the appropriate file)
>
> > +			if (!user_config)
> > +				die(_("$HOME not set"));
>
> This check needs to come before deciding which config file to use

True, but that problem existed before this series, too. So the new
behavior is no worse with respect to the XDG config stuff, and any
improvements to that behavior can be done independently on top.

Thanks,
Taylor
