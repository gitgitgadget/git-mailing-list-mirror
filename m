Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275902036B
	for <e@80x24.org>; Wed,  4 Oct 2017 02:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdJDCBD (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 22:01:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50915 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751117AbdJDCBD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 22:01:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A29FE9EB15;
        Tue,  3 Oct 2017 22:01:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/J+GpWO56tLk
        oxb4h5I88LDOlLc=; b=oH8kzZdd6HM0WYVXEhYc+52aZQHUVw7z+Mg2/faaqvXi
        5VJUMJY7nQV9+NG5bq9mi6iT+JkvKFov0Tuy5WZ+O83bR1iSZZDkJCnQ/2OLIu0J
        zF0Mz7FjvJWG1tzaMySeswBx8aoCKvvPeXfoyCHl2z7UM2L8syuclMu/2R3UqIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mHxLt8
        yIyn5AqNLdn4uWbP6Ai8+C9ujCkFTSLYeDqfb3+ipZCkQq/sEprWKMfzfIgW3dKh
        QgFrfhYSas2BPRKj0OWaO0cRKgq4apqHXx2RIILj3BoQc/YQpQof4gCp+k90k2c/
        aMgJyc4QSL/9WSD0vMjFTf/cv6zeXJpgLZA/8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A3939EB14;
        Tue,  3 Oct 2017 22:01:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 997039EB10;
        Tue,  3 Oct 2017 22:01:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
        <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
        <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
        <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
Date:   Wed, 04 Oct 2017 11:00:59 +0900
In-Reply-To: <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 3 Oct 2017 21:19:55
 +0200")
Message-ID: <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DF63D3BE-A8A7-11E7-8E81-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> $ git rm -r --cached . && git add .
>
> (Both should work)
>
> To be honest, from the documentation, I can't figure out the difference=
 between
> $ git read-tree --empty
> and
> $ git rm -r --cached .
>
> Does anybody remember the discussion, why we ended up with read-tree ?

We used to use neither, and considered it fine to "rm .git/index" if
you wanted to empty the on-disk index file in the old world.  In the
modern world, folks want you to avoid touching filesystem directly
and instead want you to use Git tools, and the above are two obvious
ways to do so.

"git read-tree" (without any parameter, i.e. "read these 0 trees and
populate the index with it") and its modern and preferred synonym
"git read-tree --empty" (i.e. "I am giving 0 trees and I know the
sole effect of this command is to empty the index.") are more direct
ways to express "I want the index emptied" between the two.

The other one, "git rm -r --cached .", in the end gives you the same
state because it tells Git to "iterate over all the entries in the
index, find the ones that match pathspec '.', and remove them from
the index.".  It is not wrong per-se, but conceptually it is a bit
roundabout way to say that "I want the index emptied", I would
think.

I wouldn't be surprised if the "rm -r --cached ." were a lot slower,
due to the overhead of having to do the pathspec filtering that ends
up to be a no-op, but there shouldn't be a difference in the end
result.
