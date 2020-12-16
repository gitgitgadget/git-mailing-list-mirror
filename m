Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AC4C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F34223731
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgLPXuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgLPXuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 18:50:00 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29533C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 15:49:20 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id v26so6260076pff.23
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 15:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=c4yoEcUyVYdUyOpfP8nH+5iiHTFA6F+Pr/AjIZ8vTUg=;
        b=qAnxV+eyJvhz2DBxZMzWGYOuZ17o5RsNQ7S573x/QBD5LxLuA6T94BbaWHF1mN3UV9
         IBd8wfmvivY98hHFSLQ4RyLDhVPCnapdt1+tEUOjC34VnglMd/jLzFQ87HSSsuXJ773p
         ZOYavgwaG11WvszUJHRT9kPWMnUqo+KHRUlIQZlGjkwRMgGeQmhb6PBeTNUFSRGf3goH
         acpUGvS1TB2XhQwS13TAHqxfHwwGZzQ+EYhrEiYWV0DR8FXqOO/LnQAm5NEWs7G61ETj
         RdhcUH5ZhQCKOmE41xhED8TLKmhD6HyAPIhuLbiSMoinoltIOfdu4Rpc/OEdZBvPTaWV
         p7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c4yoEcUyVYdUyOpfP8nH+5iiHTFA6F+Pr/AjIZ8vTUg=;
        b=W2sqTqQz2yM5KySDXzf+VJP2/2fBgAvo80+64VLz8yLZCMPAgOF0Drf7W37k0dKnre
         p/5Ih+dssjN8GBPmjz0Zc4W/GOTg7Cy6Mvk4pF0n3DaHLdeBgcohD4g1ef0lSn2U0FAc
         zFAX0FyamesiiSvlRUWRciErd614El83OC1+iyIKln7B/5IT6Oo2ULPjALNUUk2/aMcG
         hKKFqHmc30BUv5aY55XALaKXvhwfMmBxZgekPDSPL4OPGGsv9nCb5pgnhlm/TZcDVpVA
         uUkibZtTQR/nYY4SJSLRyEdeOqAE0ASqrfSlzZ175epG+W6pZ+5mq0zejrk2tpzHMYxJ
         NJ2g==
X-Gm-Message-State: AOAM5328lXbJ6ienIehyJDGltQzQ59gr/FIm4noVVHP3i/5EPR7ADhCd
        kCVGSRJY2VPOJ4qL35/sUKpBKmikJ4ApMJN4k7qF
X-Google-Smtp-Source: ABdhPJxnqXjvUfECiJBxIxXB/79VExRw6THp26nRu5yYu5kl4b6pSLYN19Xg/UsGxc4IDSJgMR4vwx94FNANjVTW3cJ1
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9198:0:b029:18b:3835:3796 with
 SMTP id x24-20020aa791980000b029018b38353796mr5620600pfa.9.1608162558760;
 Wed, 16 Dec 2020 15:49:18 -0800 (PST)
Date:   Wed, 16 Dec 2020 15:49:14 -0800
In-Reply-To: <xmqq1rfq5l8x.fsf@gitster.c.googlers.com>
Message-Id: <20201216234914.1671487-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq1rfq5l8x.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: Re: [PATCH v2 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        felipe.contreras@gmail.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -74,8 +79,28 @@ static int send_ref(const char *refname, const struct object_id *oid,
> >  	return 0;
> >  }
> >  
> > -static int ls_refs_config(const char *var, const char *value, void *data)
> > +static void send_possibly_unborn_head(struct ls_refs_data *data)
> >  {
> > +	struct strbuf namespaced = STRBUF_INIT;
> > +	struct object_id oid;
> > +	int flag;
> > +	int null_oid;
> 
> I'd suggest renaming this one, which masks the global null_oid of
> "const struct object_id" type.  This code does not break only
> because is_null_oid() happens to be implemented as a static inline,
> and not as a C-preprocessor macro, right?

OK - will rename.

> > +	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
> > +	resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
> > +	null_oid = is_null_oid(&oid);
> > +	if (!null_oid || (data->symrefs && (flag & REF_ISSYMREF)))
> > +		send_ref(namespaced.buf, null_oid ? NULL : &oid, flag, data);
> > +	strbuf_release(&namespaced);
> > +}
> > +
> > +static int ls_refs_config(const char *var, const char *value, void *cb_data)
> > +{
> > +	struct ls_refs_data *data = cb_data;
> > +
> > +	if (!strcmp("lsrefs.unborn", var))
> > +		data->allow_unborn = !strcmp(value, "allow") ||
> > +			!strcmp(value, "advertise");
> 
> Are there differences between allow and advertise?  Would
> lsrefs.allowUnborn that is a boolean, thus allowing the value to be
> parsed by git_config_bool(), make more sense here, I wonder.  Or is
> this meant as some future enhancement, e.g. you plan to have some
> servers that allow "unborn" request even though they do not actively
> advertise the support of the feature?  Without documentation update
> or an in-code comment, it is rather hard to guess the intention
> here.

I'll update the documentation. With this current patch, yes, some
servers will allow "unborn" requests even though they do not actively
advertise it. This allows servers in load-balanced environments to first
be configured to support the feature, then after ensuring that the
configuration for all servers is complete, to turn on advertisement.

> > @@ -91,7 +116,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
> >  
> >  	memset(&data, 0, sizeof(data));
> >  
> > -	git_config(ls_refs_config, NULL);
> > +	git_config(ls_refs_config, &data);
> >  
> >  	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
> >  		const char *arg = request->line;
> > @@ -103,14 +128,35 @@ int ls_refs(struct repository *r, struct strvec *keys,
> >  			data.symrefs = 1;
> >  		else if (skip_prefix(arg, "ref-prefix ", &out))
> >  			strvec_push(&data.prefixes, out);
> > +		else if (data.allow_unborn && !strcmp("unborn", arg))
> > +			data.unborn = 1;
> 
> Somehow, it appears to me that writing it in a way along with this
> line ...
> 
> 		else if (!strcmp("unborn", arg))
> 			data.unborn = data.allow_unborn;
> 
> ... would make more sense.  Whether we allowed "unborn" request or
> not, when the other side says "unborn", we are handling the request
> for the unborn feature, and the condition with strcmp() alone
> signals that better (in other words, when we acquire more request
> types, we do not want to pass the control to "else if" clauses that
> may come after this part when we see "unborn" request and when we
> are configured not to accept "unborn" requests.
> 
> It does not make any difference in the current code, of course, and
> it is more about future-proofing the cleanness of the code.

Good point. I'll go ahead and write it as you describe.

I was following the style in upload-pack, where writing it my way versus
your way would make a difference because we die on invalid arguments at
the end. (It does raise the question whether we should die on invalid
arguments, but maybe that's for another time.)

> 
> > -	head_ref_namespaced(send_ref, &data);
> > +	if (data.unborn)
> > +		send_possibly_unborn_head(&data);
> > +	else
> > +		head_ref_namespaced(send_ref, &data);
> 
> I found the "send_possibly 70% duplicates what the more generic
> head_ref_namespaced() does" a bit disturbing.

There's more duplication in refs.c (e.g. head_ref_namespaced() and
refs_head_ref()) too. I'll see if I can refactor those into something
more generic.

