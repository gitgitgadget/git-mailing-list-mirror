Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D05C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 10:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6298C23A23
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 10:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbhAIKz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 05:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbhAIKz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 05:55:59 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07E9C061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 02:55:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id w1so17882370ejf.11
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 02:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=iWIUCp7HZLzYjiAhCwO9xbgao+/T+B8CNPvF310+LrY=;
        b=G7zvpeNMw36WD5VR5VNABxBod3115TkvaDA+RUawntbdEIcoEg4smwWWcuX8dSoxlH
         vUm2kg6yNEt8ng44YtlYJvscaj9F9Yp1PmVuLsEKuCPb2befAkFhBHX8ONTz2ODqD6gL
         yVpP5MDixmFRce6BdBXz66kAlT/c9KOJp2Iy3lwAoEdTaRSBeqInIj1RtjCe6RJgw6jU
         bXs73kdBtWMCVLnWCzPeFZmKLe1ZbqCLWtBdh50omI21ii4UliUkCJUhxXVqMkRPzjMv
         ZZcFWvAMf518GOFkXObTtFVkuR5G6BGMH2gRSHEoN5fzFSztquYtWuMcqWDJgyM4BLEa
         2fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=iWIUCp7HZLzYjiAhCwO9xbgao+/T+B8CNPvF310+LrY=;
        b=TnKY6hSvBQMKR9htrIFPAOTTB2EJvYGwEDAcD1uX3M3kQWjU1RMtMFmY/E9hpEzOzi
         yKrLBfhwVUnF84T2f9AIowhvI6m8JT9VS3F0iELgeEdJhEi0Lrsr3M5NJHXLT5pHcFD6
         c0p8Enp/heTtUA2ns6dzryo8yEBtk2fwBPRdsEoTpAq3XhFsiRzRzL4JSVMMKItPij2L
         M+g+NPA4ihgOrpm5aakSQY+r9FsJkKWXO29MkKT/An3O1jd9NpeM8B1b2Aprf37uF6WY
         4saj5MRgtCBupd9fVWp3EqOlmK5QvHScdiScO14YSHV9vdGzLLjyy1dQiZ+DDtGqNwAO
         2LsA==
X-Gm-Message-State: AOAM5315BtC98YA4jBn74VsaWTjwQsG8pMJz2h7Ls6yq8Evu3b+Ixlzz
        QG/4EPfYOYylAaV+IHa76SQ=
X-Google-Smtp-Source: ABdhPJxQBBN+v6vhPeFGWu6oCd+lllQcee6tMx0w19ilBnb2fPRFVNvIMdIdh3//H0RHCB9jEXe9eA==
X-Received: by 2002:a17:906:adce:: with SMTP id lb14mr5316775ejb.502.1610189717164;
        Sat, 09 Jan 2021 02:55:17 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id d3sm4895776edt.32.2021.01.09.02.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 02:55:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
Date:   Sat, 09 Jan 2021 11:55:15 +0100
Message-ID: <871reu752k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 08 2021, Junio C Hamano wrote:

> 	git://git.kernel.org/pub/scm/git/git.git/
> 	git://repo.or.cz/alt-git.git/
> 	https://kernel.googlesource.com/pub/scm/git/git/
> 	https://github.com/git/git/
> 	https://gitlab.com/git-vcs/git/

As an aside thanks for following-up on adding the git-vcs/git URL. I
don't think I responded to a question in that E-Mail chain about whether
this repo only has your branches (and not some random topic branches of
mine or whatever). That's the case, it's a strict mirror of your
push-outs.

> * ab/trailers-extra-format (2020-12-09) 5 commits
>   (merged to 'next' on 2020-12-14 at 9fc731944e)
>  + pretty format %(trailers): add a "key_value_separator"
>  + pretty format %(trailers): add a "keyonly"
>  + pretty-format %(trailers): fix broken standalone "valueonly"
>  + pretty format %(trailers) doc: avoid repetition
>  + pretty format %(trailers) test: split a long line
>
>  The "--format=3D%(trailers)" mechanism gets enhanced to make it
>  easier to design output for machine consumption.

Thanks! Am refactoring some out-of-tree code to take advantage of this
:)

I forgot that, oops. Is just declaring here that all of that's:

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Since you have some acks etc. squashed into it at this point...

> * bc/hashed-mailmap (2020-12-12) 1 commit
>  - mailmap: support hashed entries in mailmaps
>
>  The mailmap database learned to take hashed value as the original
>  side of mapping.
>
>  Expecting a reroll.

FWIW there was since a re-roll on 2021-01-03, but the discussion is
sort-of outstanding, so maybe that's intentional...

> * ab/mktag (2021-01-06) 23 commits
>   (merged to 'next' on 2021-01-08 at 6f9e11ad97)
>  + mktag: add a --[no-]strict option
>  + mktag: mark strings for translation
>  + mktag: convert to parse-options
>  + mktag: allow omitting the header/body \n separator
>  + mktag: allow turning off fsck.extraHeaderEntry
>  + fsck: make fsck_config() re-usable
>  + mktag: use fsck instead of custom verify_tag()
>  + mktag: use puts(str) instead of printf("%s\n", str)
>  + mktag: remove redundant braces in one-line body "if"
>  + mktag: use default strbuf_read() hint
>  + mktag tests: test verify_object() with replaced objects
>  + mktag tests: improve verify_object() test coverage
>  + mktag tests: test "hash-object" compatibility
>  + mktag tests: stress test whitespace handling
>  + mktag tests: run "fsck" after creating "mytag"
>  + mktag tests: don't create "mytag" twice
>  + mktag tests: don't redirect stderr to a file needlessly
>  + mktag tests: remove needless SHA-1 hardcoding
>  + mktag tests: use "test_commit" helper
>  + mktag tests: don't needlessly use a subshell
>  + mktag doc: update to explain why to use this
>  + mktag doc: grammar fix, when exists -> when it exists
>  + mktag doc: say <hash> not <sha1>
>
>  "git mktag" validates its input using its own rules before writing
>  a tag object---it has been updated to share the logic with "git
>  fsck".
>
>  Will merge to 'master'.

Thanks. I've got some more local fsck-y fixes I'm hoping to submit soon.
