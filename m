Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399DCB0
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:09:50 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-41b7fd8f458so5521441cf.0
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759389; x=1701364189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkI5qX6Ih6MrcFKBCNY02A/B6YJag8N/nifUBygkEnY=;
        b=mloRe1KPUgBkbgxCH54jhmLBoHSx+sOlScr0tA5D0KQSKLnZufrEoVzZXTvpdeQ7rs
         L0jN52cYf9NKvWttTfvbna2+xeXMyLBcvozYeRo4zLvvvutKI09OL7HNRBkorpOqF54Z
         Q4c7XvQf+nZksS2j6LulptrQajue9Lm8iU+EMg2vz19GKsfUNO+bVWSGVwA3LXHsZiGi
         apGd3mJL2cPs93fBccMtWiA5SoGpRj2nCcof8EYFzl2VivrhmwbjqP+joW1O6aziyqpJ
         5g2jUbkVvpaijAILW2tvq1EmwckLWJJL+/0Qncml8PZcCmQfw8dqBHXoxkz2qDKxd39Q
         I86Q==
X-Gm-Message-State: AOJu0YzLUFHufa2mzMix/6qQu+B38Uf+nmYHvlC2k6wgyWvHMAE6ZWoX
	1n1FjmVP9O07VFQ8ua9s0IDnEg0AIv4+vAsdUfW+v1D8ATw=
X-Google-Smtp-Source: AGHT+IEnJjttaJs0TAvp0Wblxf6/f4qi/4bKR4yKs49MpUxrhg5BGbBvt9BvGzFdIaBVi8gRiyAMY9xnMjAwsC0JLSY=
X-Received: by 2002:ad4:4246:0:b0:67a:27b:a817 with SMTP id
 l6-20020ad44246000000b0067a027ba817mr148897qvq.16.1700759389266; Thu, 23 Nov
 2023 09:09:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
 <xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g> <xmqqpm01au0w.fsf_-_@gitster.g>
 <bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com>
In-Reply-To: <bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 Nov 2023 12:09:38 -0500
Message-ID: <CAPig+cRdQW-DG8PFb-P0U_44pFWxskVoOtjbGfD_OiHHDk8DdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a branch
 used elsewhere
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Willem Verstraeten <willem.verstraeten@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 11:33=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> On 23/11/2023 06:00, Junio C Hamano wrote:
> > "git checkout -B <branch> [<start-point>]", being a "forced" version
> > of "-b", switches to the <branch>, after optionally resetting its
> > tip to the <start-point>, even if the <branch> is in use in another
> > worktree, which is somewhat unexpected.
> >
> > Protect the <branch> using the same logic that forbids "git checkout
> > <branch>" from touching a branch that is in use elsewhere.
> >
> > This is a breaking change that may deserve backward compatibliity
> > warning in the Release Notes.  The "--ignore-other-worktrees" option
> > can be used as an escape hatch if the finger memory of existing
> > users depend on the current behaviour of "-B".
>
> I think this change makes sense and I found the implementation here much
> easier to understand than a previous attempt at
> https://lore.kernel.org/git/20230120113553.24655-1-carenas@gmail.com/

Thanks for digging up this link. Upon reading the problem report, I
felt certain that we had seen this issue reported previously and that
patches had been proposed, but I was unable to find the conversation
(despite having taken part in it).

I agree, also, that this two-patch series is simple to digest.
