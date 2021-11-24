Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F029CC433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 11:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbhKXMAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 07:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhKXMAP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 07:00:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B60C061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 03:57:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so9294773edd.3
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 03:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g3rmkRdPVOHg6JhkHnOYHa0idSXHwdMzkcUe57vMUm8=;
        b=OUQhU42HtgJNfurqEbdPBe0TkxAVOsul65TVD+wr3TIvtrNb+/HjAPg7ZQYadJJccD
         +0zDQGiKzHaxokjqDEk/LQqcX0HmT6WD4+4Qtgr5N9aWhd4CfHwyVZ3AiUTyGe6X9qd3
         U3LBvM+JNoLnQ+W3MCrZOv5yMg1UDhnbW3GZ3VWsu6e28Ea2GyiSNJ+u1RK8JSQDZy/G
         lcIdvnLCV8/22FtiJRWIcgjzptE6QwRjkr92soXFEdNVcHChBw/X7HVGtGkf9kCKO3DM
         ZOfSavfWyNmatxwygPq/+KCxpDaIky5y1DX5JAev13Peykx/PcdKGyKLtQtfjBau/Xm+
         a65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g3rmkRdPVOHg6JhkHnOYHa0idSXHwdMzkcUe57vMUm8=;
        b=PQAT6XyUQCjNBum+mqet4b3oTjjZKGS0pjuz1T5lHViMCiW8fe8YfBjlHg5cCzuw12
         456SabA4Mz+Q/LEI9rM0F5hfWAMcoVJwpLFWkI18+ZVjvUsf1+4HxUagVgU0sCEuqqiY
         YBs8l3ES1q9ugHx/Huy8PEl7snYJ7JNbUP9UQui9o3U2nWrdDJjdpTWLQJSRhHm6se1W
         ONZESH/kNT2Og11OUZuOAXvEYtZD7PJ5nFTNbaxrWtoMo95E5H0RdUSqxmnM2dbGJRBk
         SaSmBIoa42dtq92Kp3IMuZVfc7z0qvCQGFyUwSzyo3OGJdHT1gFmsIMsOi1ANfvgjbTO
         FbBA==
X-Gm-Message-State: AOAM531nBo6uE0kfw/Ya5t4PL2GVPBm7mLVv4bRpWU1zRLuznnJUN9vA
        aNYlVSf2P+vpcfrxOhHwE6W/WA==
X-Google-Smtp-Source: ABdhPJyl5uUI2JglcEjbFnigOigsjzr6XMWKkkYeXQDXDIYk21q0zi4YEemoal5vAmTqqO0YrsFWhA==
X-Received: by 2002:a17:906:c152:: with SMTP id dp18mr19105937ejc.241.1637755024652;
        Wed, 24 Nov 2021 03:57:04 -0800 (PST)
Received: from [10.45.33.40] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id ne33sm6858204ejc.6.2021.11.24.03.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 03:57:04 -0800 (PST)
Message-ID: <7c2a01ec-8a69-b7af-cabb-c6a6ef7483a9@unity3d.com>
Date:   Wed, 24 Nov 2021 12:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] fast-export: fix surprising behavior with --first-parent
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
 <211123.865ysjui34.gmgdl@evledraar.gmail.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <211123.865ysjui34.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/11/2021 14.07, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 23 2021, William Sprent via GitGitGadget wrote:
> 
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
>>
>> Signed-off-by: William Sprent <williams@unity3d.com>
>> ---
>>      fast-export: fix surprising behavior with --first-parent
>>      
>>      Hi,
>>      
>>      This is my first time patching git, so I probably need some guidance on
>>      my approach. :)
> 
> Hi, thanks for your first contribution to git. This is a rather shallow
> review, a deeper one is much deserved.
> > I notice that you're removing code in builtin/fast-export.c, presumably
> we have code in revision.c that does the same thing. It would really
> help a reviewer for you to dig a bit into the relevant commit history
> and note it in the commit message.
> 
> I.e. could revision.c always do this, and this was always needless
> duplication, or at time X it was needed, but as of Y revision.c learned
> to do this, and callers A, B and C were adjusted, but just not this
> missed call D? etc.
> 

That's a really good suggestion. I should've done that. I did dig just 
enough to see that the logic has been around since fast-export was 
introduced, but I didn't check whether the 'reverse' option was part of 
revision.c at that point. I see that Elijah has done that homework for 
me later in this thread and discovered that --reverse was introduce a 
year or so before fast-export though.

>> -static int has_unshown_parent(struct commit *commit)
>> -{
>> -	struct commit_list *parent;
>> -
>> -	for (parent = commit->parents; parent; parent = parent->next)
>> -		if (!(parent->item->object.flags & SHOWN) &&
>> -		    !(parent->item->object.flags & UNINTERESTING))
>> -			return 1;
>> -	return 0;
>> -}
>> -
>>   struct anonymized_entry {
>>   	struct hashmap_entry hash;
>>   	const char *anon;
>> @@ -752,20 +740,6 @@ static char *anonymize_tag(void *data)
>>   	return strbuf_detach(&out, NULL);
>>   }
>>   
>> -static void handle_tail(struct object_array *commits, struct rev_info *revs,
>> -			struct string_list *paths_of_changed_objects)
>> -{
>> -	struct commit *commit;
>> -	while (commits->nr) {
>> -		commit = (struct commit *)object_array_pop(commits);
>> -		if (has_unshown_parent(commit)) {
>> -			/* Queue again, to be handled later */
>> -			add_object_array(&commit->object, NULL, commits);
>> -			return;
>> -		}
>> -		handle_commit(commit, revs, paths_of_changed_objects);
>> -	}
>> -}
> 
> ...
> 
>>   static void handle_tag(const char *name, struct tag *tag)
>>   {
>> @@ -1185,7 +1159,6 @@ static int parse_opt_anonymize_map(const struct option *opt,
>>   int cmd_fast_export(int argc, const char **argv, const char *prefix)
>>   {
>>   	struct rev_info revs;
>> -	struct object_array commits = OBJECT_ARRAY_INIT;
>>   	struct commit *commit;
>>   	char *export_filename = NULL,
>>   	     *import_filename = NULL,
>> @@ -1281,19 +1254,14 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>>   
>>   	get_tags_and_duplicates(&revs.cmdline);
>>   
>> +	revs.reverse = 1;
> 
> Is the placement of revs.reverse = 1 here important, or could it go
> earlier after init_revision_sources() when we assign some other values
> ir revs?
> 
>>   	if (prepare_revision_walk(&revs))
>>   		die("revision walk setup failed");
> 
> A light reading of prepare_revision_walk() suggests it could come after,
> but maybe I'm entirely wrong.

It needs to go after the setup_revisions() call as otherwise a --reverse 
passed to fast-export will toggle the option off again. You are right in 
that it can be moved down. I've done that in my working directory for 
the next patch.

Another option would be to move the revs.reverse up as you suggest and 
then then call die() if it was toggled off by setup_revisions(). The 
only downside I can think of is that it would make any current usage of 
'fast-export --reverse' go from a no-op to an error.

>>   	revs.diffopt.format_callback = show_filemodify;
>>   	revs.diffopt.format_callback_data = &paths_of_changed_objects;
>>   	revs.diffopt.flags.recursive = 1;
>>   	while ((commit = get_revision(&revs))) {
>> -		if (has_unshown_parent(commit)) {
>> -			add_object_array(&commit->object, NULL, &commits);
>> -		}
>> -		else {
>> -			handle_commit(commit, &revs, &paths_of_changed_objects);
>> -			handle_tail(&commits, &revs, &paths_of_changed_objects);
>> -		}
>> +		handle_commit(commit, &revs, &paths_of_changed_objects);
>>   	}
>>   
> 
> Yay code deletion, good if it works (I didn't check).
> 
> Since this is just a one-statement while-loop we can also remove its
> braces now.
>  >> +test_expect_success 'fast-export --first-parent outputs all 
revisions output by revision walk' '
>> +	git init first-parent &&
>> +	cd first-parent &&
> 
> Do any such "cd" in a sub-shell:
> 
> 	git init x &&
> 	(
>      		cd x &&
>                  ...
> 	)
> Otherwise the next test after you is going to run in anotherdirectory.
> 
>> +	test_commit init &&
>> +	git checkout -b topic1 &&
>> +	test_commit file2 file2.txt &&
>> +	git checkout main &&
>> +	git merge topic1 --no-ff &&
>> +
>> +	git checkout -b topic2 &&
>> +	test_commit file3 file3.txt &&
>> +	git checkout main &&
>> +	git merge topic2 --no-ff &&
> 
> Just a nit. I'd use "test_commit A", "test_commit B" etc. when the
> filenames etc. aren't important. There's no subsequent reference here,
> so I assume they're not.
> 
>> +	test_commit branch-head &&
>> +
>> +	git rev-list --format="%ad%B" --first-parent --topo-order --no-commit-header main > expected &&
> 
> nit; >expected, not > expected is the usual style.
>> +
>> +	git fast-export main -- --first-parent > first-parent-export &&
>> +	git fast-export main -- --first-parent --reverse > first-parent-reverse-export &&
> 
> ditto:
> 
>> +	git init import && cd import &&
> 
> ditto earlier "cd" comment.
> 
>> +	cat ../first-parent-export | git fast-import &&
> 
> Instead of "cat x | prog" do "prog <x".
> 
>> +	git rev-list --format="%ad%B" --topo-order --all --no-commit-header > actual &&
> 
>> +	test $(git rev-list --all | wc -l) -eq 4 &&
> 
> Instead:
> 
>      git rev-list --all >tmp &&
>      test_line_count = 4 tmp
> 
> (for some value of tmp)
> 
>> +	test_cmp ../expected actual &&
>> +	test_cmp ../first-parent-export ../first-parent-reverse-export
>> +'
> 
> Maybe some of the CD-ing around here wouldu be easier by not doing that
> and instead running e.g.:
> 
>      git -C subdir fast-export >file-not-in-subdir &&
>      ...
> 

Thanks for taking the time to give your feedback. :) I'll remove those 
braces from the while loop and incorporate your comments about the test 
for v2.
