Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0217CC4BA06
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC322176D
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K27UVOAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgBYXTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:19:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34530 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgBYXTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 18:19:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so399927pfc.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 15:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+RWLhvnL0XeSPMnbQQvPqBKew03S38PPpyp/wwXyCl0=;
        b=K27UVOAAzeALVTf+QlpIukuwpLYsn2u6vgfUH7Kb/4EUBPKXZVSl4XtFeyY/Jc+4qE
         oTTKCWMbs+Gw/Kxv2m0czM3Sr4uSVPhKqWq0jBANGSBjKddJ1x4BZbA5NnoVR2wrshte
         q8U3igYrnkKvwtuDzmBafGlvUomLnxoCAEEukZ5Iwg+Hxh44U+t5pe9Vs6gEME/p0Xvb
         uoZIC+ug69o/YY/mB2ywBs5rpRH8UMsfFVE3FQtl4HoxPxDvrMHwnLZB4AqrP5w3HZfs
         1GnNTue5BYYWvMhleddoEZr00qTmFv0PScX76v1Til6BAQaX/Ngpv3i2FnekYZ5Wtnsa
         hHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+RWLhvnL0XeSPMnbQQvPqBKew03S38PPpyp/wwXyCl0=;
        b=ZWNOIR+jEl3PebEvTLJ/skm/kQHPQ3LQVcLx0LLZUiZZzzONDCGdLNJMu78DfDDb41
         w1lo0FX2sEKIKM64Ws0xQgZEm64Ax6jyqrSPuQ3yMolmMYXfzvcS83sBISXjtBj09Tqq
         rejDrIIbUMF+7/kuSDinxIYYeRHfWpSz8e9NckNEzw903OWF5VljglwzYNF93ov6DUDV
         HVuGDa4qpt35IakwIS1DMs0FBWPnOpcgDNSQPXSMo0FGNK4sHxFs1wcDNt+BNF5J2L9W
         kbylGFS2VKL1YHCd73KfG52h3xud+rTtVkVUSMNlO9bygub4ywnq3cpj1CNtuz9oLwei
         g6Og==
X-Gm-Message-State: APjAAAWFk1OGu8KRpZ0xdK8nwFqZk17wL2PKJcuiVmXTDNDaAPhZKPlx
        vmbFxR6cpvosd+tZuMpmYDUwWp17hIo=
X-Google-Smtp-Source: APXvYqyQBZ7f/l+/oBF4hekL3383vY/OYmAl9nNvCmIZ37XkHGKvL3nJBfPADTua+QwO4z4zfgT0eQ==
X-Received: by 2002:a62:547:: with SMTP id 68mr1103132pff.217.1582672763197;
        Tue, 25 Feb 2020 15:19:23 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id g9sm147667pfm.150.2020.02.25.15.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 15:19:22 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:19:18 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 11/15] bugreport: collect list of populated hooks
Message-ID: <20200225231918.GC212281@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-12-emilyshaffer@google.com>
 <xmqqeeup9ds7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeeup9ds7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 12:58:32PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +static void get_populated_hooks(struct strbuf *hook_info, int nongit)
> > +{
> > +	/*
> > +	 * Doesn't look like there is a list of all possible hooks; so below is
> > +	 * a transcription of `git help hooks`.
> > +	 */
> 
> It may want to become a NEEDSWORK comment.

Oh, good point. I'll rephrase it.
> 
> > +	const char *hooks = "applypatch-msg,"
> > +			    "pre-applypatch,"
> > +			    "post-applypatch,"
> > +			    "pre-commit,"
> > +			    "pre-merge-commit,"
> > +			    "prepare-commit-msg,"
> > +			    "commit-msg,"
> > +			    "post-commit,"
> > +			    "pre-rebase,"
> > +			    "post-checkout,"
> > +			    "post-merge,"
> > +			    "pre-push,"
> > +			    "pre-receive,"
> > +			    "update,"
> > +			    "post-receive,"
> > +			    "post-update,"
> > +			    "push-to-checkout,"
> > +			    "pre-auto-gc,"
> > +			    "post-rewrite,"
> > +			    "sendemail-validate,"
> > +			    "fsmonitor-watchman,"
> > +			    "p4-pre-submit,"
> > +			    "post-index-changex";
> 
> Typo here?

Yep, I imagine from trying to press 'x' to remove the ',' from my list.

> 
> > +	struct string_list hooks_list = STRING_LIST_INIT_DUP;
> > +	struct string_list_item *iter = NULL;
> > +
> > +
> > +	if (nongit) {
> > +		strbuf_addstr(hook_info,
> > +			"not run from a git repository - no hooks to show\n");
> > +		return;
> > +	}
> > +
> > +	string_list_split(&hooks_list, hooks, ',', -1);
> > +
> > +	for_each_string_list_item(iter, &hooks_list) {
> 
> I do not get why you want to use string_list for this, especially if
> you need to use string_list_split.
> 
> To me,
> 
> 	int i;
> 	const char *hook[] = {
> 		"applypatch-msg",
> 	        "pre-applypatch",
> 		...
> 		"post-index-change",
> 	};
> 
> 	for (i = 0; i < ARRAY_SIZE(hook); i++) {
> 		if (hook[i] is enabled)
> 			strbuf_addf(hook_info, "%s\n", hook[i]);
> 	}
> 
> would be far easier to understand.  Do you have an external source
> that can feed you a single long string of comma separated hook names
> in mind, so that the initialization of *hooks will become simpler
> that way, or something?

Huh. I'm having a hard time remembering why I did it this way. I think I
wanted to use the string_list foreach? But you're right that it is
pretty hard to understand, plus expensive; I'll just use an array like
you suggest.

> 
> > +		if (find_hook(iter->string)) {
> > +			strbuf_addstr(hook_info, iter->string);
> > +			strbuf_complete_line(hook_info);
> > +		}
> > +	}
> > +}
> > +
> >  static const char * const bugreport_usage[] = {
> >  	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
> >  	NULL
> > @@ -166,6 +216,9 @@ int cmd_main(int argc, const char **argv)
> >  	get_header(&buffer, "Safelisted Config Info");
> >  	get_safelisted_config(&buffer);
> >  
> > +	get_header(&buffer, "Enabled Hooks");
> > +	get_populated_hooks(&buffer, nongit_ok);
> > +
> >  	report = fopen_for_writing(report_path.buf);
> >  
> >  	if (report == NULL) {
