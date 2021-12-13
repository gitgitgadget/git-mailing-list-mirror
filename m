Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F2C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 15:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbhLMPJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 10:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhLMPJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 10:09:53 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C5CC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 07:09:52 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so52301736edb.8
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 07:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IviZ2BOH5aWgqVzsFu2lACJIKPujakHJ0IYR7fGDXFo=;
        b=C1s97GK5p2rbDVnrzkgloKdfVQ3qjQ5B2Rd3RU0p3TvyoFMSNpeFanzRCaHuqge75F
         D9EMJvaBfvft4WjMkvyN/wXQRN72MlcHyjpBCjkukgVHJ1A/J4Ux1jF+cQ3jck5Du3K0
         ORm87H5awOER7GVzFCJuJtM2rkW7hp2MYvoz1RktgME62k3wmSZutDsln3NsmmB/w3oK
         hD7Z0un4U83smdHSxwZzzDKivOgLqptMFrF+V6wU8NWY9maCx0X1woW6JaiO8pvRtKg/
         4VZwMrfGSjrndXY9rfx7HYq7Kx+CNU2+sXYYM0vZ40T2a1G9KKfPM2IFCRg4Pp+kc9Hw
         89wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IviZ2BOH5aWgqVzsFu2lACJIKPujakHJ0IYR7fGDXFo=;
        b=u3GatDPSpusstdo7ioyU0ak45Zt5JZCUZy9ppDVAwHYZm0CrC/2XyJfxrm3EVWG3Tm
         kqwdnew7UIdZaKmvqxTYQPp8JE0UtLJLRYcJtjvUI/OZQD8S5nVisg8BoI3OALW0xVp/
         9U+1negW0B/grcSLqvUa9/NK8vIyQbUzReKych9xWuR5DtXzLBV6L+umP8HMtz7Sy4h1
         wgntT75P0qhFGOGZmO5fdKOZMgQh9BOeal+MmIafwx9DO5kgXr8eYsa0YIK56yHXSu0r
         Zp0Wnx/SN1EtW+oSXOyrJRjzebjVWCw4gRxH7OS+jCEfjBGAcKFBko48gbbx5SWDjsFw
         DqJA==
X-Gm-Message-State: AOAM530tDrR7jTex7MOOPaKsUOV4brl39umGCRphI5ybbyNtEI+gyhkp
        P6rCRkhLAFIlvzygrEB+Rj/BrFpXMri0sDYp
X-Google-Smtp-Source: ABdhPJxwaD570g88CL6aG9Ocu0nMnOD3KDrsxx7vI2NYbbwfAAoYMPbnhmr+QBZ8D1O1b4IyaS+CxQ==
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr65276320edd.2.1639408190882;
        Mon, 13 Dec 2021 07:09:50 -0800 (PST)
Received: from [10.45.34.115] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id r13sm6492723edo.71.2021.12.13.07.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 07:09:50 -0800 (PST)
Message-ID: <b87ec8f9-dd0d-c7b8-1c2a-edfd3d015930@unity3d.com>
Date:   Mon, 13 Dec 2021 16:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2] fast-export: fix surprising behavior with
 --first-parent
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
 <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>
 <CABPp-BGdCizEGcwPS+0VB_vvYLpGCWKLqx-nbZtJ16QkVxzbGQ@mail.gmail.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <CABPp-BGdCizEGcwPS+0VB_vvYLpGCWKLqx-nbZtJ16QkVxzbGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2021 04.48, Elijah Newren wrote:
>   On Thu, Dec 9, 2021 at 12:13 AM William Sprent via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: William Sprent <williams@unity3d.com>
>>
>> When invoking git-fast-export with the --first-parent flag on a branch
>> with merges, fast-export would early-out on processing the first merge
>> on the branch. If combined with --reverse, fast-export would instead
>> output all single parent commits on the branch.
>>
>> This commit makes fast-export output the same commits as rev-list
>> --first-parent, and makes --reverse not have an effect on which commits
>> are output.
>>
>> The fix involves removing logic within fast-export which was responsible
>> for ensuring that parents are processed before their children, which was
>> what was exiting early due to missing second parents. This is replaced
>> by setting 'reverse = 1' before revision walking, which, in conjuction
>> with topo_order, allows for delegating the ordering of commits to
>> revision.c. The reverse flag is set after parsing rev-list arguments to
>> avoid having it disabled.
> 
> This explains how you discovered the issue, but seems to focus on
> these particular flags, leaving the reader wondering whether there are
> other flags that are also mishandled that need additional care, and
> whether this fix might break things for other sets of flags.  It took
> me quite a bit of reasoning to satisfy myself on those points; it's
> actually somewhat complex.  May I suggest an alternative commit
> message based on that?  Here's what I think are the relevant points
> (and yeah, it's lengthy):
> 
> 
> The revision traversal machinery typically processes and returns all
> children before any parent.  fast-export needs to operate in the
> reverse fashion, handling parents before any of their children in
> order to build up the history starting from the root commit(s).  This
> would be a clear case where we could just use the revision traversal
> machinery's "reverse" option to achieve this desired affect.
> 
> However, this wasn't what the code did.  It added its own array for
> queuing.  The obvious hand-rolled solution would be to just push all
> the commits into the array and then traverse afterwards, but it didn't
> quite do that either.  It instead attempted to process anything it
> could as soon as it could, and once it could, check whether it could
> process anything that had been queued.  As far as I can tell, this was
> an effort to save a little memory in the case of multiple root commits
> since it could process some commits before queueing all of them.  This
> involved some helper functions named has_unshown_parent() and
> handle_tail().  For typical invocations of fast-export, this
> alternative essentially amounted to a hand-rolled method of reversing
> the commits -- it was a bunch of work to duplicate the revision
> traversal machinery's "reverse" option.
> 
> This hand-rolled reversing mechanism is actually somewhat difficult to
> reason about.  It takes some time to figure out how it ensures in
> normal cases that it will actually process all traversed commits
> (rather than just dropping some and not printing anything for them).
> 
> And it turns out there are some cases where the code does drop commits
> without handling them, and not even printing an error or warning for
> the user.  Due to the has_unshown_parent() checks, some commits could
> be left in the array at the end of the "while...get_revision()" loop
> which would be unprocessed.  This could be triggered for example with
>      git fast-export main -- --first-parent
> or non-sensical traversal rules such as
>      git fast-export main -- --grep=Merge --invert-grep
> 
> While most traversals that don't include all parents should likely
> trigger errors in fast-export (or at least require being used in
> combination with --reference-excluded-parents), the --first-parent
> traversal is at least reasonable and it'd be nice if it didn't just
> drop commits.  It'd also be nice to have a simpler "reverse traversal"
> mechanism.  Use the "reverse" option of the revision traversal
> machinery to achieve both.
> 
> Even for the non-sensical traversal flags like the --grep one above,
> this would be an improvement.  For example, in that case, the code
> previously would have silently truncated history to only those commits
> that do not have an ancestor containing "Merge" in their commit
> message.  After this code change, that case would would include all
> commits without "Merge" in their commit message -- but any commit that
> previously had a "Merge"-mentioning parent would lose that parent
> (likely resulting in many new root commits).  While the new behavior
> is still odd, it is at least understandable given that
> --reference-excluded-parents is not the default.
> 
> 

Thanks for taking the time to write such a thorough explanation. I'll
apply Junio's comments and use it as the commit message for the next
version.

>>
>> Signed-off-by: William Sprent <williams@unity3d.com>
>> ---
>>      fast-export: fix surprising behavior with --first-parent
>>
>>      Hi,
>>
>>      I've noticed that git fast-export exhibits some odd behavior when passed
>>      the --first-parent flag. In the repository I was working on, it would
>>      only output the initial commit before exiting. Moreover, adding the
>>      --reverse flag causes it to behave differently and instead output all
>>      commits in the first parent line that only have one parent. My
>>      expectation is more or less that git fast-export should output the same
>>      set of commits as git rev-list would output given the same arguments,
>>      which matches how it acts when given revision ranges.
>>
>>      It seems like this behavior comes from the fact that has_unshown_parents
>>      will never be false for any merge commits encountered when fast-export
>>      is called with --first-parent. This causes the while loop to follow the
>>      pattern of pushing all commits into the "commits" queue until the
>>      initial commit is encountered, at which point it calls handle_tail which
>>      falls through on the first merge commit, causing most of the commits to
>>      be unhandled.
>>
>>      My impression is that this logic only serves to ensure that parents are
>>      processed before their children, so in my patch I've opted to fix the
>>      issue by delegating that responsibility to revision.c by adding the
>>      reverse flag before performing the revision walk. From what I can see,
>>      this should be equivalent to what the previous logic is trying to
>>      achieve, but I can also see that there could be risk in these changes.
>>
>>      Changes since v1:
>>
>>       * Moved revs.reverse assignment down to similar assignments below.
>>       * Removed braces around single statement while loop.
>>       * The test now only changes directory inside a sub-shell.
>>       * Applied stylistic feedback on test such as: making redirections be on
>>         the form >FILE etc.
>>
>>      There were questions raised about whether it makes sense at all for
>>      fast-export to simply accept all git rev-list arguments whether they
>>      have an effect or not - in particular for a flag like --reverse. I think
>>      I agree that it is questionable behavior, or at least questionably
>>      documented, but I also think it is out of scope for this change.
>>
>>      I did consider teaching fast-export to complain if given --reverse, but
>>      it seemed inconsistent to me as it will gladly accept every other
>>      rev-list argument (for example, "git fast-export HEAD --show-signature
>>      --graph" works just fine).
>>
>>      cc: Ævar Arnfjörð Bjarmason avarab@gmail.com
>>
> ...
>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>> index 8e2caf72819..cb1d6473f12 100644
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -107,18 +107,6 @@ static int parse_opt_reencode_mode(const struct option *opt,
>>
>>   static struct decoration idnums;
>>   static uint32_t last_idnum;
>> -
>> -static int has_unshown_parent(struct commit *commit)
>> -{
>> -       struct commit_list *parent;
>> -
>> -       for (parent = commit->parents; parent; parent = parent->next)
>> -               if (!(parent->item->object.flags & SHOWN) &&
>> -                   !(parent->item->object.flags & UNINTERESTING))
>> -                       return 1;
>> -       return 0;
>> -}
>> -
>>   struct anonymized_entry {
>>          struct hashmap_entry hash;
>>          const char *anon;
>> @@ -752,20 +740,6 @@ static char *anonymize_tag(void *data)
>>          return strbuf_detach(&out, NULL);
>>   }
>>
>> -static void handle_tail(struct object_array *commits, struct rev_info *revs,
>> -                       struct string_list *paths_of_changed_objects)
>> -{
>> -       struct commit *commit;
>> -       while (commits->nr) {
>> -               commit = (struct commit *)object_array_pop(commits);
>> -               if (has_unshown_parent(commit)) {
>> -                       /* Queue again, to be handled later */
>> -                       add_object_array(&commit->object, NULL, commits);
>> -                       return;
>> -               }
>> -               handle_commit(commit, revs, paths_of_changed_objects);
>> -       }
>> -}
> 
> Deleted code is debugged code!  :-)
> 
>>
>>   static void handle_tag(const char *name, struct tag *tag)
>>   {
>> @@ -1185,7 +1159,6 @@ static int parse_opt_anonymize_map(const struct option *opt,
>>   int cmd_fast_export(int argc, const char **argv, const char *prefix)
>>   {
>>          struct rev_info revs;
>> -       struct object_array commits = OBJECT_ARRAY_INIT;
>>          struct commit *commit;
>>          char *export_filename = NULL,
>>               *import_filename = NULL,
>> @@ -1283,18 +1256,13 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>>
>>          if (prepare_revision_walk(&revs))
>>                  die("revision walk setup failed");
>> +
>> +       revs.reverse = 1;
> 
> I really wanted to see this next to the
>      rev.topo_order = 1
> statement elsewhere, but as you alluded to in the commit message, this
> part of revision.c makes that unsafe:
> 
> """
> } else if (!strcmp(arg, "--reverse")) {
>      revs->reverse ^= 1;
> """
> 
> However, given that it's unsafe to set revs.reverse=1 earlier, now
> that I think about it, isn't it also unsafe to set revs.topo_order
> where it is?  Someone could override it by passing --date-order to
> fast-export.  (It's okay if you want to leave fixing that to someone
> else, just thought I'd mention it while reviewing.)
> 

I couldn't tell you for sure if the topo_order placement is safe. I at
least don't see any place where topo_order itself can be toggled off in
revision.c. I'm sure there exists at least one rev-list argument which
will cause unexpected behaviour, though.

I agree that it would be nice to have the traversal order options be
assigned in the same place. I guess we have three options:


    1. Put the reverse assignment to the top (together with topo_order),
allowing the user to disable it with --reverse, which will cause odd
behaviour.

    2. Put the reverse assignment to the top and throw an error if the
user passes the --reverse option.

    3. Keep the reverse assignment at the bottom, silently ignoring any
--reverse option.


I don't think any of the three options are particularly good. The first
one for obvious reasons. The second seems inconsistent to me as we would
only error on --reverse but not any of the other "nonsensical" rev-list
args. However, silently ignoring certain arguments does also not make
for a good user experience.

I think that it might be a good idea to move up the 'reverse' assignment
and then add a paragraph to the man page for git-fast-export explaining
that some arguments, in particular the ones that change the ordering of
commits and the ones that change how commits are displayed (such as 
--graph), may have no or unexpected effects.

I've tried writing a snippet in git-fast-export.txt, which I could include
in the next version, if you think it seems like a reasonable approach:

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 1978dbdc6a..34875ef01d 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -157,16 +157,21 @@ by keeping the marks the same across runs.
 [<git-rev-list-args>...]::
 	A list of arguments, acceptable to 'git rev-parse' and
 	'git rev-list', that specifies the specific objects and references
 	to export.  For example, `master~10..master` causes the
 	current master reference to be exported along with all objects
 	added since its 10th ancestor commit and (unless the
 	--reference-excluded-parents option is specified) all files
 	common to master{tilde}9 and master{tilde}10.
++
+Arguments to `git rev-list` which change the _order_ in which commits are
+traversed, such as '--reverse', as well as arguments which control how commits
+are displayed, such as '--graph', may either have no effect or have an
+unexpected effect on which commits are exported.
 
 EXAMPLES
 --------


>>          revs.diffopt.format_callback = show_filemodify;
>>          revs.diffopt.format_callback_data = &paths_of_changed_objects;
>>          revs.diffopt.flags.recursive = 1;
>> -       while ((commit = get_revision(&revs))) {
>> -               if (has_unshown_parent(commit)) {
>> -                       add_object_array(&commit->object, NULL, &commits);
>> -               }
>> -               else {
>> -                       handle_commit(commit, &revs, &paths_of_changed_objects);
>> -                       handle_tail(&commits, &revs, &paths_of_changed_objects);
>> -               }
>> -       }
>> +       while ((commit = get_revision(&revs)))
>> +               handle_commit(commit, &revs, &paths_of_changed_objects);
> 
> Looks good.  Nice work on finding this.
> 
>>
>>          handle_tags_and_duplicates(&extra_refs);
>>          handle_tags_and_duplicates(&tag_refs);
>> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
>> index 409b48e2442..df1a5b1013a 100755
>> --- a/t/t9350-fast-export.sh
>> +++ b/t/t9350-fast-export.sh
>> @@ -750,4 +750,39 @@ test_expect_success 'merge commit gets exported with --import-marks' '
>>          )
>>   '
>>
>> +
>> +test_expect_success 'fast-export --first-parent outputs all revisions output by revision walk' '
>> +       git init first-parent &&
>> +       (
>> +               cd first-parent &&
>> +               test_commit A &&
>> +               git checkout -b topic1 &&
>> +               test_commit B &&
>> +               git checkout main &&
>> +               git merge topic1 --no-ff &&
>> +
>> +               git checkout -b topic2 &&
>> +               test_commit C &&
>> +               git checkout main &&
>> +               git merge topic2 --no-ff &&
> 
> micro nit: I'd really prefer the --no-ff before the "topic1" and "topic2".
> 

I agree. I'll move it forward.

>> +
>> +               test_commit D &&
>> +
>> +               git rev-list --format="%ad%B" --first-parent --topo-order --no-commit-header main >expected &&
> 
> I'd much prefer this were changed to
>      git log --format="%ad %s" --first-parent >expected &&
> because:
>    * --topo-order is irrelevant when you have a linear history (which
> --first-parent gives you)
>    * --no-commit-header can be tossed by using log instead of rev-list
>    * %B provides the entire (multi-line) commit message body but you
> clearly care about how many commits you saw below and were assuming
> just one line per commit, so %s is better.
>    * The format looks weird when inspecting as a human; it's much nicer
> with a space between the %ad and %s.
>

I think that makes sense. That would also allow me to use 'actual' in
the line count test below.

>> +
>> +               git fast-export main -- --first-parent >first-parent-export &&
>> +               git fast-export main -- --first-parent --reverse >first-parent-reverse-export &&
>> +
>> +               git init import &&
>> +               git -C import fast-import <first-parent-export &&
>> +
>> +               git -C import rev-list --format="%ad%B" --topo-order --all --no-commit-header >actual &&
> 
> Same simplifications as above here:
>     git -C import log --format="%ad %s" --topo-order --all >actual &&
> 
> However, is there a reason you're using "--all" instead of "main"?
> Although main is the only branch, which makes either output the same
> thing, it'd be easier for folks reading to catch the equivalence if it
> was clear you were now listing information about the same branch.
> 

I guess the intent is to be completely sure that only four commits were
exported, and no other refs made it into the new repository. I don't feel
too strongly about it, but I think it is a slightly stronger test than
leaving out the '--all'.

>> +               git -C import rev-list --all >tmp &&
>> +
>> +               test_line_count = 4 tmp &&
> 
> I don't understand why you need tmp.  Why not just use actual on the
> test_line_count line?
> 

As you noted above, I used '%B' for writing into 'actual', so I don't think
I can use that to verify that the correct number of commits have been
exported. I guess I can use your suggestion above and then save one check.

>> +               test_cmp expected actual &&
>> +               test_cmp first-parent-export first-parent-reverse-export
> 
> This last line would be much nicer to include right after
> first-parent-reverse-export is created.  Or else move the creation of
> first-parent-reverse-export down to just above this line.
> 

I agree. I will move it up. Except if we decide on moving the revs.reverse
assignment to the topo_order assignment, then passing '--reverse' won't be
a no-op and I'll remove the check instead.

>> +       )
>> +'
>> +
>>   test_done

