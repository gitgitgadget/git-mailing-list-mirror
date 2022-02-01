Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E5C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 20:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbiBAUOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiBAUOD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 15:14:03 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F86C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 12:14:03 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id e79so22654376iof.13
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 12:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=obPSu5VZ7DR+AOyNRZv6xw3aJxlg34G+r+bCfNdMs2c=;
        b=F2mqypOgK9XXzCAw/Lsr1QuYEClPdXxqMh3SO+L3SXuziyfxTgvyeFzRHNAk3i9aX5
         dGOh5+Ucn907LbUg5fd8WbR/+JmwuIEVeRgLy2ja4nfS29oH5kXDdNykm6Q1AQ7ucqOy
         3dvzj3xq3r6oCon5M70Wfu+pJqlZndRRVLYS+ryrChJ1euznMU+kvsbMDYm03IJ8ZeaM
         XC5zPb0zT3kqHIvEqWC8ko/iqS4cjlGaUpoI47Ei3waqwaDxJHRBuwv3Il/0joM6/MXj
         yym99MnsmyOdPuT8UbWbVEcGmW6pfRrx1UQQI4mzvSe4QphVgke39Rb0B6kkduo5ZgNj
         1tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=obPSu5VZ7DR+AOyNRZv6xw3aJxlg34G+r+bCfNdMs2c=;
        b=WXRs1L1CBuat+XGbIuypiieocdy8LBUr0thHI0rhTqz8dRSEYGh2cYbFE7A6Puq3pH
         SukJoTsoqhXtJ5FDUCNIZBYST3mfxzHOqhhYiNJ+S4eF3g04xSqpuDWcFpz8TVE0amPi
         LbXePR1lsRR27yYBVpEQoM5wacfjwCjyjwgRcVjgiXqh8QIWi5tIBzlyWmAA7QUYiHRY
         +AnC4US8IxQp2V6JLKXw4WPHo3hK5XOme8s4A19CN3TslHz8w55QqvHkYE5mc57oyxq+
         Rbzp68PozNeJmALtECBvAProYQr+TWKMUrazQV+f5DGx8lUeGBFe6iLxz15PEjQc/JwA
         S4Kg==
X-Gm-Message-State: AOAM5334bJi6m81wymackJ1kBNvDpyHxQf6rrxNnft7eZ22SICi818Wk
        v5bXgX3sJ/rxXDarb4NqgGGGWvJEj3e4Ig==
X-Google-Smtp-Source: ABdhPJxiPg1ZD8mvtJYdW128cYzrEebEinJqIS2da6FlUyFtXEMHb00vMAsbyOBNobXrkfubOlOlyQ==
X-Received: by 2002:a05:6602:3419:: with SMTP id n25mr14962354ioz.130.1643746442890;
        Tue, 01 Feb 2022 12:14:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y7sm13329671ilu.55.2022.02.01.12.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 12:14:02 -0800 (PST)
Date:   Tue, 1 Feb 2022 15:14:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
Message-ID: <YfmUiXJ//ZC5NZU+@nand.local>
References: <20220128183319.43496-1-johncai86@gmail.com>
 <CAP8UFD3sHvA3Gx9+d=VjQ11sEqWF47AEeo-m4bGsVO3OUJ4dLw@mail.gmail.com>
 <YflzZsb/txsopusP@nand.local>
 <674CD40F-7060-4892-97CD-1940AEF7C3D7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <674CD40F-7060-4892-97CD-1940AEF7C3D7@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 01, 2022 at 02:27:54PM -0500, John Cai wrote:
> On 1 Feb 2022, at 12:52, Taylor Blau wrote:
> > I'm not sure that I've seen a response along the lines of "we need to
> > control when the output stream is flushed in order to do ..." yet, but I
> > would be interested to see one before moving too much further ahead of
> > where we already are.
>
> This would be useful when there is another process A interacting with
> a long running git cat-file process B that is retrieving object
> information from the odb interactively but also wants to use --buffer
> mode.

Let me try and repeat my understanding of what you said to make sure
that I fully grok the use-case you have in mind.

You have a repository and want to have a long-running `git cat-file`
process that can serve multiple requests. Because the processes which
interact with your long-running `cat-file` may ask for many objects, you
don't want to flush the output buffer after each object, and so would
ideally like to use `--buffer`.

But that doesn't quite work, since the `cat-file` process may not have
decided to flush its output buffer even when process A is about to go
away.

I wonder about the viability of accomplishing this via a signal handler,
i.e., that `cat-file` would call fflush(2) whenever it receives e.g.,
SIGUSR1. A couple of possible downsides:

  - SIGUSR1 doesn't exist on Windows AFAIK.

  - There are definitely going to be synchrony issues to contend with.
    What happens if we receive our signal while writing to the output
    stream? I think you would just need to mark a variable that
    indicates we should flush after finishing serving the current
    request, but I haven't thought too hard about it.

So maybe a signal isn't the way to go. But I don't think `--stdin-cmd`
is the simplest approach either. At the very least, I don't totally
understand your plan after implementing a flush command. You mention
that it would be nice to implement other commands, but I'm not totally
convinced by your examples[1].

I wonder if we could strike a middle ground, which might look like `git
cat-file --batch --buffer`, and just feeding it something which we know
for certain isn't an object identifier. In other words, what if we
did something as simple as:

--- >8 ---

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d94050e6c1..bae162fc18 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -595,6 +595,11 @@ static int batch_objects(struct batch_options *opt)
 	warn_on_object_refname_ambiguity = 0;

 	while (strbuf_getline(&input, stdin) != EOF) {
+		if (!strcmp("<flush>", input.buf)) {
+			fflush(stdout);
+			continue;
+		}
+
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning

--- 8< ---

On the other hand, something even hackier than the above is that we
flush stdout whenever we get a request to print an object which could
not be found. So if you feed a single "\n" to your `cat-file` process,
you'll get " missing" on its output, and the buffer will immediately be
flushed.

I'm not sure that I'd recommend relying on that behavior exactly, but if
you're looking for a short-term solution, it might work ;).

Thanks,
Taylor

[1]: One that comes to mind is changing the output format mid-stream.
     But how often does it really make sense to change the output
     format? I can understand wanting to flush at the end asking
     cat-file for a bunch of objects, but I don't see how you would want
     to change the output format often enough that shaving off Git's
     negligible startup cost is worthwhile (or couldn't be accomplished
     by just spawning another cat-file process and using that).
