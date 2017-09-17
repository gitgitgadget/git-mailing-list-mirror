Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D44320A26
	for <e@80x24.org>; Sun, 17 Sep 2017 04:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbdIQErT (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 00:47:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65282 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750744AbdIQErS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 00:47:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D5829A781;
        Sun, 17 Sep 2017 00:47:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3dN4/inpLqw/pqn/JT2h/SP52eI=; b=a1ZNxn
        GDZbK5I/yu12SFAx7G/5zgGLn/UjkK+GwsJikfcKtGGUTI5Z3whYYTGRDmsTe2wM
        UrmduxLZ0W8cgpSIUekHWVHKAPAGgK2mupJ3nO4bg5WY6VKjCXKQQMlJgKSvlaYB
        pVVjab+sMBlHpVHOVLOMzBCi69pHLzpTwlFoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MIEZcbTNi3+SAaIv0SJQdc2z153+18gg
        jXsXQuegNH94TejQbwXUM563vBBqeleSWL/CiNkz7yLtB6o0jPX4Di41ndNLWEyZ
        3/5Ur8N/FdraT+fuG3gd855vICfFJ9AzjvENcwffnFIDn49vsEqIu2C4cbi2vnUn
        ZdwpcFcaahg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AECE9A77F;
        Sun, 17 Sep 2017 00:47:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A9729A77E;
        Sun, 17 Sep 2017 00:47:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor extension
References: <20170610134026.104552-1-benpeart@microsoft.com>
        <20170915192043.4516-1-benpeart@microsoft.com>
        <20170915192043.4516-11-benpeart@microsoft.com>
Date:   Sun, 17 Sep 2017 13:47:15 +0900
In-Reply-To: <20170915192043.4516-11-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 15 Sep 2017 15:20:41 -0400")
Message-ID: <xmqqy3peszho.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47BE266E-9B63-11E7-B5ED-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> +write_integration_script() {
> +	write_script .git/hooks/fsmonitor-test<<-\EOF
> +	if [ "$#" -ne 2 ]; then
> +		echo "$0: exactly 2 arguments expected"
> +		exit 2
> +	fi
> +	if [ "$1" != 1 ]; then
> +		echo -e "Unsupported core.fsmonitor hook version.\n" >&2
> +		exit 1
> +	fi

In addition to "echo -e" thing pointed out earlier, these look
somewhat unusual in our shell scripts, relative to what
Documentation/CodingGuidelines tells us to do:

 - We prefer a space between the function name and the parentheses,
   and no space inside the parentheses. The opening "{" should also
   be on the same line.

	(incorrect)
	my_function(){
		...

	(correct)
	my_function () {
		...

 - We prefer "test" over "[ ... ]".

 - Do not write control structures on a single line with semicolon.
   "then" should be on the next line for if statements, and "do"
   should be on the next line for "while" and "for".

	(incorrect)
	if test -f hello; then
		do this
	fi

	(correct)
	if test -f hello
	then
		do this
	fi

> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
> new file mode 100755
> index 0000000000..aaee5d1fe3
> --- /dev/null
> +++ b/t/t7519/fsmonitor-watchman
> @@ -0,0 +1,128 @@
> +#!/usr/bin/perl
> +
> +use strict;
> +use warnings;
> +use IPC::Open2;
> + ...
> +	open (my $fh, ">", ".git/watchman-query.json");
> +	print $fh "[\"query\", \"$git_work_tree\", { \
> +	\"since\": $time, \
> +	\"fields\": [\"name\"], \
> +	\"expression\": [\"not\", [\"allof\", [\"since\", $time, \"cclock\"], [\"not\", \"exists\"]]] \
> +	}]";
> +	close $fh;
> +
> +	print CHLD_IN "[\"query\", \"$git_work_tree\", { \
> +	\"since\": $time, \
> +	\"fields\": [\"name\"], \
> +	\"expression\": [\"not\", [\"allof\", [\"since\", $time, \"cclock\"], [\"not\", \"exists\"]]] \
> +	}]";

This look painful to read, write and maintain.  IIRC, Perl supports
the <<HERE document syntax quite similar to shell; would it make
these "print" we see above easier?

> +}
> \ No newline at end of file

Oops.

Thanks.
