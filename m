Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2094F1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932371AbcHSUtx (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:49:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55657 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932337AbcHSUtv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:49:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3580337138;
        Fri, 19 Aug 2016 16:44:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JMEglv79AoLomDOnqh7j2nZicVY=; b=dvHODe
        a+blWT/mcapXpWlM5thBSZIDfTY1huRD/FNbt0amY4JaMIQLC/APcJxT3TFtM9LD
        RO2rsBzvuZk2tZ3FxPx0zMfmdoJOeMjq+1ZAypLfnDQ7GNAuS6IakM92eHwuXOjQ
        6iT02nKtE7oKAwMTkp82/8FPhcnEGpby8SlM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M4BCjBJ0iz2zh4JKvy6O86uk+CKsquuT
        1+iYmaEE/FSuwjErMG5j4saZ9MKNGkMo50cwHqvYo9Dlxwijg4YSSlOtK+LHvxtM
        2MwDMnBixeHNx83sESwY3vMtkwhqdBfXGM4h/SVBcfQwvokNX0AA3GMx1NkFX8Eg
        dfFbPEcvm2M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D1DC37137;
        Fri, 19 Aug 2016 16:44:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3FE037136;
        Fri, 19 Aug 2016 16:44:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org
Subject: Re: [PATCH] diff-highlight: add some tests.
References: <xmqqh9ag39zk.fsf@gitster.mtv.corp.google.com>
        <20160819201837.GA18918@tci.corp.yp.com>
Date:   Fri, 19 Aug 2016 13:44:28 -0700
In-Reply-To: <20160819201837.GA18918@tci.corp.yp.com> (Brian Henderson's
        message of "Fri, 19 Aug 2016 13:18:37 -0700")
Message-ID: <xmqqbn0o1ob7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA6191B6-664D-11E6-95BF-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> writes:

> Junio, how does this look?
> ...
> +# dh_test is a test helper function which takes 1) some file data, 2) some
> +# change of the file data, creates a diff and commit of the changes and passes
> +# that through diff-highlight.
> +# The optional 3rd parameter is the expected output of diff-highlight minus the
> +# diff/commit header. This parameter is given directly to printf as the format
> +# string (in order to properly handle ascii escape codes; CW, CR), so any '%'
> +# need to be doubled to protect it.
> +# Don't include a 3rd parameter if diff-highlight is supposed to leave the
> +# input unmodified.
> +# For convienence, the 3rd parameter can begin with a newline which will be
> +# stripped.

You seem to be stripping any and all empty lines with "perl -pe"; I
am not sure if that is sensible.

I really do not see the point of being able to spell

"
aaa
bbb
"

when you can perfectly well read

"aaa
bbb"

or even "aaa\nbbb\n" for that matter.  I personally do not think the
difference is worth the cost of an extra invocation of Perl, but we
already saw how stubborn you are, so there is no point spending my
time on trying to convince you further.  Assuming that it is so
precious that the input can start with an extra blank line, what you
wrote is a sensible implementation.

> +dh_test () {
> +	a="$1" b="$2" &&
> +
> +	{
> +		printf "$a" >file &&
> +		git add file &&
> +		git commit -m "Add a file" &&
> +
> +		printf "$b" >file &&
> +		git diff file >diff.raw &&
> +		git commit -am "Update a file" &&
> +		git show >commit.raw
> +	} >/dev/null &&
> +
> +	if test $# -ge 3

I think

	if test $# = 3

is much better; you would want to catch bugs in a caller that gave
you fourth parameter by mistake, instead of silently ignoring it.

> +test_strip_patch_header () {
> +	sed -e '1,/^@@/d' "$@"
> +}

While I think it is a great idea to hide the sed command behind a
helper function for readability, I am not sure "strip patch header"
is a great name that describes what it does.  A natural expectation
for an operation with that name done to this input:

    diff --git a/file b/file
    index fffffff..fffffff 100644
    --- a/file
    +++ b/file
    @@ -l,k +m,n @@ comments
     common
    -old
    +new
     common
    @@ -l,k +m,n @@ more comments
     common
    +added more
    +added even more

would be to remove the first four lines, not five.

