Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BAC43446
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA9320760
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyBK+fPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgGPNGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgGPNGG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 09:06:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFEAC061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 06:06:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so4798360pgm.11
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 06:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HaD6GQEybV7dY1bXsequk6X4X88UjuRziFKuivmc9i4=;
        b=VyBK+fPcmPabUnXE3+ee9JCzig07+ImNLWi2HiUW3a2l1EpCIp0u5iX9JLVR36mitT
         Zmb36tjy5oRMj4bo1yf3o7Pho5L8pzbTcYi5dTh/5nBIBkZ+kgDeU8DjYgFF2E80uouQ
         TOm6mxxPNwBpPEh921IhV5grr9nnKBIrDnXLWEaXELx5J5sM49xw+GRMU5J8D/ziWekl
         FA0rjtCcG9IkANV3T05dnfZ9cojNdQIrpS3dYYcIjrjjl1JsUaUV/sGcPXZy3Ffofo2P
         c1zeu1BIL4DQJcacQurSrm1x2MxRCJbL5y7XOjGvTMXO0Ybh8cCcb+mXUy5fXos2bXsY
         /icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HaD6GQEybV7dY1bXsequk6X4X88UjuRziFKuivmc9i4=;
        b=Gq4MHBlHAspfvGmG05ItDHOX9wux4v3z2E1Mp1cxSdXMHKLSeIYmgnWp1Z0DajV/MO
         SSqh0Dzlmer1qYpRfFPtNKAWd8jLXr81aTPeAZo7KR8OCfcjYnQUsns/uMEIITAb+tuZ
         TXliRKj2Myb6BgPnpkHCFkJGTea/1kDTh6tuKJ8DxzpHwIDQdlnm0PjRfgHCiGI9htdw
         vrp5ix3rRhVkz+enIGPpbsjTrokpg6Xfz9Qn+bMSVfgktaiayk7732RQ6X4kxjzDaeaR
         vb5MCt4iZUJj0vmxzZBLVgMYrNjB0QhUeKd+ccASmYH9pgdrVhNtybFRc0LCtSY96ZFj
         dW4w==
X-Gm-Message-State: AOAM532rgn6MAM7iiIN7ViwrS7WJFiwFvH5UxSrr8P3g35n2jUhHWkDE
        tYNp9OxRe/tJMfm9/st4p9A=
X-Google-Smtp-Source: ABdhPJxSiaN85XA8bqmvF9KoDPAnG02GwIVcxfzZMuLdm2kFD7oyuzT5cfE3mrj0pHNdkVNDubldIw==
X-Received: by 2002:a63:2223:: with SMTP id i35mr4347389pgi.64.1594904766352;
        Thu, 16 Jul 2020 06:06:06 -0700 (PDT)
Received: from localhost ([2402:800:6375:2db4:7eb6:3e8e:903a:6638])
        by smtp.gmail.com with ESMTPSA id m22sm5448728pfk.216.2020.07.16.06.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:06:05 -0700 (PDT)
Date:   Thu, 16 Jul 2020 20:06:03 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] rebase -i: support --committer-date-is-author-date
Message-ID: <20200716130603.GB7803@danh.dev>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200713101045.27335-1-phillip.wood123@gmail.com>
 <20200713101045.27335-3-phillip.wood123@gmail.com>
 <20200715142717.GA7803@danh.dev>
 <281d92d3-f901-bca1-6030-fd0c8761f214@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <281d92d3-f901-bca1-6030-fd0c8761f214@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 2020-07-16 09:23:17+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >> [...]
> > > +	if (opts->committer_date_is_author_date) {
> > > +		struct ident_split ident;
> > > +		struct strbuf date = STRBUF_INIT;
> > > +
> > > +		if (split_ident_line(&ident, author, (int)strlen(author)) < 0) {
> > > +			res = error(_("malformed ident line '%s'"), author);
> > 
> > I've checked with the translation for my native language (vi).
> > The translators seem to misread ident (as in identity) as
> > indent (as in indentation).
> > 
> > The translation in po/vi.po:25045 (of v2.28.0-rc0) reads:
> > 
> > 	#~ msgid "malformed ident line"
> > 	#~ msgstr "thụt đầu dòng dị hình"
> > 
> > Translating back to English, it reads: "malformed indentation".
> > 
> > Hence, I think it would read better if we write:
> > 
> > 	res = error(_("malformed identity line '%s'"), author);
> > 
> > 3 more characters is not that much :)
> 
> Looking through the existing strings "invalid ident line: %.*s" is already
> used by am so maybe we should reuse that (log.c also contains "invalid ident
> line: %s"). Is the translation correct?
> 
> #: builtin/am.c:1270
> #, c-format
> msgid "invalid ident line: %.*s"
> msgstr "dòng thụt lề không hợp lệ: %.*s"

That translation isn't correct either.
It seems like it's recurring pattern.
I'll take it to the Vietnamese translation team.

Anyway, I've checked with other translation that I can understand
in part. I think

	invalid ident line: %s

is better candidate for the message.
Since Spanish translation also mis-translates the message:

	es.po:9836:msgid "invalid ident line: %.*s"
	es.po-9837-msgstr "sangría no válida: %.*s"

"sangría" also means "indentation" in this context.

Thanks,
-Danh

> 
> Best Wishes
> 
> Phillip
> 
> > 
> > > +			goto out;
> > > +		}
> > > +		if (!ident.date_begin) {
> > > +			res = error(_("corrupted author without date information"));
> > > +			goto out;
> > > +		}
> > > +
> > > +		strbuf_addf(&date, "@%.*s %.*s",
> > > +			    (int)(ident.date_end - ident.date_begin),
> > > +			    ident.date_begin,
> > > +			    (int)(ident.tz_end - ident.tz_begin),
> > > +			    ident.tz_begin);
> > > +		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
> > > +		strbuf_release(&date);
> > > +
> > > +		if (res)
> > > +			goto out;
> > > +	}
> > > +
> > >   	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
> > >   		res = error(_("git write-tree failed to write a tree"));
> > >   		goto out;
> > > @@ -2532,6 +2578,11 @@ static int read_populate_opts(struct replay_opts *opts)
> > >   			opts->signoff = 1;
> > >   		}
> > > +		if (file_exists(rebase_path_cdate_is_adate())) {
> > > +			opts->allow_ff = 0;
> > > +			opts->committer_date_is_author_date = 1;
> > > +		}
> > > +
> > >   		if (file_exists(rebase_path_reschedule_failed_exec()))
> > >   			opts->reschedule_failed_exec = 1;
> > > @@ -2622,6 +2673,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
> > >   		write_file(rebase_path_drop_redundant_commits(), "%s", "");
> > >   	if (opts->keep_redundant_commits)
> > >   		write_file(rebase_path_keep_redundant_commits(), "%s", "");
> > > +	if (opts->committer_date_is_author_date)
> > > +		write_file(rebase_path_cdate_is_adate(), "%s", "");
> > >   	if (opts->reschedule_failed_exec)
> > >   		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
> > > @@ -3542,6 +3595,10 @@ static int do_merge(struct repository *r,
> > >   			goto leave_merge;
> > >   		}
> > > +		if (opts->committer_date_is_author_date)
> > > +			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
> > > +					 author_date_from_env_array(&cmd.env_array));
> > > +
> > >   		cmd.git_cmd = 1;
> > >   		argv_array_push(&cmd.args, "merge");
> > >   		argv_array_push(&cmd.args, "-s");
> > > @@ -3819,7 +3876,8 @@ static int pick_commits(struct repository *r,
> > >   	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> > >   	if (opts->allow_ff)
> > >   		assert(!(opts->signoff || opts->no_commit ||
> > > -				opts->record_origin || opts->edit));
> > > +				opts->record_origin || opts->edit ||
> > > +				opts->committer_date_is_author_date));
> > >   	if (read_and_refresh_cache(r, opts))
> > >   		return -1;
> > > diff --git a/sequencer.h b/sequencer.h
> > > index 0bee85093e..4ab94119ae 100644
> > > --- a/sequencer.h
> > > +++ b/sequencer.h
> > > @@ -45,6 +45,7 @@ struct replay_opts {
> > >   	int verbose;
> > >   	int quiet;
> > >   	int reschedule_failed_exec;
> > > +	int committer_date_is_author_date;
> > >   	int mainline;
> > > diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> > > index 55ca46786d..c8234062c6 100755
> > > --- a/t/t3422-rebase-incompatible-options.sh
> > > +++ b/t/t3422-rebase-incompatible-options.sh
> > > @@ -61,7 +61,6 @@ test_rebase_am_only () {
> > >   }
> > >   test_rebase_am_only --whitespace=fix
> > > -test_rebase_am_only --committer-date-is-author-date
> > >   test_rebase_am_only -C4
> > >   test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
> > > diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
> > > index 4f8a6e51c9..50a63d8ebe 100755
> > > --- a/t/t3436-rebase-more-options.sh
> > > +++ b/t/t3436-rebase-more-options.sh
> > > @@ -9,6 +9,9 @@ test_description='tests to ensure compatibility between am and interactive backe
> > >   . "$TEST_DIRECTORY"/lib-rebase.sh
> > > +GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
> > > +export GIT_AUTHOR_DATE
> > > +
> > >   # This is a special case in which both am and interactive backends
> > >   # provide the same output. It was done intentionally because
> > >   # both the backends fall short of optimal behaviour.
> > > @@ -21,11 +24,20 @@ test_expect_success 'setup' '
> > >   	test_write_lines "line 1" "new line 2" "line 3" >file &&
> > >   	git commit -am "update file" &&
> > >   	git tag side &&
> > > +	test_commit commit1 foo foo1 &&
> > > +	test_commit commit2 foo foo2 &&
> > > +	test_commit commit3 foo foo3 &&
> > >   	git checkout --orphan master &&
> > > +	rm foo &&
> > >   	test_write_lines "line 1" "        line 2" "line 3" >file &&
> > >   	git commit -am "add file" &&
> > > -	git tag main
> > > +	git tag main &&
> > > +
> > > +	mkdir test-bin &&
> > > +	write_script test-bin/git-merge-test <<-\EOF
> > > +	exec git-merge-recursive "$@"
> > > +	EOF
> > >   '
> > >   test_expect_success '--ignore-whitespace works with apply backend' '
> > > @@ -52,6 +64,50 @@ test_expect_success '--ignore-whitespace is remembered when continuing' '
> > >   	git diff --exit-code side
> > >   '
> > > +test_ctime_is_atime () {
> > > +	git log $1 --format=%ai >authortime &&
> > > +	git log $1 --format=%ci >committertime &&
> > > +	test_cmp authortime committertime
> > > +}
> > > +
> > > +test_expect_success '--committer-date-is-author-date works with apply backend' '
> > > +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
> > > +	git rebase --apply --committer-date-is-author-date HEAD^ &&
> > > +	test_ctime_is_atime -1
> > > +'
> > > +
> > > +test_expect_success '--committer-date-is-author-date works with merge backend' '
> > > +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
> > > +	git rebase -m --committer-date-is-author-date HEAD^ &&
> > > +	test_ctime_is_atime -1
> > > +'
> > > +
> > > +test_expect_success '--committer-date-is-author-date works with rebase -r' '
> > > +	git checkout side &&
> > > +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
> > > +	git rebase -r --root --committer-date-is-author-date &&
> > > +	test_ctime_is_atime
> > > +'
> > > +
> > > +test_expect_success '--committer-date-is-author-date works when forking merge' '
> > > +	git checkout side &&
> > > +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
> > > +	PATH="./test-bin:$PATH" git rebase -r --root --strategy=test \
> > > +					--committer-date-is-author-date &&
> > > +	test_ctime_is_atime
> > > +'
> > > +
> > > +test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
> > > +	git checkout commit2 &&
> > > +	GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only --reset-author &&
> > > +	test_must_fail git rebase -m --committer-date-is-author-date \
> > > +		--onto HEAD^^ HEAD^ &&
> > > +	echo resolved > foo &&
> > 
> > Nitpick: no space after ">" :D
> > 

-- 
Danh
