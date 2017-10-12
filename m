Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4616E20437
	for <e@80x24.org>; Thu, 12 Oct 2017 10:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdJLKLS (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 06:11:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53898 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751140AbdJLKLR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 06:11:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90A149FC57;
        Thu, 12 Oct 2017 06:11:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ovg/G7yTyBdBc9RDsB0oSLzJinc=; b=skma/r
        v3ERAp6NtQHsP3KqDdggUTGHYvTHnkqPvdERN66W9gYowhZqDtYY5fZa2KuIYfeA
        nKXt9TPtwS+rrASwd9ldrEx/zOssWozogu96Kjct6Fj50dmubuqKcTWJLej2vgoN
        TN4iqhStCYO/CVrTAPRlHqsd7BBXBsmeLN8lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mBtja1+cBanuyEKlD+xKEXM/RhPeE3Ox
        LVndPdrmK0zQFU9r3pX0rHdh+XGYALXhG6zd9FhLBvghNZKc1OfL676BNbh1QmQf
        U09Pn4btEAwzE3y+CtOuqF5FZ3sUMkrypRY3WyhOBpewOaUlbR6Ih2n6JJY8Xug5
        Hu2hVoZIVkw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87B6C9FC56;
        Thu, 12 Oct 2017 06:11:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C031A9FC50;
        Thu, 12 Oct 2017 06:11:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "W. Trevor King" <wking@tremily.us>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Subject: Re: [PATCH v2] pull: pass --signoff/--no-signoff to "git merge"
References: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
        <51d67d6d707182d4973d9961ab29358f26c4988a.1507796638.git.wking@tremily.us>
Date:   Thu, 12 Oct 2017 19:11:14 +0900
In-Reply-To: <51d67d6d707182d4973d9961ab29358f26c4988a.1507796638.git.wking@tremily.us>
        (W. Trevor King's message of "Thu, 12 Oct 2017 01:46:39 -0700")
Message-ID: <xmqqk200znel.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEBFFF3C-AF35-11E7-B99C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"W. Trevor King" <wking@tremily.us> writes:

> e379fdf3 (merge: refuse to create too cool a merge by default,
> 2016-03-18) gave a reason for *not* passing options from pull to
> merge:
>
>   ...because such a "two project merge" would be done after fetching
>   the other project into some location in the working tree of an
>   existing project and making sure how well they fit together...

Read the above again and notice the phrase "two project merge".  The
reasoning applies only to the --allow-unrelated-histories option.
It gave a reason for not passing *THAT* option and nothing else, and
does not mean to say anything about passing or not passing any other
options.  

That is why I said the reference to that commit was irrelevant in
the context of this patch.

If you find somebody saying "we should not pass --signoff from pull
to merge" when we taught "--signoff" to "merge", then that may be
worth referring to, as this commit _will_ be changing that earlier
decision.  I however do not think that is a case.  Just saying
"merge can take --signoff, but without pull passing --signoff down,
it is inconvenient, so let's pass it through" is sufficient to
justify this change.

> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index ded8f98dbe..82680a30f8 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -165,4 +165,44 @@ test_expect_success 'git pull --allow-unrelated-histories' '
>  	)
>  '
>  
> +test_expect_success 'git pull does not add a sign-off line' '
> +	test_when_finished "rm -fr src dst" &&
> +	git init src &&
> +	test_commit -C src one &&
> +	git clone src dst &&
> +	test_commit -C src two &&
> +	git -C dst pull --no-ff &&
> +	! test_has_trailer -C dst HEAD Signed-off-by
> +'
> +
> +test_expect_success 'git pull --no-signoff does not add sign-off line' '
> +	test_when_finished "rm -fr src dst" &&
> +	git init src &&
> +	test_commit -C src one &&
> +	git clone src dst &&
> +	test_commit -C src two &&
> +	git -C dst pull --no-signoff --no-ff &&
> +	! test_has_trailer -C dst HEAD Signed-off-by
> +'
> +
> +test_expect_success 'git pull --signoff add a sign-off line' '
> +	test_when_finished "rm -fr src dst" &&
> +	git init src &&
> +	test_commit -C src one &&
> +	git clone src dst &&
> +	test_commit -C src two &&
> +	git -C dst pull --signoff --no-ff &&
> +	test_has_trailer -C dst HEAD Signed-off-by "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
> +'
> +
> +test_expect_success 'git pull --no-signoff flag cancels --signoff flag' '
> +	test_when_finished "rm -fr src dst actual" &&
> +	git init src &&
> +	test_commit -C src one &&
> +	git clone src dst &&
> +	test_commit -C src two &&
> +	git -C dst pull --signoff --no-signoff --no-ff &&
> +	! test_has_trailer -C dst HEAD Signed-off-by
> +'
> +
>  test_done
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 1701fe2a06..08409b1c25 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -726,6 +726,49 @@ test_must_be_empty () {
>  	fi
>  }
>  
> +# Call test_has_trailer with the arguments:
> +# [-C <directory>] <object> <token> [<value>]
> +# where <object> is an object name as described in gitrevisions(7),
> +# <token> is a trailer token (e.g. 'Signed-off-by'), and
> +# <value> is an optional value (e.g. 'A U Thor <author@example.com>').
> +# test_has_trailer returns success if the specified trailer is found
> +# in the object content.  If <value> is unset, any value will match.
> +#
> +# Both <token> and <value> are basic regular expressions.
> +#
> +# If the first argument is "-C", the second argument is used as a path for
> +# the git invocations.
> +test_has_trailer () {
> +	INDIR=
> +	case "$1" in
> +	-C)
> +		INDIR="$2"
> +		shift 2 || error "<directory> not specified"
> +		;;
> +	esac
> +	INDIR="${INDIR:+${INDIR}/}"
> +	OBJECT="$1"
> +	shift || error "<object> not specified"
> +	TOKEN="$1"
> +	shift || error "<token> not specified"
> +	SEP=':'  # FIXME: read from trailer.separators?
> +	CONTENT="$(git ${INDIR:+ -C "${INDIR}"} cat-file -p "${OBJECT}")" || error "object ${OBJECT} not found${INDIR:+ in ${INDIR}}"
> +	PATTERN="^${TOKEN}${SEP}"
> +	if test 0 -lt "$#"
> +	then
> +		VALUE="$1"
> +		PATTERN="${PATTERN} *${VALUE}$"
> +	fi
> +	if (echo "${CONTENT}" | grep -q "${PATTERN}")
> +	then
> +		printf "%s found in:\n%s\n" "${PATTERN}" "${CONTENT}"
> +		return 0
> +	else
> +		printf "%s not found in:\n%s\n" "${PATTERN}" "${CONTENT}"
> +		return 1
> +	fi
> +}

The reason why I suggested a simple "sed -n -e ...p" you used in
your original was because it could be used to extract not just one
Signed-off-by: lines to store in >actual, to be compared with an
expect that has multiple S-o-b lines and the output is in correct
order, etc.  An elaborate filter that can onlyl give "found/not
found" boolean looks a bit over-engineered for no real gain.

>  # Tests that its two parameters refer to the same revision
>  test_cmp_rev () {
>  	git rev-parse --verify "$1" >expect.rev &&
