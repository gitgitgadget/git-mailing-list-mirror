Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnHxr6xZ"
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B6299
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 01:31:41 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso2339600a12.2
        for <git@vger.kernel.org>; Mon, 20 Nov 2023 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700472701; x=1701077501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHlNFDogQHlkrvSZnTou3OKQbv4VlyjS4TSZQNaMZzg=;
        b=TnHxr6xZhijdYZ68MBEU/KZVj/+3BrZz9oXj5yo6nBv2jcoVFjbvfZlG48iWaTxesJ
         r00iAVUm+cxeq4KlDpyES/rMZ75uC39qirX6xF923hmgZSc5ueCjNk8AgBlA7QXNrr4n
         BlQuvQY/1SGZ7lE5EC5/EqgYPO8CTVUPegEW0u4aewIxQA8qusXklPgxvwmRO/74Gfwi
         fa5tD/Lw9guyOWn642Z2A+KXQUNVUAl+aCzeUu62q50m2vYChmMIXuopREM5hOzRxm2h
         4k+O3RZR5Lw0sTpCBoeYdLTBX5HUHN7+9QD/+JUWMWIi/YOSKA7pj9o4wMqHUTcVruhI
         fqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700472701; x=1701077501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHlNFDogQHlkrvSZnTou3OKQbv4VlyjS4TSZQNaMZzg=;
        b=jjeAxErHVzoW+RT5TEvc4c2xxMtPlT3FlW9A+eZuTidpOcaTMj/64lkwhz11KL+sd8
         /j3YwrpA9OgsmkbubJ5gToI6YLAergP/Q1pob1naLkL+rW0vJXLHY2tr237mZ3A5N/3F
         LxsOBiKC6DHbUpj9WUrZbgTsKf1OF9EvJjQr1LcDaEq24R/Pzwqb/YlK9lTS/hNn4JXU
         jp4w2VpyP9MQ6qMT5z4wVcUmsv9rJMDNCAh/muCRBms+0iK/2IRIrsQtA/03aSQjOqlE
         5GEcxWyKaPMnkZ3JiqwHFvrDJgrSOegiqimvGQqJ/Qhj4+/p/gTgYk7sMJN7gYC6dltk
         Pyxw==
X-Gm-Message-State: AOJu0YyvhxCy3imZz6ycHIuy6d13BLOjtEp45SA5DGvrYEHjhaRJuyZb
	hnYcLlGnWhcAX5zAgDfjKPpfY52ZGEiqwuwBKhU=
X-Google-Smtp-Source: AGHT+IEmwMklh86WvxBXME2eP8vnhVT6ujsKnjZ0Q8FdzUhnzb11isItG6se5vhwjd2H1cXHTm5IKUBLJUouA35US04=
X-Received: by 2002:a17:90a:ab01:b0:280:200c:2e20 with SMTP id
 m1-20020a17090aab0100b00280200c2e20mr4322226pjq.27.1700472701049; Mon, 20 Nov
 2023 01:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117202513.20604-1-adamm@zombino.com> <20231117203253.21143-1-adamm@zombino.com>
 <xmqqbkbppbrd.fsf@gitster.g>
In-Reply-To: <xmqqbkbppbrd.fsf@gitster.g>
From: Glen Choo <glencbz@gmail.com>
Date: Mon, 20 Nov 2023 17:31:29 +0800
Message-ID: <CA+we5Gqp2nhoXyqJKJiXQMDx-ZXcnNGHu3wnwERWREng2XHHuQ@mail.gmail.com>
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	Adam Majer <adamm@zombino.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 7:24=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Adam Majer <adamm@zombino.com> writes:
>
> > In a garbage collected bare git repository, the refs/ subdirectory is
> > empty.  In use-cases when such a repository is directly added into
> > another repository, it no longer is detected as valid.
>
> Josh & Glen [*], isn't this a layout that we  explicitly discourage and
> eventually plan to forbid anyway?

If my recollection of [1] serves me correctly, we didn't come to a
strong conclusion on whether or not to forbid bare repositories in the
working tree, particularly because it would leave existing repos (like
Git LFS) high and dry. Though personally, I'd be happy to see a
version of Git that forbade bare repositories in the working tree.

I don't really recall the bare repo tracing bits, so I'll leave that to Jos=
h.

[1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.c=
orp.google.com/
