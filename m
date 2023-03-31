Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C720C6FD1D
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 00:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCaA5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 20:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCaA5C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 20:57:02 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243131CB87
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 17:56:24 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso11055039otb.12
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 17:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680224183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF5piak97XmflE9SMRZdS3P75IK9bgm9WbplrVQDKcM=;
        b=i9LhRGKhT/yZ0gpNZebZQowCIEUdAopnZeXZj4b+aJFE8QKj4BAEop7QxK7b52yBIV
         KypDTpP8udpEbdnPUhVF6exee7pqGKZ0JOiaA4xjeDzVRAwqHRWSE9en9AS9dFIqngdb
         B8SkE32JTro5fInfOv6UayT8EqdTPKWHe/wuPZF73l7FbLm5AZzldqTwUc31psn5aeB0
         YLrXWZTYbnXpmKIoOkICrUazMi6zySMGc+FVD62ZFG1cjrcKvGoM6vCeaJ2EvcTG3Em1
         akfUAS42N0s2fkAC2f/RjTWTok0gW+FTFrTF36lAWkKRcSTTFLIBIvDirk5KULFj5p1q
         hgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680224183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qF5piak97XmflE9SMRZdS3P75IK9bgm9WbplrVQDKcM=;
        b=dh/gNwROHzJhfcVcDCB9xtpmvrIpd/315WcnDYzJGxJoyLP0Q2qvVsR3klNrKqkFXu
         4tYMjoStg8lV37/L5ncDbHQBvI3Blej8Ndby1NPcyW2CwE62Sj7MM4bumYUJ/UUAB6m/
         zoi+ZoQtBHNYvrTQmgqvTn75WJYZbuAGCDIWMhzGOmtoeCP9QPTdGoaX19n/j9pFbjCt
         Dec65msgYhTnVkhLfPMjaHsR6cOCjRrG+BDd0Nr69wFsAhCcUL84DyhDWb9q3thP5wX6
         uBz/rwWzOexh9TM95FLmCyvseqM2AJEDnKo0bs0ygBy5nuk6w8XGP2h/aWbjPVyQDqLC
         SU1Q==
X-Gm-Message-State: AO0yUKVGqZyNM/0RFbsen4lcZaXi/KFu1MB2mQbQLEJ61x2W4OQ+/Y3f
        PIyDr5901aUz6BCN5bcMWHXfuMS/nV4qIqB3INE=
X-Google-Smtp-Source: AK7set+b1zvBmVgXFSs8bboFyaqUEmWFUukvXZAOAGeuqOSW7kt5H8zX8feSp9+xjLswfTXrY3Pkn48TCOlVmFT8B4g=
X-Received: by 2002:a9d:6f02:0:b0:69f:a43d:f6c5 with SMTP id
 n2-20020a9d6f02000000b0069fa43df6c5mr8342865otq.2.1680224182601; Thu, 30 Mar
 2023 17:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230324170800.331022-1-jacob.e.keller@intel.com> <kl6l4jq2c6h9.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l4jq2c6h9.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 30 Mar 2023 17:56:12 -0700
Message-ID: <CA+P7+xqC71LrDNao2oeaMdHh=dC+HMwr8G1_NNmsvTxOVzevZw@mail.gmail.com>
Subject: Re: [PATCH v3] blame: allow --contents to work with non-HEAD commit
To:     Glen Choo <chooglen@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 1:46=E2=80=AFPM Glen Choo <chooglen@google.com> wro=
te:
>
> Hi Jacob! Great to see you at Review Club :)
>
> If you'd like, yo ucan review the notes here:
>
>   https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn=
3stCuS_w/edit
>
> but as always, all important discussion happens on the ML.
>
> I see that this patch is already queued for 'master' (which is fine),
> though I think it might even better with another patch on top.
>

Yep. I'm happy to send some follow up.

> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > The --contents option can be used with git blame to blame the file as i=
f
> > it had the contents from the specified file. This is akin to copying th=
e
> > contents into the working tree and then running git blame. This option
> > has been supported since 1cfe77333f27 ("git-blame: no rev means start
> > from the working tree file.")
> >
> > The --contents option always blames the file as if it was based on the
> > current HEAD commit. If you try to pass a revision while using
> > --contents, you get the following error:
> >
> >   fatal: cannot use --contents with final commit object name
> >
> > This is because the blame process generates a fake working tree commit
> > which always uses the HEAD object as its sole parent.
> >
> > Enhance fake_working_tree_commit to take the object ID to use for the
> > parent instead of always using the HEAD object. Then, always generate a
> > fake commit when we have contents provided, even if we have a final
> > object. Remove the check to disallow --contents and a final revision.
>
> I thought that the commit message was very clear and provided enough
> context even for reviewers who weren't familiar with "git blame
> --contents". Thanks!
>
> I'll reorder the patch hunks to make discussion easier:
>

Thanks!

> > diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> > index f1b9a6ce4dae..b35be20cf327 100644
> > --- a/t/annotate-tests.sh
> > +++ b/t/annotate-tests.sh
> > @@ -98,6 +108,10 @@ test_expect_success 'blame 2 authors' '
> >       check_count A 2 B 2
> >  '
> >
> > +test_expect_success 'blame with --contents and revision' '
> > +     check_count -h testTag --contents=3Dfile A 2 "Not Committed Yet" =
2
> > +'
> > +
>
> As the test notes, the author of the changes is "Not Committed Yet"...
>
> > diff --git a/Documentation/blame-options.txt b/Documentation/blame-opti=
ons.txt
> > index 9a663535f443..95599bd6e5f4 100644
> > --- a/Documentation/blame-options.txt
> > +++ b/Documentation/blame-options.txt
> > @@ -64,11 +64,11 @@ include::line-range-format.txt[]
> >       manual page.
> >
> >  --contents <file>::
> > -     When <rev> is not specified, the command annotates the
> > -     changes starting backwards from the working tree copy.
> > -     This flag makes the command pretend as if the working
> > -     tree copy has the contents of the named file (specify
> > -     `-` to make the command read from the standard input).
> > +     Pretend the file being annotated has a commit with the
> > +     contents from the named file and a parent of <rev>,
> > +     defaulting to HEAD when no <rev> is specified. You may
> > +     specify '-' to make the command read from the standard
> > +     input for the file contents.
>
> which I found quite difficult to reconcile with the description here,
> in particular:
>
>   Pretend the file being annotated has a commit...
>
> We could try to make the two more coherent by rewording the docs, maybe:
>
>   Pretend that the working copy has the contents of the named file. If
>   <rev> is also given, also pretend that HEAD is at <rev>.
>

It is quite tricky to get a concise description here.

> But (as Junio suggested in Review Club), maybe it would be better to
> just change "Not Committed Yet" to something more accurate, like
> "External file (--contents)", and then we can drop the language around
> "pretend".
>

I think this is a good direction, It makes it distinguished from the
working tree output.

> It would be pretty simple, too. Here's a rough patch (that I don't mind
> you sending as your own):
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-option=
s.txt
> index 95599bd6e5..4a861ff31c 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -64,11 +64,10 @@ include::line-range-format.txt[]
>         manual page.
>
>  --contents <file>::
> -       Pretend the file being annotated has a commit with the
> -       contents from the named file and a parent of <rev>,
> -       defaulting to HEAD when no <rev> is specified. You may
> -       specify '-' to make the command read from the standard
> -       input for the file contents.
> +       Annotate using the contents from the named file instead of the
> +       working tree copy, starting with <rev> if it is specified, and
> +       HEAD otherwise. You may specify '-' to make the command read
> +       from the standard input for the file contents.
>

I think I would reword this slightly:

Annotate using the contents from the name file, starting from <rev> if
it is specified, and HEAD otherwise.

I do not think we need "instead of the working tree copy" as this  is
confusing since if <rev> is specified we do not use the working tree
copy today. This is where the difficulty in being concise here is. I
think just not mentioning working copy is correct here. Perhaps we
need to mention that the working copy is used if no <rev> is specified
elsewhere in the documentation?

>  --date <format>::
>         Specifies the format used to output dates. If --date is not
> diff --git a/blame.c b/blame.c
> index 2d02cf0636..129dae7641 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -204,8 +204,12 @@ static struct commit *fake_working_tree_commit(struc=
t repository *r,
>
>         origin =3D make_origin(commit, path);
>
> -       ident =3D fmt_ident("Not Committed Yet", "not.committed.yet",
> -                       WANT_BLANK_IDENT, NULL, 0);
> +       if (contents_from)
> +               ident =3D fmt_ident("External file (--contents)", "extern=
al.file",
> +                               WANT_BLANK_IDENT, NULL, 0);
> +       else
> +               ident =3D fmt_ident("Not Committed Yet", "not.committed.y=
et",
> +                               WANT_BLANK_IDENT, NULL, 0);
>         strbuf_addstr(&msg, "tree 000000000000000000000000000000000000000=
0\n");
>         for (parent =3D commit->parents; parent; parent =3D parent->next)
>                 strbuf_addf(&msg, "parent %s\n",
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index b35be20cf3..2ef70235b1 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -72,6 +72,13 @@ test_expect_success 'blame 1 author' '
>         check_count A 2
>  '
>
> +test_expect_success 'blame working copy' '
> +       test_when_finished "git restore file" &&
> +       echo "1A quick brown fox jumps over the" >file &&
> +       echo "another lazy dog" >>file &&
> +       check_count A 1 "Not Committed Yet" 1
> +'
> +
>  test_expect_success 'blame with --contents' '
>         check_count --contents=3Dfile A 2
>  '
> @@ -79,7 +86,7 @@ test_expect_success 'blame with --contents' '
>  test_expect_success 'blame with --contents changed' '
>         echo "1A quick brown fox jumps over the" >contents &&
>         echo "another lazy dog" >>contents &&
> -       check_count --contents=3Dcontents A 1 "Not Committed Yet" 1
> +       check_count --contents=3Dcontents A 1 "External file (--contents)=
" 1
>  '
>
>  test_expect_success 'blame in a bare repo without starting commit' '
> @@ -109,7 +116,7 @@ test_expect_success 'blame 2 authors' '
>  '
>
>  test_expect_success 'blame with --contents and revision' '
> -       check_count -h testTag --contents=3Dfile A 2 "Not Committed Yet" =
2
> +       check_count -h testTag --contents=3Dfile A 2 "External file (--co=
ntents)" 2
>  '
>
>  test_expect_success 'setup B1 lines (branch1)' '
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>
> The patch doesn't do anything special, except that we'd need to make
> sure to test that the working copy is annotated correctly (we didn't
> have tests for this before??).

We check the authorship with the tests I added now.

>
> The doc and the fake commit author could use some tweaking, but IMO the
> end result is a lot easier to explain to end users, even in the case
> where "--contents" is given without <rev>.
>

Yea I think changing the author name is good.

> The _one_ reason not to merge this is that this changes the annotated
> author with "--contents", which could cause trouble for end users who
> are parsing the output and expecting literal "Not Committed Yet". Given
> our history with Hyrum's law, surely _someone_ is doing this in the
> non-"--contents" case, but I suspect that "--contents" is uncommon
> enough that we could take the chance.

I am one of those people using --contents and analyzing the output...
but at least in my case I'm looking for the 00000000 commit ID instead
of looking for the author name.

I'm in favor of changing the output, but I'd like to hear other opinions he=
re.
