Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD454BD6
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d1t/Ml4A"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 93A5D1D64BB;
	Mon,  8 Jan 2024 13:04:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=44dtyWo8PSEa
	5jPqgAhLNLQet1iqZ0En0wZKz2N5Qyc=; b=d1t/Ml4AMi2dfC1BAxqLlJN5zes+
	5R4KO8rJNhe8K7y1uqyMW7R5soAPH7ZQ2Pi3SuHluzTkRQstR/SGUJHjgSEXu+Xv
	5Mq48w/Fxe9m7Foj0Revm1X7IvwXtSfC5Luy0E+0hn69dlzk6LFW9sm/K8qG+RI+
	zmLLxQl0jib3sh0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A70E1D64BA;
	Mon,  8 Jan 2024 13:04:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCBEB1D64B7;
	Mon,  8 Jan 2024 13:04:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: clarify <oldbranch> term
In-Reply-To: <d38e5a18-4d85-48f3-bc8b-8ca02ea683a4@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sat, 6 Jan 2024 15:38:37 +0100")
References: <d38e5a18-4d85-48f3-bc8b-8ca02ea683a4@gmail.com>
Date: Mon, 08 Jan 2024 10:04:55 -0800
Message-ID: <xmqq8r4zln08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6E7AC3A0-AE50-11EE-9BCA-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Since 52d59cc645 (branch: add a --copy (-c) option to go with --move
> (-m), 2017-06-18) <oldbranch> is used in more operations than just -m.
>
> Let's also clarify what we do if <oldbranch> is omitted.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  Documentation/git-branch.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
> index 4395aa9354..233264549c 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -312,7 +312,8 @@ superproject's "origin/main", but tracks the submod=
ule's "origin/main".
>  	option is omitted, the current HEAD will be used instead.
> =20
>  <oldbranch>::
> -	The name of an existing branch to rename.
> +	The name of an existing branch.  If this option is omitted,
> +	the name of the current branch will be used instead.

Thanks.

Will queue this patch as is for now, but I suspect that in the
longer term it will help readers a lot to revamp the whole page.
The description for the "branch rename" operation, for example, is
split and partly repreated in three places, i.e.=20

 * a paragraph in the DESCRIPTION that talks about <oldbranch>,
   where readers will be helped by the same clarification as this
   patch gives;

 * -m/-M option description which is very sketchy and does not even
    hint that they take <oldbranch> and <newbranch>; and

 * <oldbranch> description as a separate bullet item in the same
   list, which does not even hint that this is used by -m/-M.

which is unmanageable from writers' point of view, and hard to
follow from readers' point of view.

Such a rewrite may look like this:

 * Trim down the DESCRIPTION explanation to enumerate "features"
   offered, with pointers into the OPTIONS section using the option
   names as hints, e.g.,

     The command offers many features that work on branches,
     depending on the options.

     - The default mode of operation is to list (the --list option
       explicitly calls for it, or the lack of other options to
       trigger different mode).

     - ...

     - An existing branch can be renamed to a different name with
       "-m/-M" options.

     - ...

 * Enhance the description in the OPTIONS section so that each
   bullet item (e.g., "-m") gives everything the user wants to know
   about that option, e.g.,

       -m [<oldbranch>] <newbranch>::
       -M [<oldbranch>] <newbranch>::
            Rename <oldbranch> (defaults to the current branch) to
            <newbranch>.  If <newbranch> already exists, `-m` will error
            out and renaming must be forced by using `-M` (in other
            words, `-M` works as a short-hand for `-m --force`).
       +
       The contents reflog of the <oldbranch> will also be renamed to bec=
ome
       the reflog of the <newbranch>, and a reflog entry is added for
       the renaming of the branch.

 * Remove the non-option entries from the OPTIONS bullet list.

