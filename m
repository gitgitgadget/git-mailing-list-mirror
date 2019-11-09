Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0821F454
	for <e@80x24.org>; Sat,  9 Nov 2019 11:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKILbq (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 06:31:46 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:36147 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfKILbq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 06:31:46 -0500
Received: by mail-wm1-f47.google.com with SMTP id c22so8778269wmd.1
        for <git@vger.kernel.org>; Sat, 09 Nov 2019 03:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ESP+Ni37+f4rnsZviSabHbAwQWNRavuIcrz4c7zoZCk=;
        b=WQsIwJSTSnXyPBnktGFqvVi59+nOR/2X4dvNeXNi4jKgDh7pIlZl0E1W2k2IGUY5fm
         igXKv37tLbwwDpSoXK3ovunEmeCZJOASKNgUM/RHuUC7q42xcdfh7gd+tis8RhafuLNB
         hjOWtm4dQnTk6yNrpva+OumJ2D+N5XRpgYZIZiiPE6DQC1VzPyB7KCPtKdWWVN2kRDO1
         ROjX2vjttoKUARvuPr2dULsQjnK2O69Sz/d+y6lLh7j7A2ztaggVM6LLC+GBz0X0z/U5
         M8iHJhkoPlyyccl6qXPILvvJPSsDg/CyQxmM+uJlG3pmoEpbNPobVih8kNcF7ff0kpGq
         HRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ESP+Ni37+f4rnsZviSabHbAwQWNRavuIcrz4c7zoZCk=;
        b=pkv/rg3auEmVoGb9jkeUF+1aVBFiRDFwWl8veCqLN6rie+z7bb21X6rjTO6QFBV0/a
         WDwsBsBE/9hlHvqQKflaQZKkDBRWQUjJjWwFKedkfhP63iYowSR1OpPBHfJnOB46p6WT
         l3PTlCPM1IQYw1sHYE0A7nujNCYL2tHpI6lTfEXBd8S7c20CJWbbtxyq2EG4MvuWxwP2
         Xr4NJiDz9NurdHpIMhjIffv71MIae2lq0qmKyxRjmt8ilTZBmK4b4Yl/26pqXg/8n012
         WYAwT6onO9xMXCccdcvW0ugR6SMfQUVRXfu6JhsCibgSpcWhysCwnqkyjeAXlrvgYSSH
         zPAw==
X-Gm-Message-State: APjAAAVFKbzbOkNlRwnIPhnFF0XuS3CXc/RlSFf8VoKz+v7l5zyAMUac
        yIPfkQ5LeCEn4AJJFRX5iCW+GfHsI8ZpJ5bkSZSe5A6g
X-Google-Smtp-Source: APXvYqye+1EWHLxGXR3i63eCobPO4GRAuX295DokJfWJrctghesA82aa2jXM+x2Az67DqNjZ/hqCqUFizUNMxU2vZmo=
X-Received: by 2002:a7b:c743:: with SMTP id w3mr9962164wmk.165.1573299102993;
 Sat, 09 Nov 2019 03:31:42 -0800 (PST)
MIME-Version: 1.0
From:   Sebastiaan Dammann <triadsebas@gmail.com>
Date:   Sat, 9 Nov 2019 12:31:31 +0100
Message-ID: <CAE7Eq9jJzftkP9JWFpstS96SiCd+jO_adSQ-HruyYYNi3gWe7w@mail.gmail.com>
Subject: git name-rev looks at refs/notes, refs/svn/map: stack overflow
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git users,

I'm running into git crashing with an stack overflow and hope to hear
your views on this.

I have a from SVN converted repository (using Subgit). If I execute
"git name-rev 92f054ba5c71b8e689aed529ff31370984089b64" on this bare
repository, git crashes with a stack overflow.

One property of the git conversion process is that at every commit a
note is attached which lists the SVN version number. This repository
has over 50000 commits.
In addition, refs exist at refs/svn/map which also contains many
entries. It appears the name-rev looks at the notes and other refs as
well.

The backtrace of the stack overflow is this:

[repeats many times]
#12976 0x000000000046d178 in name_rev (commit=0x37241b0,
    tip_name=0x37ccb70 "notes/commits", taggerdate=1572995101, generation=3,
    distance=3, from_tag=0, deref=0) at builtin/name-rev.c:139
#12977 0x000000000046d178 in name_rev (commit=0x3724160,
    tip_name=0x37ccb70 "notes/commits", taggerdate=1572995101, generation=2,
    distance=2, from_tag=0, deref=0) at builtin/name-rev.c:139
#12978 0x000000000046d178 in name_rev (commit=0x3724110,
    tip_name=0x37ccb70 "notes/commits", taggerdate=1572995101, generation=1,
    distance=1, from_tag=0, deref=0) at builtin/name-rev.c:139
#12979 0x000000000046d178 in name_rev (commit=0x37240c0,
    tip_name=0x37ccb70 "notes/commits", taggerdate=1572995101, generation=0,
    distance=0, from_tag=0, deref=0) at builtin/name-rev.c:139
#12980 0x000000000046d69d in name_ref (path=0x37232e5 "notes/commits",
    oid=0x37c6030, flags=66, cb_data=0x155ef20) at builtin/name-rev.c:277
#12981 0x00000000005c6645 in do_for_each_ref_helper (r=0x7acee0 <the_repo>,
    refname=0x37232e0 "refs/notes/commits", oid=0x37c6030, flags=66,
    cb_data=0x155ede0) at refs.c:1552
#12982 0x00000000005cfcd1 in do_for_each_repo_ref_iterator (
    r=0x7acee0 <the_repo>, iter=0x37c6190,
    fn=0x5c65ff <do_for_each_ref_helper>, cb_data=0x155ede0)
    at refs/iterator.c:418
#12983 0x00000000005c66de in do_for_each_ref (refs=0x3716aa8,
    prefix=0x71d34f <__ac_HASH_UPPER+271> "", fn=0x46d3ff <name_ref>, trim=0,
    flags=0, cb_data=0x155ef20) at refs.c:1566
#12984 0x00000000005c673f in refs_for_each_ref (refs=0x3716aa8,
    fn=0x46d3ff <name_ref>, cb_data=0x155ef20) at refs.c:1572
#12985 0x00000000005c677a in for_each_ref (fn=0x46d3ff <name_ref>,
   cb_data=0x155ef20) at refs.c:1577
#12986 0x000000000046e2c1 in cmd_name_rev (argc=0, argv=0x37106b8, prefix=0x0)
    at builtin/name-rev.c:495
#12987 0x000000000040305c in run_builtin (p=0x6b56e8 <commands+1704>, argc=2,
    argv=0x37106b0) at git.c:444
#12988 0x0000000000403446 in handle_builtin (argc=2, argv=0x37106b0)
    at git.c:673
#12989 0x00000000004036fc in run_argv (argcp=0x155fdb0, argv=0x155fd58)
    at git.c:740
#12990 0x0000000000403b62 in cmd_main (argc=2, argv=0x37106b0) at git.c:871
#12991 0x00000000004c8647 in main (argc=3, argv=0x37106a8) at common-main.c:52

If I trace it back to the source we get this:
(gdb)
#16 0x000000000046d178 in name_rev (commit=0x3b948d30,
    tip_name=0x37ccb70 "notes/commits", taggerdate=1572995101,
    generation=12963, distance=12963, from_tag=0, deref=0)
    at builtin/name-rev.c:139
139                             name_rev(parents->item, tip_name, taggerdate,
(gdb)
#17 0x000000000046d178 in name_rev (commit=0x3b948ce0,
    tip_name=0x37ccb70 "notes/commits", taggerdate=1572995101,
    generation=12962, distance=12962, from_tag=0, deref=0)
    at builtin/name-rev.c:139
139                             name_rev(parents->item, tip_name, taggerdate,
(gdb)
#18 0x000000000046d178 in name_rev (commit=0x3b948c90,
    tip_name=0x37ccb70 "notes/commits", taggerdate=1572995101,
    generation=12961, distance=12961, from_tag=0, deref=0)
    at builtin/name-rev.c:139
139                             name_rev(parents->item, tip_name, taggerdate,
(gdb)
#19 0x000000000046d178 in name_rev (commit=0x3b948c40,
    tip_name=0x37ccb70 "notes/commits", taggerdate=1572995101,
    generation=12960, distance=12960, from_tag=0, deref=0)
    at builtin/name-rev.c:139
139                             name_rev(parents->item, tip_name, taggerdate,
(gdb)
#20 0x000000000046d178 in name_rev (commit=0x3b948bf0,
    tip_name=0x37ccb70 "notes/commits", taggerdate=1572995101,
    generation=12959, distance=12959, from_tag=0, deref=0)
    at builtin/name-rev.c:139
139                             name_rev(parents->item, tip_name, taggerdate,
(gdb)
#21 0x000000000046d178 in name_rev (commit=0x3b948ba0,
    tip_name=0x37ccb70 "notes/commits", taggerdate=1572995101,
    generation=12958, distance=12958, from_tag=0, deref=0)
    at builtin/name-rev.c:139
139

Essentially too much, but not endless recursion, causing a stack overflow.

The destructive workaround at the moment is to delete the refs, then
run an aggressive gc:
git update-ref -d refs/notes/commits
git update-ref -d refs/svn/map
git gc --prune=all --aggressive

I was redirected here by the git-for-windows team (issue link if
you're interested:
https://github.com/git-for-windows/git/issues/2393), so I'm going to
repeat what was said there:

> But yes, the problem seems to be the many, many notes. Which points to a deeper issue: name_rev should not even look at anything byt refs/heads/*, refs/remotes/* and refs/tags/. Certainly it should exclude refs/notes/*...
> This, however, is not Windows-specific. Maybe I can ask you to report this issue to the Git mailing list (git@vger.kernel.org, please suppress all HTML lest the mail will be bounced)?

I hope to hear your view on this. Is this an (confirmed) issue with
git? Are there beside the workaround I mentioned, any other
workarounds?

Groeten, Kind regards,
Sebastiaan Dammann
