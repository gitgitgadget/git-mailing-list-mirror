Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC59920281
	for <e@80x24.org>; Thu,  5 Oct 2017 14:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdJEOHT (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 10:07:19 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:47450 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdJEOHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 10:07:19 -0400
Received: by mail-lf0-f43.google.com with SMTP id n140so14833736lfn.4
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=M8U39GzeOuBT+L52VbiQsqvV2vOgIZXi1dG/wUjvxT4=;
        b=W/YsXeLROte9342MDGQwlL7EWtazIO4DTGxo6Sg5yOW/p3LbR/2R1k/n+gtxFI2nbA
         pdCpb98t9cEHmxTS6A9i2FoWExE/TeXc+/DWkRuEs1FLjY9jDWus0xpGRCJH4N30eYKR
         VWuYbXEDq7Z96j7mqVAJzxfnbOAQVmILWvi+I3Vp7iUV5P2UKIm0v4ZhiowO5Op/jynF
         nitkVZwsjd7PR0Ngpyu4qriO0AYm5/ezC7Q5fPuClB9M3buDTIMX+odkh1zxhEfPQcdx
         BJMfajJ1fhJPpfSFi7HeyEinJXjBpKi5JNn8Ps3CMkLVzRe8NWoH9sJAAlwu0ITp4fT4
         matQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M8U39GzeOuBT+L52VbiQsqvV2vOgIZXi1dG/wUjvxT4=;
        b=Hcn9lKR7IZTkQcQU5tLKVIPtg+Ha/RqVlqGbEgKz8cczQG0ZxTDEa+N6shndeJ7okV
         ILr6z8BZ2XtjXX4JVJN5K6PyDyMsr+lpjtlNJGcbhHX/E83eKu/YR3+9cEqo8LU9cezq
         BVSWazM0e3+g/+pRhoTXOIXMgVvgSQ/6g12Tp42i6i+E72eKapwjnz4dZRFfOYF6Jviy
         CS3z8IP+ERQ+gO0kMHMfLvDbOmzkPl0G6HICYDlcfiS3ljvTytXqggLwF6mhYhTIwy6d
         ++mHIGViw+f1YlaLSNDAz6s4wQZwWpaCuwNDUvwZqesuID4c3HSJyn2HfDp4GV6rqwKe
         n2jA==
X-Gm-Message-State: AMCzsaVzuqRfzG2ZGe90OqXToUIa9aDDs4vr66nJzABiQqXUEToQYbGh
        ASdZE4MSnqZUs1KNwepZfScFRNqT6FojLbXW2pAeWuyc
X-Google-Smtp-Source: AOwi7QC6fGd5VAITK2C0e3Jjp+R4A613BhL5Zfi6EX2lqnVfWAb3wjMBktRnR+SbanzSt6oaks2IiFQT9u7NlxTGC9o=
X-Received: by 10.25.215.99 with SMTP id o96mr6285011lfg.33.1507212437119;
 Thu, 05 Oct 2017 07:07:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.99.219 with HTTP; Thu, 5 Oct 2017 07:07:16 -0700 (PDT)
From:   Zachary Newman <znewman01@gmail.com>
Date:   Thu, 5 Oct 2017 10:07:16 -0400
Message-ID: <CALba54S3+dhbptijxTyqsDUmfstm48TVUKaejAsyGNv2YkHoYg@mail.gmail.com>
Subject: wildmatch + fnmatch compatibility
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I noticed a possible inconsistency in the documentation for
.gitignore; the pertinent bit is:

    If the pattern does not contain a slash /, Git treats it as a
shell glob pattern
    and checks for a match against the pathname relative to the location of the
    .gitignore file

    ...

    Otherwise, Git treats the pattern as a shell glob suitable for
    consumption by fnmatch(3) with the FNM_PATHNAME flag: wildcards in
    the pattern will not match a / in the pathname.

However, notice:

    $ cd $(mktemp -d)
    $ git init
    $ touch '['
    $ echo -e '.gitignore\n[' > .gitignore
    $ git add --dry-run .
    add '['
    $ python -c "import fnmatch; print fnmatch.fnmatchcase('[', '[')"
    True

Specifically, git *does not* match the string '[' while fnmatch
*does*. "Git treats it
as a shell glob pattern" could mean that the globbing is different
from fnmatch,
but 'test/[' exhibits the same behavior.

I believe this is the result of an inconsistency in between wildmatch
and fnmatch[1]:

    printf("%d\n", fnmatch("[", "[", FNM_PATHNAME);  // prints 0,
indicating a match
    printf("%d\n", wildmatch("[", "[", WM_PATHNAME);  // prints -1,
indicating error

While the way wildmatch handles this makes sense (it *is* a malformed pattern),
it doesn't square with the documentation for .gitignore [2].

There are a few ways that I can think of to resolve this:

* update the documentation to reflect that the syntax is similar but
not identical to
  fnmatch.
* update the behavior of wildmatch to match fnmatch.
* leave the behavior of wildmatch, but fall back to fnmatch if there's an error.
* decide that anybody who comes to depend on this behavior is already in
  dangerous territory, and it's not worth addressing.
* decide that I'm wrong.

(As an aside: I trolled through the mailing list a bit but couldn't
find a rationale
for using wildmatch instead of fnmatch---it looks to be related to a desire to
support '**' patterns in .gitignore, maybe?)

Cheers,
Zack


[1] Specifically, I've tested on both a macOS (BSD) implementation and
Ubuntu (GNU) implementation of fnmatch. Additionally, if I'm reading the
specification right, it claims "If an open bracket introduces a
bracket expression
as in XBD RE Bracket Expression...it shall introduce a pattern bracket
expression....Otherwise, '[' shall match the character itself."
(<http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_13_02>)

[2] There's one caveat: none of the older versions I tested with
ignore '[' either.
In particular, 1.8.2.3 just prints "ha!" (which seems like it
indicates an error) and
1.8.3.1 includes '['; both of these are before the 1.8.4 release, when
the cut over
to using wildmatch occurred.
