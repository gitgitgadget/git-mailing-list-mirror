Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pril-cc.20230601.gappssmtp.com header.i=@pril-cc.20230601.gappssmtp.com header.b="KnJMwbFu"
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196261BE
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 22:55:32 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5c85e8fdd2dso14639407b3.2
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 22:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pril-cc.20230601.gappssmtp.com; s=20230601; t=1700808931; x=1701413731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAnDBwy3pozqCpxuNhbQFl2K48GzQkfhxAxogNPiWNY=;
        b=KnJMwbFunNvwiGL+k7fMGSnDgrJ6owp/1RvV0ig9Lbg3QS9ojFc9ZelNA0vdBXAOls
         Z2JNkDgieyJkeVYBx0pcjWjzP35LwnTYodjY/DiqgI959k7JlyCEoV2UuBZU/CfYsTKc
         KTtwVHhfHcDH1PzkiPHh2PNLBwrP9hdUfnaEehP6e4Voqs6pNWbzyYUfBNhpN7yJgd0z
         M7hBNRBHhn4NxNRwXBfKeodrlnEeR95suMk4w4YJRHiS4CjHgKBrrT92PBbnZeDIEVW5
         me0+Y5zDAe+IhyMl82vcx0sDQu6TcI/9AjxpBwsMkPR6JBP3w8qMjP9u/3Ct/ff/p2Fb
         sNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700808931; x=1701413731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAnDBwy3pozqCpxuNhbQFl2K48GzQkfhxAxogNPiWNY=;
        b=btq41sZqJfpyCmCaIbgcWpBJfQ1RfkSgcHBqZ84+xcPvsvsutN3A8m0eMzT4hhaKl/
         ALDh7Mo3EvlThEBdOERblHoI7nD8Yz+juHNQC4S7/QzssquCjTrSQe3IwPAEDTliP3xr
         84kqcWhdEjwqn2GoybqHlob3uLjJxLn2VMahcJFnK+vQGCdpmSDYCggz8LGkQmSyGVWj
         qtkn7BPH1Lp9cMQR3veGw82iV3pbZXrQYrah9YDfZib8KfDrHXOQFefzLoP6ipFD5stl
         /jbWBTJPERC1xrM6/HHlQD2QuK2PnK//1trc3VhvFlns24wpkwHCF6lByp8EXDUU2D4Y
         NPUQ==
X-Gm-Message-State: AOJu0YxTOG3v/udyXVcjH6uZGtC+S5T/P6xcTgLwyWc/lKJfN/f8jAR3
	n4hzMYHKhxdZ9wyoMkfG/Okg7PbRUs84GLYingDE7w==
X-Google-Smtp-Source: AGHT+IEy1kJC8eG+Sbe3Z2ppTsdHh2rLx1Bv3udD+vuzrretqBI3CMbz4Am7EH5I2yKCB4mh2sgGfICbK0UJps1oIaA=
X-Received: by 2002:a0d:d40f:0:b0:5ca:ae76:1dfb with SMTP id
 w15-20020a0dd40f000000b005caae761dfbmr1695116ywd.20.1700808931247; Thu, 23
 Nov 2023 22:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1609.git.git.1700639764041.gitgitgadget@gmail.com> <xmqq1qchcjtq.fsf@gitster.g>
In-Reply-To: <xmqq1qchcjtq.fsf@gitster.g>
From: Alisha Kim <admin@pril.cc>
Date: Fri, 24 Nov 2023 15:55:21 +0900
Message-ID: <CAB5P87v-S6ODcog118t7ONkW6Y8ZUDOnNZ4C5UiH6d5Fq=3UCQ@mail.gmail.com>
Subject: Re: [PATCH] git-p4: fix fast import when empty commit is first
To: Junio C Hamano <gitster@pobox.com>
Cc: Alisha Kim via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Alisha Kim <pril@pril.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 10:57=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Alisha Kim via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Alisha Kim <pril@pril.cc>
> >
> > When executing p4 sync by specifying an excluded path, an empty commit
> > will be created if there is only a change in the excluded path in
> > revision.
> > If git-p4.keepEmptyCommits is turned off and an empty commit is the
> > first, fast-import will fail.
>
> The above describe under what condition a failure gets triggered,
> but there is no description on what approach the proposed solution
> takes.  You could teach "fast-import" to deal with an empty commit
> properly, you could ignore empty commits and not produce input for
> the fast-import command, you could probably turn these initial empty
> commits into non-empty commits by adding dummy contents, etc.  We
> want to see in our proposed log messages what solution was taken and
> how the solution was designed to satisfy what requirements.  This is
> to help future developers who will have to change the code that is
> given by this patch, so that their updates can still adhere to what
> ever design criteria you had in working on this change [*].
>
>     Side note: Your solution might be to ignore empty commits
>     despite keepEmptyCommits option is set (as I said, you did not
>     describe it at all in the above, so this is a hypothetical
>     example).  If the reason behind choosing that design were "I
>     just do not want it to fail---I do not care if the resulting
>     history coming out of fast-import is crappy (I lose the p4 CL
>     descriptions for these commits, even though the user wants to
>     keep them)", then future developers can safely "fix" your fix
>     here by turning the initial empty commits into non-empty ones by
>     adding fake contents.


I've added explanations for the changes I suggested.

>
>
> > @@ -3876,10 +3878,12 @@ class P4Sync(Command, P4UserMap):
> >                              self.commit(description, filesForCommit, b=
ranch, parent)
> >                  else:
> >                      files =3D self.extractFilesFromCommit(description)
> > -                    self.commit(description, files, self.branch,
> > +                    isCommitted =3D self.commit(description, files, se=
lf.branch,
> >                                  self.initialParent)
> >                      # only needed once, to connect to the previous com=
mit
> > -                    self.initialParent =3D ""
> > +                    if isCommitted:
> > +                        self.initialParent =3D ""
>
> "is" does not sound grammatically correct.  "didCommit" (i.e., "we
> made a commit"), "haveCommitted" (i.e., "we have made a commit")
> might be more understandable.


The problem with correct grammar that you mentioned has also been
changed. Thank you for your good comments.


>
>
> >              except IOError:
> >                  print(self.gitError.read())
> >                  sys.exit(1)
> >
> > base-commit: cfb8a6e9a93adbe81efca66e6110c9b4d2e57169
