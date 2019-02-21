Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA611F453
	for <e@80x24.org>; Thu, 21 Feb 2019 18:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfBUSty (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 13:49:54 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41612 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBUStx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 13:49:53 -0500
Received: by mail-pf1-f202.google.com with SMTP id z1so4099932pfz.8
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ysKrldl/6vCUgJ74MHd0jtUsJcd4F0IS/gJhcr1BWpc=;
        b=sYYP9nkbrah8PFl9eKqWWCerzp1bnkivSCt56rVX3BRu+kKdnFmyZfRRCC9UFQuqwC
         t9SHxvzChf+++5ZN7Nv6hkMXbYciCG+rp8UTr+o37I3dNnTI1PU/WLpyDevGKJrZbHcR
         pXT3TkMS2rKWTcytPkAi8svvROkHVDKS8Pg8kjzGXCQo1KK5U3v6lOt+nhmiridH7/ch
         6B4qZ6RzIcs974ANdq+saS8ET6B+4fJAt8tBdXFQJNlzP0jk3haSyM77zDib6/Lca20B
         DHnLdnNyDGZs0IX8YNB9LbbUGXrdkXff7eruDPjFzGUI9z4YWPsIEmXB7lE9MWu5hb5P
         QiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ysKrldl/6vCUgJ74MHd0jtUsJcd4F0IS/gJhcr1BWpc=;
        b=qVE9VcdePHfWNzmF5YTeXo8B8yiuNmad57gVxhVXbdYL3jdpWO1GcU7D0HT51RiTHg
         V1kiHx2+soEtyjMgQHp6b/tZ70jOnhyl1Nq4gkMFWtDNNl4DBJE5reEpGV4IDR95uLb9
         vxZfhWFJmKZsS7WyhhLtHf78R0faBzvennBptKRsgV64ZqLa1PmzJWz34rL5JEmjzY3F
         r32ioFFqsxB1CSNi8LYJLxMP2Wk7uMLbL4kB6OY5+LhnuZebGLv6u57D6p2zBRB/vIds
         IUCs5o4xlSa8euh5cfURQT1MHYL4zNsPvtopQgM7zLiHGD4M74A+gm53d+AG5BO+iGgB
         iEdg==
X-Gm-Message-State: AHQUAuajBXqEj2ameCkV/4aW6Yuz/F/wCsRMF4pkvnsAHS3FuxhHsaF1
        xvQg8BH7gtIOXcN503pT3f5FtUDCB+KdxmxNjVhS
X-Google-Smtp-Source: AHgI3IZmcxncLeMgSD7l3zD19HXPvbcTJS14BKfRWPR+6vUTkK1Rful0VMJfl2PGPIQvu2Fw07cbmWeUiM5jqBUATcxk
X-Received: by 2002:a62:2943:: with SMTP id p64mr4735238pfp.81.1550774992745;
 Thu, 21 Feb 2019 10:49:52 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:49:48 -0800
In-Reply-To: <20190221140809.GA21759@sigill.intra.peff.net>
Message-Id: <20190221184948.100083-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190221140809.GA21759@sigill.intra.peff.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [RFC PATCH] http: use --stdin and --keep when downloading pack
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Feb 20, 2019 at 04:14:47PM -0800, Jonathan Tan wrote:
> 
> > This is part of the work of CDN offloading of fetch responses.
> > 
> > I have plans to use the http_pack_request suite of functions to
> > implement the part where we download from CDN over HTTP(S), but need
> > this change to be able to do so. I think it's better from the code
> > quality perspective to reuse these functions, but this necessitates a
> > behavior change in that we no longer use the filename as declared by the
> > server, so I'm sending this as RFC to see what the community thinks.
> 
> I think it makes sense. We don't use the server names for any of the
> other protocols, and I'm happy to see one less place where we may
> inherit a stupid or malicious item of data from the server.

Thanks. That's true.

> I was puzzled that you had to touch http-push.c. But indeed, it seems to
> have some fetching code in it, too? I'm willing to throw up my hands in
> disgust at the http-push code without looking further at this point. :)

:)

> >  	argv_array_push(&ip.args, "index-pack");
> > -	argv_array_pushl(&ip.args, "-o", tmp_idx, NULL);
> > -	argv_array_push(&ip.args, preq->tmpfile.buf);
> > +	argv_array_push(&ip.args, "--stdin");
> > +	argv_array_pushf(&ip.args, "--keep=git %"PRIuMAX, (uintmax_t)getpid());
> >  	ip.git_cmd = 1;
> > -	ip.no_stdin = 1;
> > -	ip.no_stdout = 1;
> > +	ip.in = tmpfile_fd;
> > +	ip.out = -1;
> >  
> > -	if (run_command(&ip)) {
> > -		unlink(preq->tmpfile.buf);
> > -		unlink(tmp_idx);
> > -		free(tmp_idx);
> > -		return -1;
> > +	if (start_command(&ip)) {
> > +		ret = -1;
> > +		goto cleanup;
> >  	}
> >  
> > -	unlink(sha1_pack_index_name(p->sha1));
> > +	*lockfile = index_pack_lockfile(ip.out);
> > +	close(ip.out);
> 
> We're now doing bi-directional I/O with index-pack. But it should be
> deadlock-free, because we know the output is small and will only come at
> the end after we've closed its stdin.

Yes. This is also how fetch-pack.c does it, for example.

> > -	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->sha1))
> > -	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
> > -		free(tmp_idx);
> > -		return -1;
> > +	if (finish_command(&ip)) {
> > +		ret = -1;
> > +		goto cleanup;
> >  	}
> 
> If the command fails but we got something in *lockfile, should we clean
> it up? Likewise, do we need to be installing a signal handler to clean
> it up in case we die in other code paths (or by a signal)?

My inclination is not to do it - as far as I can tell, we don't have
cleanup or signal handlers in fetch-pack.c either.
