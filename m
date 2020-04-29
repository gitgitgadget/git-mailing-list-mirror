Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C4C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D662C20B1F
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsONrs0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgD2Vtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726775AbgD2Vte (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 17:49:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3D8C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 14:49:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s10so1369417plr.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iNJk+RhlK2nhKND3UWWd3rYYwG1zXs9hR6GGy7Yrh28=;
        b=AsONrs0n4byK8pNrr1qC1gTFx6HvXFQTgrst0shASIAvWZjTUBRNdXLkMLegGYeEVL
         WnZkoqdesrRwcJtj61sVHhaPZ+1hQuCwTS4UpM55kGao32enFElwXFvQ0yyAy1Hyc3VZ
         kbweXUSXTj8RlRw4AZ6rkXNXvPV/YEYGNe4MLOu4oSCb0Jz3mBvrE2x+VFe+8iGjnN+p
         evNwZkS7Thd4NmuGVWX9eQfXdAxthylxmSxAFO991QREF0owNJABhVn3i3182756SoEi
         9+ydyfdzOPuEJ9Vy0W88ZCb7mOiZYu3jkDmD9v393XAqWbDmNjxCWHgptGsplzDYHL+j
         EYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iNJk+RhlK2nhKND3UWWd3rYYwG1zXs9hR6GGy7Yrh28=;
        b=SXkauJcIQdJsRUVCsSAs+kl+/7KE9DfdWKFv3nMTuyd05pIyl4Sxl59jmps0zU2Hjx
         ey7lXXAJnN3HrWACJB5q/azVeaJEZD2GsUo++7BIeexYWdINNrViiAh5dU3P72xLmEFt
         oDLnzTypLOt0OEQkGu2XsX++CrE4K3hexpiXyrk+EdrQragAp51MiG1plpGmyW+k8qoW
         EdFw58H30RV9HEl3EMundGdMiN0fTuPtuhYCTbndY2NLRQHevG+sSlmnEID9reLXkWMT
         qUZ2LHjoVRMGMed2lVUVwb/FbzcBwvaCXVg7d7Oe2gvjk8Hxvnjk9ruf82VIOWTNK7pg
         ovvQ==
X-Gm-Message-State: AGi0PuYqItd2rsfMcWP0+9Oz1Y4Q7WotRHsTABM7QwprVTEztlM40CHW
        dyOzNYr/rL4Qb6PvSfyO/wo=
X-Google-Smtp-Source: APiQypKrY+gaW0SrQjKbyE7cfRVquI4p7jR4dbsqy8oqxUF6rW5Ma3femR0TD3puzWLen+c+NHVPxQ==
X-Received: by 2002:a17:902:b7cc:: with SMTP id v12mr473861plz.39.1588196973473;
        Wed, 29 Apr 2020 14:49:33 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id n30sm1835284pfq.88.2020.04.29.14.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:49:33 -0700 (PDT)
Date:   Wed, 29 Apr 2020 14:49:31 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [RFC PATCH v6 2/2] credential-store: warn for any incomplete
 credentials instead of usingy
Message-ID: <20200429214931.GB33264@Carlos-MBP>
References: <20200429003303.93583-1-carenas@gmail.com>
 <20200429203546.56753-1-carenas@gmail.com>
 <20200429203546.56753-3-carenas@gmail.com>
 <xmqqk11yuhca.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk11yuhca.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 02:12:21PM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
> 
> > originally any credential found was tried for matching as far as it had
> > a username and password, but that resulted in fatal errors as the rules
> > were harden.
> 
> harden -> hardened
> 
> > now that we have a way to report malformed credentials, use it to notify
> > the user when username/password was missing, instead of just silently
> > skipping.
> 
> Sorry, but isn't that what happend already in the previous step?
> What are you ordering the codebase (after applying the previous
> stpe) do further?  It already is "using it to notify the user when
> username and/or password is missing".

not sure I follow, but the current code (as well as the one after patch 1)
just silently ignores any credential that was missing username and password
since the _gently version of the call will only really fail for a missing
protocol.

so patch1 will notify ONLY(*) when the credential is so malformed that we can't
figure out which protocol to use (like empty lines and comments)

(*) it will also fail if we have a '\n' in one of the components but that
is hopefully not relevant here.

> > diff --git a/credential-store.c b/credential-store.c
> > index 1cc5ca081a..53f77ff6f5 100644
> > --- a/credential-store.c
> > +++ b/credential-store.c
> > @@ -26,9 +26,10 @@ static int parse_credential_file(const char *fn,
> >  
> >  	while (strbuf_getline_lf(&line, fh) != EOF) {
> >  		lineno++;
> > -		if (!credential_from_url_gently(&entry, line.buf, 1)) {
> > -			if (entry.username && entry.password &&
> > -				credential_match(c, &entry)) {
> > +		if (!credential_from_url_gently(&entry, line.buf, 1) &&
> > +			((entry.host && *entry.host) || entry.path) &&
> > +			entry.username && entry.password) {
> > +			if (credential_match(c, &entry)) {
> 
> ... this makes the code even harder to follow than it already was
> after the previous step.  In the previous step, at least it was
> clear that we'd catch *all* the well-formed/parseable input will
> come into the first if () {...} block, but with the extra logic,
> that is no longer true.  Even a line that is well formed may be
> bypassed from matching and will be fed to "else" side.

I think it will be clearer with the reformatting you suggested and that I
agree is needed, but wanted to make sure first that we agreed on the direction.

FWIW the test cases show the format of the lines affected and while they are
parseable enough that were processed they were obviously not valid, specially
considering the updated rules.

maybe we should make the _gently version less gently instead?, so that callers
will be able to know they have an incomplete credential for matching after
calling it without having to do their own check?

if the later, I am affraid this will be a far bigger change, which is why I
would rather duplicate the rule checking for at least the first iteration.

Carlo
