Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436461F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 17:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfHNRig (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 13:38:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56211 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfHNRif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 13:38:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5453F16471A;
        Wed, 14 Aug 2019 13:38:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mx2nQrKsQpVt4lLiUOtYFRKX9yA=; b=OZ0IbF
        zW+O56xHqmEOkso6RZ5cseVaFEEgE71uFAyhwzFr5OzQ8ya9LwmWHFCxWuio+CXA
        Ou2R/kJyis0Fw+wKp1Yrh/NAMw+QBbjqkZJB6Z8l7fWgtKkTfZv8608/BRGtETeH
        SMGWMZOJRzqaX/7jEAmTeQcWJoxmnDTsaBmzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x/vIW+S/xzX4ESj487f1/iqL4U2C8zdW
        IOlbxLRaDiMqKUPnIcTXogi24tpXBMw+Azgle0nI7XZzWaQKVYAwPzyQW6srK6j7
        jxbwWxH02yj+EMS2r3ghQlIKblCWCLC11RkUb0sfTK810UE5rqty6bB9gdbVUdMN
        rJpYqrmzMEo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CD51164719;
        Wed, 14 Aug 2019 13:38:30 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D3D7164718;
        Wed, 14 Aug 2019 13:38:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     git@vger.kernel.org, matthieu.moy@univ-lyon1.fr,
        corentin.bompard@etu.univ-lyon1.fr,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
Subject: Re: [PATCH] pull, fetch: add --set-upstream option
References: <86zhoil3yw.fsf@univ-lyon1.fr>
        <20190814134629.21096-1-git@matthieu-moy.fr>
Date:   Wed, 14 Aug 2019 10:38:28 -0700
In-Reply-To: <20190814134629.21096-1-git@matthieu-moy.fr> (Matthieu Moy's
        message of "Wed, 14 Aug 2019 15:46:29 +0200")
Message-ID: <xmqqlfvv6417.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53EC09A2-BEBA-11E9-9BF8-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <git@matthieu-moy.fr> writes:

> From: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
>
> Add the --set-upstream option to git pull/fetch
> which lets the user set the upstream configuration
> (branch.<current-branch-name>.merge and
> branch.<current-branch-name>.remote) for the current branch.
>
> A typical use-case is:
>
>     git clone http://example.com/my-public-fork
>     git remote add main http://example.com/project-main-repo
>     git pull --set-upstream main master
>
> or, instead of the last line:
>
>     git fetch --set-upstream main master
>     git merge # or git rebase
>
> This functionality is analog to push --set-upstream.

I was writing a one-paragraph summary for this topic, for the
"What's cooking" report, and here is what I have:

 "git fetch" learned "--set-upstream" option to help those who first
 clone from a forked repository they intend to push to, add the true
 upstream via "git remote add" and then "git fetch" from it.

After describing it like so, I cannot shake the feeling that the
workflow this intends to support feels somewhat backwards and
suboptimal.

 - Unless you rely on server-side "fork" like GitHub does, you would
   first clone from the upstream, and then push to your "fork".  The
   flow whose first step is to clone from your "fork", not from the
   true upstream, feels backwards (cloning from upstream then adding
   your fork as a secondary may be more natural, without need for
   the complexity of --set-upstream to pull/fetch/push, no?).

 - The second step adds the true upstream using "git remote", and at
   that point, in your mind you are quite clear that you want to
   pull from there (and push to your own fork).  Not having the "I
   am adding this new remote; from now on, it is my upstream"
   feature at this step, and instead having to say that with your
   first "git pull", feels backwards.  If this feature were instead
   added to "git remote", then the last step in your example does
   not even have to say "main" (and no need for this new option),
   does it?

