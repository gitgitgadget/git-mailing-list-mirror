Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE05AC433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 04:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F2960C3D
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 04:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhA3EVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 23:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhA3EGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 23:06:55 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3055C06121C
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 20:06:15 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id h13so7584259qvo.18
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 20:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ynLAjyfWlU+zTYDJ+MryTUlsHIjSOCACHPRkN8be9PY=;
        b=AD43M0CN5ET1MOvryPkxh3IayeSWHMLIA+P1KMTmPmHKmtVsVFhK2OzaYoSZk0AfCD
         tkpI34iOTlZBJn/6zSo0f4/siQXzwoGwQFOBuCsvmd0OmF2bWHCOBFoMJDxWrPqJnbrZ
         NUvRv/FXKHeh2jdm5ET7sCuHBooWd0/j/putZdH63zLi7gHhSpQxRzkV2zYaglZF/TSJ
         WUodBZ/Sqq2f5Suet0FEtqo03ZFsqBMMljusC88iPESn1FKzxuNp+RlPENPKvvOArGff
         1z5gME6PL8S2Fl0dJN1BoMLZYM6KALC8XoWlvg5RDWPFe9btNu30/cNLGf6raqE5RYcV
         AJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ynLAjyfWlU+zTYDJ+MryTUlsHIjSOCACHPRkN8be9PY=;
        b=FULpqAyKGVXKH5Dt/D+NMryVO7sA57mDEW4+QujD/8MZuZx36TYQgtmR1hRXNHA1PB
         O1wGuEBeEwhWSDbOBR0dcSSdjFMgkr/dXdC968udZOUNIsO9Ap11ACeF3in8G/ZLO3n5
         WElb/d5mW987cLa/U3B01iGzyfi7d/o9B1TVJskDeKYT6SDKPFzEY9OpPpOEsTLvOS2c
         Aa7AjNaNAj4oooHJyry97Jl89waf/BSCYQruayzyNx/lLHX4/p0z0XpzZxJk9UPpmyQi
         IaG4DBqNaArJi2rdwA4eS9G3D8PEB5kMXwjzj4+Ws7AmO2WoDt7HgXxXKCGzQr3WhSTd
         efKA==
X-Gm-Message-State: AOAM5309R1OxkNCv+HT8rq3dcX+hAHC7/4cpA8MBq2NXcobBPK+72WZh
        UqxzkFDRaKdNxipacxwW/E0tuolkkEykb6eaqqsC
X-Google-Smtp-Source: ABdhPJy2TL7/5DRLjUxmJ5ov3QISCFmenTlOybdBIa7SU7Qxba7w+StF9fMPLY2Vkidwso16AfkRR+OgiVtfmuhJLgEB
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:b292:: with SMTP id
 r18mr7025415qve.35.1611979574803; Fri, 29 Jan 2021 20:06:14 -0800 (PST)
Date:   Fri, 29 Jan 2021 20:06:13 -0800
In-Reply-To: <xmqq4kj31hzn.fsf@gitster.c.googlers.com>
Message-Id: <20210130040613.800403-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq4kj31hzn.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v5 2/3] connect, transport: encapsulate arg in struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> > index 58b7c1fbdc..c2d96f4c89 100644
> > --- a/builtin/fetch-pack.c
> > +++ b/builtin/fetch-pack.c
> > @@ -220,7 +220,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
> >  	version = discover_version(&reader);
> >  	switch (version) {
> >  	case protocol_v2:
> > -		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL, args.stateless_rpc);
> > +		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL,
> > +				args.stateless_rpc);
> >  		break;
> 
> This seems to be an unrelated line-wrapping, but there are overlong
> lines that are longer than this line in the same function.

Ah...I'll undo this in the next version.

> Everything else looks sensible to change the assumption that a strvec
> is sufficient for the communication in the codepaths and make it more
> easily extended by passing a ls-refs-options structure, which makes
> quite a lot of sense.
> 
> > diff --git a/transport.h b/transport.h
> > index 24558c027d..1f5b60e4d3 100644
> > --- a/transport.h
> > +++ b/transport.h
> > @@ -233,17 +233,24 @@ int transport_push(struct repository *repo,
> >  		   struct refspec *rs, int flags,
> >  		   unsigned int * reject_reasons);
> >  
> > +struct transport_ls_refs_options {
> > +	/*
> > +	 * Optionally, a list of ref prefixes can be provided which can be sent
> > +	 * to the server (when communicating using protocol v2) to enable it to
> > +	 * limit the ref advertisement.  Since ref filtering is done on the
> > +	 * server's end (and only when using protocol v2),
> > +	 * transport_get_remote_refs() could return refs which don't match the
> > +	 * provided ref_prefixes.
> > +	 */
> > +	struct strvec ref_prefixes;
> > +};
> > +#define TRANSPORT_LS_REFS_OPTIONS_INIT { STRVEC_INIT }
> > +
> 
> And of course, the first step only carries the strvec we have been
> passing around, i.e. does not lose or gain features.
> 
> Looking good.  Thanks.

Thanks for taking a look.
