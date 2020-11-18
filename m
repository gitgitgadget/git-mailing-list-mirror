Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330CDC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81032100A
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgsT4WGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKRCjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 21:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgKRCjG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 21:39:06 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CC6C0613D4
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 18:39:06 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id g7so478862pfc.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 18:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7P9k3FSSGfT5Ih37yfZNLYBQUNoCmrht6e5ISarkb8k=;
        b=fgsT4WGM3hlbtITzGEnK2TYaTAHotV8KLRsnkRbLYYr5i/f4n8j85E15zrYsGhL9K7
         ca6mZXsDDnVUSbK7RKBoVAP9CCi1anAzPwQ7AhA+MNX6fFjSlgWeuP3QSzzSPkhxpfzN
         Ph6t0QM6JqzVrWShfS9rffBIS60QoIbB/+UbBzUY6Kv77gSyM8++8XYQqe19i9mPGIh5
         sfeIZiIF+ykNLm3kMRxoV46pwISam7DlTTot1NPAQzrV96/bSYXxqOvWBTxPTY5P7ozP
         7Rzn8VF3mHyL3pqydbgkzCJRMo2ZPoa5X9K40lq69FP5m1ytYsWPSghqMiJ4GqkJNuul
         YF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7P9k3FSSGfT5Ih37yfZNLYBQUNoCmrht6e5ISarkb8k=;
        b=RZCmEZt6yxNiN3j7QCeU/+4r1aGvLufSsFldafhUO+aii8bjoXSksOxARTa5Aa9HMf
         BqWtBKQIllR61C0Hy7MHwjZmvdRunKKfZE7SaL06cwZCSlK84kMYxZDh5DiIJaetkFIw
         NoeU3tLJP+G3fdbyGLABu2xa+kTuVXCDaTjpQpPw5X0VDy+c/rjJST83xQna2U3dDAH7
         m8Y8U9q7jVHO1BjYtPvDBdor4aEraNOD3uwYsXkhIlNL4wIkPD/aZ/JqcIaN8eB+RvNH
         QcbPXc6lYilErUK8MGNU58RDQTo0mPYOOYZt/EOnyrny+Lr9D01REcaiHwXEtcaA1eG1
         pIuw==
X-Gm-Message-State: AOAM53100O914mC/sx7YYqJ+9THJ8Gdyc/qhhvPxOuo2H4OnSCyrJup5
        /Gdb1YAul33irLVMgADbbgM=
X-Google-Smtp-Source: ABdhPJyRCmyRB4CWlUrsOOoBRx30jaaJ/BO8wM5BzNyJKOyv3oWxE2FpWcTtAgNhRRTOakOAq68r0A==
X-Received: by 2002:a63:c157:: with SMTP id p23mr6384789pgi.349.1605667145741;
        Tue, 17 Nov 2020 18:39:05 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 26sm20046989pgm.92.2020.11.17.18.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 18:39:04 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:39:02 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
Message-ID: <20201118023902.GD360414@google.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
 <20201117233313.GB642410@coredump.intra.peff.net>
 <CAMP44s1HhiDYfji9L2sj3QbCDmsb9dnrLCS6cQJPbmS1F3vKoQ@mail.gmail.com>
 <20201118012230.GB650959@coredump.intra.peff.net>
 <CAMP44s1t3CKF3btQwSwaz_Pu2fE6PGyb+_iMW8dAbY3aE3mH7w@mail.gmail.com>
 <20201118020618.GE650959@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118020618.GE650959@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Tue, Nov 17, 2020 at 07:45:21PM -0600, Felipe Contreras wrote:
>> Jeff King wrote:

>>> Yes, I have run into that, and it's definitely annoying. The
>>> refs/remotes/<remote>/HEAD symref is created by clone, but is not
>>> updated by "fetch". That's intentional, because it's supposed to
>>> represent a local choice (that is merely seeded by the remote side). But
>>> it seems like adding it if it's missing might be reasonable.
>>
>> The equivalent of this choice is in "git remote add -m":
>>
>>   With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD`
>>   is set up to point at remote's `<master>` branch. See also the
>>   set-head command.
>
> Wow, I'm not sure how that option escaped my notice for all these years.
> Of course it would be much more useful if it pulled the value from the
> remote HEAD (but again, unless we use "-f" we are not contacting the
> remote at all).

When would I want this implicit "set-head -a" and *not* want "-f"?

[...]
>> Presumably if we want to avoid the term "master", then this option
>> needs to be renamed.
>
> Agreed that the naming is bad.

That said, single-letter options often have bad names.  (That's part of
why these days I try to push back against single-letter options unless
a flag is frequently used.)

For consistency with "git clone -b", I suppose one might expect it to
be "git remote add -b".  Or even better, to retire the option and have
people run "git remote set-head" separately.

[...]
> E.g., remote.origin.updateHEAD that can be set to one of:
>
>   - never; do not touch it
>
>   - create-if-missing; as discussed here
>
>   - always; update it on every fetch
>
> And then it is just a question of what the default is. Currently it is
> "never". I suspect most people would be happy with "always", but it does
> break some existing flows. But perhaps "create-if-missing" is a good
> medium.

Thanks for bringing this up --- this is something I had been
interested in as well but hadn't gotten around to contacting the list
about it.

The default value for a config setting like this has two purposes:

- it makes the config setting for affected people who have not
  discovered it

- it provides a sensible, predictable standard behavior

Those two goals are often in tension, as they were for example when
setting the default for push.default.

If I consider them separately:

- to make as smooth a transition as possible for people who were
  relying on "git remote set-head", a good behavior would be to
  *fail the fetch* when the remote HEAD changes.  That would force
  the user to make a choice between "never" and "always".

- one way to relax that without hurting that goal too much would be to
  fail the fetch when the remote HEAD changes from something other
  than "master" or "main".  That way, the common case (moving from a
  default to a project-appropriate setting) would work without
  friction, and in other cases the user could make a choice between
  "never" and "always".

- all that said, the default that I prefer is simply "always".  Like
  Felipe hinted, this is a simple, intuitive behavior that most people
  would expect.

As a transition plan, I can imagine going from one of those first two
to the third after some appropriate period of time has passed.

What do you think?

Thanks,
Jonathan
