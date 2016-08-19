Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70491F859
	for <e@80x24.org>; Fri, 19 Aug 2016 18:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbcHSSZ6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 14:25:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59464 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753952AbcHSSZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 14:25:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E6D136CF8;
        Fri, 19 Aug 2016 14:25:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jxR6n5sXl9hSvVsPTkqcjz1BdHQ=; b=M3T8G4
        9+SoIBS0f7uFYi/jML4pyqCPQrDR39pDSiOcX6hTXZ3xouNGfQd0ZOWJaphoiDNl
        Dx5LLjv5l7h6HZ/EvBQ1T4/KtAtkmfaNbr2ANtWdGX8slPFQ2bf5gXr/0I8h8zVf
        89wwju38mkBbKVhk9/hncIMS6ZuFp4HRgiqkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eODeU+kRYNFle5muFXCaYosnfKCOd1Ei
        Spd0/L6ZNuT2BinVFF/rTntA4Uv5qBYc08LGF+g7UIRfkyPNxGyrKe+dG0QVokDh
        b65fTz9FMen0CxyWadvJrKj5js0Ui0YQNN7tbZFO2rBWUBxJHz7m7PaUQTsA3EfJ
        LVwjZxJtyXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3672F36CF7;
        Fri, 19 Aug 2016 14:25:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B60D036CF5;
        Fri, 19 Aug 2016 14:25:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org
Subject: Re: [PATCH v3 2/3] diff-highlight: add failing test for handling --graph output.
References: <20160819170812.1676-1-henderson.bj@gmail.com>
        <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
        <20160819170812.1676-3-henderson.bj@gmail.com>
Date:   Fri, 19 Aug 2016 11:25:53 -0700
In-Reply-To: <20160819170812.1676-3-henderson.bj@gmail.com> (Brian Henderson's
        message of "Fri, 19 Aug 2016 10:08:11 -0700")
Message-ID: <xmqqd1l439am.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E4C635A-663A-11E6-A0E8-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> writes:

> Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
> ---
>  contrib/diff-highlight/t/t9400-diff-highlight.sh | 54 ++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> index 6b8a461..3b3c831 100755
> --- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
> +++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> @@ -85,10 +85,50 @@ dh_commit_test () {
>  	test_cmp commit.exp commit.act
>  }
>  
> +# dh_test_setup_history takes a series (3) of changes and generates a contrived graph
> +# of commits and merges

The first line look a bit overlong.

If the graph is truly "contrived" as the comment at the beginning
says (I haven't formed an opinion), it probably is a good idea to
draw a picture upfront.

> +dh_test_setup_history () {
> +	a="$1" b="$2" c="$3"

Even though assignment would not fail, it probably is a good idea to
&&-chain this line, too, for consistency.  I.e.

	a=$1 b=$2 c=$3 &&

Note that RHS of an assignment do not need dq; it does not hurt to
quote them, though.

> +	printf "$a" >file &&
> +	git add file &&
> +	git commit -m"Add a file" &&

Avoid sticking a short-option to its argument, i.e.

    git commit -m "Add a file"

> +	printf "$b" >file &&
> +	git commit -am"Update a file" &&

Likewise.

    git commit -a -m "Update a file".

> +left_trim () {
> +	"$PERL_PATH" -pe 's/^\s+//'
> +}
> +
> +trim_graph_el () {

What does "el" stand for?  Not E-lisp ;-)

If you meant "elements" or something, probably that is unnecessary
and "trim_graph" would be sufficient, but you may have meant
something else.

> +	# graphs start with * or |
> +	# followed by a space or / or \
> +	"$PERL_PATH" -pe 's@^((\*|\|)( |/|\\))+@@'
> +}
> +
>  test_expect_success 'diff-highlight highlights the beginning of a line' '
>  	dh_test \
>  		"aaa\nbbb\nccc\n" \
> @@ -145,6 +185,20 @@ test_expect_failure 'diff-highlight highlights mismatched hunk size' '
>  
>  # TODO add multi-byte test
>  
> +test_expect_failure 'diff-highlight works with the --graph option' '
> +	dh_test_setup_history \
> +		"aaa\nbbb\nccc\n" \
> +		"aaa\n0bb\nccc\n" \
> +		"aaa\nb0b\nccc\n" &&
> +
> +	# topo-order so that the order of the commits is the same as with --graph
> +	# trim graph elements so we can do a diff
> +	# trim leading space because our trim_graph_el is not perfect
> +	git log -p --topo-order | "$DIFF_HIGHLIGHT" | left_trim >graph.exp &&
> +	git log -p --graph | "$DIFF_HIGHLIGHT" | trim_graph_el | left_trim >graph.act &&
> +	test_cmp graph.exp graph.act
> +'
> +
>  test_done
>  
>  # vim: set noet
