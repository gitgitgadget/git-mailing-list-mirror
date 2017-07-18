Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89351FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 21:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdGRVed (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 17:34:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60079 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751560AbdGRVec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 17:34:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 122B87C2E5;
        Tue, 18 Jul 2017 17:34:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bR8GlziAkqIpRBETAhwgzR/iSMM=; b=jP3Qth
        3lzM392nndARVwknNS852bXT6TPBT4vDUqMoiL6jeLPGBSjnXmnYGGhGlizesl28
        nXhvQJCnvvaz4jnJbXM5SE4snAu8teKzO9+yAUoarCK8VelUwl+4FcXHFhl1n1+i
        yEJv8BSrIz00bRIaklsBvroeLi6vm4Vb5k3aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z6z2rkX3iYEIU8PLyGv53hvlrMqXcUFs
        WDP5FS1sTtZ0W3qbkoTuzzs4JyXQ9BHobKbiNN0I671r5DSOIZjK3wDxeXM1UBQk
        vGLiVaSwtC1rlUunQARz6PAPRBK3K3J6FOFt5qk350qN3MHYcmimNzN/Ym92WZ9V
        RHobceZnPOM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AA167C2E4;
        Tue, 18 Jul 2017 17:34:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EFB57C2E3;
        Tue, 18 Jul 2017 17:34:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH 2/3] setup: have the_repository use the_index
References: <20170711220408.173269-1-bmwill@google.com>
        <20170711220408.173269-3-bmwill@google.com>
        <xmqqzica1pli.fsf@gitster.mtv.corp.google.com>
        <20170712180143.GD65927@google.com>
        <xmqqmv891jct.fsf@gitster.mtv.corp.google.com>
        <20170712213339.GI93855@aiede.mtv.corp.google.com>
        <xmqqvamxz63i.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 18 Jul 2017 14:34:24 -0700
In-Reply-To: <xmqqvamxz63i.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 12 Jul 2017 14:40:49 -0700")
Message-ID: <xmqq379to2e7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEF7BDAC-6C00-11E7-89BE-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>
>> All that said, I don't have a strong opinion on this.  Both the 1-word
>> approach (a pointer) and 24-word approach (embedding) are tolerable
>> and there are reasons to prefer each.
>
> I do not care too much about 24-word wastage.  If this were not "a
> pointer pretending to be embedded object", the fix in 1/3 wouldn't
> have been necessary.  I am worried about this being an invitations
> for such unnecesasry bugs.

Another thing I noticed that you already pointed out was this bit in
your review message:

> I wonder if this can be done sooner.  For example, does the following
> work?  This way, 'the_repository->index == &the_index' would be an
> invariant that always holds, even in the early setup stage before
> setup_git_directory_gently has run completely.
> 
> Thanks,
> Jonathan
> 
> diff --git i/repository.c w/repository.c
> index edca907404..bdc1f93282 100644
> --- i/repository.c
> +++ w/repository.c
> @@ -4,7 +4,7 @@
>  #include "submodule-config.h"
>  
>  /* The main repository */
> -static struct repository the_repo;
> +static struct repository the_repo = { .index = &the_index };
>  struct repository *the_repository = &the_repo;
>  
>  static char *git_path_from_env(const char *envvar, const char *git_dir,

With a pointer that can point at a random instance of index_state,
the current "struct repository" allows two or more instances of it
to share the same index_state.  I do not think that is a designed
and a desirable "feature" but an invitation for a mistake.

Embedding the real instance in it would solve that, too.

So, after saying "I am not (yet) telling you to fix the design" and
then hearing what a potential advanage could be (and none of that
was a convincing one), I am inclined to say that this eventually
needs to be fixed, preferrably before too much code starts relying
on it and making it more work to fix it later.
