Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6373FC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 20:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292102054F
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 20:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2K+tGtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLKUvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:51:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36591 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLKUvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 15:51:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so62016pll.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 12:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nG/bXOJENM86vE+p2/GUpauessKm2EW/1tNAcxd3r+Q=;
        b=k2K+tGtL16l/5yhXev0ZvkQuAcD1gmRtmgkYddDtXtOq4SVoV5ZA1UeHvJj5Zpl+Fo
         MtaxgObYwV8dD7Mdgo1BWgrtwdFspI/2K0FB2NCOajMEPIaztBCNzYhoD1lMiZuaASJI
         2TRTMgKt1ku4bhWv/qPBTE/b2GMK7vv5E1PddN18dmpWt2erKHgQxPTtRA/D1EKUgOzw
         c4OOH4NijMjZ4mt6BBFKwxWU2C2G7sECYcG0VhMt5mEQ2AClNhB5air5ArD/6KINtKxd
         T/LIt1atPeyBpJSvAnZn9Szm9Eyz5saKrO9titWxh+P4AJrtFvcNgYG3YzUCTaM09O9h
         AuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nG/bXOJENM86vE+p2/GUpauessKm2EW/1tNAcxd3r+Q=;
        b=myuaSBVVoRp0szupsLvEJbaxkZInmFKDlh2fLiPGu2eue7AB2yi3pyPIshCxp8TgvG
         bVO59QgdxZ8ijklIQvxcHYa2w0/o2VLCsXenfQ/qEfURZU1gBAXu1A0UTFwoQ45ReIj4
         uSmHoegxSpRCQqWQFH3/rtrCuzNi8MgLFnL7X7y0w0CgGhNvb+VcdwGY8KuOevYp+/SY
         t0FylrBa/1+BeXhE27ZlBIJesLUrdIWbd6+G5qhow1WHfOy7vYGpylyNU4seClwzjy+z
         rc0OTWS5Yo8E4yqdowtsTUTZ8Sp63jeZw6hXKYPSCM5TPhbwlr0E+6bdbX753Zghmxqu
         ku8Q==
X-Gm-Message-State: APjAAAUX20k/fdNsYRXDxMofigxc/w1V+ZoJECGlYDTQIGDZlUBo0G0N
        3vGKXqiPA8T+ozPV0g/lyOHn9lUBvgc=
X-Google-Smtp-Source: APXvYqzZlBhySyJAYTOt6WAkcJga9uyboZQiIViYwTMmWMoFvriuW9yYpI50aAC8S4SCIstu3fjIlQ==
X-Received: by 2002:a17:90a:8986:: with SMTP id v6mr5730253pjn.63.1576097479331;
        Wed, 11 Dec 2019 12:51:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id h16sm4169308pfn.85.2019.12.11.12.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:51:18 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:51:14 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/9] bugreport: collect list of populated hooks
Message-ID: <20191211205114.GD107889@google.com>
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-6-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1910281522200.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910281522200.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 03:31:36PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Thu, 24 Oct 2019, Emily Shaffer wrote:
> 
> > Occasionally a failure a user is seeing may be related to a specific
> > hook which is being run, perhaps without the user realizing. While the
> > contents of hooks can be sensitive - containing user data or process
> > information specific to the user's organization - simply knowing that a
> > hook is being run at a certain stage can help us to understand whether
> > something is going wrong.
> >
> > Without a definitive list of hook names within the code, we compile our
> > own list from the documentation. This is likely prone to bitrot. To
> > reduce the amount of code humans need to read, we turn the list into a
> > string_list and iterate over it (as we are calling the same find_hook
> > operation on each string). However, since bugreport should primarily be
> > called by the user, the performance loss from massaging the string
> > seems acceptable.
> 
> Good idea!
> 
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  bugreport.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  bugreport.h         |  6 ++++++
> >  builtin/bugreport.c |  4 ++++
> >  3 files changed, 54 insertions(+)
> >
> > diff --git a/bugreport.c b/bugreport.c
> > index afa4836ab1..9d7f44ff28 100644
> > --- a/bugreport.c
> > +++ b/bugreport.c
> > @@ -103,3 +103,47 @@ void get_whitelisted_config(struct strbuf *config_info)
> >  	strbuf_reset(config_info);
> >  	strbuf_addbuf(config_info, &configs_and_values);
> >  }
> > +
> > +void get_populated_hooks(struct strbuf *hook_info)
> > +{
> > +	/*
> > +	 * Doesn't look like there is a list of all possible hooks; so below is
> > +	 * a transcription of `git help hook`.
> > +	 */
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
> Well, this is disappointing: I tried to come up with a scripted way to
> extract the commit names from our source code, and I failed! This is
> where I gave up:
> 
> 	git grep run_hook |
> 	sed -n 's/.*run_hook[^(]*([^,]*, *\([^,]*\).*/\1/p' |
> 	sed -e '/^name$/d' -e '/^const char \*name$/d' \
> 		-e 's/push_to_checkout_hook/"push-to-checkout"/' |
> 	sort |
> 	uniq
> 
> This prints only the following hook names:
> 
> 	"applypatch-msg"
> 	"post-applypatch"
> 	"post-checkout"
> 	"post-index-change"
> 	"post-merge"
> 	"pre-applypatch"
> 	"pre-auto-gc"
> 	"pre-rebase"
> 	"prepare-commit-msg"
> 	"push-to-checkout"
> 
> But at least it was easy to script the extracting from the
> Documentation:
> 
> 	sed -n '/^[a-z]/{N;/\n~~~/{s/\n.*//;p}}' \
> 		Documentation/githooks.txt
> 

To be totally frank, I'm not keen on spending a lot of time with
scripting this. My parallel work with config-based hooks will also
involve an in-code source of truth for available hooknames; I'd like to
punt on some scripting, putting it in the makefile, etc blah since I
know I'm planning to fix this particular annoyance at the source - and
since it looks like bugreport will stay in the review phase for at least
a little longer.

> > +	struct string_list hooks_list = STRING_LIST_INIT_DUP;
> > +	struct string_list_item *iter = NULL;
> > +
> > +	strbuf_reset(hook_info);
> > +
> > +	string_list_split(&hooks_list, hooks, ',', -1);
> > +
> > +	for_each_string_list_item(iter, &hooks_list) {
> 
> This should definitely be done at compile time, I think. We should be
> able to generate an appropriate header via something like this:
> 
> 	cat >hook-names.h <<-EOF
> 	static const char *hook_names[] = {
> 	$(sed -n '/^[a-z]/{N;/\n~~~/{s/\n.*/",/;s/^/	"/;p}}' \
> 		Documentation/githooks.txt)
> 	};
> 	EOF
> 
> Then you would use a simple `for()` loop using `ARRAY_SIZE()` to
> iterate over the hook names.
> 
> > +		if (find_hook(iter->string)) {
> > +			strbuf_addstr(hook_info, iter->string);
> > +			strbuf_complete_line(hook_info);
> > +		}
> > +	}
> > +}
> > diff --git a/bugreport.h b/bugreport.h
> > index 7413e7e1be..942a5436e3 100644
> > --- a/bugreport.h
> > +++ b/bugreport.h
> > @@ -12,3 +12,9 @@ void get_system_info(struct strbuf *sys_info);
> >   * config_info will be discarded.
> >   */
> >  void get_whitelisted_config(struct strbuf *sys_info);
> > +
> > +/**
> > + * Adds the paths to all configured hooks (but not their contents). The previous
> > + * contents of hook_info will be discarded.
> > + */
> > +void get_populated_hooks(struct strbuf *hook_info);
> > diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> > index 70fe0d2b85..a0eefba498 100644
> > --- a/builtin/bugreport.c
> > +++ b/builtin/bugreport.c
> > @@ -60,6 +60,10 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
> >  	get_whitelisted_config(&buffer);
> >  	strbuf_write(&buffer, report);
> >
> > +	add_header(report, "Populated Hooks");
> 
> Wait! I should have stumbled over this in an earlier patch. The
> `add_header()` function should not take a `FILE *` parameter at all, but
> instead an `struct strbuf *` one!
> 
> Ciao,
> Dscho
> 
> > +	get_populated_hooks(&buffer);
> > +	strbuf_write(&buffer, report);
> > +
> >  	fclose(report);
> >
> >  	launch_editor(report_path.buf, NULL, NULL);
> > --
> > 2.24.0.rc0.303.g954a862665-goog
> >
> >
