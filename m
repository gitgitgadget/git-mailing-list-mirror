Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B135C1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 17:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbdGYRxZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 13:53:25 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33754 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdGYRxX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 13:53:23 -0400
Received: by mail-pg0-f52.google.com with SMTP id g14so24288716pgu.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QoG22HnspjllNT117TzvZL8fTuogOE1oP6UZL8u0KsQ=;
        b=W+N1v9GJ7PIcBLpDU/2rs0QRfuiPIVxC2q/X+LVUBf934e7bJQ7YKbsGp5u4KX6h0w
         PzTpXWspXJd8xS9rd8GmsV1JBGkeqeXZKTIUgSJpBHKOKYfQeoZyVNelgNvanOyxrI7j
         tgYIhAFXbZ1wobZdZGu+FhrDLqgjXpH5IQbE24s7uH7JfLHlTl9oFhHYhd+JQx4qsEKw
         mx+nY/nRR1SSWyoYvxhLFHKJMh1tFY7UmsPjUs7p9zKPdzPHRzrZCpVpJQsgcB8BDlRt
         X9E/EsT7iHew09raZUg7x9yrqHRhKdDb8HRZyt+y1RHZJQFia4JCpiWEEEv8A11OLrKY
         9tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QoG22HnspjllNT117TzvZL8fTuogOE1oP6UZL8u0KsQ=;
        b=bR+Z3w+BXZRdOcJ87KFkpAoBjiLaqztCDL17iYVqD67z1IdXayYYV3FuQU2YBx682u
         ZVgbtkaLLwS9IGtxQr8UUGNsV5/QxflAK1XG/u+beOdeYCvp0CkH+hYsasS9iCHABRfc
         dx563/NGzlvSmpUdsCHRvtTINjGcbZNnSNI4wt3KrSF7+/qcgXfo7m3upeQ0RIzyxTxd
         YmKR/I2lSxjnvojMED0dtPjLL4f+VC2WikJwEfxm94FkO22B02qUDTy0k4GKQGdD4d8b
         1cDbIBKsucymhcmvojhF6Rk9EP8CHByEOZdow0eOsv3Y8RFpKMLpjZG/95d0yFzpxwxn
         s6Sg==
X-Gm-Message-State: AIVw113KXeSVQ04dYw0soFSW3g0gLs+Ftc1dVdXS7kaNVXfZKK2h39+O
        EVLhNeo3t67lT1sWw9Chkg==
X-Received: by 10.98.82.197 with SMTP id g188mr2405153pfb.34.1501005202143;
        Tue, 25 Jul 2017 10:53:22 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:8a2:3f4a:4174:ba80])
        by smtp.gmail.com with ESMTPSA id r62sm29683457pfl.45.2017.07.25.10.53.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 10:53:21 -0700 (PDT)
Date:   Tue, 25 Jul 2017 10:53:17 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        larsxschneider@gmail.com, chriscool@tuxfamily.org
Subject: Re: [PATCH] sub-process: refactor handshake to common function
Message-ID: <20170725105317.7c1ea016@twelve2.svl.corp.google.com>
In-Reply-To: <8abee4ab-de28-9181-6ff2-e6e171b27f58@gmail.com>
References: <20170724213810.29831-1-jonathantanmy@google.com>
        <8abee4ab-de28-9181-6ff2-e6e171b27f58@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Jul 2017 10:38:51 -0400
Ben Peart <peartben@gmail.com> wrote:

> Christian Couder has been working on a similar refactoring for the perl 
> versions of very similar helper functions.  They can be found in the 
> following patch series:
> 
> https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/
> 
> In particular:
> 
>      - Patches 02/49 to 08/49 create a Git/Packet.pm module by
>        refactoring "t0021/rot13-filter.pl". Functions from this new
>        module will be used later in test scripts.
> 
> Some differences I noticed: this patch does both the version and 
> capability negotiation and it lives in "sub-process.h/c" files.  In the 
> perl script patch series, the version negotiation is in the new 
> "packet.pm" module but it does not include the capability negotiation.
> 
> It would make sense to me for these to have the same API and usage 
> behaviors.  Perhaps pull them together into a single patch series so 
> that we can review and keep them in sync?

Thanks for the pointer. These are different languages and different use
cases (mine for production, his for tests), though, so I don't think
consistency in API and behavior is practical.

> > It is unfortunate that the code grew larger because it had to be more
> > generic, but I think this is better than having (in the future) 2 or
> > more separate handshake functions.
> 
> I'm always happy to see an effort to refactor common code into reusable 
> APIs.  Its a good engineering practice that makes it easier to 
> stabilize, extend and maintain the code. The challenge is making sure 
> the common function supports all the requirements of the various callers 
> and that the increase in complexity doesn't outweigh the benefit of 
> centralizing the logic.

Agreed - thanks.

> > +int subprocess_handshake(struct subprocess_entry *entry,
> > +			 const char *welcome_prefix,
> > +			 int *versions,
> > +			 int *chosen_version,
> > +			 struct subprocess_capability *capabilities,
> > +			 unsigned int *supported_capabilities) {
> > +	int version_scratch;
> > +	unsigned int capabilities_scratch;
> > +	struct child_process *process = &entry->process;
> > +	int i;
> > +	char *line;
> > +	const char *p;
> > +
> > +	if (!chosen_version)
> > +		chosen_version = &version_scratch;
> > +	if (!supported_capabilities)
> > +		supported_capabilities = &capabilities_scratch;
> > +
> > +	sigchain_push(SIGPIPE, SIG_IGN);
> > +
> > +	if (packet_write_fmt_gently(process->in, "%sclient\n",
> > +				    welcome_prefix)) {
> > +		error("Could not write client identification");
> > +		goto error;
> > +	}
> > +	for (i = 0; versions[i]; i++) {
> > +		if (packet_write_fmt_gently(process->in, "version=%d\n",
> > +					    versions[i])) {
> > +			error("Could not write requested version");
> > +			goto error;
> > +		}
> > +	}
> > +	if (packet_flush_gently(process->in))
> > +		goto error;
> > +
> > +	if (!(line = packet_read_line(process->out, NULL)) ||
> > +	    !skip_prefix(line, welcome_prefix, &p) ||
> > +	    strcmp(p, "server")) {
> > +		error("Unexpected line '%s', expected %sserver",
> > +		      line ? line : "<flush packet>", welcome_prefix);
> > +		goto error;
> > +	}
> > +	if (!(line = packet_read_line(process->out, NULL)) ||
> > +	    !skip_prefix(line, "version=", &p) ||
> > +	    strtol_i(p, 10, chosen_version)) {
> > +		error("Unexpected line '%s', expected version",
> > +		      line ? line : "<flush packet>");
> > +		goto error;
> > +	}
> > +	for (i = 0; versions[i]; i++) {
> > +		if (versions[i] == *chosen_version)
> > +			goto version_found;
> > +	}
> 
> This doesn't look like it supports negotiating a common version between 
> the client and server.  If a client supports version 1, 2, and 3 and the 
> server only supports version 1 and 2, which version and capabilities 
> will be used?

In the protocol, the client sends a list of versions it supports (see
the "for" loop above), and expects the server to write the single
version that the server chooses (see the part where we read one single
version line). In your example, the client would write "version=1\n",
"version=2\n", and "version=3\n", and the server would write
"version=2\n" (well, it could write "version=1\n" too). So version 2 (or
1) will be used.
