Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BE4C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 20:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1453F2071E
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 20:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSlf3qWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfLBUul (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:50:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37869 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfLBUul (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 15:50:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so302377pga.4
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 12:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NtG87ZsMX7qtzQ8jAGvIQsKesfqkCiaeP3a2vAliqrg=;
        b=XSlf3qWToHVfSOdO/d5OvNr5p5Q4S4MOPcMkOeGfHHxbLAw5KvEfSA40d+IxayxvkZ
         jQ4+QxNMG0Rl9WYZ8UglSRMqi9Mi2q7kHJpFu4V7fkkQ9np/8CKmWXNd9ZqBBbo0IJax
         peXiX9vqYyDlHG3NARedXQKc8WhgCUsrS7K+jA+il/l47tz6ZC/mbv+RxLhL7VB7nOK7
         OhtBlw+vn1v/CL+0cJl4ICjVFLY0wQTZzReAyrVWEGjWtPlLdsvPs2gj9wigXJEArrHm
         EBJuphfD1TdF+rxD8DN4QaJKaPlJzwxEK0YO41fa9TWWpPJ4Esu4p4We+iOfpJ9RyaJG
         QeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NtG87ZsMX7qtzQ8jAGvIQsKesfqkCiaeP3a2vAliqrg=;
        b=Oeaj/Xp+abLZPjxkC58CqoDEsh0AtduWRRjNAAOZWXd3GHFAX+ht32OqNk8dt+mprn
         +4rO+NzvEZWbHGHKn2bpke7I96yNTKs4RlZyN030Ad7Y9CI1FF+2vTjRGt2fE34D4pu5
         CMphJ+wGaCSAeHqVnSj8sLUgTHelkAz1fP9Ge9Dly4+ob8DMp/xRz8hq/TUnJlUZ6nXq
         X4YGVm1G+2QszOUmMlyZ6bXfhBzWzhD+MEeju5mD3OOLZsKTxhFKEM3B9Pi9KYdscFje
         IMGUmSTqNBtDTgro96ZjTD4+M6wGs55GD15Lwg2RvEKpIl/XTDNZYNt4yXkgFMJkiBal
         wj7Q==
X-Gm-Message-State: APjAAAX9hQM6fLJAnt/4Sdj3c2BroKyOQSlp9zlqcT/ZJapjMk1IkwzK
        mHO3PNn2b0xuHsdNJLja6aY=
X-Google-Smtp-Source: APXvYqwPMqwdAPBYNVowa0qKke2GaSH8A8e8/VvJeWQs76Aiy7zPFTqKevVs4bTFIJsF+qfa9IRn8w==
X-Received: by 2002:a63:a34b:: with SMTP id v11mr1052508pgn.229.1575319840116;
        Mon, 02 Dec 2019 12:50:40 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id w6sm395160pfq.99.2019.12.02.12.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:50:39 -0800 (PST)
Date:   Mon, 2 Dec 2019 12:50:37 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 22/26] t7700: consolidate code into
 test_no_missing_in_packs()
Message-ID: <20191202205037.GA43606@generichostname>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
 <a99a45cb6f2cc7328ef0e52fc2ea8fec537bfba9.1574884302.git.liu.denton@gmail.com>
 <xmqq7e3i4b1p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e3i4b1p.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Nov 29, 2019 at 01:39:30PM -0800, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > The code to test that objects were not missing from the packfile was
> > duplicated many times. Extract the duplicated code into
> > test_no_missing_in_packs() and use that instead.
> >
> > Refactor the resulting extraction so that if any git commands fail,
> > their return codes are not silently lost.
> >
> > We were using sed to filter lines. Although not incorrect, this is
> > exactly what grep is built for. Replace this invocation of sed with grep
> > so that we use the correct tool for the job.
> 
> Well, 
> 
>     $ sed -n -e 's/required match/desired part of the line/p'
> 
> is much much more approirate than 
> 
>     $ grep -e "requred match" |
>       extract desired part of the line
> 
> "grep" is better only if the original were
> 
>     $ sed -n -e '/required match/p'
> 
> but everybody would write it with grep to begin with ;-)

This was what I was intending. It was originally written like the above
and it made sense to convert it to use grep. I guess "filter lines" in
my commit message is a little bit vague. Could we change this to "filter
matching lines" perhaps?

> 
> So, I dunno about this part of the conversion.
> 
> > Instead of verifying each file of `alt_objects/pack/*.idx` individually
> > in a for-loop, batch them together into one verification step.
> 
> Do you mean this one?
> 
> 	git verify-pack -v alt_objects/pack/*.idx
> 
> where we may pass 1 or more .idx file to the command?  At first my
> reading was interrupted by a "Huh?", but that does look good.  We'd
> need to be a bit careful to make sure that we have at least 1 .idx
> file, as the shell will happily feed a file whose name is "*.idx",
> which verify-pack would be unhappy about.
> 
> > The original testing construct was O(n^2): it used a grep in a loop to
> > test whether any objects were missing in the packfile. Rewrite this to
> > sort the files then use `comm -23` so that finding missing lines from
> > the original file is done more efficiently.
> 
> OK.  If we an show measurable speedups, it would be great, but the
> loop structure does look O(n^2) and unnecessary costly.
> 
> > +test_no_missing_in_packs () {
> > +	myidx=$(ls -1 .git/objects/pack/*.idx) &&
> > +	test_path_is_file "$myidx" &&
> 
> If there are 2 or more .idx files, or if there is none, $myidx would
> hopefully be a concatenation of these filenames or a string that
> ends with asterisk-dot-idx and would fail path_is_file.  Sounds OK.
> 
> Ah, I do not have to review this part---these are repeated patterns
> in the original.
> 
> > +	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
> > +	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&
> 
> If output from 'grep' can be used as-is, it is worth doing, but if
> you have to pipe it to cut, the original that used sed to filter and
> edit the line would probably be a better way to write it.

The original sed actually only filtered the line; no editing done. The
cut invocation was a consequence of using comm. Previously, in the while
loop, we would separate the line into `sha1` and `rest` components and
only match using the `sha1`. Since we use comm now, we have to use cut
to grab the sha1 and omit the rest of the line.

We could rewrite it with sed like this:

	sed -n -e "/^[0-9a-f]\{40\}/s/^\($[0-9a-f]\{40\}\).*/\1/" orig.raw

but I believe that breaking it into grep and cut makes the intent much
more clear. 

What do you think?

(By the way, if I were to reroll this series, should I keep sending out
the entire patchset? It feels very noisy to send out 20-something emails
every reroll when I'm just making a small one or two line change.)

Thanks,

Denton

> 
> > +	git verify-pack -v $myidx >dest.raw &&
> 
> This part does not quote $myidx" (inherited from the original); it
> probably is OK, as any potentially problematic value in $myidx would
> have been caught as an error much earlier in this test.
> 
