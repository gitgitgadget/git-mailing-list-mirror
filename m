Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1CDC433E7
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 08:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE21206EB
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 08:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpb0c3k9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgICIq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgICIq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 04:46:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D4C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 01:46:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o68so1768148pfg.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 01:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EIkEBP7wK2RYxF8Qdlxzsc35ljo7B/r/24+XYdVMBxk=;
        b=Mpb0c3k9PKG60AuZ6r6Nxxyc8JP37m7WZJ/0Rjq8X/QMKYR7jN1cGimepdqWJDoE2D
         HPOnuT+TgWG8m4jxPoU2FSqibGA87iG47fbkfuSrqJTNWyZ82WlgiBEgOJfs64lg8R4q
         TAFYUmFAxbxs+E8EZ72peXS3Cn8IHdHOaGvd4CpI9Bhh2kMBb7A9mIDZpsmwHXUpN9zJ
         fNNFTrgHqva6AE21bpmkxb7atBYMJ7UAnCSxQj9rgzIrUFHUv9cGB9ibFsab+J+YZ2hX
         ZZB3SvYSS+afed6velV4JXuEQFCuGHgImPyvMtXpsipVrh5mPQCBhNDFbqEwU7832seP
         0QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EIkEBP7wK2RYxF8Qdlxzsc35ljo7B/r/24+XYdVMBxk=;
        b=SREjGQH/rNbR76QGbvhLXXtj1qBY8QEwLmcPiizeaGacEme7Y6uCcqNzNUDYsCjacl
         WQ3srps0vME/XCXpagTKb6wXBY/zKopsYyHYeq6Kbgjsln6omz+rxXHQvUyr4yjS7SBW
         AB5vYwJ5w06KRc4B8adcgNwdY+5+j9MXwfedhdt8lIZ/i3eHX3sqc7l1mLe8XjBtOLp5
         OrsW62w+aVmdH5W6hP0XoOUzStd7xCQ3EKGWjxTpQ0NEXgnRrzp0fmxV9eOzlENpV70d
         m2Z9eavSyGaqFOQIRcmiXO3yX1SA7h86B1cNDvfnRL0FNhRomSy393AJQy9MjDsZ0QBb
         6bBg==
X-Gm-Message-State: AOAM532S4sFxDtFUULa3qldNHMIXZsuwhdtYSBLpSHaPoMUPuorVuNju
        PoBmGa3GUJCkZJthj2c06AE=
X-Google-Smtp-Source: ABdhPJxDC+4O3XgrFGQjXgrEN4zW//7tF1SwmP09FFzv6p0Gnxb6XOUdGBM+6Fev3+l8aUeHgiFAGQ==
X-Received: by 2002:aa7:8e8f:: with SMTP id a15mr2811052pfr.135.1599122786638;
        Thu, 03 Sep 2020 01:46:26 -0700 (PDT)
Received: from lwitch-pc ([49.207.133.82])
        by smtp.gmail.com with ESMTPSA id k6sm2209764pfh.92.2020.09.03.01.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 01:46:26 -0700 (PDT)
Message-ID: <dba90fee82a709538b9bff015e56a3c4834a42ca.camel@gmail.com>
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from
 shell to C
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, liu.denton@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Date:   Thu, 03 Sep 2020 14:16:17 +0530
In-Reply-To: <20200902120422.GA28650@konoha>
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
         <xmqq8se36gev.fsf@gitster.c.googlers.com> <20200826091502.GA29471@konoha>
         <ce151a1408291bb0991ce89459e36ee13ccdfa52.camel@gmail.com>
         <20200831130448.GA119147@konoha>
         <31e40c63bbac03d261ac6f46a0d2f6ae90a21038.camel@gmail.com>
         <20200902120422.GA28650@konoha>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Cc: Elijah Newren, Martin Ågren

On Wed, 2020-09-02 at 17:34 +0530, Shourya Shukla wrote:
> On 02/09 02:05, Kaartic Sivaraam wrote:
> > On Mon, 2020-08-31 at 18:34 +0530, Shourya Shukla wrote:
> > > On 31/08 01:28, Kaartic Sivaraam wrote:
> > > 
> > > This is what I have done finally:
> > > ---
> > > 	if (read_cache() < 0)
> > > 		die(_("index file corrupt"));
> > > 
> > > 	if (!force) {
> > > 		if (cache_file_exists(path, strlen(path), ignore_case) ||
> > > 		    cache_dir_exists(path, strlen(path)))
> > > 			die(_("'%s' already exists in the index"), path);
> > > 	} else {
> > > 		int cache_pos = cache_name_pos(path, strlen(path));
> > > 		struct cache_entry *ce = the_index.cache[cache_pos];
> > > 		if (cache_pos >= 0 && !S_ISGITLINK(ce->ce_mode))
> > > 			die(_("'%s' already exists in the index and is not a "
> > > 			      "submodule"), path);
> > > 	}
> > > ---
> > > 
> > > I did not put the 'cache_pos >= 0' at the start since I thought that it
> > > will unnecessarily increase an indentation level. Since we are using
> > > 'cache_{file,dir}_exists' in the first check and 'cache_name_pos()' in
> > > the second, the placement of check at another indentation level would be
> > > unnecessary. What do you think about this?
> > > 
> > 
> > Interestingly. 'cache_dir_exists' seems to work as expected only when
> > the global ignore_case whose value seems to depend on core.ignorecase.
> > So, we can't just rely on 'cache_dir_exists to identify a directory
> > that has tracked contents. Apparently, the 'directory_exists_in_index'
> > in 'dir.c' seems to have the code that we want here (which is also the
> > only user of 'index_dir_exists'; the function for which
> > 'cache_dir_exists' is a convenience wrapper.
> 
> I think both 'cache_{dir,file}_exists()' depend on 'core.ignorecase'
> though I am not able to confirm this for 'cache_dir_exists()'. Where
> exactly does this happen for the function?

As you can see in 'name-hash.c', 'index_file_exists' and there by
'cache_dir_exists' work using the 'name_hash' stored in the index. If
you look at the flow of 'lazy_init_name_hash', you'll see how
'name_hash' gets initialized and populated despite the value of
'ignore_case'. OTOH, dir_hash is populted only when 'ignore_case' is
true. So, it seems to be that only 'cache_dir_exists' depends on the
value of 'ignore_case'.

>  The function you mention
> seems perfect to me, though, we will also have to make the enum
> 'exist_status' visible. Will that be fine?

To me that appears to be the only way forward other than spawning a
call to ls-files as was done in one of the earlier versions tat was not
sent to the list. Anyways, I'm not the best person to answer this
question. So, I've CC-ed a couple of people who might be able to shed
some light for us.

>  The final output will be:
> ---
> 	if (!force) {
> 		if (directory_exists_in_index(&the_index, path, strlen(path)))
> 			die(_("'%s' already exists in the index"), path);
> 	} else {
> 		int cache_pos = cache_name_pos(path, strlen(path));
> 		struct cache_entry *ce = the_index.cache[cache_pos];
> 		if (cache_pos >= 0 && !S_ISGITLINK(ce->ce_mode))
> 			die(_("'%s' already exists in the index and is not a "
> 			      "submodule"), path);
> 	}
> ---
> 
> 

The above doesn't handle all cases. In particular, we want to handle
the case of tracked files when `force` is not given
(directory_exists_in_index certainly doesn't handle that). We also need
to handle directories with tracked contents when force is given (we
already know cache_name_pos is not sufficient to handle them). So, I
think we would want something along the lines of the following:

        if (read_cache() < 0)
                die(_("index file corrupt"));

        cache_pos = cache_name_pos(path, strlen(path));
        if (cache_pos < 0 &&
            directory_exists_in_index(&the_index, path, strlen(path)) == index_directory) {
                directory_in_cache = 1;
        }

        if (!force) {
               if (cache_pos >= 0 || directory_in_cache)
                        die(_("'%s' already exists in the index"), path);
        }
        else {
                struct cache_entry *ce = NULL;
                if (cache_pos >= 0)
                {
                        ce = the_index.cache[cache_pos];
                }

                if (directory_in_cache || (ce && !S_ISGITLINK(ce->ce_mode))) {
                        die(_("'%s' already exists in the index and is not a "
                              "submodule"), path);
                }
        }

After seeing this, I'm starting to think it's better have this in a
separate helper function instead of making the `module_add` function
even more longer than it already is.

> And obviously an extra commit changing the visibility of the function
> and the enum.
>  
> > > > This is more close to what the shell version did but misses one case
> > > > which might or might not be covered by the test suite[1]. The case when
> > > > path is a directory that has tracked contents. In the shell version we
> > > > would get:
> > > > 
> > > >    $ git submodule add ../git-crypt/ builtin
> > > >    'builtin' already exists in the index
> > > >    $ git submodule add --force ../git-crypt/ builtin
> > > >    'builtin' already exists in the index and is not a submodule
> > > > 
> > > >    In the C version with the above snippet we get:
> > > > 
> > > >    $ git submodule add --force ../git-crypt/ builtin
> > > >    fatal: 'builtin' does not have a commit checked out
> > > >    $ git submodule add ../git-crypt/ builtin
> > > >    fatal: 'builtin' does not have a commit checked out
> > > > 
> > > >    That's not appropriate and should be fixed. I believe we could do
> > > >    something with `cache_dir_exists` to fix this.
> > > > 
> > > > 
> > > >    Footnote
> > > >    ===
> > > > 
> > > >    [1]: If it's not covered already, it might be a good idea to add a test
> > > >    for the above case.
> > > 
> > > Like Junio said, we do not care if it is a file or a directory of any
> > > sorts, we will give the error if it already exists. Therefore, even if
> > > it is an untracked or a tracked one, it should not matter to us. Hence
> > > testing for it may not be necessary is what I feel. Why should we test
> > > it?
> > 
> > I'm guessing you misunderstood. A few things:
> > 
> > - We only care about tracked contents for the case in hand.
> > 
> > - Identifying whether a given path corresponds to a directory
> >   which has tracked contents is tricky. Neither 'cache_name_pos'
> >   nor 'cache_file_exists' handle this. 'cache_dir_exists' is also
> >   not very useful as mentioned above.
> > 
> > So, we do have to take care when handling that case as Junio pointed
> > out.
> 
> I still do not understand this case. Let's say this was our
> superproject:
> 
> .gitmodules .git/ a.txt dir1/
> 
> And we did:
>     $ git submodule add <url> dir1/
> 
> Now, at this point, how does it matter if 'dir1/' has tracked content or
> not right? A directory exists with that name and now we do not add the
> SM to that path.
> 

I'm guessing you're looking at it in a more general sense of the
command workflow. I was speaking only about the following snippet of
the shell script which we're trying to emulate now:

        if test -z "$force"
        then
                git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
                die "$(eval_gettext "'\$sm_path' already exists in the index")"
        else
                git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
                die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
        fi

When sm_path is an empty directory or a directory that has no tracked
contents the 'ls-files' command would fail and we apparently will *not*
get an error stating the path already exists in the index. The command
might fail in a later part of the code but that's not what I'm talking
about.

A few other things I noticed:

> +       strbuf_addstr(&sb, path);
> +       if (is_directory(path)) {

I remember mentioning to you that the 'is_directory' check is
sufficient here and the 'is_nonbare_repository_dir' is not necessary
here as 'resolve_gitlink_ref' already takes care of it. Unfortunately,
looks like without the 'is_nonbare_repository_dir' check we get the
following unhelpful error message when the path is a directory that
_exists_ and is ignored in .gitignore:

   $ git submodule add ../git-crypt/ Debug
   fatal: 'Debug' does not have a commit checked out

   The shell version did not have this problem and gave the following
   appropriate error message:

   $ git submodule add ../git-crypt/ Debug
   The following paths are ignored by one of your .gitignore files:
   Debug
   hint: Use -f if you really want to add them.
   hint: Turn this message off by running
   hint: "git config advice.addIgnoredFile false"

      So, we should check whether the given directory is a non-bare
      repository before calling 'resolve_gitlink_ref' to be consistent with
      what the shell version does.

      For the note, this isn't caught by the 'submodule add to .gitignored
      path fails' in t7400 as the corresponding directory doesn't exist
      there. So, our 'is_directory' check fails and we don't call
      'resolve_gitlink_ref'.

      > +               struct object_id oid;
> +               if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
> +                       die(_("'%s' does not have a commit checked out"), path);
> +       }
> +
> +       if (!force) {
> +               struct strbuf sb = STRBUF_INIT;
> +               struct child_process cp = CHILD_PROCESS_INIT;
> +               cp.git_cmd = 1;
> +               cp.no_stdout = 1;
> +               strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
> +                            "--no-warn-embedded-repo", path, NULL);
> +               if (pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))
> +                       die(_("%s"), sb.buf);

Using 'die' to print an already formatted error message of a command
results in an additional newline which looks ugly. For reference, here
are the output from the shell and C versions of the command:

-- 8< --
$ # Shell version
$ git submodule add ../parent/ submod
The following paths are ignored by one of your .gitignore files:
submod
hint: Use -f if you really want to add them.
hint: Turn this message off by running
hint: "git config advice.addIgnoredFile false"
$ # C version
$ git submodule add ../parent/ submod
fatal: The following paths are ignored by one of your .gitignore files:
submod
hint: Use -f if you really want to add them.
hint: Turn this message off by running
hint: "git config advice.addIgnoredFile false"

$
-- >8 --

So, it would be nice if we use 'fprintf(stderr, ...)' or something like
that so that we don't get the additional newline.

> +               strbuf_release(&sb);
> +       }
> 

-- 
Sivaraam


