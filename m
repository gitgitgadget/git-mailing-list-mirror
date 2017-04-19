Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEBAB207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 03:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759437AbdDSDpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 23:45:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61203 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759434AbdDSDp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 23:45:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82A80843F0;
        Tue, 18 Apr 2017 23:45:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=H85HkITaa33E
        kwM/7Mz7i6p+eJE=; b=S0/MktXxwiogK0siFi7KlfaChCPXMwL2KwKcIwfRTkok
        TxsigfgbukbksXH59BTASHme2WEaUPSYWaqNA9vE105iyGgBZhNAMXe8gO6bh01z
        w+IUToCqw8eaD/lDB2T/6qOS2+BcwJ6VC5UHRN9qNoHRo5mtXh+jKrJWoi+aZv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VZSfNu
        YxOVtL3j8Tz6c0jHVd1CPTzc7ehlX/2jxFZNOPu2Ql6my6KZTbCBGwzKB7Zw5Ef3
        LYwxWYIaAtYm24QAoyKAhvQk86IhNHzZn2ZXWjwo/+F/y+i+jtt+rwlg/l8PuZ8A
        QQxdDdEdzV137hNrXTXqZxyy0F73JiKrA9TZ0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B2DD843EF;
        Tue, 18 Apr 2017 23:45:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8722843EE;
        Tue, 18 Apr 2017 23:45:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] completion: expand "push --delete <remote> <ref>" for refs on that <remote>
References: <20170418133152.3262-1-avarab@gmail.com>
Date:   Tue, 18 Apr 2017 20:45:25 -0700
In-Reply-To: <20170418133152.3262-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 18 Apr 2017 13:31:52 +0000")
Message-ID: <xmqqo9vtawmi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A03A2FEA-24B2-11E7-9C6F-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the completion of "push --delete <remote> <ref>" to complete
> refs on that <remote>, not all refs. Before this e.g. cloning git.git
> and doing "git push --delete origin p<TAB>" will complete nothing,
> whereas origin/p<TAB> will uselessly complete origin/pu.
>
> Now p<TAB> will complete as "pu". The completion of giving --delete
> later, e.g. "git push origin --delete p<TAB>" remains unchanged, this
> is a bug, but is a general existing limitation of the bash completion,
> and not how git-push is documented, so I'm not fixing that case.
>
> I looked over t9902-completion.sh but couldn't quickly find out how to
> add a test for this, but all the existing tests pass, and all my
> manual testing of "git push --delete <remote> ..." does the right
> thing now.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

This looks like a sensible thing to want to add.  Perhaps somebody
more familiar with the completion tests can help with t/ and also
give us general comments.  Until then, let me queue it as is on
'pu'.

Thanks.

>  contrib/completion/git-completion.bash | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index 1150164d5c..2e5b3ed776 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -701,7 +701,7 @@ __git_complete_revlist ()
>  __git_complete_remote_or_refspec ()
>  {
>  	local cur_=3D"$cur" cmd=3D"${words[1]}"
> -	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
> +	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0 de=
lete=3D0
>  	if [ "$cmd" =3D "remote" ]; then
>  		((c++))
>  	fi
> @@ -709,6 +709,7 @@ __git_complete_remote_or_refspec ()
>  		i=3D"${words[c]}"
>  		case "$i" in
>  		--mirror) [ "$cmd" =3D "push" ] && no_complete_refspec=3D1 ;;
> +		--delete) delete=3D1 ;;
>  		--all)
>  			case "$cmd" in
>  			push) no_complete_refspec=3D1 ;;
> @@ -761,7 +762,9 @@ __git_complete_remote_or_refspec ()
>  		fi
>  		;;
>  	push)
> -		if [ $lhs =3D 1 ]; then
> +		if [ $delete =3D 1 ]; then
> +			__git_complete_refs --remote=3D"$remote" --pfx=3D"$pfx" --cur=3D"$c=
ur_"
> +		elif [ $lhs =3D 1 ]; then
>  			__git_complete_refs --pfx=3D"$pfx" --cur=3D"$cur_"
>  		else
>  			__git_complete_refs --remote=3D"$remote" --pfx=3D"$pfx" --cur=3D"$c=
ur_"
