Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963D61F453
	for <e@80x24.org>; Wed, 24 Apr 2019 07:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfDXH1X (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 03:27:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56664 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfDXH1X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 03:27:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAD1B56663;
        Wed, 24 Apr 2019 03:27:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FAfCE29qBknXJvKENXe5BwDJeVA=; b=cno0tL
        olk4/sZPBLhLBgubaoFQjLaEoxwH2/FuTcz3tODc89gVCX/KTFVLqVNX7mfYepEQ
        oXA9kk+htlHrulwR898IsUoQmv6yuTFSol8G+123H61c8iHR/KjW4Rkj2jEvbTce
        mkIUGp3DTdRh3EmTbSzxUt1Dvdjq6m8jK9raA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RW/Bpmw72NT8g9x5zbUHSLSdSsJsR2b1
        i77zvLghREgGdNPb28q0YqWt8JAIQrZnRiM6IcVZ/8QOIGTfIjJoge370g/chKxH
        jgIhMXVvp6QiI6SpjR6YUlqvmdnOVA7h/RCqjdWQKiYlGEVq1BwaIcU+XqP0cVtr
        TwDpbiqv63I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C816C56662;
        Wed, 24 Apr 2019 03:27:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E8C6856661;
        Wed, 24 Apr 2019 03:27:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/5] mergetool: use get_merge_tool_guessed function
References: <cover.1555880168.git.liu.denton@gmail.com>
        <cover.1556009181.git.liu.denton@gmail.com>
        <e928db892e35bcb68fcdb52c9bf7158dbbb46616.1556009181.git.liu.denton@gmail.com>
Date:   Wed, 24 Apr 2019 16:27:12 +0900
In-Reply-To: <e928db892e35bcb68fcdb52c9bf7158dbbb46616.1556009181.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 23 Apr 2019 01:54:01 -0700")
Message-ID: <xmqqr29r278v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6212285A-6662-11E9-80FA-D01F9763A999-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +get_merge_tool_guessed () {
> +	is_guessed=false
>  	# Check if a merge tool has been configured
> -	merge_tool=$(get_configured_merge_tool)
> +	merge_tool=$(get_configured_merge_tool $GIT_MERGETOOL_GUI)
>  	# Try to guess an appropriate merge tool if no tool has been set.
>  	if test -z "$merge_tool"
>  	then
>  		merge_tool=$(guess_merge_tool) || exit
> +		is_guessed=true
>  	fi
> -	echo "$merge_tool"
> +	echo "$is_guessed:$merge_tool"
> +}
> +
> +get_merge_tool () {
> +	get_merge_tool_guessed | sed -e 's/^[a-z]*://'
>  }

Yuck.  Returning a:b is fine if the main use is to match that string
using shell builtins like "test" and "case", but piping to "sed"
feels a bit too much overhead.  Especially given that the other
reader in git-emrgetool.sh is not protected for $merge_tool that has
a colon in it.  Do not try to be too cute and end up with a hack
that is both inefficient and brittle at the same time.

Possible alternatives:

 - Because variables in bourne family of shells are global, the
   caller can easily peek at $is_guessed; or

 - One bit "did we guess, or did we get from the user?" boolean
   choice can sufficiently be conveyed by ending the fuction like so
   instead:

		...
	fi
		echo "$merge_tool"
		test "$is_guessed" = true
	}

> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 01b9ad59b2..63e4da1b2f 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -449,14 +449,9 @@ main () {
>  
>  	if test -z "$merge_tool"
>  	then
> -		# Check if a merge tool has been configured
> -		merge_tool=$(get_configured_merge_tool $gui_tool)
> -		# Try to guess an appropriate merge tool if no tool has been set.
> -		if test -z "$merge_tool"
> -		then
> -			merge_tool=$(guess_merge_tool) || exit
> -			guessed_merge_tool=true
> -		fi
> +		IFS=':' read guessed_merge_tool merge_tool <<-EOF
> +		$(GIT_MERGETOOL_GUI=$gui_tool get_merge_tool_guessed)
> +		EOF

With the "let the return code speak" alternative, this would become
something like

	if merge_tool=$(GIT_MERGETOOL_GUI=$gui_tool; get_merge_tool_guessed)
	then
		guessed_merge_tool=true
	else
		guessed_merge_tool=false
	fi
	
I do not know what you are trying with GIT_MERGETOOL_GUI=$gui_tool
before the shell function, though.  It does not work as one-shot
assignment to an environment variable.  I _think_ it is to feed the
all-caps variable to get_configured_merge_tool that is invoked by
the get_merge_tool_guessed function, so it does not have to be
exported as an environment in the first place, so in the above
illustration, I simply wrote an assignment statement, followed by a
separate statement that is a parameterless call of a shell function,
separated by a semicolon.

>  	fi
>  	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
>  	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
