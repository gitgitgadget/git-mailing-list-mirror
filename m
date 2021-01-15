Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5086FC433E6
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 18:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA1323A5E
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 18:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbhAOSoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 13:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbhAOSoA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 13:44:00 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509FC061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 10:43:19 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id p5so10564891oif.7
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 10:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kK+mtAGFk6R+FJVqLOWOuAj71zPhOWZ+05a3w+nCvlw=;
        b=FmZxK11/koS8OMXAzomR8ithbp95IAVh/8EmQ0wPuK6NgQaW/j1VFWfn2W84qP/G0K
         kQTlyQnluDVy3HnrnrlnMWWHzcuRLl5S30RJZeMZgwVBcxAIaBnuN8M3C1YkThc8cOGk
         0MGO9nKn0Z4Ya8/8vi+FSpWgviZalg9bMVc405PtKxZtgiWnEUOAkA3BKNF0xb+xPghS
         o3ktDKTX6O9EbdSK9XfP7nZY/5y5xj2zFa9TYM3A9Dv/LJKXNmnyG8G+2cveVqUtZh7a
         NSe5YzKPg+bHK+8+LF0QAWovwfg7dSd/H092myiahRflr4b6JCiGovaRzDAFFrx0Bf2f
         BV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kK+mtAGFk6R+FJVqLOWOuAj71zPhOWZ+05a3w+nCvlw=;
        b=UO0dr8XtuKc50ZQcPpxP5UGhSmGxCD8/D5gvxMCF1ICIBvgXg6U/CmJh5oIIoIjeri
         sFR4pZvmIG51/jIVRZ6g3ihlBSJd/bz0yQtr2b1aqKAornFT5FB4AY7l709Rp8QZrkCb
         z2y7AP3EIf5naHdoETLVrFmSD7MJenZT4kaoPKiqpLnTPAQ82jC2paYecD3D80mEPl9e
         zhxeQUYbxPMGmYBj6w6BYxqk5UBfUwwnKBFAKMVbKhzeZQV3UtCl5njGtQcjDLeGfAvB
         cvqNvoUS8LooOBX0SdZN4yNaQ47yrE40X6/4Bhsld/eOhyew8mqcHF5UVoTodcp3I3Rj
         Zrlg==
X-Gm-Message-State: AOAM532MVfzs/FAdCJwLeIFfkChH9GrBylqRVkicOiQoJ7eGFhldeRtq
        wVHPo86EJc5eGsY73U7xW9a1CbvWCP1r0M0ZN+A=
X-Google-Smtp-Source: ABdhPJzYjvMLHBNumSfuUTEGz5wFdTGm+OxSIwrnigT34fkGe3vXZ5XbxKh/S4pwCprc0Yh36hA2NB34s2kAP9yPzTo=
X-Received: by 2002:a54:4185:: with SMTP id 5mr6578199oiy.31.1610736198932;
 Fri, 15 Jan 2021 10:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20190814024927.13167-1-phil.hord@gmail.com> <CABURp0rtkmo7MSSCVrdNXT0UzV9XqV_kXOGkC23C+_vMENNJUg@mail.gmail.com>
In-Reply-To: <CABURp0rtkmo7MSSCVrdNXT0UzV9XqV_kXOGkC23C+_vMENNJUg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 Jan 2021 10:43:07 -0800
Message-ID: <CABPp-BEUPH5Yc08uDehAXNQ5-3fJ9YeW0xscVBR45hniDe+HEg@mail.gmail.com>
Subject: Re: [PATCH v2] use delete_refs when deleting tags or branches
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Jan 14, 2021 at 6:00 PM Phil Hord <phil.hord@gmail.com> wrote:
>
> I noticed this is still only in my local branch.   Can I get an ACK/NAK?

Sorry for missing this when you posted in August.  Thanks for sending
in the update from v1.

For other reviewers: v1 is over here:
https://lore.kernel.org/git/20190808035935.30023-1-phil.hord@gmail.com/,
and has review comments from Martin, me, Peff, and Junio.

> On Tue, Aug 13, 2019 at 7:49 PM Phil Hord <phil.hord@gmail.com> wrote:
>>
>> From: Phil Hord <phil.hord@gmail.com>
>>
>> 'git tag -d' and 'git branch -d' both accept one or more refs to
>> delete, but each deletion is done by calling `delete_ref` on each argv.
>> This is very slow when removing from packed refs as packed-refs is
>> locked and rewritten each time. Use delete_refs instead so all the
>> removals can be done inside a single transaction with a single update.

Awesome, thanks for also fixing up git branch with v2.

>> Since delete_refs performs all the packed-refs delete operations
>> inside a single transaction, if any of the deletes fail then all
>> them will be skipped. In practice, none of them should fail since
>> we verify the hash of each one before calling delete_refs, but some
>> network error or odd permissions problem could have different results
>> after this change.
>>
>> Also, since the file-backed deletions are not performed in the same
>> transaction, those could succeed even when the packed-refs transaction
>> fails.
>>
>> After deleting refs, report the deletion's success only if the ref was
>> actually deleted. For branch deletion, remove the branch config only
>> if the branch ref is actually removed.
>>
>> A manual test deleting 24,000 tags took about 30 minutes using
>> delete_ref.  It takes about 5 seconds using delete_refs.

As I said on v1, it's really nice to have this fixed.  Thanks for doing it.

>>
>> Signed-off-by: Phil Hord <phil.hord@gmail.com>
>> ---
>> This reroll adds the same delete_refs change to 'git branch'. It checks
>> individual refs after the operation to report correctly on each whether
>> it was successfully deleted or not. Maybe this is an unnecessary step,
>> though. This handles the weird case where some file system error
>> prevented us from deleting refs, leaving us with an error from
>> delete_refs but without any idea which refs might have been affected.
>>
>>  builtin/branch.c | 50 +++++++++++++++++++++++++++++-------------------
>>  builtin/tag.c    | 45 +++++++++++++++++++++++++++++++++----------
>>  2 files changed, 65 insertions(+), 30 deletions(-)
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 2ef214632f..2273239f41 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -202,6 +202,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>>         int remote_branch = 0;
>>         struct strbuf bname = STRBUF_INIT;
>>         unsigned allowed_interpret;
>> +       struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>> +       struct string_list_item *item;
>> +       int refname_pos = 0;
>>
>>         switch (kinds) {
>>         case FILTER_REFS_REMOTES:
>> @@ -209,12 +212,13 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>>                 /* For subsequent UI messages */
>>                 remote_branch = 1;
>>                 allowed_interpret = INTERPRET_BRANCH_REMOTE;
>> -
>> +               refname_pos = 13;
>>                 force = 1;
>>                 break;
>>         case FILTER_REFS_BRANCHES:
>>                 fmt = "refs/heads/%s";
>>                 allowed_interpret = INTERPRET_BRANCH_LOCAL;
>> +               refname_pos = 11;
>>                 break;
>>         default:
>>                 die(_("cannot use -a with -d"));
>> @@ -265,30 +269,36 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>>                         goto next;
>>                 }
>>
>> -               if (delete_ref(NULL, name, is_null_oid(&oid) ? NULL : &oid,
>> -                              REF_NO_DEREF)) {
>> -                       error(remote_branch
>> -                             ? _("Error deleting remote-tracking branch '%s'")
>> -                             : _("Error deleting branch '%s'"),
>> -                             bname.buf);
>> -                       ret = 1;
>> -                       goto next;

The code used to set the return code to 1 if it failed to delete a branch

>> -               }
>> -               if (!quiet) {
>> -                       printf(remote_branch
>> -                              ? _("Deleted remote-tracking branch %s (was %s).\n")
>> -                              : _("Deleted branch %s (was %s).\n"),
>> -                              bname.buf,
>> -                              (flags & REF_ISBROKEN) ? "broken"
>> -                              : (flags & REF_ISSYMREF) ? target
>> -                              : find_unique_abbrev(&oid, DEFAULT_ABBREV));
>> -               }
>> -               delete_branch_config(bname.buf);
>> +               item = string_list_append(&refs_to_delete, name);
>> +               item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
>> +                                   : (flags & REF_ISSYMREF) ? target
>> +                                   : find_unique_abbrev(&oid, DEFAULT_ABBREV));
>>
>>         next:
>>                 free(target);
>>         }
>>
>> +       delete_refs(NULL, &refs_to_delete, REF_NO_DEREF);
>> +
>> +       for_each_string_list_item(item, &refs_to_delete) {
>> +               char * describe_ref = item->util;
>> +               char * name = item->string;
>> +               if (ref_exists(name))
>> +                       ret = 1;

Now it sets the return code if the branch still exists after trying to
delete.  I thought that was subtly different...but I tried doing a
branch deletion of a non-existent branch since I thought that would be
the only difference -- however, that errors out earlier in the
codepath before even getting to the stage of deleting refs.  So I
think these are effectively the same.

>> +               else {
>> +                       char * refname = name + refname_pos;
>> +                       if (!quiet)
>> +                               printf(remote_branch
>> +                                       ? _("Deleted remote-tracking branch %s (was %s).\n")
>> +                                       : _("Deleted branch %s (was %s).\n"),
>> +                                       name + refname_pos, describe_ref);

Neither remote_branch nor refname_pos are changing throughout this
loop, which I at first thought was in error, but it looks like git
branch only allows you to delete one type or the other -- not a
mixture.  So this is correct.

>> +
>> +                       delete_branch_config(refname);
>> +               }
>> +               free(describe_ref);
>> +       }
>> +       string_list_clear(&refs_to_delete, 0);
>> +
>>         free(name);
>>         strbuf_release(&bname);
>>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index e0a4c25382..0d11ffcd04 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -72,10 +72,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
>>  }
>>
>>  typedef int (*each_tag_name_fn)(const char *name, const char *ref,
>> -                               const struct object_id *oid, const void *cb_data);
>> +                               const struct object_id *oid, void *cb_data);
>>
>>  static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
>> -                            const void *cb_data)
>> +                            void *cb_data)
>>  {
>>         const char **p;
>>         struct strbuf ref = STRBUF_INIT;
>> @@ -97,18 +97,43 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
>>         return had_error;
>>  }
>>
>> -static int delete_tag(const char *name, const char *ref,
>> -                     const struct object_id *oid, const void *cb_data)
>> +static int collect_tags(const char *name, const char *ref,
>> +                       const struct object_id *oid, void *cb_data)
>>  {
>> -       if (delete_ref(NULL, ref, oid, 0))
>> -               return 1;

This used to return 1 if it failed to delete a ref.

>> -       printf(_("Deleted tag '%s' (was %s)\n"), name,
>> -              find_unique_abbrev(oid, DEFAULT_ABBREV));
>> +       struct string_list *ref_list = cb_data;
>> +
>> +       string_list_append(ref_list, ref);
>> +       ref_list->items[ref_list->nr - 1].util = oiddup(oid);
>>         return 0;

Now it unconditionally returns 0.

>>  }
>>
>> +static int delete_tags(const char **argv)
>> +{
>> +       int result;
>> +       struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>> +       struct string_list_item *item;
>> +
>> +       result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
>> +       delete_refs(NULL, &refs_to_delete, REF_NO_DEREF);

You now only look at the result of collecting the tags, and ignore the
result of trying to delete them...

>> +
>> +       for_each_string_list_item(item, &refs_to_delete) {
>> +               const char * name = item->string;
>> +               struct object_id * oid = item->util;
>> +               if (ref_exists(name))
>> +                       result = 1;

...except that you check if the refs still exist afterward and set the
return code based on it.  Like with the branch case, I can't come up
with a case where the difference matters.  I suspect there's a race
condition there somewhere, but once you start going down that road I
think the old code may have had a bunch of races too.  It might be
nice to document with a comment that there's a small race condition
with someone else trying to forcibly re-create the ref at the same
time you are trying to delete, but I don't think it's a big deal.

If you did use the result of delete_refs(), you might have to double
check that the callers (git.c:handle_builtin() -> git.c:run_builtin()
-> builtin/tag.c:cmd_tag() -> builtin/tag.c:delete_tags()) are all
okay with the return code; it looks like handle_builtin() would pass
the return code to exit() and the git-tag manpage doesn't document the
return status, so you've at least got some leeway in terms of what
values are acceptable.  Or you could just normalize the return value
of delete_refs() down to 0 or 1.  But you'd only need to worry about
that if the race condition is something we're worried enough to
tackle.

>> +               else
>> +                       printf(_("Deleted tag '%s' (was %s)\n"),
>> +                               item->string + 10,
>> +                               find_unique_abbrev(oid, DEFAULT_ABBREV));
>> +
>> +               free(oid);
>> +       }
>> +       string_list_clear(&refs_to_delete, 0);
>> +       return result;
>> +}
>> +
>>  static int verify_tag(const char *name, const char *ref,
>> -                     const struct object_id *oid, const void *cb_data)
>> +                     const struct object_id *oid, void *cb_data)
>>  {
>>         int flags;
>>         const struct ref_format *format = cb_data;
>> @@ -511,7 +536,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>         if (filter.merge_commit)
>>                 die(_("--merged and --no-merged options are only allowed in list mode"));
>>         if (cmdmode == 'd')
>> -               return for_each_tag_name(argv, delete_tag, NULL);
>> +               return delete_tags(argv);
>>         if (cmdmode == 'v') {
>>                 if (format.format && verify_ref_format(&format))
>>                         usage_with_options(git_tag_usage, options);
>> --
>> 2.23.0.rc1.174.g4cc1b04b4c

Overall, I like the patch.  Peff commented on v1 that the basic idea
(use the part of the refs API that batches operations) is the right
thing to do.  I'm not that familiar with refs-touching code, but your
patch makes sense to me.  I think I spotted a minor issue (you ignore
the return status of delete_refs(), then later check the existence of
the refs afterwards to determine success, which I believe is a minor
and unlikely race condition), but I'm not sure it's worth fixing;
perhaps just mark it with #leftoverbits and move on -- the faster
branch and tag deletion is a very nice improvement.

I notice Martin said on v1 that there was a testcase that had problems
with your patch; I tested v2 and it looks like you fixed any such
issues.  I think you also addressed the feedback from Junio, though
his comments about the return code and the minor race condition I
noticed around it might mean it'd be good to get his comments.

Anyway,
Acked-by: Elijah Newren <newren@gmail.com>

I would say Reviewed-by, but I'd like to get Junio's comments on the
return code and minor race.
