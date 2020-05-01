Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822F6C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 17:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C82C24954
	for <git@archiver.kernel.org>; Fri,  1 May 2020 17:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gnmTsgIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgEARKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 13:10:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55340 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbgEARKY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 13:10:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD860C2819;
        Fri,  1 May 2020 13:10:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z3rPK6i0XE7uUPFYQeDegk9xqsk=; b=gnmTsg
        IUfcpQ/WM45JjHZkatsA/8jv3cXamKwDICHRUt+tM6oM5+Bhu5XFgxMy7kiMF1Im
        B7iQ22yq+TE+FEsqZnY35WSWMwd1IzgpOhw3KhWmoPmGDtSD4mR9X3Bp1eE5Up6n
        xmfOG5xcXI0p/vzzQb2LAYcDRaigvoUeatRCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gkLxm2rI/vM8aPg+VWvi40vaSuGlwoph
        jP4XLGlXVFdjToFJ7sJ4rOge3+Ain3yVz+jwNoPt5VyD5OPcymiAOC010JBjMJKf
        nj7gLPMI5DPN8MHGmqLOHalkDupnBNrb14V01oXkQxbecPvssK9Fgznze/AMGoKy
        0g76vpjTEzs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4E78C2818;
        Fri,  1 May 2020 13:10:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E7D46C2817;
        Fri,  1 May 2020 13:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Russo <antonio.e.russo@gmail.com>
Cc:     git-ml <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3 v3] Clean up t6016-rev-list-graph-simplify-history
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
        <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
        <3a2605b6-c612-f70c-a11e-1e1cc3f59184@gmail.com>
Date:   Fri, 01 May 2020 10:10:15 -0700
In-Reply-To: <3a2605b6-c612-f70c-a11e-1e1cc3f59184@gmail.com> (Antonio Russo's
        message of "Fri, 1 May 2020 08:21:04 -0600")
Message-ID: <xmqq4kszoa2w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A10BE176-8BCE-11EA-AF67-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Russo <antonio.e.russo@gmail.com> writes:

> +check_graph () {
> +	cat >expected &&

Not a new issue, but we may want to fix this to align to majority of
tests by calling it "expect".

> +	git rev-list --graph "$@" | sed "$(cat sedscript)" > actual &&

Style. No SP between > (or < for that matter) and the filename.

The "sed" utility can be told to read its script from a file with
its "-f" option.

Correctness.  Never run "git" command that is the target being
tested on the left side of a pipe.  It will hide the exit status.

> +	test_cmp expected actual
> +}

>  test_expect_success 'set up rev-list --graph test' '
>  	# 3 commits on branch A
>  	test_commit A1 foo.txt &&
> @@ -43,76 +49,62 @@ test_expect_success 'set up rev-list --graph test' '
>
>  	test_commit A7 bar.txt &&
>
> -	# Store commit names in variables for later use
> -	A1=$(git rev-parse --verify A1) &&
> -	A2=$(git rev-parse --verify A2) &&
> -	A3=$(git rev-parse --verify A3) &&
> -	A4=$(git rev-parse --verify A4) &&
> -	A5=$(git rev-parse --verify A5) &&
> -	A6=$(git rev-parse --verify A6) &&
> -	A7=$(git rev-parse --verify A7) &&
> -	B1=$(git rev-parse --verify B1) &&
> -	B2=$(git rev-parse --verify B2) &&
> -	C1=$(git rev-parse --verify C1) &&
> -	C2=$(git rev-parse --verify C2) &&
> -	C3=$(git rev-parse --verify C3) &&
> -	C4=$(git rev-parse --verify C4)
> -	'
> +	echo "s/ *$//;" > sedscript &&
> +	( for tag in $(git tag -l) ; do echo "s/$(git rev-parse --verify $tag)/$tag/;" >> sedscript ; done )

Avoid unreadable one-liner with needless subshell.

I suspect that this is a task for-each-ref was designed for,
something along the lines of...

	git for-each-ref --format='s|%(objectname)|%(refname:short)|' \
		refs/tags/ >>sedScript

> +'
>
>  test_expect_success '--graph --all' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "*   $A6" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "| * $C3" >> expected &&
> -	echo "* | $A5" >> expected &&
> -	echo "| |   " >> expected &&
> -	echo "|  \\  " >> expected &&
> -	echo "*-. | $A4" >> expected &&
> -	echo "|\\ \\| " >> expected &&
> -	echo "| | * $C2" >> expected &&
> -	echo "| | * $C1" >> expected &&
> -	echo "| * | $B2" >> expected &&
> -	echo "| * | $B1" >> expected &&
> -	echo "* | | $A3" >> expected &&
> -	echo "| |/  " >> expected &&
> -	echo "|/|   " >> expected &&
> -	echo "* | $A2" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "* $A1" >> expected &&
> -	git rev-list --graph --all > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --all <<-\EOF
> +	* A7
> +	*   A6
> +	|\
> +	| * C4
> +	| * C3
> +	* | A5
> +	| |
> +	|  \
> +	*-. | A4
> +	|\ \|
> +	| | * C2
> +	| | * C1
> +	| * | B2
> +	| * | B1
> +	* | | A3
> +	| |/
> +	|/|
> +	* | A2
> +	|/
> +	* A1
> +	EOF

Much nicer to see.

Having said all that, I am not sure if this change of design is
sound.

The original approach would have worked even if two or more of these
tags pointed at the same object.  Your version will pick one of
them.  If two tags, say A5 and C8, pointed at the same commit, and
the illustration given to check_graph helper from its standard
output labeled a commit as C8, wouldn't the actual output converted
to show A5 with your sedScript approach?

I think it is salvageable by changing the direction you munge.
Instead of munging the rev-list output, you can store it as-is in
"actual", and instead pass the illustration that comes from the
standard input of the check_graph helper through sed to expand the
symbolic names to actual object names before comparing. i.e.

	check_graph () {
		sed -f expand_tag_to_objects.sed >expect &&
		git rev-list --graph "$@" >actual &&
		test_cmp expect actual
	}

Note that I renamed the overly generic "sedscript" to a name that
reflects the purpose of the file (and the contents being of a
certain type is conveyed by .sed suffix, just like you'd use
suffixes like .c, .txt).  A good discipline to learn, I would say.

Thanks.
