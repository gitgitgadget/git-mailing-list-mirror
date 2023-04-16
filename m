Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0402CC77B76
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 23:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjDPX0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 19:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDPX0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 19:26:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1372106
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 16:26:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so10965713wmb.3
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 16:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681687571; x=1684279571;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZswM5KZYCrl2aHcKFvE0qySwnxTx99XFmNKNqFUpsA=;
        b=r3SL+PbJIP3jbrrUUzjLBPcHSKxy1NQJIi9mVb1BO1sfYNJEMi8IK1bHrcJuhFlKC9
         nkUuGwGMC/y/MenyPtYA8JojqiHMEU16xEWO+dvxRCYZsaOxivWbnlLhzwpVsKsn/L4l
         wezW0FqAV1ENpy0TJW7TYnSyucvJNYFYJlSH5S++LfqKhs9LeEt+GYcW+wuL/D5eN7U8
         bD7+jUa46mzUJ+mhXvMso6RAxUtRRWWBMflDj3VsMJHqtsXuuo9vLf2FXh1rm+LStWer
         0IrzQzWT6OMVUMqa6PzTm9mtchqNLV8DGMFydqEGsT6uvmkTeo6i9pd4aTAmsXXmFRwV
         x+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681687571; x=1684279571;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZswM5KZYCrl2aHcKFvE0qySwnxTx99XFmNKNqFUpsA=;
        b=DnWfUzzacj/bKcFhOWKZNBi9KW9sXm9zv2ibkUUfVcPB2aYLITeLleBhBatC2EtjbO
         6jW5ygdFEr1ADGHtwfTuTDGuWCsWblWHbhc8ISW+FWYM2oPPVmc0BQCEJkpVg37Pz/GP
         s8Tr732LWotywM8d0u+JnBv4jOr/kiUSs8u6sUKWXu2MMPxtoBxmqEf8wcWMwBflA9Ty
         og+q7C6JoQlL5LQ4FozBy8UHqn/Mpji4SdUEDEFSbP9kHiXbDPmqKsavsWd6Bz0poaVY
         gHlGFNFuOGW7DH21DsAmj8sMJAAz/zdbZD5ci3YxY7S7YROl6R1AqXbzCqPyOknEFcxd
         0/cQ==
X-Gm-Message-State: AAQBX9ce77OhdfvN/y1BjlPftkU0LbEy7Yxj1ljwKy/yk8fEADfY8N0Q
        eN89Lxcs6Nyd2rbRvNVhjL8=
X-Google-Smtp-Source: AKy350a0BzI+GjxXl8fOM1KEaiVpTLx9IqYlmrzfadgnQ53Uzub7ITMyZC1M5Tx3Em3tpPFTgzch3g==
X-Received: by 2002:a1c:7717:0:b0:3ed:2eb5:c2e8 with SMTP id t23-20020a1c7717000000b003ed2eb5c2e8mr9674747wmi.10.1681687571256;
        Sun, 16 Apr 2023 16:26:11 -0700 (PDT)
Received: from [192.168.2.52] (123.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.123])
        by smtp.gmail.com with ESMTPSA id z4-20020adfe544000000b002f6dafef040sm7314668wrm.12.2023.04.16.16.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 16:26:10 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: add and apply branch_get() rules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
 <230416.86ildvsyt6.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <c544be9f-896b-29d5-be26-fb7bcd0f2fc5@gmail.com>
Date:   Mon, 17 Apr 2023 01:26:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <230416.86ildvsyt6.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16-abr-2023 15:56:56, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Apr 06 2023, Rubén Justo wrote:
> 
> > There are three supported ways to obtain a "struct branch *" for the
> > currently checked out branch, in the current worktree, using the API
> > branch_get(): branch_get(NULL), branch_get("") and branch_get("HEAD").
> >
> > The first one is the recommended [1][2] and optimal usage.  Let's add
> > two coccinelle rules to convert the latter two into the first one.
> >
> >   1. f019d08ea6 (API documentation for remote.h, 2008-02-19)
> >
> >   2. d27eb356bf (remote: move doc to remote.h and refspec.h, 2019-11-17)
> 
> I wondered why it is that we don't just make passing "HEAD" an error,
> and what I thought was the case is why: It's because we use this API
> both for "internal" callers like what you modify below, but also for
> passing e.g. a "HEAD" as an argv element directly to the API, and don't
> want every command-line interface to hardcode the "HEAD" == NULL. So
> that makes sense.
> 
> But do we need to support "" at all? changing branch_get() so that we do:
> 
> 	if (name && !*name)
> 		BUG("pass NULL, not \"\"");
> 
> Passes all our tests, but perhaps we have insufficient coverage.

I haven't found a use case where it is used, but the consideration is
there since it was introduced in cf818348f1 (Report information on
branches from remote.h, 2007-09-10).

We can introduce that BUG() and see what happens.  But I'm not sure the
change is worth the potential noise.

> 
> > Signed-off-by: Rubén Justo <rjusto@gmail.com>
> > ---
> >  builtin/fetch.c                     |  2 +-
> >  builtin/pull.c                      |  8 ++++----
> >  contrib/coccinelle/branch_get.cocci | 10 ++++++++++
> 
> We've typically named these rules after the API itself, in this case
> this is in remote.c, maybe we can just add a remote.cocci?

Is the new rule worth the cost in the CI?  That's what I'm thinking
about now.  Maybe adding the rule to the message for future reference is
enough.

> 
> >  3 files changed, 15 insertions(+), 5 deletions(-)
> >  create mode 100644 contrib/coccinelle/branch_get.cocci
> >
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 7221e57f35..45d81c8e02 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1738,7 +1738,7 @@ static int do_fetch(struct transport *transport,
> >  	commit_fetch_head(&fetch_head);
> >  
> >  	if (set_upstream) {
> > -		struct branch *branch = branch_get("HEAD");
> > +		struct branch *branch = branch_get(NULL);
> >  		struct ref *rm;
> >  		struct ref *source_ref = NULL;
> 
> I wonder if we shouldn't just change all of thes to a new inline helper
> with a more obvious name, perhaps current_branch()?

I had the same idea and explored it a bit.  I ended up thinking that I
was introducing a _new_ way of using the API.  So, I dunno.

> > diff --git a/contrib/coccinelle/branch_get.cocci b/contrib/coccinelle/branch_get.cocci
> > new file mode 100644
> > index 0000000000..3ec5b59723
> > --- /dev/null
> > +++ b/contrib/coccinelle/branch_get.cocci
> > @@ -0,0 +1,10 @@
> > +@@
> > +@@
> > +- branch_get("HEAD")
> > ++ branch_get(NULL)
> > +
> > +@@
> > +@@
> > +- branch_get("")
> > ++ branch_get(NULL)
> > +
> 
> You don't need this duplication, see
> contrib/coccinelle/the_repository.cocci.
> 
> I think this should do the trick, although it's untested:
> 	
> 	@@
> 	@@
> 	  branch_get(
> 	(
> 	- "HEAD"
> 	+ NULL
> 	|
> 	- ""
> 	+ NULL
> 	)
> 	  )
> 	
> A rule structured like that makes it clear that we're not changing the
> name, but just the argument.
> 

Thanks.
