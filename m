Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66E21FCA9
	for <e@80x24.org>; Fri, 16 Sep 2016 09:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758683AbcIPJk0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 05:40:26 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:58057 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758204AbcIPJkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 05:40:25 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bkpd7-0007xI-9w; Fri, 16 Sep 2016 11:40:21 +0200
Date:   Fri, 16 Sep 2016 11:40:19 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 3/2] batch check whether submodule needs pushing into one
 call
Message-ID: <20160916094019.GB1488@book.hvoigt.net>
References: <20160824173017.24782-1-sbeller@google.com>
 <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
 <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
 <20160914173124.GA7613@sandbox>
 <xmqqwpiep10i.fsf@gitster.mtv.corp.google.com>
 <20160915121044.GA96648@book.hvoigt.net>
 <xmqq1t0kna51.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1t0kna51.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 02:08:58PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >  	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
> >  		struct child_process cp = CHILD_PROCESS_INIT;
> > -		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
> > +
> > +		argv_array_push(&cp.args, "rev-list");
> > +		sha1_array_for_each_unique(hashes, append_hash_to_argv, &cp.args);
> > +		argv_array_pushl(&cp.args, "--not", "--remotes", "-n", "1" , NULL);
> > +
> >  		struct strbuf buf = STRBUF_INIT;
> >  		int needs_pushing = 0;
> 
> These two become decl-after-stmt; move your new lines a bit lower,
> perhaps?

Thanks, missed those. Will do.

> > -		argv[1] = sha1_to_hex(sha1);
> > -		cp.argv = argv;
> >  		prepare_submodule_repo_env(&cp.env_array);
> 
> By the way, with the two new patches, 'pu' seems to start failing
> some tests, e.g. 5533 5404 5405.

Ah ok I did only test on master, will look into those.

Cheers Heiko
