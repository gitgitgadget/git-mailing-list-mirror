Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD942035E
	for <e@80x24.org>; Wed, 12 Jul 2017 18:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbdGLStn (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:49:43 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34443 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbdGLStm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:49:42 -0400
Received: by mail-pg0-f53.google.com with SMTP id t186so17285170pgb.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e1YXOQm7WFGI46qPzcqDmgl1IK7V8Dzs97QyYHN/lwI=;
        b=mHD1Le4jeAFkh71Ln4gDJxqJZgA23dNEQa1qun62a4bzFvIr/4cB187juyZVfzulHX
         Z1UGGbTTmfZ4GSdzvjcLK2DpghNIjnv7KO5hoiGtpEgNe4cmAR9AcjuC6oooqqe8oVuw
         DZ6Tww1P9ZeoyoI/FvTXImM3lvZyjs9qEoUT1tQAtYFh1FgAYkuMr/x6chDkFQO9PC2U
         VVVNxt+sq3wFTWy6KjKNSR6Jt3gRkV0e6Y92ztpxcOuNnRwcj/Frc99/O9IWLQVXSoX6
         zhWTTde+W/rFakGuFNRNpD/IlFeWlWg66uVsAYzgigMrKWXChws6dfsKN8f9ZvwnMg1m
         bybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e1YXOQm7WFGI46qPzcqDmgl1IK7V8Dzs97QyYHN/lwI=;
        b=OvuTfqEmsuJfbVjxyubWUf/0wr7BOpI11UQdoYhUKRq29xeiTNPQpdJX7OEPoDknPw
         p1kRK4lx8O9w3RQ7O5flH/zF6meR1dpMjZOZOTRXK6KIAGSHqOMK1BEA0qcECW6kMEFv
         nGVoDOkx1nIhMW3VHj0QLjkD6gacooajmKhBpdmtiY32DP4MV8yewEOiA+jekU/3U582
         8H0P0TAq8ZMEkZsfFaBAQSqSE+G3l6LycESJgaiyeT637bZtqfFINM7/6bGoZZcfVXyZ
         4urZHucSS10WhSx8af6JTbGwQVQil6oix1AKOTHhbeIBolhp+rEa0dED+SRmuV+uLHx3
         4Bpg==
X-Gm-Message-State: AIVw113HwkHda3hvYiAggCvW6fgrEEFYr/W1DmM214E3f4QYXy90fD3v
        CSXk1wwwL87eh6FQ
X-Received: by 10.84.238.206 with SMTP id l14mr5472376pln.280.1499885381809;
        Wed, 12 Jul 2017 11:49:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3d1f:bb9:8897:56b4])
        by smtp.gmail.com with ESMTPSA id 74sm6855120pfh.49.2017.07.12.11.49.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 11:49:40 -0700 (PDT)
Date:   Wed, 12 Jul 2017 11:49:39 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 3/3] grep: recurse in-process using 'struct repository'
Message-ID: <20170712184939.GF65927@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-4-bmwill@google.com>
 <20170712002533.GD93855@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712002533.GD93855@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > Convert grep to use 'struct repository' which enables recursing into
> > submodules to be handled in-process.
> 
> \o/
> 
> This will be even nicer with the changes described at
> https://public-inbox.org/git/20170706202739.6056-1-sbeller@google.com/.
> Until then, I fear it will cause a regression --- see (*) below.
> 
> [...]
> >  Documentation/git-grep.txt |   7 -
> >  builtin/grep.c             | 390 +++++++++------------------------------------
> >  cache.h                    |   1 -
> >  git.c                      |   2 +-
> >  grep.c                     |  13 --
> >  grep.h                     |   1 -
> >  setup.c                    |  12 +-
> >  7 files changed, 81 insertions(+), 345 deletions(-)
> 
> Yay, tests still pass.
> 
> [..]
> > --- a/Documentation/git-grep.txt
> > +++ b/Documentation/git-grep.txt
> > @@ -95,13 +95,6 @@ OPTIONS
> >  	<tree> option the prefix of all submodule output will be the name of
> >  	the parent project's <tree> object.
> >  
> > ---parent-basename <basename>::
> > -	For internal use only.  In order to produce uniform output with the
> > -	--recurse-submodules option, this option can be used to provide the
> > -	basename of a parent's <tree> object to a submodule so the submodule
> > -	can prefix its output with the parent's name rather than the SHA1 of
> > -	the submodule.
> 
> Being able to get rid of this is a very nice change.
> 
> [...]
> > +++ b/builtin/grep.c
> [...]
> > @@ -366,14 +349,10 @@ static int grep_file(struct grep_opt *opt, const char *filename)
> >  {
> >  	struct strbuf buf = STRBUF_INIT;
> >  
> > -	if (super_prefix)
> > -		strbuf_addstr(&buf, super_prefix);
> > -	strbuf_addstr(&buf, filename);
> > -
> >  	if (opt->relative && opt->prefix_length) {
> > -		char *name = strbuf_detach(&buf, NULL);
> > -		quote_path_relative(name, opt->prefix, &buf);
> > -		free(name);
> > +		quote_path_relative(filename, opt->prefix, &buf);
> > +	} else {
> > +		strbuf_addstr(&buf, filename);
> >  	}
> 
> style micronit: can avoid these braces since both branches are
> single-line.

Didn't realize that with all the deleted lines, I'll fix for the next
version.

> 
> [...]
> > @@ -421,284 +400,80 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
> >  		exit(status);
> >  }
> >  
> > -static void compile_submodule_options(const struct grep_opt *opt,
> > -				      const char **argv,
> > -				      int cached, int untracked,
> > -				      int opt_exclude, int use_index,
> > -				      int pattern_type_arg)
> > -{
> [...]
> > -	/*
> > -	 * Limit number of threads for child process to use.
> > -	 * This is to prevent potential fork-bomb behavior of git-grep as each
> > -	 * submodule process has its own thread pool.
> > -	 */
> > -	argv_array_pushf(&submodule_options, "--threads=%d",
> > -			 (num_threads + 1) / 2);
> 
> Being able to get rid of this is another very nice change.
> 
> [...]
> > +	/* add objects to alternates */
> > +	add_to_alternates_memory(submodule.objectdir);
> 
> (*) This sets up a single in-memory object store with all the
> processed submodules.  Processed objects are never freed.
> This means that if I run a command like
> 
> 	git grep --recurse-submodules -e neverfound HEAD
> 
> in a project with many submodules then memory consumption scales in
> the same way as if the project were all one repository.  By contrast,
> without this patch, git is able to take advantage of the implicit
> free() when each child exits to limit its memory usage.
> 
> Worse, this increases the number of pack files git has to pay
> attention to the sum of the numbers of pack files in all the
> repositories processed so far.  A single object lookup can take
> O(number of packs * log(number of objects in each pack)) time.  That
> means performance is likely to suffer as the number of submodules
> increases (n^2 performance) even on systems with a lot of memory.
> 
> Once the object store is part of the repository struct and freeable,
> those problems go away and this patch becomes a no-brainer.
> 
> What should happen until then?  Should this go in "next" so we can get
> experience with it but with care not to let it graduate to "master"?

I agree that this is an issue and that we need to address by having
an object store per repository.  While that is being worked on (by
Stefan) I don't know how long it would take to have it be a reality.
So the question ends up being do we care more about the state of the
code and cleaning up a lot of 'hacks' that I introduced to get grep
working with submodules, or do we care about the performance more.  I
don't know which is the right answer but I'd personally like to see the
hacks I added to be removed sooner rather than later.  That and I think
that with the code in this sate it would make it easier to transition
once we have per-repository object-stores.

Either way I should add a NEEDSWORK comment here to indicate that it
should be removed once per-repo object-stores exist.

> 
> Aside from those two concerns, this patch looks very good from a quick
> skim, though I haven't reviewed it closely line-by-line.  Once we know
> how to go forward, I'm happy to look at it again.
> 
> Thanks,
> Jonathan

-- 
Brandon Williams
