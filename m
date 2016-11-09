Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAF12035F
	for <e@80x24.org>; Wed,  9 Nov 2016 05:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbcKIF4W (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 00:56:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51568 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751725AbcKIF4U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 00:56:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9FA14EEE9;
        Wed,  9 Nov 2016 00:56:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=+At3Mglcmmth4lWmHDC5yIwj0UU=; b=K90wlqEYBnHj4vuymmaT
        Cd3dRMyWbjcgeujeRwbNL4zhvfRuT1beYtPtQf0bXQMv4DQwYGjrwE34caCncG5q
        q0Nbe6eDDf8tWgqNLrjx8d+oqZAOVUEv6r6KdEb7yEQLk/Y/fl0Ua0svY9dC9/h2
        oOXnvt+jDbRdd74b6VPuB/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=hpZ3f9Jf8LcNBU/BGsFJLCWhUt+8VP+eg5QVOWaowhhwUi
        xpWJxViHOM5FOr3qU7RToJnjHgfyhjY3MRlnwFympS72EDYxhUGI0lgdJSBJYdaS
        AwJvZFBA+bXFDleBIsuaPruR7QsY/g+FCAW2eqgwH/ScQLzId9zuNMiCUfwFA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C18FC4EEE8;
        Wed,  9 Nov 2016 00:56:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 465734EEE7;
        Wed,  9 Nov 2016 00:56:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v5 01/16] Git.pm: add subroutines for commenting lines
Date:   Tue, 08 Nov 2016 17:06:35 -0800
References: <20161108120823.11204-1-vascomalmeida@sapo.pt>
        <20161005172110.30801-1-vascomalmeida@sapo.pt>
        <20161108120823.11204-2-vascomalmeida@sapo.pt>
Message-ID: <xmqqshr19oxp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C276242-A641-11E6-8E7B-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Add subroutines prefix_lines and comment_lines.
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  perl/Git.pm | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index b2732822a..17be59fb7 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1438,6 +1438,29 @@ sub END {
>  
>  } # %TEMP_* Lexical Context
>  
> +=item prefix_lines ( PREFIX, STRING )
> +
> +Prefixes lines in C<STRING> with C<PREFIX>.
> +
> +=cut
> +
> +sub prefix_lines {
> +	my ($prefix, $string) = @_;
> +	$string =~ s/^/$prefix/mg;
> +	return $string;
> +}
> +
> +=item comment_lines ( STRING )
> +
> +Comments lines following core.commentchar configuration.
> +
> +=cut
> +
> +sub comment_lines {
> +	my $comment_line_char = config("core.commentchar") || '#';
> +	return prefix_lines("$comment_line_char ", @_);
> +}
> +

This makes it appear as if comment_lines can take arbitrary number
of strings as its arguments (because the outer caller just passes @_
thru), but in fact because prefix_lines ignores anything other than
$_[0] and $_[1], only the first parameter given to comment_lineS sub
is inspected for lines in it and the prefix-char prefixed at the
beginning of each of them.

Which is not a great interface, as it is quite misleading.

Perhaps

	prefix_lines("#", join("\n", @_));

or something like that may make it less confusing.
