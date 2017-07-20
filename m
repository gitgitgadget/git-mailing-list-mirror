Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4841F600
	for <e@80x24.org>; Thu, 20 Jul 2017 15:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964783AbdGTPQd (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 11:16:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51800 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935486AbdGTPQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 11:16:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D909D764CD;
        Thu, 20 Jul 2017 11:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wDjJhv2Acg+aBEAF/IcGCsM0AFw=; b=Q+y7n6
        xZvZgk+eWstQXkbCzyBnLpgk8f15vwkWBHmYHW4MP7PNYg5uB7SxdN0ea+8msuT8
        OVYrWSJUyQ+GXzYQnIstFidNPvW1LMPIP9HP9t1F7dNog2aa0m3ZuTDyc9yYrybq
        zvMy19mYRE+CPME8O20qz+1SqYTcXbG3aDWAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tHccqIZg19XHtkPgsL3qGVEqEUUtjFXX
        MNgeAl6A6BE5pbCGssglV+Z96gMCVtm4LgcX6zggtJMFahAn0hY8gnvNzCVASo10
        clPwhBtz6ibbD45SibdViLv8J8cWzXGuAUTJ8Dqm0SCOJmw8TmpNg1cXnoG7miXu
        Jj9wAV/DA/o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1181764CB;
        Thu, 20 Jul 2017 11:16:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AF99764CA;
        Thu, 20 Jul 2017 11:16:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: Reducing redundant build at Travis?
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com>
        <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com>
        <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com>
        <20170714122401.uahk2fzvcjj3nwve@sigill.intra.peff.net>
        <xmqqbmonrrvr.fsf@gitster.mtv.corp.google.com>
        <20170714153224.6qnupcsa3pkig76k@sigill.intra.peff.net>
        <4BB4EDA1-58A5-45AD-8BEC-1CB06CDC23DD@gmail.com>
Date:   Thu, 20 Jul 2017 08:16:30 -0700
In-Reply-To: <4BB4EDA1-58A5-45AD-8BEC-1CB06CDC23DD@gmail.com> (Lars
        Schneider's message of "Thu, 20 Jul 2017 10:18:45 +0200")
Message-ID: <xmqq4lu7m94h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68F3042C-6D5E-11E7-99D9-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 14 Jul 2017, at 17:32, Jeff King <peff@peff.net> wrote:
>> 
>> I don't know if Travis's cache storage is up to that challenge. We could
>> probably build such a lock on top of third-party storage, but things are
>> rapidly getting more complex.
>
> I think we shouldn't go there because of the complexity. I reached out
> to TravisCI and asked about the "hash build twice" problem [1]. Unfortunately,
> I got no response, yet. The issue could also be considered a feature as you
> could perform different actions in your TravisCI configuration based on
> the branch name.

Oh, no doubt that it is a feature, and a very useful one at that.
With that, we can change actions depending on the branch name in
such a way that normally we do our build and test, but when we are
on a branch (not testing a tag) and its tip is tagged, we become
no-op to avoid the cost of testing.  That is the feature we exactly
want.

The question I had, and wanted a help from you, was if there was a
way we can write that "are we on a branch (not testing a tag) and is
its tip tagged?" test only once in .travis.yml, even though we have
quite a many items in the matrix.  With the current way .travis.yml
is laid out, without such a facility, we'd need the logic sprinkled
to at the beginning of all "before_install:" or something like that,
which is not quite optimal.

> I think Junio's original suggestions for the Windows build makes a lot
> of sense because it saves Dscho's compute resources:
>
> --- a/ci/run-windows-build.sh
> +++ b/ci/run-windows-build.sh
> @@ -12,6 +12,12 @@ test -z "$GFW_CI_TOKEN" && echo "GFW_CI_TOKEN not defined" && exit
> BRANCH=$1
> COMMIT=$2
>
> +if TAG=$(git describe --exact-match "$COMMIT" 2>/dev/null)
> +then
> +	echo "Tip of $BRANCH exactly at $TAG"
> +	exit 0
> +fi
> +
> gfwci () {
> 	local CURL_ERROR_CODE HTTP_CODE
> 	CONTENT_FILE=$(mktemp -t "git-windows-ci-XXXXXX")
>
> However, I don't think we need to do the same for the builds that
> use TravisCI resources. If they would be concerned about that then 
> they wouldn't build the same hash twice in the first place.

But I do care ;-) It would be nice for me not to have to wait and
keep worrying about MacOSX builds.  It also is not nice that
branches for other tests are blocked and have to wait only because
'maint' and 'vX.Y.Z' are both tested even though we know they are
the same tree.  This is where my question earlier comes from---is
there a good way to do the "not test a branch if its at a tagged
commit, because that tag will be tested anyway" test only at one
place in the .travis.yml we have?---because it's not like we only
care about Windows.

