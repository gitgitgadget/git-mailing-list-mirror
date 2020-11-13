Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95D0C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8652223F
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I16GGxas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgKMNrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 08:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKMNrn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 08:47:43 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B198C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 05:47:43 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g15so6630184qtq.13
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 05:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ggxNKAD4QZnJldeFzppE4LuXOWjqDdlYQoosccinL0=;
        b=I16GGxasvtq+7/A3JnKTbfnkWxWGW2mycdGJZ91HjEJmDmF/0lf3h60CM9jnXpdikO
         pYXkRJnDJ3by1invahU7UxKrydH7oyxDgHXfetp1Q/jy2eL3Yi1Ig8iolFbqI6zaZIjA
         YIjdLYJx8iOj12ikqIqo4Y6EKlkblSydy8cTiT8NrGK7ie9TZI7Lu1iz24j/sYcc+H+X
         wiaha5ml4cm5VtE0lWqBy1ZuHFsrJucXseud/9l+XY44uPPhmpRSK2AckRc8a/zf7l9o
         USs4CuxVza1N7c5fk+z+qZDzER4v5L7BUgO8vUZbG04nyMpHU8s+FfFq6Bt45NSeg/nw
         yFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ggxNKAD4QZnJldeFzppE4LuXOWjqDdlYQoosccinL0=;
        b=Y+qIULK05JowlGguhWbaHuYj9EXZWRfvEz14/OiJ48Yo7/dEoUJio/mv29Art7taN0
         JLXfQbd+ISjS56+bWfVxFswIpGY9DU6gmnciEELJSVj3yAuPBwhK88itB2qiJm0TgdwM
         d7O8JP0khUT2tjPNW8OaACwwtFV928humhclbPMHuz5MppiqC7DTc96cyHQ5p6wgrdQF
         OAnZG/XfWkK3RkdxgBNC1plvDbJpouZWbL85WOcYAkBT71fJD015okNUBDEmOgkUmJLz
         758W2YlcngDv5iS1h+thHSqO4G/BLIbpsL6DtHJkuWS/JQXKdO8zvMVNgEildYy6YuKJ
         wz5w==
X-Gm-Message-State: AOAM533cI+q08g/196aPAVITB4NjI7bbRMg6fYYKqsaMvwNO6Jm7s6S3
        dUwCE0Sx68r5zYr1aVMBl1pf80YDlmNlnQ==
X-Google-Smtp-Source: ABdhPJzb+QxkCRe1sh15O52Mg7O6UFuPZZUAatdhAcIar3eUxmt7RpALsQ5a3SkFyW+so0J9sNBRkg==
X-Received: by 2002:ac8:6b92:: with SMTP id z18mr1995727qts.30.1605275261764;
        Fri, 13 Nov 2020 05:47:41 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:30c9:afaa:d787:e592? ([2600:1700:e72:80a0:30c9:afaa:d787:e592])
        by smtp.gmail.com with UTF8SMTPSA id y1sm397524qky.63.2020.11.13.05.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 05:47:41 -0800 (PST)
Subject: Re: [PATCH] rm: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <CABPp-BGkkNwdjLB4HSygvU43OZRiuhDyt7RjrDGodWrfNgkBXQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <70ae5b1d-b1d2-1b3f-11cf-8e5ceafe6048@gmail.com>
Date:   Fri, 13 Nov 2020 08:47:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGkkNwdjLB4HSygvU43OZRiuhDyt7RjrDGodWrfNgkBXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/2020 6:54 PM, Elijah Newren wrote:
> Hi,
> 
> On Thu, Nov 12, 2020 at 1:02 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>>
>> Make git-rm honor the 'sparse.restrictCmds' setting, by restricting its
>> operation to the paths that match both the command line pathspecs and
>> the repository's sparsity patterns. This better matches the expectations
>> of users with sparse-checkout definitions, while still allowing them
>> to optionally enable the old behavior with 'sparse.restrictCmds=false'
>> or the global '--no-restrict-to-sparse-paths' option.
> 
> (For Stolee:) Did this arise when a user specified a directory to
> delete, and a (possibly small) part of that directory was in the
> sparse checkout while other portions of it were outside?

The user who suggested this used a command like 'git rm */*.csprojx' to
remove all paths with that file extension, but then realized that they
were deleting all of those files from the entire repo, not just the
current sparse-checkout.

> I can easily see users thinking they are dealing with just the files
> relevant to them, and expecting the directory deletion to only affect
> that relevant subset, so this seems like a great idea.  We'd just want
> to make sure we have a good error message if they explicitly list a
> single path outside the sparse checkout.

We should definitely consider how to make this more usable for users
who operate within a sparse-checkout but try to modify files outside
the sparse-checkout.

Is there a warning message such as "the supplied pathspec doesn't
match any known file" that we could extend to recommend possibly
disabling the sparse.restrictCmds config? (I see that you identify
one below.)

>> +CONFIGURATION
>> +-------------
>> +
>> +sparse.restrictCmds::
>> +       By default, git-rm only matches and removes paths within the
>> +       sparse-checkout patterns. This behavior can be changed with the
>> +       `sparse.restrictCmds` setting or the global
>> +       `--no-restrict-to-sparse-paths` option. For more details, see the
>> +       full `sparse.restrictCmds` definition in linkgit:git-config[1].
> 
> Hmm, I wonder what people will think who are reading through the
> manual and have never used sparse-checkout.  This seems prone to
> confusion for them.  Maybe instead we could word this as:
> 
> When sparse-checkouts are in use, by default git-rm will only match
> and remove paths within the sparse-checkout patterns...

A preface such as "When using sparse-checkouts..." can help users
ignore these config settings if they are unfamiliar with the
concept.
>> @@ -293,8 +294,12 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>>
>>         seen = xcalloc(pathspec.nr, 1);
>>
>> +       sparse_paths_only = restrict_to_sparse_paths(the_repository);
>> +
>>         for (i = 0; i < active_nr; i++) {
>>                 const struct cache_entry *ce = active_cache[i];
>> +               if (sparse_paths_only && ce_skip_worktree(ce))
>> +                       continue;
>>                 if (!ce_path_match(&the_index, ce, &pathspec, seen))
>>                         continue;
>>                 ALLOC_GROW(list.entry, list.nr + 1, list.alloc);

This seems like an incredibly simple implementation! Excellent.

>> +test_expect_success 'rm should respect --[no]-restrict-to-sparse-paths' '
>> +       git init sparse-repo &&
>> +       (
>> +               cd sparse-repo &&
>> +               touch a b c &&
>> +               git add -A &&
>> +               git commit -m files &&
>> +               git sparse-checkout set "/a" &&
>> +
>> +               # By default, it should not rm paths outside the sparse-checkout
>> +               test_must_fail git rm b 2>stderr &&
>> +               test_i18ngrep "fatal: pathspec .b. did not match any files" stderr &&
> 
> Ah, this answers my question about whether the user gets an error
> message when they explicitly call out a single path outside the sparse
> checkout.  I'm curious if we want to be slightly more verbose on the
> error message when sparse-checkouts are in effect.  In particular, if
> no paths match the sparsity patterns, but some paths would have
> matched the pathspec ignoring the sparsity patterns, then perhaps the
> error message should include a reference to the
> --no-restrict-to-sparse-paths flag.

The error message could be modified similar to below:

if (!seen[i]) {
	if (!ignore_unmatch) {
		die(_("pathspec '%s' did not match any files%s"),
			original,
			sparse_paths_only
				? _("; disable sparse.restrictCmds if you intend to edit outside the current sparse-checkout definition")
				: "");
	}
}

>> +
>> +               # But it should rm them with --no-restrict-to-sparse-paths
>> +               git --no-restrict-to-sparse-paths rm b &&
>> +
>> +               # And also with sparse.restrictCmds=false
>> +               git reset &&
>> +               git -c sparse.restrictCmds=false rm b
>> +       )
>> +'
>> +
>>  test_done
> 
> Do we also want to include a testcase where the user specifies a
> directory and part of that directory is within the sparsity paths and
> part is out?  E.g.  'git sparse-checkout set /sub/dir && git rm -r
> sub' ?

That is definitely an interesting case. I'm not sure the current
implementation will do the "right" thing here. Definitely worth
testing, and it might require a more complicated implementation.

>> diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
>> index 26852586ac..1761a2b1b9 100755
>> --- a/t/t7011-skip-worktree-reading.sh
>> +++ b/t/t7011-skip-worktree-reading.sh
>> @@ -132,11 +132,6 @@ test_expect_success 'diff-files does not examine skip-worktree dirty entries' '
>>         test -z "$(git diff-files -- one)"
>>  '
>>
>> -test_expect_success 'git-rm succeeds on skip-worktree absent entries' '
>> -       setup_absent &&
>> -       git rm 1
>> -'
>> -

Instead of deleting this case, perhaps we should just use "-c sparse.restrictCmds=false"
in the 'git rm' command, so we are still testing this case?

Thanks again! I appreciate that you jumped on this suggestion.

-Stolee

