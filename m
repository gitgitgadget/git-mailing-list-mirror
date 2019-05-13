Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8738B1F461
	for <e@80x24.org>; Mon, 13 May 2019 09:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfEMJSc (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 05:18:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57602 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfEMJSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 05:18:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFBB177CDA;
        Mon, 13 May 2019 05:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lU7FeIuhouG0fqzFhIPUNanvLZc=; b=g8Mt7K
        FfFVtNef8kFoOAiKWn/6AtcczFNPpZKe4PNhpR5IivMrSaYv2gk71DPnohKgK/FB
        MU/BvaLSHx9w0slocrJfQf7hGNBARDkId1mA8irHPo/97TabyH7aV7ihFDM+FAka
        fs6Qcizg8kitgWF6Frp7X+e0j9HXInyxEcFjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CwGNubCkDB2fSB6VrPGUFJo1DMKpKi7e
        CX8akptSiTob3yW7FDfPYz5T9sT/2fbxm6LrZroudmxoXTZPmvrgAGogK1HeQEW3
        3iQBwAEFB9VHDB3jLsuu3WqepHNFMl0JssMYP9aDIHq5RpcGqlXAp2qoBBZFktCs
        Y+/UZdNkWaY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B690777CD9;
        Mon, 13 May 2019 05:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E675877CD8;
        Mon, 13 May 2019 05:18:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: push docs: inaccurate description of omitted destination?
References: <87sgtj6mo3.fsf@kyleam.com>
Date:   Mon, 13 May 2019 18:18:21 +0900
In-Reply-To: <87sgtj6mo3.fsf@kyleam.com> (Kyle Meyer's message of "Sun, 12 May
        2019 23:47:08 -0400")
Message-ID: <xmqqimuebtlu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EF2CFD2-7560-11E9-A16C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> It seems to me that push's manpage contains a couple of inaccurate (or
> at least confusingly incomplete) statements about omitting the
> destination part of the refspec.
>
> First, the refspec section of the manpage has this to say:
>
>     If `git push [<repository>]` without any `<refspec>` argument is set to
>     update some ref at the destination with `<src>` with
>     `remote.<repository>.push` configuration variable, `:<dst>` part can
>     be omitted--such a push will update a ref that `<src>` normally updates
>     without any `<refspec>` on the command line.  Otherwise, missing
>     `:<dst>` means to update the same ref as the `<src>`.
>
> Reading that, I'd think that, if I haven't configured
> remote.<repository>.push in a way that involves <src>, omitting <dst>
> will update the remote ref with the same name.

... if such a push would update the ref at the remote with the same
name, yes.  Otherwise no.  And that is determined by what push mode
is being used (e.g. are we using the matching mode?  The current
mode?  Something else?).

>  But push.default is also
> consulted before falling back entirely to using the remote ref with the
> same name:

Yes.  The push.default configuration participates in the selection
of the ref at the remote that gets updated, given a refspec element
with a missing :<dst>.  And you do not have to write :<dst> to name
the ref that a refspec with missing :<dst> would update anyway.

>     `git push origin master`::
>        Find a ref that matches `master` in the source repository
>        (most likely, it would find `refs/heads/master`), and update
>        the same ref (e.g. `refs/heads/master`) in `origin` repository
>        with it.  If `master` did not exist remotely, it would be
>        created.
>
> Perhaps I'm misreading that, but I'd interpret that as saying the remote
> ref with the same name will always be updated,...

That part is random listing of examples with vanilla configuration,
so depending on what setting you personally have, the behaviour may
be different.
