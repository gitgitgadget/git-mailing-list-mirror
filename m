Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45FF20988
	for <e@80x24.org>; Wed, 19 Oct 2016 00:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754753AbcJSA4O (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 20:56:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64140 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752683AbcJSA4M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 20:56:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31BB149131;
        Tue, 18 Oct 2016 20:56:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tmOO6e6V18HTkpsTpUD/W1DHBtw=; b=r3Ns1u
        C1pWsfvwpKM0WTrfhpGyjZuLnv7gOdJma2c2M+xeQQ3TRVtOZeFZ40+mQ/nd/aQ2
        cr2j9nDz/53HXx+swaKmZ+WGwVeTne7xYvHJDD5bdope3bX/HgqVF8WBs97einQT
        jpCM2BhyR/QQpcE0G5gyZbHmPZB7ZMubTCxQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WZG5DIUyFkVY+1I351WaRfgSJKsmJJ4E
        xdG/9zUoVd0a+r+dHh2YlqgkVRy4p/4r1SGSBXpWHk7LXpxGN8PbDS7W2CdilcD2
        dEjuvn//8tJKh/Fh+GsZbe15aIiiAbuS9phb4qWcve+zrW5uo9A4qhbr+4bFS0AX
        DfgzX8YodtM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28A0849130;
        Tue, 18 Oct 2016 20:56:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EEAC4912F;
        Tue, 18 Oct 2016 20:56:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
References: <20161018210623.32696-1-sbeller@google.com>
        <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
        <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZHLVpxbJ_C-dM2LDA64-_TJNyY+52fTWkOvLvvAq2XDg@mail.gmail.com>
Date:   Tue, 18 Oct 2016 17:56:08 -0700
In-Reply-To: <CAGZ79kZHLVpxbJ_C-dM2LDA64-_TJNyY+52fTWkOvLvvAq2XDg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 18 Oct 2016 16:25:08 -0700")
Message-ID: <xmqq60opnolz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D360C07E-9596-11E6-A562-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The underlying issue is two fold:
>
> * in t3600 we'd need
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index d046d98..545d32f 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -616,7 +616,7 @@ test_expect_success 'setup subsubmodule' '
>         git submodule update &&
>         (cd submod &&
>                 git update-index --add --cacheinfo 160000 $(git
> rev-parse HEAD) subsubmod &&
> -               git config -f .gitmodules submodule.sub.url ../. &&
> +               git config -f .gitmodules submodule.sub.url ./. &&
>                 git config -f .gitmodules submodule.sub.path subsubmod &&
>                 git submodule init &&
>                 git add .gitmodules &&
>
> because the sub-submodule URL is actually the same as the submodule
> (because we'd test lazily)

This fix sounds entirely sane.  The "../." you touched was depending
on the buggy behaviour; it is exactly the case of "there were two
wrongs that were covering each other; after one of them gets fixed,
the other one's brokenness is exposed", right?

> However in t7403, we have a construct like:
>
>     git clone . super
>
> which then results in
>
>     git -C super remote -v
> ...../git/t/trash directory.t7403-submodule-sync/. (fetch)

That sounds expected.  We do not have to add trailing "/.", but the
system ought to work with or without it correctly and the same way.

> However instead of fixing the levels of nesting, the fix is as easy as:
> diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
> index 0726799..525d32b 100755
> --- a/t/t7403-submodule-sync.sh
> +++ b/t/t7403-submodule-sync.sh
> @@ -15,7 +15,9 @@ test_expect_success setup '
>         git add file &&
>         test_tick &&
>         git commit -m upstream &&
> -       git clone . super &&
> +       # avoid cloning a repository with a url ending in /.
> +       git clone . root &&
> +       git clone root super &&
>         git clone super submodule &&
>         (
>                 cd submodule &&
>
> Same goes for t740{6,7} as well as t7506.

Isn't the issue the same as that "3600-rm" one?  I know you said
twofold upfront, but I am not sure I agree.

The "super" repository refers to its submodules with "../submodule"
in the test code we have, even though the submodule referred to
lives inside $TRASH, and by fixing the "trailing /. and trailing
/root are treated the same way" bug, its reference created in the
test ends up referring to one level above, perhaps in t/submodule,
instead of the intended place t/trash/submodule.  By using "root",
you are making their wrong references point at the right place.

Admittedly, the updated test above tests something different from
what it originally wanted to test, which feels somewhat distasteful
but I do not think it is wrong.

> I think this change to the test suite is not warranted, because
> we want to have the current behavior as-is ...

I am not sure.  Certainly we would want to make sure that the normal
case (i.e. no funny trailing junk) to work correctly, but we do want
to protect the fix from future breakage as well, no?

Perhaps we can do a preliminary step to update tests to primarily
check the cases that do not involve URL with trailing "/." by either
doing that double clone, or more preferrably, clone from "$(pwd)"
and adjust the incorrect submodule reference that have been relying
on the buggy behaviour.  With that "root" trick, the test would pass
with or without the fix under discussion, right?

Then do the fix under discussion and introduce a test that clones
from "." refers to submodules with relative path and makes sure that
trailing "/." is interpreted correctly.
