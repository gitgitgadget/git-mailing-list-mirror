Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C1BC10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 11:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D90C2465A
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 11:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcbBlTMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgCJLAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:00:18 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:39463 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgCJLAS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 07:00:18 -0400
Received: by mail-wm1-f51.google.com with SMTP id f7so806857wml.4
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R3AlcbO2RRiivdyh/F13Iv2WZD5SrwXKbXp0rKQQz78=;
        b=CcbBlTMRnmYhFEJjSYs/bA2C2+EeuWwgA87Nq5y/LCbSqiVcCVCLJQG42Cb760NRz8
         vxVYxj8cRCuzYm6Gx71PnoorounH7vGWwpndmCo5Yob4vnA/S8Wd0Jf6mPQ4cv8YpeiO
         XOi45t7BAolt/porzVcQVbKyjg/aNtkfby6za4GtDF6DrzEfpC5zYyA2Tyedu+VTYeX1
         uJmAe4U2qwNA4ZK2SYi+I20KEBaEXNaok9h+0ZuhGvRMm0nkr+oS0OPyke4yHewGMEDs
         BdcFfZSy8NRkdj5XcDI8NEyVwxkLuQwSVuGDW1x6JxTdNBJlPchUQNW7s/s1lPhO3pJ/
         dIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3AlcbO2RRiivdyh/F13Iv2WZD5SrwXKbXp0rKQQz78=;
        b=IB6KBAbJ5eqLneA9zjuh7zQTzriwROcjRDf5Y+e4WPXv35KhEA74m51sgKg93Yf3gq
         cZmTSUmq7BOUra5MWRuT5L12RrZgFKGnlHkDJXzT4i+XbJYjLEOZy3cwCvM8WHqSVEeO
         ayExQXgIh/OIBjxP14pahFKfAOountdv/2/+xIy7oLiMFt/p8M8p5EltOLtx9G1HjLqp
         d0Ud/QbIGFLcgsJo+/UnrnR1kCg8duZ6bwM1M5Uqv247mvNH9UTN/r4DsWebGNwQoQ3Y
         PmyAdSfYZLpEoEXTXIPTifminF0XMZPg4dLz7j0sVw5t1c5Ibw/X9RX8qmAZUkFn8pJ4
         Bu5g==
X-Gm-Message-State: ANhLgQ1L41PTdi6tAi/ykGv718IHNxZ1rsxa0AvPsVqjsaid2qF4YOqB
        5lJ6zlU40lZuGlt/M5fcg2V5sixb
X-Google-Smtp-Source: ADFU+vsKTzx7lYbSmp5ii0VqItgWA9peW//nLWOi+c60ZWDSGf5Hnxil20y7Bdsu1QTB4n+kE1S8Yg==
X-Received: by 2002:a7b:c7cf:: with SMTP id z15mr1662209wmk.25.1583838015048;
        Tue, 10 Mar 2020 04:00:15 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id x24sm3486153wmc.36.2020.03.10.04.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 04:00:13 -0700 (PDT)
Date:   Tue, 10 Mar 2020 12:00:08 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [Breakage] t0410 - subtests report unable to remove non-existent
 file.
Message-ID: <20200310110008.GA3122@szeder.dev>
References: <010b01d5ee87$09be74d0$1d3b5e70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <010b01d5ee87$09be74d0$1d3b5e70$@nexbridge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 05:32:57PM -0500, Randall S. Becker wrote:
> Starting at t0410, subtest 5 (missing ref object, but promised, passes
> fsck), on the NonStop L-series platform, we are seeing errors like the
> following:
> 
> not ok 5 - missing ref object, but promised, passes fsck
> #
> #               rm -rf repo &&
> #               test_create_repo repo &&
> #               test_commit -C repo my_commit &&
> #
> #               A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
> #
> #               # Reference $A only from ref
> #               git -C repo branch my_branch "$A" &&
> #               promise_and_delete "$A" &&
> #
> #               git -C repo config core.repositoryformatversion 1 &&
> #               git -C repo config extensions.partialclone "arbitrary
> string" &&
> #               git -C repo fsck
> #
> 
> With verbose output as follows:

Try to run tests with '-x' tracing enabled for additional info about
what's going on, and thus potentially additional clues about what might
go wrong.

> Initialized empty Git repository in /home/ituglib/randall/git/t/trash
> directory.t0410-partial-clone/repo/.git/
> [master (root-commit) 9df77b9] my_commit
>  Author: A U Thor <author@example.com>
>  1 file changed, 1 insertion(+)
>  create mode 100644 my_commit.t
> Enumerating objects: 1, done.
> Counting objects: 100% (1/1), done.
> Writing objects: 100% (1/1), done.
> Total 1 (delta 0), reused 0 (delta 0)
> a391e3e0447189aa0050c8f206462a1b0530a34a
> rm: cannot remove 'repo/.git/objects/a3/91e3e0447189aa0050c8f206462a1b0530a34a': No such file or directory

So this failing 'rm' happens inside the 'promise_and_delete' helper
function, which does  the following, simplified a bit for the purpose
of this discussion:

  promise_and_delete () {
          HASH=$(git -C repo rev-parse "$1") &&
          <...>
          git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
          <...>
          delete_object repo "$HASH"
  }

The failing 'rm' is in the 'delete_object_repo' helper function.
The 'pack_as_from_promisor' does the following:

  pack_as_from_promisor () {
          HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
          >repo/.git/objects/pack/pack-$HASH.promisor &&
          echo $HASH
  }

Notice that both 'promise_and_delete' and 'pack_as_from_promisor' set
the $HASH variable.  This is usually not an issue, because
'pack_as_from_promisor' is invoked in a pipe, and thus most shells
execute it in a subshell environment.

However, apparently 'ksh' doesn't run this helper function in a
subshell environment, and the value set in 'pack_as_from_promisor'
overwrites the value set in its caller, thus 'promise_and_delete' ends
up trying to delete a non-existing object (it's the SHA1 of a
packfile).

See the trimmed/annotated '-x' output with 'ksh' from t0410.5:

  + promise_and_delete 383670739c2f993999f3c10911ac5cb5c6591523
  + git -C repo rev-parse 383670739c2f993999f3c10911ac5cb5c6591523
# Setting $HASH in 'promise_and_delete':
  + HASH=383670739c2f993999f3c10911ac5cb5c6591523
  + git -C repo tag -a -m message my_annotated_tag 383670739c2f993999f3c10911ac5cb5c6591523
  + pack_as_from_promisor
  + git -C repo rev-parse my_annotated_tag
  + git -C repo pack-objects .git/objects/pack/pack
  Enumerating objects: 1, done.
  Counting objects: 100% (1/1), done.
  Writing objects: 100% (1/1), done.
  Total 1 (delta 0), reused 0 (delta 0)
# Setting $HASH in 'pack_as_from_promisor', and overwriting its value
# in the caller:
  + HASH=a391e3e0447189aa0050c8f206462a1b0530a34a
  + 1> repo/.git/objects/pack/pack-a391e3e0447189aa0050c8f206462a1b0530a34a.promisor
  + echo a391e3e0447189aa0050c8f206462a1b0530a34a
  a391e3e0447189aa0050c8f206462a1b0530a34a
  + git -C repo tag -d my_annotated_tag
  + 1> /dev/null
# Using the new value in the caller:
  + delete_object repo a391e3e0447189aa0050c8f206462a1b0530a34a
  + sed -e 's|^..|&/|'
  + echo a391e3e0447189aa0050c8f206462a1b0530a34a
  + rm repo/.git/objects/a3/91e3e0447189aa0050c8f206462a1b0530a34a
  rm: cannot remove 'repo/.git/objects/a3/91e3e0447189aa0050c8f206462a1b0530a34a': No such file or directory

Note, however, that 'ksh' is not utterly wrong in doing so, because
POSIX does allow this behavior: POSIX 2.12 Shell Execution Environment,
the last paragraph of the section:

  "each command of a multi-command pipeline is in a subshell
   environment; as an extension, however, any or all commands in a
   pipeline may be executed in the current environment."

   https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_12

So apparently 'ksh' implements this extension.

The trivial fix would be to mark $HASH as 'local' in both helper
functions, but this would not help 'ksh', of course, as it doesn't
support 'local'.  However, since we use more and more 'local's in our
testsuite, 'ksh' might be considered a lost cause anyway.

Or we could rename these HASH variables to something more specific to
prevent this name collision, e.g. PACK_HASH in 'pack_as_from_promisor'.

Note that there are tests in t0410 that set and use the $HASH variable
outside of these helper function, and, worse, there is a test that uses
the $HASH variable set in the previous test.  Luckily, none of those
tests use 'promise_and_delete' or 'pack_as_from_promisor'.

