Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BB3C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF4220719
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isfuG0I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDGXBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:01:38 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:39600 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGXBi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 19:01:38 -0400
Received: by mail-pg1-f173.google.com with SMTP id g32so2435175pgb.6
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=96SrzJPXaNIl/adQYBPCs3K42AYgV9pTr+6iYmWenz4=;
        b=isfuG0I5fbhIhGsdmTsokEDTNDjf3Zu0KUpXrqDM0dvdPu2qG06PPPAsaDZstaRPpE
         VLR7V1wkKtVuItShX8SQyzBfEFTrIucCCuLOFUCWrmgGGWtUyPtEuqP/4ooKtlfM2n0a
         sNS7fympG6+dVx79sSvbnFV1poSIvQXCNSeE9L83rdLwstYXV+hIq8bXcWO/xPga8UKD
         GqFKJum9Jf2zT4V6RAfhfwaNw+6jB27//dFxjRlWuCXcysIhJDCyXxcGNOYZ+WMJJuFN
         9KXvYdD3qjrgmiosS6KPW+dCG5B/Jp8bjupGoKmJNj9WQVh62Ckbs0kbeTkPKP+JvvbK
         /hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=96SrzJPXaNIl/adQYBPCs3K42AYgV9pTr+6iYmWenz4=;
        b=U7S0H91g5VmicJZSG5L2FRYqkoRSMA8+TqOjhsxux0izB+J6nqAs83UjxsOPUXl0PR
         mmvXlkBPJO0k/uK+GNCuo0iZRs9EDWAs9yuH4W76OgDnM+azgtDGHxcDOXfebvsUXy8w
         WQZUyGGivJT9BleLndj4MNGUE6VUQMp5ZvgmBhKpXdg2aZWKJbbPnzwV6QqcI/H+Jww/
         kPCLfEQ0pmF0QhNfSBMwAGiKV5ZNI01CvmQV3W34EU0uK0BMmfGWKA4Hw1Q4faVj1xwB
         SA3K8lV2uiSLT280I6WRaOYoz09LoHqD/DQoV5CvZdhNwhi4pMZbuLaVWO8N/hD3tHk6
         o8IQ==
X-Gm-Message-State: AGi0Pubu/6lxZDJ+eGSemmomMDy9daWnBubd897RtgPSanfLSKyS6y7c
        bFwRKjZjQMBprdvH/uhLCas73g==
X-Google-Smtp-Source: APiQypJ9VDRjqKWUIQA+48w8hh3mVUtiJXynNawiIc9EN8Dkl28P+iPjGC5qhR1Z5pTcLckiTS0OgA==
X-Received: by 2002:a63:a07:: with SMTP id 7mr3317390pgk.261.1586300497237;
        Tue, 07 Apr 2020 16:01:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id o187sm672852pfb.12.2020.04.07.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 16:01:36 -0700 (PDT)
Date:   Tue, 7 Apr 2020 16:01:32 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200407230132.GD137962@google.com>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
 <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 10:56:59AM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:

Phew - now that git-bugreport looks to be on the path to 'next' I get to
work on hooks again :) Forgive me for the late reply.

> 
> > This means that we could do something like this:
> >
> > [hook "/path/to/executable.sh"]
> > 	event = pre-commit
> > 	order = 123
> > 	mustSucceed = false
> > 	parallelizable = true
> >
> > etc, etc as needed.
> 
> You can do
> 
>     [hook "pre-commit"]
> 	order = 123
> 	path = "/path/to/executable.sh"
> 
>     [hook "pre-commit"]
> 	order = 234
> 	path = "/path/to/another-executable.sh"
> 
> as well, and using the second level for what hook the (sub)section
> is about, instead of "we have this path that is used for a hook.
> What hook is it?", feels (at least to me) more natural.

Yeah, I see what you mean, and it's true I misread the notes and
misremembered Peff's suggestion. I was reworking my RFC patch some
today, and noticed that the following two configs:

A.gitconfig:
  [hook "pre-commit"]
    command = "/path/to/executable.sh"
    option = foo
  [hook "pre-commit"]
    command = "/path/to/another-executable.sh"

B.gitconfig:
  [hook "pre-commit"]
    command = "/path/to/executable.sh"
  [hook "pre-commit"]
    option = foo
    command = "/path/to/another-executable.sh"

are indistinguishable during the config parse - both show up during the
config callback looking like:

  value = "hook.pre-commit.command"; var = "/path/to/executable.sh"
  value = "hook.pre-commit.option"; var = "foo"
  value = "hook.pre-commit.command"; var = "/path/to/another-executable.sh"

I didn't see anything to get around this in the config parser library;
if I missed it I'd love to know.

Using the hook path as the subsection still doesn't help, of course. I
think the only way I see around it is to require a specific value at the
beginning of each hook config section, e.g. "each hook entry must begin
with 'command'"; that means that the config parser callback can look
something like:

  parse section, subsection, key
  if section.subsection = "hook.pre-commit":
    if key = "command":
      add a new hook to the hook list
    else:
      operate on the tail of the hook list

The price of this is poor user experience for those handcrafting their
own hook configs, but I don't think it's poorer than carefully spelling
out "123:~/my-hook-path.sh:whatever:other:options" or something. I'll
add that I had planned to teach 'git-hook' to write and modify config
files for the user with an interactive-rebase-like UI, so a brittle
config layout might not be the end of the world.

Or, I suppose, we could teach the config parser how to understand
"structlike" configs like this where repeated header entries need to be
collated together. That seems to be contrary to the semantics of the
config file right now, though, and it looks like it'd require a rework
of the config_set implementation: today config_set_element looks like

  struct config_set_element {
          struct hashmap_entry ent;
          char *key; /* "hook.pre-commit.command" */
          struct string_list value_list; /* "/path/to/executable.sh"
	                                  * "path/to/another-executable.sh"
					  */
  };

I'm not very keen on the idea of changing the way configs are stored for
everyone, although if folks are unsatisfied with the way it is now and
want to do that, I guess it's an option. But it's certainly more
overhead than my earlier suggestion.

Thoughts?

 - Emily
