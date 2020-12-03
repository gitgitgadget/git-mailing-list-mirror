Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1ACC4167B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 19:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104F6221EF
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 19:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbgLCTew (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 14:34:52 -0500
Received: from mail.javad.com ([54.86.164.124]:51626 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389419AbgLCTew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:52 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 07B7A3EE68;
        Thu,  3 Dec 2020 19:34:09 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kkuMi-0003zD-FQ; Thu, 03 Dec 2020 22:34:08 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 24/27] doc/git-log: describe new --diff-merges options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-25-sorganov@gmail.com>
        <CABPp-BGZO+7bRdCAGFdetOkmwyFnHxDPQ=SD4f6TSa9ZYGFn=A@mail.gmail.com>
Date:   Thu, 03 Dec 2020 22:34:08 +0300
In-Reply-To: <CABPp-BGZO+7bRdCAGFdetOkmwyFnHxDPQ=SD4f6TSa9ZYGFn=A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 2 Dec 2020 22:09:25 -0800")
Message-ID: <877dpyhefj.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sun, Nov 8, 2020 at 1:46 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Describe all the new --diff-merges options in the git-log.txt
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/git-log.txt | 79 +++++++++++++++++++++++----------------
>>  1 file changed, 46 insertions(+), 33 deletions(-)
>>
>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> index 2b8ac5ff882a..de498a189646 100644
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -120,45 +120,58 @@ DIFF FORMATTING
>>  By default, `git log` does not generate any diff output. The options
>>  below can be used to show the changes made by each commit.
>>
>> -Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
>> -will never show a diff, even if a diff format like `--patch` is
>> -selected, nor will they match search options like `-S`. The exception is
>> -when `--first-parent` is in use, in which merges are treated like normal
>> -single-parent commits (this can be overridden by providing a
>> -combined-diff option or with `--no-diff-merges`).
>> +Note that unless one of `--diff-merges` variants (including short
>> +`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
>> +will not show a diff, even if a diff format like `--patch` is
>> +selected, nor will they match search options like `-S`. The exception
>> +is when `--first-parent` is in use, in which case
>> +`--diff-merges=first-parent` is implied.
>>
>> --c::
>> -       With this option, diff output for a merge commit
>> -       shows the differences from each of the parents to the merge result
>> -       simultaneously instead of showing pairwise diff between a parent
>> -       and the result one at a time. Furthermore, it lists only files
>> -       which were modified from all parents.
>> -
>> ---cc::
>> -       This flag implies the `-c` option and further compresses the
>> -       patch output by omitting uninteresting hunks whose contents in
>> -       the parents have only two variants and the merge result picks
>> -       one of them without modification.
>> +--diff-merges=(off|none|first-parent|separate|combined|dense-combined)::
>> +--no-diff-merges::
>> +       Specify diff format to be used for merge commits. This has no
>> +       effect unless diff output is enabled in the first place (e.g.,
>> +       with `--patch` option.)
>
> This seems inconsistent with c7eaf8b4c3 ("log: when --cc is given,
> default to -p unless told otherwise", 2015-08-20); shouldn't these
> imply -p?

Looks like it is indeed, and worse yet, the patch series don't handle
this optimally due to my ignorance of this behavior. I think I need to
make changes to imply -p whenever some of diff-merge options (except
--diff-merges=none) are explicitly given, cause it's now, after these
patches, is unclear why only combined diffs imply -p, and not, say,
--diff-merges=first-parent.

Nice catch, thanks!

BTW, in the original, why only "git log" is affected? Ah, probably
because "git show" has -p by default?

While we are at it, why do we have "git show" at all? How is it
essentially different from "git log -n1 --first-parent ..."? I mean,
shouldn't it effectively be just an alias?

>
>> ++
>> +--diff-merges=(off|none):::
>> +--no-diff-merges:::
>> +       (default) Disable output of diffs for merge commits. Useful to
>> +       override implied value.
>> ++
>> +--diff-merges=first-parent:::
>> +       This option makes merge commits show the full diff with
>> +       respect to the first parent only, exactly like  regular
>> +       commits.
>
> Not sure that "exactly like regular commits" is helpful here; I'd
> personally rather cut those four words out.  I'm worried it'll be
> taken not as an implementation explanation, but as a "this treats
> merge commits in the natural way that regular commits are" which users
> may mistakenly translate to "it shows what changes the user manually
> made as part of the commit" which is not at all the correct mapping.

Dunno. Don't have strict preference here. Git has no idea how the
changes in a commit have been made in the first place. Changes are just
changes.

To my excuse, I took this from git:5fbb4bc191 that has:

+Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
+will never show a diff, even if a diff format like `--patch` is
+selected, nor will they match search options like `-S`. The exception is
+when `--first-parent` is in use, in which merges are treated like normal
+single-parent commits (this can be overridden by providing a
+combined-diff option or with `--no-diff-merges`).

Thanks,
-- Sergey Organov
