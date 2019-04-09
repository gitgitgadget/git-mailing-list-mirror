Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A0620248
	for <e@80x24.org>; Tue,  9 Apr 2019 12:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDIMxC (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 08:53:02 -0400
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:37990 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIMxC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 08:53:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 55618A007F
        for <git@vger.kernel.org>; Tue,  9 Apr 2019 14:52:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id InJMLWakQUNh for <git@vger.kernel.org>;
        Tue,  9 Apr 2019 14:52:57 +0200 (CEST)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id BCA57A0156
        for <git@vger.kernel.org>; Tue,  9 Apr 2019 14:52:57 +0200 (CEST)
Received: from Corentin-Linux.lan (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Tue, 9 Apr 2019 14:52:56 +0200
From:   Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
To:     <matthieu.moy@univ-lyon1.fr>
CC:     <corentin.bompard@etu.univ-lyon1.fr>, <git@vger.kernel.org>,
        <nathan.berbezier@etu.univ-lyon1.fr>,
        <pablo.chabanne@etu.univ-lyon1.fr>
Subject: Re: [PATCH] [WIP/RFC] add git pull and git fetch --set-upstream
Date:   Tue, 9 Apr 2019 14:52:05 +0200
Message-ID: <20190409125205.13754-1-corentin.bompard@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <86sguxvkrd.fsf@univ-lyon1.fr>
References: <86sguxvkrd.fsf@univ-lyon1.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: BEMBX2013-01.univ-lyon1.fr (134.214.201.247) To
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr> writes:
>
>> Adding the --set-upstream option to git pull/fetch
>
> We usually write commit messages with imperative tone, hence "add", not
> "adding".

Fixed.

>> +		/*
>> +		 * We want to set the current branch config following the 
>> +		 * ref_map entry which fetches on FETCH_HEAD
>
> fetches _to_? And period at end of sentence.

Fixed.

>> +		 * In case of "git pull <remote> --set-upstream" we
>> +		 * 	don't want to set all branches' config.
>> +		 * If there is no local ref which points on FETCH_HEAD
>
> Indentation is weird. If you're just writting sentences, just wrap the
> text 1 column away from the "*", and to make paragraphs, add blank lines
> (containing just "*") between paragraphs.

We fixed indentation.

>> +		 * 	we don't set the config for the current branch
>> +		 * 	and warn the user.
>> +		 * If there is a fetch of more than one branch for example: 
>> +		 * 	"git pull <remote> <branch> <branch> --set-upstream"
>> +		 *	setting the current branch's config makes no sense.
>> +		 * Where we are in case of "git pull <remote> <branch>:<branch>" we
>> +		 * 	don't want to set the config for the local branch
>> +		 * 	can be improved in the future to set local branch's config.
>> +		 */
>
> I'm biaised because we talked about this in real-life, but I find the
> explanation unclear. I'd write stg like
> /*
> * We're setting the upstream configuration for the current branch. The
> * relevant upstream is the fetched branch that is meant to be merged with
> * the current one, i.e. the one fetched to FETCH_HEAD.
> * 
> * When there are several such branches, consider the request ambiguous and
> * err on the safe side by doing nothing and just emit a warning.
> */
>
> I think the discussion about the various use-case that may lead to
> different cases (0, 1 or >1 branches fetched to FETCH_HEAD) is not
> needed here, but can be relevant comments in the tests.

We took your message and we will add the use-case in test file.

>> +		for (rm = ref_map; rm; rm = rm->next) {
>> +			fprintf(stderr, "\n -%s", rm->name);
>> +			if (rm->peer_ref) {
>> +				fprintf(stderr, " -> %s", rm->peer_ref->name);
>> +			} else {
>> +				if (target) {
>> +					fprintf(stderr, " -> FETCH_HEAD\n");
>> +					warning(_("Multiple FETCH_HEAD"));
>
> Is this a debug statement or a real warning? In the later case, it
> should be made clearer to the user.

This statement is called when the user call set-upstream with more
than one branch like "git pull <remote> <branch> <branch> --set-upstream"
We replaced the warning message by the following message
"Multiple branch detected, incompatible with --set-upstream".

>> +					target = NULL;
>> +					break;
>> +				} else {
>> +					target = rm;
>
> This is the branch you're fetching from, right? If so, "target" is a
> misleading name. Perhaps source_ref?

We replaced target with source_ref because it's clearer.

>> +					fprintf(stderr, " -> FETCH_HEAD");
>> +				}
>> +			}
>> +		}
>> +		fprintf(stderr, "\n\n");
>> +		if (target) {
>> +			if (!strcmp(ref_map->name, "HEAD") ||
>> +					starts_with(ref_map->name, "refs/heads/")) {
>
> Weird indentation. Perhaps you have a tab-width != 8?

Taken in consideration.

> More importantly, shouldn't ref_map->name be target->name here?

Fixed.

>> +				install_branch_config(0, branch->name,
>> +							 transport->remote->name,
>> +							 target->name);
>> +			} else if (starts_with(ref_map->name, "refs/remotes/")) {
>> +				warning(_("Not setting upstream for a remote remote-tracking branch"));
>> +			} else if (starts_with(ref_map->name, "refs/tags/")) {
>> +				warning(_("Tag upstream not set"));
>> +			} else {
>> +				warning(_("Unknown branch type"));
>> +			}
>> +		} else {
>> +			warning(_("Fetching more than one branch. Current branch's upstream not set"));
>
> The warning seems misleading to me: this else branch is executed in many
> cases (described in the comment above), not only when there's more than
> one branch, right?

This else clause is executed if there is more than one branch which fetches to FETCH_HEAD
or if the user use the syntax git pull --set-upstream <remote> <branch>:<branch> or if there is no
branch which fetches to FETCH_HEAD.

>> --- /dev/null
>> +++ b/t/t5553-set-upstream.sh
>> @@ -0,0 +1,141 @@
>> +#!/bin/sh
>> +
>> +test_description='"git fetch/pull --set-upstream" basic tests.
>> +
>> +'
>> +. ./test-lib.sh
>> +
>> +
>> +
>> +check_config() {
>> +	(echo $2; echo $3) >expect.$1
>> +	(git config branch.$1.remote
>> +	 git config branch.$1.merge) >actual.$1
>> +	test_cmp expect.$1 actual.$1
>> +}
>> +
>> +check_config_empty() {
>> +	git config branch.$1.remote >remote.$1
>> +	test_must_be_empty remote.$1
>> +	git config branch.$1.merge >merge.$1
>> +	test_must_be_empty merge.$1
>> +}
>
> Broken &&-chain (in both functions, but most importantly in the second,
> where the first test_must_be_empty is useless without &&.

We restored the &&-chain in the functions. 

>> +test_expect_success 'fetch --set-upstream does not set branch other' '
>
> Misleading test name: "set branch" -> "set upstream"? And here it's not
> just about "other" but about all branches.
>
> 'fetch --set-upstream does not set upstream w/o branch'
> ?

We edited the test's title

>> +	git checkout master &&
>> +	git fetch --set-upstream upstream &&
>> +	check_config_empty master &&
>> +	check_config_empty other
>> +'
>
>> +#test_expect_success 'fetch --set-upstream does not set branch other' '
>> +#	git checkout master &&
>> +#	git fetch --set-upstream upstream &&
>> +#	check_config master upstream refs/heads/master &&
>> +#	check_config_empty other
>> +#'
>
> Avoid leaving leftovers like this, even in WIP patches, they distract
> the reader.

We removed the test in comment because it no longer makes sense.

>> +test_expect_success 'fetch --set-upstream upstream master sets branch master but not other' '
>> +	git fetch --set-upstream upstream master &&
>> +	check_config master upstream refs/heads/master &&
>> +	check_config_empty other
>> +'
>> +
>> +
>
> Style: you sometimes leave 2 blank lines, sometimes 1 between tests. Try
> to be consistent.

We removed to have only 1 blank line between tests.

>> +test_expect_success 'pull --set-upstream upstream other sets branch other' '
>
> Test title and content say the opposite of each other.
>
>> +	git pull --set-upstream upstream other &&
>> +	check_config master upstream refs/heads/other &&
>> +	check_config_empty other
>> +'

We changed the title of this test.

>> +test_expect_success 'pull --set-upstream http://nosuchdomain.example.com fails with the bad url' '
>> +	test_must_fail git pull --set-upstream http://nosuchdomain.example.com
>> +'
>
> You should check that it doesn't touch the config. That it fails is not
> a surprise regardless of the correctness of your code, but the thing to
> check is that it does not touch the config before failing.

We added some config check and improved 
the test 'fetch ---set-upstream http://nosuchdomain.example.com fails with the bad url'.

>> +test_expect_success 'pull --set-upstream upstream with more than one branch does nothing' '
>
> Here also, test title and content say different things. Probably you
> need to reset the config and use check_config_empty.

We created a new function clear_config which clears the branches config and use check_config_empty to 
check if the config is empty for all branches.

The fixed patch will follow.
