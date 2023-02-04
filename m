Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910A5C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 22:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjBDWqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 17:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDWqw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 17:46:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E88C16A
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 14:46:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ba1so3394774wrb.5
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 14:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2OVS3ip9t9PiN3ZiKuH2YIzjPrcUJsE0/F8C4Wpt4s=;
        b=HJwpTvKPGHc8h480/0bzBoDlKcBYsvFwXnIptiG/PwrYdja06FOaADQc9I+HfcQdyA
         3X7TkcLGMf1SeXFc8lNr/MMcSpY4KaJ3yvlGBI91IxSLc4VnNhIn5/VOxUGRv3El6tLa
         GzZoQbdJTlKwOoiY9IymXrLaFEy0F8uagDV1n/RM8xQPGrwvUYK1GWgrjJ+IPe1bIb8I
         WyQlVDomnuA/jMC2YkhaAon4x02vew1+zFTShzD8KYr7Bj/IafLZN//G13tXF43XJcHk
         +wzYba8hFWPjaBpQePhjPElGjQnV+UhKONxMQxBe3zENJy1aJS87/aQVxXWQYu4wQT2F
         sVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2OVS3ip9t9PiN3ZiKuH2YIzjPrcUJsE0/F8C4Wpt4s=;
        b=OPnNMC3kVP2v61REjCkxQ/w3rKQrpmPpg/4NbAvQgWLBMGTpbGjblP7nINCwuGKpbs
         ozt0Za+h2AYEMBJmVEWQKprJVm4EqgAl4h1WtRPNQg3a4vjJVmAsPFnp8sZw8pVVnzH0
         cbpLRbdMQ4mtZuR2RzVcFWKnb3UsiYXmfbJe5Cpe5Ot6OMYmBDelMYzW2+0d92ttaPdk
         7FpWHpRkFvU3isbS6UTAdYK6v6pfUFbnATSLjz8peWoHKWxzw7qLijFHxtcvqKz5cCNR
         2kA66IWs2Zeu4d39uLTZDZw//dwYW3hsEDgkSsEM1G2+FGYXx9payWW86q6diM7GO8sh
         SKRA==
X-Gm-Message-State: AO0yUKUBbAW/84lG4v/dIym4t6j3vnAk76zOlVxXZ7k26JKUJV6PZrf7
        UvzaPIKeB7lQgWo/WKw3+y8=
X-Google-Smtp-Source: AK7set+SAngbmL5NQl01qB4ssxf94lFs60A+UTIB8FeCBkptJeoFxeD+4vTo96OOYRgD/t1tflzLGw==
X-Received: by 2002:a5d:6d05:0:b0:2bf:e39d:c8a7 with SMTP id e5-20020a5d6d05000000b002bfe39dc8a7mr18703932wrq.44.1675550809591;
        Sat, 04 Feb 2023 14:46:49 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d608a000000b002bfd8ad20a0sm5184187wrt.44.2023.02.04.14.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 14:46:49 -0800 (PST)
Subject: Re: [PATCH] bisect: fix "reset" when branch is checked out elsewhere
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
 <xmqqo7qqovp1.fsf@gitster.g> <0d04f8ed-6933-9354-1f64-24d827424c71@gmail.com>
 <xmqqzga5b4yz.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <a66218a3-919d-eca2-1859-41ac02aa38e7@gmail.com>
Date:   Sat, 4 Feb 2023 23:46:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqzga5b4yz.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26-ene-2023 09:06:28, Junio C Hamano wrote:

> > But, and this is what makes me think that "checking out will fail" is the wrong
> > choice for "bisect", while bisecting, with the worktree in a detached HEAD
> > state, the branch to which "bisect reset" will check out back (BISECT_START),
> > is still considered checked out in the working tree:
> >
> > 	$ git checkout -b work
> > 	$ git bisect start HEAD HEAD~3
> > 	... bisect detaches the current worktree ...
> > 	$ git worktree add work
> > 	Preparing worktree (checkout out 'work')
> > 	fatal: 'work' is already checked out at ...
> >
> > So, checking out back to the implicitly checked out branch sounds like it
> > should not fail.
> 
> If that is what you are aiming at, I suspect that the posted patch
> is doing it in a wrong way.  Instead, we should just declare that
> the branch being bisected does not mean the branch cannot be checked
> out elsewhere, so that
> 
> 	$ git worktree add --detach ../another HEAD^0
> 	$ git checkout -b work
> 	$ git bisect start work work~3
>         ... detaches ...
> 	$ git -C ../another checkout work
> 
> should just work, no?

Sorry, I should have been more explicit, I meant: "checking out back to the
implicitly checked out branch sounds like it should not fail in the worktree
where the user is bisecting".

So, to your question: no, in another worktree should not work without
the --ignore-other-worktrees.  But

	$ git checkout -b work
	$ git worktree add -f ../another work
	$ git -C ../another bisect start work work~3
	  ... detaches ...
	$ git -C ../another bisect reset

should work.

> So, how about removing the is_worktree_being_bisected() check from
> find_shared_symref(), so that not just "worktree add" and "bisect
> reset", but "checkout" and "switch" are allowed to make the branch
> current even it is being bisected elsewhere?

The devil is in the details: "git branch -m", "git branch -d".

We're not ready to have BISECT_START pointing to a deleted branch, or
renaming a branch pointed by it.

Also the inconvenience that, if we allow the user to checkout normally
the same branch in another worktree, we are not providing any facility
in "git bisect reset" to override the "already checked out".  We are
forcing the user to "git bisect reset HEAD~0 && git checkout
--ignore-other-worktrees ...".  Which, to me, sound as an
inconvenience.

> 
> That would affect the other topic, I suspect, as well.

I'm not sure.  The other topic is somewhat independent of what we decide
here.

This series started because the other topic is going to affect "git
bisect", not the other way around.  But this series can be
considered even if the other topic is discarded.

Now, "git bisect reset" with a branch checked out multiple times, works
in the first worktree that has the branch checkedout (the main tree is
always the first), and fails in the next ones.  This is due to a bug
the other topic is fixing.

This series aims to make "git bisect reset" to the original branch, work
in all worktrees.  Independently of the other topic.
