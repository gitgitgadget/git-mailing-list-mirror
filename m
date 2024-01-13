Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425CB1A5A7
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ1lEMct"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7b273352so7629252e87.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 17:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705110321; x=1705715121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnQHolIFJfd35D/9SgNoe4yntBJMYLkdwGhmx0t2fNY=;
        b=LZ1lEMct1gaqlr+f+7BD2rV+V9Li44EkPH2usj9MDztWNnXybS0iBXY2BQpz/zyNA/
         P6sjKFauMV0zOzHgjtk16luJHQSw/RtwFm8+ixca0K67/JdlABRtugL563EjAq9y4axc
         xBnkCxR7PweeeYM4RFgiekhtQeZBgJAx/Y/3CTwQ5vgoPJYFdICiAufd/FWZcF4VzB/L
         Lcj44rxEOnZ567iD3/CXfmk8DfL8B1+eyZCTfQ/AO6DiCg84iQGSHhUVjccljukCkEjD
         aaqEHzpUK7grjmrwom+e6CjrU+insdfOgK6tlvuPsVqr5YMcz5xmcrDjgwmmD6W61tLW
         u+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705110321; x=1705715121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnQHolIFJfd35D/9SgNoe4yntBJMYLkdwGhmx0t2fNY=;
        b=I8ocejVURWCKe/We2NT794+zueuSHbMCfXLI6jmwTb8KDexZwMLbx4rmrzgj+rboyz
         +vPONMuYnHqRY7fTeBCkSbhRT8opj14elzlbnGk3uupj+K/NEjPa1Wyvp284b56QioYw
         9INJg6YkMuEZLV5kR6a82yxZzBj/ubnnSH7uWQo3cAcOWRaZQrr327/R83kxrcvicxGB
         AubTdGUcso22RUlXu+NzXBB/qf7uuhxUCJGsnjfPYL+uBcd/rlDPQ6zqjaTNhcgnyIbO
         YR789Inv4vqiOVlK6DMKd5PQmDJRJwek98nSchRx1WVmObUh82x6oRZSJnrNeveTKBtA
         IIHg==
X-Gm-Message-State: AOJu0YyF6vRGtUg8u0z/q/kXoPqp5qdhZ/0ZO59f9X+E0R1fj1atYBjg
	hCBjgiqeBfPGrMwS9No4BFIhB/nqE43JiviAD9U=
X-Google-Smtp-Source: AGHT+IE040qjSzMPVXxmAGGykL4V+HqT3sPGE+ZpQDnPBnvZEkca2cMUfloHPoRm/yx62sxzQA+SpAbdQhWJa7mWNxc=
X-Received: by 2002:a05:6512:e81:b0:50e:416d:c1cd with SMTP id
 bi1-20020a0565120e8100b0050e416dc1cdmr1294092lfb.23.1705110320922; Fri, 12
 Jan 2024 17:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1637.git.1705006074626.gitgitgadget@gmail.com> <xmqqedenearc.fsf@gitster.g>
In-Reply-To: <xmqqedenearc.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 12 Jan 2024 17:45:08 -0800
Message-ID: <CABPp-BGp0NMQKLYg=OxJgnVxARffNF57B_N2bLmwT2R2EZqhdA@mail.gmail.com>
Subject: Re: [PATCH] diffcore-delta: avoid ignoring final 'line' of file
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 3:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/diffcore-delta.c b/diffcore-delta.c
> > index c30b56e983b..7136c3dd203 100644
> > --- a/diffcore-delta.c
> > +++ b/diffcore-delta.c
> > @@ -159,6 +159,10 @@ static struct spanhash_top *hash_chars(struct repo=
sitory *r,
> >               n =3D 0;
> >               accum1 =3D accum2 =3D 0;
> >       }
> > +     if (n > 0) {
> > +             hashval =3D (accum1 + accum2 * 0x61) % HASHBASE;
> > +             hash =3D add_spanhash(hash, hashval, n);
> > +     }
>
> OK, so we were ignoring the final short bit that is not terminated
> with LF due to the "continue".  Nicely found.
>
> > diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> > index 85be1367de6..29299acbce7 100755
> > --- a/t/t4001-diff-rename.sh
> > +++ b/t/t4001-diff-rename.sh
> > @@ -286,4 +286,23 @@ test_expect_success 'basename similarity vs best s=
imilarity' '
> >       test_cmp expected actual
> >  '
> >
> > +test_expect_success 'last line matters too' '
> > +     test_write_lines a 0 1 2 3 4 5 6 7 8 9 >nonewline &&
> > +     printf "git ignores final up to 63 characters if not newline term=
inated" >>nonewline &&
> > +     git add nonewline &&
> > +     git commit -m "original version of file with no final newline" &&
>
> I found it misleading that the file whose name is nonewline has
> bunch of LF including on its last line ;-).

Yeah, sorry.  It's been a while, but I think I started with a file
with only one line that had no LF, but then realized for inexact
rename detection to kick in I needed some other lines, at least one of
which didn't match...but I forgot to update the filename after adding
the other lines...

> > +     # Change ONLY the first character of the whole file
> > +     test_write_lines b 0 1 2 3 4 5 6 7 8 9 >nonewline &&
>
> Same here, but it is too much to bother rewriting it ...
>
>         {
>                 test_write_lines ...
>                 printf ...
>         } >incomplete
>
> ... like so ("incomplete" stands for "file ending with an incomplete line=
"),
> so I'll let it pass.
>
> > +     printf "git ignores final up to 63 characters if not newline term=
inated" >>nonewline &&
>
>
> > +     git add nonewline &&
> > +     git mv nonewline still-no-newline &&
> > +     git commit -a -m "rename nonewline -> still-no-newline" &&
> > +     git diff-tree -r -M01 --name-status HEAD^ HEAD >actual &&
> > +     cat >expected <<-\EOF &&
> > +     R097    nonewline       still-no-newline
>
> I am not very happy with the hardcoded 97.  You are already using
> the non-standard 10% threshold.  If the delta detection that
> forgets about the last line is so broken as your proposed log
> message noted, shouldn't you be able to construct a sample pair of
> preimage and postimage for which the broken version gives so low
> similarity to be judged not worth treating as a rename, while the
> fixed version gives reasonable similarity to be made into a rename,
> by the default threshold?  That way, the test only needs to see if
> we got a rename (with any similarity) or a delete and an add.

Oops, the threshold is entirely unnecessary here; not sure why I
didn't remember to take it out (originally used the threshold while
testing without the fix to just how low of a similarity git thought
these nearly identical files had).

Since you don't like the threshold, and since we don't seem to have a
summary format that reports on the rename without the percentage, I
guess I need to munge the output with sed:

      sed -e "s/^R[0-9]* /R /" actual >actual.munged &&

and then compare the expected output to that.  I'll send in a patch
doing so and fix up the filenames and drop the rename threshold while
at it.
