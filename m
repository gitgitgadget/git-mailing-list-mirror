Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05BDC11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFEA206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2PzJLG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgBTWd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:33:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35608 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgBTWd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:33:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so2119857plt.2
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 14:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DCa2R9jRA461jjfi6ctBMPrbnEaDia2899ShpUYJ4uQ=;
        b=S2PzJLG/+qBFg4HNTBxl+qyU8JgflSD0tqMQw6+4svvQwMKIfO+w7UNtzKx/wXpq+9
         u2qa2g6X6G5Myfg45Sys8UCfyTxvdw5tB/QR5J7bcjTb1CyUAuIzWuu044/orMbGAzBq
         rQKSciuwTSDYldzMIr2CRkKi/vTmNJmecwxPOUjIceT9LwMjVowRSKQItZOR7AtDey8h
         c36e6Jdfh5Qp4i2y+5zrhRYDzS3iLDo0ZKt6qWP/v8U/BgI+gz34GOhwOpYHaO9lrabD
         flPtyahA3PEqZcxZYvR7TAG8UdEc5LJvT4+BsiNxS96SHodvCUu/qcslQ9HR1g53Di+a
         Ji9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DCa2R9jRA461jjfi6ctBMPrbnEaDia2899ShpUYJ4uQ=;
        b=HTfpENRTcy36dVeFDZDG82mm/RemuF4/S7RKAvwVOo1gnd87aHMT15JMqVGiQXJdjx
         z+OdI/QtCk36FiUOGF7ItFzwPYBF2iY4tVJrly/LMdFb2qGBP/9kNvyA2hiTM9ReXJzE
         DsAgDS68TOhh59CHCHu4qtXGTqqVZzvCzgbLPyvN3OtizBNd5J8Hi2/mcCQTTH/1tCRS
         nKM0kj3zcUPuIUhoOiZfQwijP3YJxbMN7zMX691ooC7w4gtSrKfL0KAASFzkzcCaYxLI
         b0ehMfjZnxXf3sbpSUMwcfKlmQTJ4+XN9PZhgB2B0aiEXLX/z9/Uy+ow2VDsFmtcp27L
         h2xw==
X-Gm-Message-State: APjAAAVM69Wm2sCMqzzCmtPAFHAtVqZ12Gc+oo0ZuA+kF0c5UTRQuIri
        D/xQfTPUf0SKvJORAXgZB5S6D6AVtxQ=
X-Google-Smtp-Source: APXvYqz33rIZp78vAeGPGQnlNpOFYcYlqU3y98wkxqTjPrloZchL+p9eDUfnZVlIr0ZKtFYUH/UoGQ==
X-Received: by 2002:a17:902:fe93:: with SMTP id x19mr33681729plm.155.1582238008667;
        Thu, 20 Feb 2020 14:33:28 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id o19sm4155644pjr.2.2020.02.20.14.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 14:33:27 -0800 (PST)
Date:   Thu, 20 Feb 2020 14:33:23 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200220223323.GD2447@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-4-emilyshaffer@google.com>
 <xmqq8skxawah.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8skxawah.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 11:33:26AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +	argc = parse_options(argc, argv, "", bugreport_options,
> > +			     bugreport_usage, 0);
> 
> Which one between an empty string and NULL is more appropriate to be
> passed as "prefix" here?  I assume that this is *not* really a git
> program, and no repository/working-tree discovery is involved, and
> you won't be using OPT_FILENAME, so it would probably be OK.
> 
> > +
> > +	if (option_output) {
> > +		strbuf_addstr(&report_path, option_output);
> > +		strbuf_complete(&report_path, '/');
> > +	}
> > +
> > +
> > +	strbuf_addstr(&report_path, "git-bugreport-");
> > +	strbuf_addftime(&report_path, option_suffix, localtime(&now), 0, 0);
> > +	strbuf_addstr(&report_path, ".txt");
> > +
> > +	if (!stat(report_path.buf, &statbuf))
> > +		die("'%s' already exists", report_path.buf);
> 
> Missed i18n/l10n, but I do not think it is a useful thing for this
> check to be here in the first place.
> 
> > +	switch (safe_create_leading_directories(report_path.buf)) {
> > +	case SCLD_OK:
> > +	case SCLD_EXISTS:
> > +		break;
> > +	default:
> > +		die(_("could not create leading directories for '%s'"),
> > +		    report_path.buf);
> > +	}
> > +
> > +	get_bug_template(&buffer);
> > +
> > +	report = fopen_for_writing(report_path.buf);
> 
> fopen_for_writing() does not give good semantics for what you seem
> to want to do here (i.e. to make sure you do not overwrite an
> existing one).  It even has "if we cannot open it, retry after
> unlinking" logic in it, which screams "this function is designed for
> those who want to overwrite the file", and if you look at its
> callers, they are _all_ about opening a file for writing with a well
> known name like FETCH_HEAD, COMMIT_EDITMSG, etc.
> 
> Besides, a stat() that dies when a file exists would not
> help---since that check, you've spent non-zero time, creating
> leading directories and preparing boilerplate in the buffer,
> and there is no guarantee somebody else used the same filename
> in the meantime.

Good point. Ouch.

> 
> If you want to avoid overwriting an existing file (which I think is
> a good idea---I just do not think the earlier "if (!stat()) die()"
> is a good way to do so), the only sensible way to do so is to ask
> your open/creat to fail if there already is a file---that is how
> you'd avoid racing with another process that may be creating such a
> file.  Grep for O_EXCL to find where the flag is used with O_CREAT
> to see how it is done.

Sure. Thanks, I reworked it to use open().

By the way, I noticed reading the GNU manual that file descriptors may
not be supported outside of GNU environments; but I also noticed that 1)
Git uses open() lots of places to use O_EXCL, and 2) fopen() doesn't
support exclusive opens (except in glibc, and nobody is using that
particular option in the Git codebase now). So I guess it's safe to use
open()...

> 
> > +	if (report == NULL) {
> 
> Style. "if (!report)"

The type of 'report' changes using open(), so this check changes too.
Now it says "if (report < 0)" - per the open() doc, it returns a
positive fd or -1.

> 
> > +		strbuf_release(&report_path);
> > +		die("couldn't open '%s' for writing", report_path.buf);
> 
> Do we see a use-after-free here?  Also missed i18n/l10n.

Hm. I suppose it's OK to UNLEAK() like we do at the successful exit
since the die() will end the process. Added i18n too.

> It is embarrassing on the reviewers' side that this (which is not
> new in this round at all and hasn't changed since v6) hasn't been
> caught for a few rounds X-<.

Well, I'm embarrassed to have written it in the first place.

 - Emily
