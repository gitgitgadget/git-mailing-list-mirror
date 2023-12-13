Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TQEkpDlp"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E3111
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 07:38:49 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E2FE532DC4;
	Wed, 13 Dec 2023 10:38:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=D1lxckZUsNcl9ktTNba1Dra7ajD03hRNLYpf0I
	UguTo=; b=TQEkpDlpxE3FjoghwJjypLaOqmkyHldOLYLJOTBsW2tU2LXEu7lD49
	87xjOlznjSYETyrFD+H541hAQN9kpFgahfmlap1JQPvvCGd6aMljtV/WJAijmrU5
	PgFwoMx1S0a0q0JgrUS7JJ3gdEV17FfXDahogDxXuoXeMvPDgC5Sk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DC37132DC3;
	Wed, 13 Dec 2023 10:38:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 734A032DC2;
	Wed, 13 Dec 2023 10:38:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alexey Murz Korepov <murznn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Allow adding files from git submodule to parent git repo if
 they are in .gitignore in the submodule
In-Reply-To: <CAL5pyKseyxEfLbgEkDHSqWQVLGkrrcZU=BzRx2zZOaCdQbMaoA@mail.gmail.com>
	(Alexey Murz Korepov's message of "Wed, 13 Dec 2023 15:07:43 +0400")
References: <CAL5pyKseyxEfLbgEkDHSqWQVLGkrrcZU=BzRx2zZOaCdQbMaoA@mail.gmail.com>
Date: Wed, 13 Dec 2023 07:38:43 -0800
Message-ID: <xmqq34w6nmd8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B38E76EA-99CD-11EE-B440-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Alexey Murz Korepov <murznn@gmail.com> writes:

> ```
> $ git add -f mysubmodule/config.yaml
> fatal: Pathspec 'mysubmodule/config.yaml' is in submodule 'mysubmodule'
> ```
> But I see no problems with doing this, if the file is in .gitignore of
> the mysubmodule submodule.
>
> So, let's discuss the approach of how we can allow this in git?

What should happen when mysubmodule/.gitignore changes?  Who
guarantees that such a file stolen by the superproject will stay in
the .gitignore file in the submodule?

I do not think you want to go there, and I do not think I want to
see such a behaviour in Git, as we would be the ones who will be
blamed for the resulting mess.

The right solution probably is to keep such a file in a directory
that is separate from the directory where you bind your submodule.
Track the file in the superproject, and have a build procedure to
copy it into the submodule directory (as an untracked file, of
course).
