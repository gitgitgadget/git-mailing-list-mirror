Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77433C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 00:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BF2610D2
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 00:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhHSAKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 20:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhHSAKV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 20:10:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0277CC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 17:09:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso3535137pjy.5
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 17:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6HcZd+uNQux8v7Ei0icbjQbmF0o4xAkRUzVtRf9w82w=;
        b=PYgr7cH1UGP3o4PDgW5zSlB8hWWSaKYzF59V2dJRyvY0fHZHTa/emv3AFwYk1GLrMu
         mTwtnZTqaJLTIDG9jGmOkdujcttS6KJk2+CiCRrQkf/gctQ3vzEJ55NSerggwgjiY8FW
         XHR8U2wUmpRpW1h52buhuqmjSVSs178Pq5W/FtlXypb0zdPJLQKC+jcQ2FAaQqX0iVxL
         HbON29uYE4FnhEgpfMYXE4fIybRIzvApwQO03junz07iTP12H6GCObcQ7wMqiw7nBLHh
         Ig9NTG+ok3R86iznmZBNpitLACRE4uSMdV4/cjxBnnewjHHfkYXqlif6bUdTtSJqNta7
         DvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6HcZd+uNQux8v7Ei0icbjQbmF0o4xAkRUzVtRf9w82w=;
        b=lfiPNcRYqqRvdqgYJmcBEUuJgO9mztoBar7eA6/uRBwehr5enK4jx2cVEBEtW/mYmL
         eG8SDEO/S0aMIqLAzNGHvdHdjlSoVDxxXiVAsXpeEPLUxQivlqid3wsVTPnGrCF1scnT
         H0qfraA+4eNGwmxSJMYTpL7i5gjw2c33QXddbtRG1Pg4YwDC9unxe0rt9Q0R7KwiZVTG
         FceuXrWIYNaa+gkMDtTVfxrB+zsBQbULE+GmvMzsTxGFCRKC/KcCrt7z/gO6ESTDVuoO
         Nsgx1JF69Ju8JTvzxm1AZL4p7h2dKI82BaC0nLmRw8bjkHuKlJgX+ZGoINI94xjCf2n0
         oMeQ==
X-Gm-Message-State: AOAM530dimZkIfnjZvzJaemjvLZOLIRJbGkUazXjIwRo380WokKdB71M
        Zlz+dQkZBfVw044HhuNcipPwFQ==
X-Google-Smtp-Source: ABdhPJykj0OhQ1Hzr9pbgTAQowVlbylcItBKYEnwAq8/ALcRNPuL6E0WfBAySgUNCX7kcpOyFjMSqg==
X-Received: by 2002:a17:90a:35e:: with SMTP id 30mr12112028pjf.160.1629331785283;
        Wed, 18 Aug 2021 17:09:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
        by smtp.gmail.com with ESMTPSA id i6sm932856pfa.44.2021.08.18.17.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 17:09:44 -0700 (PDT)
Date:   Wed, 18 Aug 2021 17:09:36 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/6] hook: include hooks from the config
Message-ID: <YR2hQBtZTX5oHdQg@google.com>
References: <20210812004258.74318-1-emilyshaffer@google.com>
 <20210812004258.74318-6-emilyshaffer@google.com>
 <xmqqsfze1jb3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsfze1jb3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 01:48:00PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Teach the hook.[hc] library to parse configs to populare the list of
> > hooks to run for a given event.
> >
> > Multiple commands can be specified for a given hook by providing
> > multiple "hook.<friendly-name>.command = <path-to-hook>" and
> > "hook.<friendly-name>.event = <hook-event>" lines. Hooks will be run in
> > config order of the "hook.<name>.event" lines.
> >
> > For example:
> >
> >   $ git config --list | grep ^hook
> >   hook.bar.command=~/bar.sh
> >   hook.bar.event=pre-commit
> 
> Your answer might be "read the design doc", but it is unclear to me
> why "bar" (friendly-name) is needed in this picture at all.  Is it
> because you may want to fire more than one command for pre-commit
> event?  IOW,
> 
> 	[hook "bar"]
> 		command = bar1.sh
> 		command = bar2.sh
> 		event = pre-commit
> 
> is easier to manage with an extra level of redirection?  I doubt it
> as 
> 
> 	[hook "pre-commit"]
> 		command = bar1.sh
> 		command = bar2.sh
> 
> would be equally expressive and shorter.  Or would it help use case
> for multiple "friendly-name" to refer to the same "event", e.g.
> 
> 	[hook "xyzzy"]
> 		event = pre-commit
> 		command = xyzzy1
> 
> 	[hook "frotz"]
> 		event = pre-commit
>                 command = frotz1
>                 command = frotz2
> 
> or something?  I am not sure if this gives us useful extra
> flexibility, and if so, the extra flexibility helps us more than it
> confuses us.
> 
> And moving the "event" to the second level in the configuration
> hierarchy, getting rid of "friendly-name" from the design, would not
> make this example unworkable, either:
> 
> >   $ git hook run
> >   # Runs ~/bar.sh
> >   # Runs .git/hooks/pre-commit
> 
> Again, this is not an objection wrapped in a rhetorical question.
> It just is that I do not see how the extra level of redirection
> helps us.

Please have a look at
https://lore.kernel.org/git/87fswey5wd.fsf%40evledraar.gmail.com and
replies, where Ævar and I discussed the schema change at length. I know
it is a lot of back and forth but I think it is useful to understand why
I ended up changing the schema this way.

> 
> > diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> > index 96d3d6572c..a97b980cca 100644
> > --- a/Documentation/config/hook.txt
> > +++ b/Documentation/config/hook.txt
> > @@ -1,3 +1,8 @@
> > +hook.<command>.command::
> > +	A command to execute during the <command> hook event. This can be an
> > +	executable on your device, a oneliner for your shell, or the name of a
> > +	hookcmd. See linkgit:git-hook[1].
> 
> Please make sure you use the terminology consistently.  If the
> second level is "friendly name", hook.<name>.command should be
> described, instead of hook.<command>.command.

Thanks, this is an oversight. Will update the config/hook.txt doc in
next reroll.

> 
> Also, to help those who are familiar with the current Git from their
> use in the past 10 years or so, giving an example name from the
> current system may help, e.g. when describing hook.<name>.event,
> you may want to say the values are things like "pre-commit",
> "receive", etc.

Sure.

> 
> > +This command parses the default configuration files for pairs of configs like
> > +so:
> > +
> > +  [hook "linter"]
> > +    event = pre-commit
> > +    command = ~/bin/linter --c
> 
> The above addition of .command should also have hook.<name>.event
> next to it, no?

I don't understand the question. Doesn't this config snippet equate to
"""
  hook.linter.event=pre-commit
  hook.linter.command=~/bin/linter --c
"""
? So in this case, '<name>' is 'linter', as that's not a native Git hook.

> 
> > +Conmmands are run in the order Git encounters their associated
> 
> "Conmmands -> Commands", I would think.
ACK
> 
> > +`hook.<name>.event` configs during the configuration parse (see
> > +linkgit:git-config[1]).
> 
> Here you use <name>, which should be matched by the description in
> the first hunk of the patch to this file.
Yep.
> 
> > +In general, when instructions suggest adding a script to
> > +`.git/hooks/<hook-event>`, you can specify it in the config instead by running
> > +`git config --add hook.<some-name>.command <path-to-script> && git config --add
> > +hook.<some-name>.event <hook-event>` - this way you can share the script between
> > +multiple repos. That is, `cp ~/my-script.sh ~/project/.git/hooks/pre-commit`
> > +would become `git config --add hook.my-script.command ~/my-script.sh && git
> > +config --add hook.my-script.event pre-commit`.
> 
> One repository may use a friendly name "xyzzy" while the other may
> use "frotz" to group the hooks that trigger upon "pre-commit" event,
> but unless one of the repositories change the friendly name to
> match, they cannot share these configurations, no?  It seems that an
> extra level of indirection is hindering sharing, rather than
> helping.

Ah, I think this means the documentation isn't sufficient, if you are
asking that. Instead of explaining it in ephemeral email, I think it is
better for me to explain it in documentation reroll, and for you to then
tell me how you interpret it. I expect to send the reroll before I go
home today, since I didn't receive comments from anybody besides you so
far.

Thanks very much for the feedback on the doc - this is very useful.

 - Emily
