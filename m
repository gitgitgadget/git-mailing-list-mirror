Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC0C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 09:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3D52082E
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 09:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkFVaYTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfLAJbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 04:31:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33515 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLAJbx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 04:31:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so10733760wrq.0
        for <git@vger.kernel.org>; Sun, 01 Dec 2019 01:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P/jT66GHYcOO5cYZ8HdWkoYMq016qPjeiGCTeSaNdXo=;
        b=kkFVaYTs4S9pk3VPTAlu3sqM5Hp5VteWE3SWEP2HhqoWWzn7xGvSjNEw1ZDdtHvRmc
         4G437BCOyyoSVJO9x3UEeLgIfKRM8stoILgPEa+OfyZki7Fb5P9Lb7ut+Q8uXGmlY3NA
         qXV1jdJfEffj0zVz267d/N8aohovGiOz6qz1JtAwtym/HRsRcyINzpLNFrC8GvdDwKHk
         uWN8zYJCNbIlEQyjXqWfWrt6e1sHUJDlYz3SQ/p6WFm4CpeSUdi3epLQs+3m9zZLgdOA
         B4JzWDHs0T8eavjHf+yn02PzXncJdFaTK1CdGJ67hTz4kJI/AO9RM+lGnRc5n66DWDsg
         OxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P/jT66GHYcOO5cYZ8HdWkoYMq016qPjeiGCTeSaNdXo=;
        b=SUnh4GYCRR2aMgsWanruZgkqmEKF5MOlAjh9shasd230TQyNn7NTblHht03zO/1oz4
         XePww9Y/ASaEhbxrEnlQWb0QXU8LpJZIhduFWOSUkr6ZTKfYj505GbBtjsOwyf1PwiKX
         UYoGkhfvkTnCbriNmPAvMLe+vk9hj1AXdNUYZA+F13nTE29n/7Wvqp5HBKrx83wzhOCB
         3FIN6so3njdbbici7tUbzkgc29/6MESRbYew7K/IY0hMoTPbDM4XwNEle4e6FzWmBUYm
         0vtcf3PAf/j76dq8R03j/sQw1nYgnRQ0kQ2xJV1o2KEUztjUrxVEXTK3ZZu9wM6AuZIr
         mBEQ==
X-Gm-Message-State: APjAAAX1DdVwCDrWVv9X5s1B4B6j7eQNtcMOpbUkPSUmaQsOahPRqJCp
        C/AbVag0WrGyia5fUM0UowI=
X-Google-Smtp-Source: APXvYqw6m9y8krwdSjtH8I+tuo54jMIa4CMMORNA+PRD+yU4oQ2HtS+9FaCJwlqOmvJ5+5Ijk6eShQ==
X-Received: by 2002:a5d:5391:: with SMTP id d17mr68069579wrv.382.1575192710942;
        Sun, 01 Dec 2019 01:31:50 -0800 (PST)
Received: from szeder.dev (x4db454dc.dyn.telefonica.de. [77.180.84.220])
        by smtp.gmail.com with ESMTPSA id w188sm20787324wmg.32.2019.12.01.01.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Dec 2019 01:31:50 -0800 (PST)
Date:   Sun, 1 Dec 2019 10:31:48 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9300-fast-import: don't hang if background fast-import
 exits too early
Message-ID: <20191201093148.GH23183@szeder.dev>
References: <20191130104644.17350-1-szeder.dev@gmail.com>
 <xmqqsgm512vl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsgm512vl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 30, 2019 at 01:16:30PM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > +	(
> > +		git fast-import $options <&8 >&9 &
> > +		echo $! >V.fi.pid
> > +		wait $!
> > +		echo >&2 "background fast-import terminated too early with exit code $?"
> > +		# Un-block the read loop in the main shell process.
> > +		echo >&9 UNEXPECTED
> > +	) &
> > +	echo $! >V.sh.pid
> >  	# We don't mind if fast-import has already died by the time the test
> >  	# ends.
> > -	test_when_finished "
> > +	test_when_finished '
> >  		exec 8>&-; exec 9>&-;
> > -		kill $(cat V.pid) && wait $(cat V.pid)
> > -		true"
> > +		kill $(cat V.sh.pid) && wait $(cat V.sh.pid)
> > +		kill $(cat V.fi.pid) && wait $(cat V.sh.pid)
> > +		true'
> 
> The original interpolates the PID of the fast-import when
> "when-finished" program is registered, so it is OK if somebody else
> removed V.pid file; the new one interpolates when "when-finished"
> program is run, reading from V.??.pid, so somebody needs to make
> sure these pid files will stay around.  I do not think it is an
> issue as I suspect we've left it to the global clean-up procedure
> that removes the trash directory to remove the pid file.

In the original the same shell process starts 'git fast-import',
writes its pidfile, and registers the test_when_finished commands, so
we can be sure that the pid file is already present when the shell
runs the $(cat V.pid) command substitutions.

With this patch that's not the case anymore, because the background
subshell starts 'git fast-import' and writes the pidfile, but the main
shell process registers the test_when_finished commands.  IOW these
two shell processes are racing, and it's possible that the
test_when_finished command is executed before the background subshell
can write the pidfile.  So double quotes around the block of
test_when_finished commands are not good.

> By the way, does the second "kill && wait" wait for the right
> process?

Ouch, it clearly doesn't.  Copy-paste error I suppose.
Thanks for spotting it.

> 
> >  background_import_still_running () {
> > -	if ! kill -0 "$(cat V.pid)"
> > +	if ! kill -0 "$(cat V.fi.pid)"
> >  	then
> >  		echo >&2 "background fast-import terminated too early"
> >  		false
> >  	fi
> >  }
