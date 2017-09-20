Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8215B2047F
	for <e@80x24.org>; Wed, 20 Sep 2017 04:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbdITEMs (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 00:12:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50492 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750785AbdITEMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 00:12:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CDDFAAB4B;
        Wed, 20 Sep 2017 00:12:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rcm28MkkxNjJoFpNLb8G2SVfnqA=; b=IynEeo
        Jx0ifginVrQAH3iKX6lLfVEGGllOoDl+mmdAFumErqwDrfa+Eke9Iwyy5uaCIH5A
        JTiia3DJydfgEfHuAgLCcRhmswrIjdm1PZvc+lcfZ2S/yHoGNt0CfDdQk+C2P+Q2
        F61Qyiy0hc00pnVb9qLcqaTV66jg8X3Asnnso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T/X9aiW3qhWhMjm9TddOx3FxS09pLtnC
        tF68HaSNqd1ZAVWFXvnL779RbWYNXR7580jwPNSrTaK6WS6YauOZIDAokZITXkg0
        o7WpcK8WfpStw/XuOYUzQlCygwaF8UN70KfhiuTpRvMwP1Su23c7aRdePgWLbLh2
        4SAiA8egvfE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1541BAAB4A;
        Wed, 20 Sep 2017 00:12:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 796EEAAB49;
        Wed, 20 Sep 2017 00:12:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] branch: document the usage of certain parameters
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
        <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
        <20170919071525.9404-3-kaarticsivaraam91196@gmail.com>
Date:   Wed, 20 Sep 2017 13:12:45 +0900
In-Reply-To: <20170919071525.9404-3-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 19 Sep 2017 12:45:22 +0530")
Message-ID: <xmqq4lryovnm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5205E8C-9DB9-11E7-8025-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Documentation for a certain function was incomplete as it didn't say
> what certain parameters were used for.
>
> So, document them for the sake of completeness and easy reference.

Thanks.

> @@ -15,6 +15,11 @@
>   *
>   *   - reflog creates a reflog for the branch
>   *
> + *   - if 'force' is true, clobber_head indicates whether the branch could be
> + *     the current branch; else it has no effect

Everybody else in this list begins with what it is describing for
easy eyeballing.  Can you make this match that pattern?

Also, what does "could be" mean in that sentence?  Is the caller
telling the function "how, I do not exactly know if that is the
case, but the branch I am asking to create you might be the same
branch as what is currently checked out, so be extra careful"?

Or is the comment telling a potential caller that it can pass true
to signal that create_branch() is allowed to (re)"create" the branch
that is already checked out (hence it already exists)?

I think the confusing statement above arises because an assumption
is unstated there.  If the reader knows "Even with force, calling
create_branch() on the currently checked out branch is normally
forbidden", then the reader can guess your "could" mean the latter.

	- clobber_head_ok allows the currently checked out (hence
          existing) branch to be overwritten; without force, it has
          no effect.

perhaps?  As the underlying helper calls it clobber_head_ok, and
that name is more clearly expresses that this is a permission than
the current name, I chose to add _ok to the above example, but if
you are to take the suggestion, you'd need to also update the names
in the declaration, too.

> + *
> + *   - quiet suppresses tracking information
> + *
>   *   - track causes the new branch to be configured to merge the remote branch
>   *     that start_name is a tracking branch for (if any).
>   */
