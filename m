Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F5B1F462
	for <e@80x24.org>; Thu, 25 Apr 2019 03:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbfDYDCa (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 23:02:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57524 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388648AbfDYDCa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 23:02:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6350F5E872;
        Wed, 24 Apr 2019 23:02:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iJTkJ6E50RzZilj9oexMEZIwVAc=; b=xcOeS6
        RAJIZz+pNkpGzRfCxq5KuhTNbpT5pO6INRJWLSE0+Ls0uCTPUkpmuZK5Vs4gYC3k
        W3Xgw1SUW9aLIa6jph1/zRW3VYWmQVpZezdnWIpxPDC26n4xKg5nVQbaxDLmSEoi
        gNr3B12JGHE/mAqq6a82yRhddTRI89mpQtU5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T/kt8Np5gOzqSK5N68ui76i1i/y5jM4W
        c9tMfEfTHi2zFU/fJdu/HZSlqUN1Pmuf+XCJ8Xpb5YcW276ZsMnJjYXz4hDh0ODK
        TUWF1dquVS7mfQZinwJSiZlrFrsjlnFSX8iVgXx95wRcKn2Gjdym6nj/x65qzjcF
        8hf5DZNN+TY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B7CD5E870;
        Wed, 24 Apr 2019 23:02:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8977E5E86D;
        Wed, 24 Apr 2019 23:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/6] mergetool: fallback to tool when guitool unavailable
References: <cover.1556009181.git.liu.denton@gmail.com>
        <cover.1556142510.git.liu.denton@gmail.com>
        <e975fe4a8b206d8e40f9c4d7cd278fdb5c7358f0.1556142510.git.liu.denton@gmail.com>
Date:   Thu, 25 Apr 2019 12:02:23 +0900
In-Reply-To: <e975fe4a8b206d8e40f9c4d7cd278fdb5c7358f0.1556142510.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 24 Apr 2019 15:47:01 -0700")
Message-ID: <xmqq7ebizt1c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DAB5924-6706-11E9-BF13-D01F9763A999-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In git-difftool, if the tool is called with --gui but `diff.guitool` is
> not set, it falls back to `diff.tool`. Make git-mergetool also fallback
> from `merge.guitool` to `merge.tool` if the former is undefined.
>
> If git-difftool were to use `get_configured_mergetool`, it would also

I agree that the precedence order below makes sense, but I am a bit
confused by "were to use" here.  Do you mean you'll make the change
to make difftool to look at mergetool configuraiton in a later step
in the series?  Or is there a way for the user to say "I want my
difftool to also pay attention to the mergetool configurations" (and
another "I do not want that" option)?  I'll come back to this later.

> get the fallback behaviour in the following precedence:
>
> 1. diff.guitool
> 2. merge.guitool
> 3. diff.tool
> 4. merge.tool
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/git-mergetool.txt |  4 +++-
>  git-mergetool--lib.sh           | 27 ++++++++++++++++++---------
>  t/t7610-mergetool.sh            | 19 +++++++++++++++++++
>  3 files changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
> index 0c7975a050..6b14702e78 100644
> --- a/Documentation/git-mergetool.txt
> +++ b/Documentation/git-mergetool.txt
> @@ -83,7 +83,9 @@ success of the resolution after the custom tool has exited.
>  --gui::
>  	When 'git-mergetool' is invoked with the `-g` or `--gui` option
>  	the default merge tool will be read from the configured
> -	`merge.guitool` variable instead of `merge.tool`.
> +	`merge.guitool` variable instead of `merge.tool`. If
> +	`merge.guitool` is not set, we will fallback to the tool
> +	configured under `merge.tool`.

Makes sense.  So "mergetool --gui" from the command line would look
at guitool and then tool in the merge section.

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 68ff26a0f7..ada16acffc 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -350,20 +350,29 @@ guess_merge_tool () {
>  }
>  
>  get_configured_merge_tool () {
> -	# If first argument is true, find the guitool instead
> -	if test "$1" = true
> +	is_gui="$1"
> +	sections="merge"
> +	keys="tool"
> +
> +	if diff_mode
>  	then
> -		gui_prefix=gui
> +		sections="diff $sections"
>  	fi
>  
> -	# Diff mode first tries diff.(gui)tool and falls back to merge.(gui)tool.
> -	# Merge mode only checks merge.(gui)tool
> -	if diff_mode
> +	if "$is_gui" = true
>  	then
> -		merge_tool=$(git config diff.${gui_prefix}tool || git config merge.${gui_prefix}tool)
> -	else
> -		merge_tool=$(git config merge.${gui_prefix}tool)
> +		keys="guitool $keys"
>  	fi

OK, so $sections is "diff merge" for difftool and just "merge" for mergetool.
$tool is "guitool tool" under "--gui", and just "tool" otherwise.

> +	IFS=' '
> +	for key in $keys
> +	do
> +		for section in $sections
> +		do
> +			merge_tool=$(git config $section.$key) && break 2
> +		done
> +	done

And you do up to four iterations to cover the combination in the
precedence order.  Which makes sense.

I am not sure about the wisdom of setting IFS here, though.

As far as I can see, both $keys and $sections do not take any
arbitrary values, but just the two (for each) values you know that
do not have any funny characters, so I am not sure what you are
trying to achieve by that (i.e. benefit is unclear).

As long as the get_configured_merge_tool function is called always
for string_emitted_to_stdout=$(that function), the updated setting
will not leak to the outside world so there is no risk to break its
callers, but it is not immediately obvious if helper functions
called in the remainder of this function are OK with the modified
value of IFS (i.e. safety is not obvious).

Now for the promised "come back to this later", I think you meant
"the get_configured_merge_tool function is already prepared to be
used from difftool in this step and when difftool starts to call it
here is what happens".  But I wonder if it makes the evolution of
the topic easier to follow if you defer it to a later step when you
actually make difftool to start calling it?  In other words, in this
step, your get_configured_merge_tool would look like

	sections=merge

	case "$1" in
	true)
		keys="guitool tool" ;;
	*)
		keys="tool" ;;
	esac

	for key in $keys
	do
		for section in $sections
		do
			merge_tool=$(git config ...) && break 2
		done
	done
	...

and then in a later step (6/6?), the unconditional setting of
sections to 'merge' would be updated so that in diff_mode, you'll
iterate over two sections.

I dunno.
