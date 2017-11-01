Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C27F20281
	for <e@80x24.org>; Wed,  1 Nov 2017 06:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdKAGkH (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 02:40:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54273 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750904AbdKAGkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 02:40:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00742997AF;
        Wed,  1 Nov 2017 02:40:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6nM6LWUakmoavDrSUi5Gftn9XjQ=; b=O0mnrX
        Fbl5960SCWlYhDIDry3EY6GjyTNcbD6HPHn626TMYagr5jxZS4sJC5xQ4Ytg4Nks
        yvTcNIeF5do+GU0Zz7NYD04iOUB2cunCAAKcEMWDw2WWlKxqQ2icHjSjzTkkGaER
        yNTo4PRHy+5zdgXTwjOhAiG6GW7vyLlh87XLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jiAnL6wqy2nh65n9waKciuobGcNWj+Um
        CwnSzdP1bhFWX/ri7qP17Os7cmGQF1hrU/LA3aqa08eHbdXCZfFgtdGn4xY6YtT5
        IX6gAy8ulSqMhyt/IHNQCSKiUXRqr6FZ4M9u1rgPwtFvub49TsxFcKRA2tE0QDXu
        yhDTgUcRps8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F301B997A7;
        Wed,  1 Nov 2017 02:40:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5651C9979F;
        Wed,  1 Nov 2017 02:40:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Payre Nathan <second.payre@gmail.com>
Cc:     git@vger.kernel.org, matthieu.moy@univ-lyon1.fr,
        timothee.albertin@etu.univ-lyon1.fr,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr,
        Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [PATCH 2/2] send-email: quote-email quotes the message body
References: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
        <20171030223444.5052-3-nathan.payre@etu.univ-lyon1.fr>
Date:   Wed, 01 Nov 2017 15:40:00 +0900
In-Reply-To: <20171030223444.5052-3-nathan.payre@etu.univ-lyon1.fr> (Payre
        Nathan's message of "Mon, 30 Oct 2017 23:34:44 +0100")
Message-ID: <xmqqa806tscf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D1677BE-BECF-11E7-8ADD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Payre Nathan <second.payre@gmail.com> writes:

> From: Tom Russello <tom.russello@grenoble-inp.org>
>
> ---
>  Documentation/git-send-email.txt |  4 +-
>  git-send-email.perl              | 80 ++++++++++++++++++++++++++++++++++++++--
>  t/t9001-send-email.sh            | 19 +++++++++-
>  3 files changed, 97 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 710b5ff32..329af66af 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -107,7 +107,9 @@ Only necessary if --compose is also set.  If --compose
>  is not set, this will be prompted for.
>  
>  --quote-email=<email_file>::
> -	Fill appropriately header fields for the reply to the given email.
> +	Fill appropriately header fields for the reply to the given email and quote
> +	the message body in the cover letter if `--compose` is set or otherwise
> +	after the triple-dash in the first patch given.

Hmmm.  I have a strong suspicion that people want an option to
trigger the feature from just 1/2 but not 2/2 some of the time.
Sure, removing the unwanted lines in the compose editor may be easy,
but it feels wasteful use of user's time to include the lines of
text from the original only to have them removed.

Also, if you are not offering these two as separate features, there
isn't much point splitting them into two patches.

> @@ -743,6 +768,9 @@ if ($compose) {
>  	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
>  	my $tpl_subject = $initial_subject || '';
>  	my $tpl_reply_to = $initial_reply_to || '';
> +	my $tpl_quote = $message_quoted &&
> +		"\nGIT: Please, trim down irrelevant sections in the quoted message\n".
> +		"GIT: to keep your email concise.\n" . $message_quoted || '';
>  
>  	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
>  From $tpl_sender # This line is ignored.
> @@ -756,7 +784,7 @@ EOT2
>  From: $tpl_sender
>  Subject: $tpl_subject
>  In-Reply-To: $tpl_reply_to
> -
> +$tpl_quote
>  EOT3

OK, by emitting it into $compose_filename as part of the front
matter, you get the "do we have to do mime?" etc. for free, which
sort-of makes sense.

> @@ -821,9 +849,53 @@ EOT3
>  		$compose = -1;
>  	}
>  } elsif ($annotate) {
> -	do_edit(@files);
> +	if ($quote_email) {
> +		my $quote_email_filename = ($repo ?
> +			tempfile(".gitsendemail.msg.XXXXXX",
> +				DIR => $repo->repo_path()) :
> +			tempfile(".gitsendemail.msg.XXXXXX",
> +				DIR => "."))[1];
> +
> +		# Insertion in a temporary file to keep the original file clean
> +		# in case of cancellation/error.
> +		do_insert_quoted_message($quote_email_filename, $files[0]);
> +
> +		my $tmp = $files[0];
> +		$files[0] = $quote_email_filename;
> +
> +		do_edit(@files);
> +
> +		# Erase the original patch if the edition went well
> +		move($quote_email_filename, $tmp);
> +		$files[0] = $tmp;
> +	} else {
> +		do_edit(@files);
> +	}
>  }
