Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA33EC433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CE364DE7
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhA2U1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhA2UXu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 15:23:50 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCFEC06174A
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 12:23:10 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a12so6602433pfh.19
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 12:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1N228hJVzapqTyw83zvaMhzJdXGnanU1k57WkykZW4Q=;
        b=rOzbsD2ncQjIdzJV0rku0iAQeOkGVOl1+3uqXHR26P4UyqQcuuu2sFsOtNTa4H+BMN
         0z9dhkEtru4h9W2cWAoV9gmratUDRfN+jWuwun5f/0pzGebOlh56ZCH+XwSc3lY9AXOW
         HOacD6XA+aAgO+iYRNIzZir6gMPvpl69nw+VQfiR+OH3wB7G8pCQB5pR53ZMR9LM2hZq
         ldVE324DWByScJZcEW+uHE3eIh4L7UYlZr3UMFcDHV6v+ObowIOGF8L/jRbvyTJsPxQ8
         wTGW5zeW29VE+CG2obM33/2XnIsWymV7AJFe23CuPZR4V5zgkDb0KN/xbSnzKZkL2RtW
         rwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1N228hJVzapqTyw83zvaMhzJdXGnanU1k57WkykZW4Q=;
        b=gATEY4g3SzK+ru1eC3G66Ie1n0mPriMbBQVii6LxJu17WK5Nw7IRNp2dhgHt/7mNQs
         R06yrDnxfLmRx5bDLaSgR4rfIkeCEzEuRwZf4U4ApVvixWlXYgP4mdLZugWrf8KNU2Y0
         +0RIG1F8fRTFLtk6m0zunpjlJu7BB9DSHntHr/mkNo2Srw25S9agdFtDkJqiYAcJo2Dk
         i4g2htqmYKotMMRQKzei5vBozYaHzlavtMW/6XFrhNLjcEmK9vftrjeUnbH+eogfHzBX
         ErHVolqKALW0QO6V5gNj+66Wj2UmqoTf1CDKeCsbPMInZvAWDa2cFDx9j9tpkubB2typ
         npZQ==
X-Gm-Message-State: AOAM530+KtlbtevHOAxo3vqbfWAV2RXmhJd5uxfFO96NoaH3TU+nj5Op
        xezNEbXX8yd+zGzKpkTcUFVEqsFD6/FTtTZEPU64
X-Google-Smtp-Source: ABdhPJz4g8l8HOZk4V22qAsmFulDUHzQ3KWWcc4yfTYOQteq71XKL4DGBkQAkGy/Ls9JRFFxnx6D6QLhwi85pyiTTZwn
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:9295:0:b029:1b7:b74f:75b1 with
 SMTP id o143-20020a6292950000b02901b7b74f75b1mr5691010pfd.67.1611951790028;
 Fri, 29 Jan 2021 12:23:10 -0800 (PST)
Date:   Fri, 29 Jan 2021 12:23:06 -0800
In-Reply-To: <xmqq8s8f1iqe.fsf@gitster.c.googlers.com>
Message-Id: <20210129202306.723272-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq8s8f1iqe.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -47,7 +49,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
> >  	if (!ref_match(&data->prefixes, refname_nons))
> >  		return 0;
> >  
> > -	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> > +	if (oid)
> > +		strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> > +	else
> > +		strbuf_addf(&refline, "unborn %s", refname_nons);
> 
> When a call is made to this helper with NULL "oid", it unconditionally
> sends the "refname" out as an 'unborn' thing.  If data->symrefs is not
> true, or flag does not have REF_ISSYMREF set, then we'd end up
> sending
> 
>     "unborn" SP refname LF
> 
> without any ref-attribute.  The caller is responsible for ensuring
> that it passes sensible data->symrefs and flag when it passes
> oid==NULL to this function, but it is OK because this is a private
> helper.
> 
> OK.

Thanks for checking.

> >  	if (data->symrefs && flag & REF_ISSYMREF) {
> >  		struct object_id unused;
> >  		const char *symref_target = resolve_ref_unsafe(refname, 0,
> > @@ -74,8 +79,30 @@ static int send_ref(const char *refname, const struct object_id *oid,
> >  	return 0;
> >  }
> >  
> > -static int ls_refs_config(const char *var, const char *value, void *data)
> > +static void send_possibly_unborn_head(struct ls_refs_data *data)
> >  {
> > +	struct strbuf namespaced = STRBUF_INIT;
> > +	struct object_id oid;
> > +	int flag;
> > +	int oid_is_null;
> > +
> > +	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
> > +	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
> > +		return; /* bad ref */
> > +	oid_is_null = is_null_oid(&oid);
> > +	if (!oid_is_null ||
> > +	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
> > +		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
> 
> And this caller makes sure that send_ref()'s expectation holds.

Thanks for checking.

> > +	strbuf_release(&namespaced);
> > +}
> > +
> > +static int ls_refs_config(const char *var, const char *value, void *cb_data)
> > +{
> > +	struct ls_refs_data *data = cb_data;
> > +
> > +	if (!strcmp("lsrefs.allowunborn", var))
> > +		data->allow_unborn = git_config_bool(var, value);
> > +
> >  	/*
> >  	 * We only serve fetches over v2 for now, so respect only "uploadpack"
> >  	 * config. This may need to eventually be expanded to "receive", but we
> > @@ -91,7 +118,8 @@ int ls_refs(struct repository *r, struct strvec *keys,
> >  
> >  	memset(&data, 0, sizeof(data));
> >  
> > -	git_config(ls_refs_config, NULL);
> > +	data.allow_unborn = 1;
> > +	git_config(ls_refs_config, &data);
> 
> The above is a usual sequence of "an unspecified allow-unborn
> defaults to true, but the configuration can turn it off".  OK

Later, you address this issue again so I'll comment there.

> > @@ -103,14 +131,31 @@ int ls_refs(struct repository *r, struct strvec *keys,
> >  			data.symrefs = 1;
> >  		else if (skip_prefix(arg, "ref-prefix ", &out))
> >  			strvec_push(&data.prefixes, out);
> > +		else if (data.allow_unborn && !strcmp("unborn", arg))
> > +			data.unborn = 1;
> 
> I think the use of &&-cascade is iffy here.  Even when we are *not*
> accepting request for unborn, we should still parse it as such.
> This does not matter in today's code, but it is a basic courtesy for
> future developers who may add more "else if" after it.
> 
> IOW
> 
> 		else if (!strcmp("unborn", arg)) {
> 			if (!data.allow_unborn)
> 				; /* we are not accepting the request */
> 			else
> 				data.unborn = 1;
> 		}
> 
> I wrote the above in longhand only for documentation purposes; in
> practice, 
> 
> 		else if (!strcmp("unborn", arg))
>                 	data.unborn = data.allow_unborn;
> 
> may suffice.

My thinking was (and is) that falling through in the case of a
disallowed argument (as opposed to a completely unrecognized argument)
makes it more straightforward later if we ever decide to tighten
validation of the ls-refs request - we would only have to put some code
at the end that reports back to the user.

If we write it as you suggest, we would have to remember to replace the
"we are not accepting the request" part (as in the comment in your
suggested code) with an error report, but perhaps that is a good thing -
we would be able to insert a custom error message instead of an
information-hiding "argument not supported".

I'm OK either way.

> >  	}
> >  
> >  	if (request->status != PACKET_READ_FLUSH)
> >  		die(_("expected flush after ls-refs arguments"));
> >  
> > -	head_ref_namespaced(send_ref, &data);
> > +	send_possibly_unborn_head(&data);
> >  	for_each_namespaced_ref(send_ref, &data);
> 
> And here is another caller of send_ref().  Are we sure that
> send_ref()'s expectation is satisfied by this caller when the
> iteration encounters a broken ref (e.g. refs/heads/broken not a
> symref but names an object that does not exist and get_sha1()
> yielding 0{40}), or a dangling symref (e.g. refs/remotes/origin/HEAD
> pointing at something that does not exist)?

I assume that by "this caller" you mean for_each_namespaced_ref(), since
you mention an iteration. I believe so - send_ref has been changed to
tolerate a NULL (as in (void*)0, not 0{40}) oid, and that is the only
change, so if it worked previously, it should still work now.

> >  	packet_flush(1);
> >  	strvec_clear(&data.prefixes);
> >  	return 0;
> >  }
> > +
> > +int ls_refs_advertise(struct repository *r, struct strbuf *value)
> > +{
> > +	if (value) {
> > +		int allow_unborn_value;
> > +
> > +		if (repo_config_get_bool(the_repository,
> > +					 "lsrefs.allowunborn",
> > +					 &allow_unborn_value) ||
> > +		    allow_unborn_value)
> > +			strbuf_addstr(value, "unborn");
> > +	}
> 
> This reads "when not explicitly disabled, stuff "unborn" in there".
> 
> It feels somewhat brittle that we have to read the same variable and
> apply the same "default to true" logic in two places and have to
> keep them in sync.  Is this because the decision to advertize or not
> has to be made way before the code that is specific to the
> implementation of ls-refs is run?
> 
> If ls_refs_advertise() is always called first before ls_refs(), I
> wonder if it makes sense to reuse what we found out about the
> configured (or left unconfigured) state here and use it when
> ls_refs() gets called?  I know that the way serve.c infrastructure
> calls "do we advertise?" helper from each protocol-element handler
> is too narrow and does not allow us to pass such a necessary piece
> of information but I view it as a misdesign that can be corrected
> (and until that happens, we could use file-local static limited to
> ls-refs.c).

Perhaps what I could do is have a static variable that tracks whether
config has been read and what the config is (or if the default variable
is used), and have each function call another function that sets that
static variable if config has not yet been read. I think that will
address this concern.
