Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9C9C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 01:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEEF206B8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 01:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+TaLEiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDFBkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 21:40:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43686 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgDFBkA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 21:40:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id 13so2445765qko.10
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 18:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lt4BwQCwTEbpY6O9nvgga/6zcNZ7FeQs86/X3GsUYSA=;
        b=c+TaLEiFmVFP1XLpE05pKNeyQQHgDDP1R8O+IUQt4ul2jO7bhE3X2lN8A0zA/HffOY
         55OuNdZXQEuS8xGAuO0/SVKuvrlYmZ4DS71j7kK4ReyN8eltXS4bNyQtRLRdyd/OM3ap
         2F+b5qyFo9eqqP5C9t1/v3UVmpuvxJgBn4n3lBiCY1N9HK2n1uCnRHNJzHzczSC8Vqwx
         WGw7Vv7xqmGm0NEqTzsYnhKrNxjQJ3aEXe/4pkrSQcjlo9OAucwRYX9SbxM5gFAbS2sD
         r0yJmzhUKTWpuBB3MaU2nxggOy+EgWmHNi2pJd0mmcZTMexpxa6Ewc0O7vPrT3FeThIv
         XnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lt4BwQCwTEbpY6O9nvgga/6zcNZ7FeQs86/X3GsUYSA=;
        b=mTEYA2QIQjrFZAjeyAX5Qea3xhorC9r91tPwp3olw6bFf8YDVqF3yj5mmRzzh85FVf
         W9LpcNBXJ71OlTh19m30sdw9RCTzfpUswGM0Wo5I1fA522nP/HAzaio34ebz8fmiy5+m
         0wr6YL5/FFGkRXIIA8Ny6T1NHJ0qd19DYhWdsxMF/Pqy7z+a4SOGYMhL8+7Afsgen3Q0
         XZoyh9lzYAqsPs3olP8EHHdiHEy2lSEf1S4y/Dw7RaOxZpv3+d3S5oJWi4DeFL3q+joU
         o9UZIV/y2UExTqdZYHF/LhmV6rEgSwP+8kmzx9X/gLYtuiOkXpMYyKFg33YhOZDaGMO1
         bq+A==
X-Gm-Message-State: AGi0Puanqp+msy7ehb8TcernAUT+32Vk1cktbBPal07FtMNVdU/V9f7R
        VSxXc+DIatI5OaP54o9tCRQYv9qR
X-Google-Smtp-Source: APiQypITVxdJHbkA16c1XgSdxUPF67FST5vFDOVXvzSIiQvugumuv7zKF6joePh99diqacUTsOCEqQ==
X-Received: by 2002:a37:8f06:: with SMTP id r6mr15583413qkd.260.1586137199539;
        Sun, 05 Apr 2020 18:39:59 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p65sm1999722qkf.108.2020.04.05.18.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 18:39:58 -0700 (PDT)
Date:   Sun, 5 Apr 2020 21:39:56 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 04/23] sequencer: reuse strbuf_trim() in
 read_oneliner()
Message-ID: <20200406013956.GA1879124@generichostname>
References: <cover.1584782450.git.liu.denton@gmail.com>
 <cover.1585962672.git.liu.denton@gmail.com>
 <c7a3cfa20005aeeedc27d2eb4af1e2c4470ad73d.1585962672.git.liu.denton@gmail.com>
 <xmqqr1x1wqpk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1x1wqpk.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, Apr 05, 2020 at 02:46:47PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > @@ -2471,7 +2467,6 @@ void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
> >  
> >  static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
> >  {
> > -	strbuf_reset(buf);
> >  	if (!read_oneliner(buf, rebase_path_strategy(), 0))
> >  		return;
> >  	opts->strategy = strbuf_detach(buf, NULL);
> > @@ -2494,7 +2489,6 @@ static int read_populate_opts(struct replay_opts *opts)
> >  				free(opts->gpg_sign);
> >  				opts->gpg_sign = xstrdup(buf.buf + 2);
> >  			}
> > -			strbuf_reset(&buf);
> >  		}
> >  
> >  		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
> > @@ -2526,7 +2520,6 @@ static int read_populate_opts(struct replay_opts *opts)
> >  			opts->keep_redundant_commits = 1;
> >  
> >  		read_strategy_opts(opts, &buf);
> > -		strbuf_reset(&buf);
> >  
> 
> >  		if (read_oneliner(&opts->current_fixups,
> >  				  rebase_path_current_fixups(), 1)) {
> 
> Is this conversion correct around here?  read_oneliner() used to
> "append" what was read from the file to what is already in the
> strbuf, and many strbuf_reset() in this function was because these
> callers of read_oneliner() in this function that has strbuf_reset()
> immediately before did *not* want the "append" semantics.  But this
> one looks different.  Where in the original does the current_fixups
> strbuf get emptied for this read_oneliner() to ignore the previous
> contents?  Or are we relying on the caller not to have done anything
> to current_fixups before it calls this function?

As far as I can tell, opts->current_fixups is always empty when
read_oneliner() is called here.

> In other words, the original behaviour of read_oneliner() having the
> "append" semantics suggests me that there were callers that wanted
> to keep the current contents and append---this current_fixups may
> not be one of them, but nevertheless, changing the semantics of the
> function from "append" to "discard and read from scratch" without
> vetting all the existing callers smells iffy to me.

Before making this change, I manually checked all invocations of
read_oneliner() and ensured that they all passed in an empty strbuf.
Same thing with "rebase: use read_oneliner()", I manually checked all of
those invocations as well. It's quite possible that I made a mistake,
though.

To be doubly sure that I caught everything, I ran the test suite on
'master' with this patch:

	diff --git a/builtin/rebase.c b/builtin/rebase.c
	index 27a07d4e78..a0c03dd1d6 100644
	--- a/builtin/rebase.c
	+++ b/builtin/rebase.c
	@@ -589,6 +589,9 @@ static const char *state_dir_path(const char *filename, struct rebase_options *o
	 /* Read one file, then strip line endings */
	 static int read_one(const char *path, struct strbuf *buf)
	 {
	+	if (buf->len)
	+		BUG("rebase change bad: %s", buf->buf);
	+
		if (strbuf_read_file(buf, path, 0) < 0)
			return error_errno(_("could not read '%s'"), path);
		strbuf_trim_trailing_newline(buf);
	diff --git a/sequencer.c b/sequencer.c
	index 6fd2674632..d7bc5c9c95 100644
	--- a/sequencer.c
	+++ b/sequencer.c
	@@ -433,6 +433,9 @@ static int read_oneliner(struct strbuf *buf,
	 {
		int orig_len = buf->len;
	 
	+	if (buf->len)
	+		BUG("sequencer change bad: %s", buf->buf);
	+
		if (!file_exists(path))
			return 0;

Thanks,

Denton
