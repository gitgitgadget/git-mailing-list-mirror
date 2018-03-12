Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5E81F404
	for <e@80x24.org>; Mon, 12 Mar 2018 22:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeCLWju (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 18:39:50 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:41017 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWjt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 18:39:49 -0400
Received: by mail-pf0-f175.google.com with SMTP id f80so5004087pfa.8
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kcNc3t1k0kYkN7fxlEUQcn+8/jaxVxsU/lBjsxR7DtI=;
        b=ejJHz9xJ/Wm4Rn5gdjt4hFyKRVTl1MN2zXbmNr04gVgIqEXLoZjWxrbpG0I8xQsB6M
         DwFzu+xeA+CMbVnCnItCknX0CcltIrl6QswdCHQGf4/dTI+46vStf+GGRnCDPS6rNyuB
         qu6+25sLW4r38LLi8bPfSVMqregBMCO3GU/imA2uVb97xbZZqc1NDF49WcXoxP7i5XcK
         syHz+q5xOTRrem+QZ3ud6WccGHzcTv9yXjJfWa7TmFgNZJ0M/TbHvu7ztjhEMYQvXmbU
         bfsW+GzZyE6474BFEVmh4yw/S+Crj4CPX3x11mmYDZFzReN3sm+wiyEyBHrlJGpyHqMC
         yGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kcNc3t1k0kYkN7fxlEUQcn+8/jaxVxsU/lBjsxR7DtI=;
        b=WQ6zXZlj0TLcXnZ3/ZIG58TMa++t+o5855DheV5W9lBwa2tyauouAC2Ik2P6ayZLr7
         SmA23fFfNnyKyop8161L9yxqh6sNuAv1p0H/n+3JA7pja8RoHIEfT1cjDHE4Wj2slehk
         fY66rVYEUhgl+RAMFpjzV0quNTuTt9CJ+NDiQ4C/qQlXztXiDEbIjxDWW7S13Fp+iXju
         TjWlAT75gaA5NUVxLW5pyqTXn5B4wK8lIm+DqdHRPhrmtXq9VBtwOnZSI8hkxAUritB8
         kfe3nb1jUB4J61BLEAiR/a59t4GhXTk3aSSHzFciBtux+iO/dUNtgwm7nqhdi+HbdnuC
         5z/Q==
X-Gm-Message-State: AElRT7HfLBitoApNx6NQec/eZR0o6f1/bSmX1eJjn0ksEAi0uhcs24PX
        Aqq0n/CNeA5G1elfXdjsFBYddFd8irA=
X-Google-Smtp-Source: AG47ELtkKvhvTPqRW6VOcfm6i5ye56YkpIj0Fz/yDhUx73Bn5r69h63qeg+diQloU2w0DnLthmH9qw==
X-Received: by 10.98.180.13 with SMTP id h13mr9382680pfn.139.1520894388633;
        Mon, 12 Mar 2018 15:39:48 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id i125sm18906763pfe.176.2018.03.12.15.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 15:39:47 -0700 (PDT)
Date:   Mon, 12 Mar 2018 15:39:46 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 05/35] upload-pack: factor out processing lines
Message-ID: <20180312223946.GF61720@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-6-bmwill@google.com>
 <xmqq371jfpzj.fsf@gitster-ct.c.googlers.com>
 <20180312222443.GE61720@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312222443.GE61720@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/12, Brandon Williams wrote:
> On 03/01, Junio C Hamano wrote:
> > Brandon Williams <bmwill@google.com> writes:
> > 
> > > Factor out the logic for processing shallow, deepen, deepen_since, and
> > > deepen_not lines into their own functions to simplify the
> > > 'receive_needs()' function in addition to making it easier to reuse some
> > > of this logic when implementing protocol_v2.
> > 
> > These little functions that still require their incoming data to
> > begin with fixed prefixes feels a bit strange way to refactor the
> > logic for later reuse (when I imagine "reuse", the first use case
> > that comes to my mind is "this data source our new code reads from
> > gives the same data as the old 'shallow' packet used to give, but in
> > a different syntax"---so I'd restructure the code in such a way that
> > the caller figures out the syntax part and the called helper just
> > groks the "information contents" unwrapped from the surface syntax;
> > the syntax may be different in the new codepath but once unwrapped,
> > the "information contents" to be processed would not be different
> > hence we can reuse the helper).
> > 
> > IOW, I would have expected the caller to be not like this:
> > 
> > > -		if (skip_prefix(line, "shallow ", &arg)) {
> > > -			struct object_id oid;
> > > -			struct object *object;
> > > -			if (get_oid_hex(arg, &oid))
> > > -				die("invalid shallow line: %s", line);
> > > -			object = parse_object(&oid);
> > > -			if (!object)
> > > -				continue;
> > > -			if (object->type != OBJ_COMMIT)
> > > -				die("invalid shallow object %s", oid_to_hex(&oid));
> > > -			if (!(object->flags & CLIENT_SHALLOW)) {
> > > -				object->flags |= CLIENT_SHALLOW;
> > > -				add_object_array(object, NULL, &shallows);
> > > -			}
> > > +		if (process_shallow(line, &shallows))
> > >  			continue;
> > > +		if (process_deepen(line, &depth))
> > >  			continue;
> > 		...
> > 
> > but more like
> > 
> > 		if (skip_prefix(line, "shallow ", &arg) {
> > 			process_shallow(arg, &shallows);
> > 			continue;
> > 		}
> > 		if (skip_prefix(line, "deepen ", &arg) {
> > 			process_deepen(arg, &depth);
> > 			continue;
> > 		}
> > 		...
> > 
> > I need to defer the final judgment until I see how they are used,
> > though.  It's not too big a deal either way---it just felt "not
> > quite right" to me.
> 
> This is actually a really good point (and maybe the same point stefan
> was trying to make on an old revision of this series).  I think it makes
> much more sense to refactor the code to have a structure like you've
> outlined.  I'll fix this for the next version.

And then I started writing the code and now I don't know which I
prefer.  The issue is that its for processing a line which has some well
defined structure and moving the check for "shallow " away from the rest
of the code which does the processing makes it a little less clear how
that shallow line is to be defined.

-- 
Brandon Williams
