Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3764C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7574A619CF
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhC3Rqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:46:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57679 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhC3RqM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 13:46:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4429412C7ED;
        Tue, 30 Mar 2021 13:46:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZNlb/jesbwgLVjf3QUPCtycwOHE=; b=i9vpsW
        S7zZD/s1tHZTPuy9EQ4cOTm37cDyU09UjY4P6fqJq4UD4nruC2OGuntjtsNXDDGz
        cPVkXiLwierwBxQ7cZ2+iYYXrl0RmGL4jVkoVoP8X++p4/iqK30MW99CXQQMy9Tr
        sG5ChEsCA3Udg7QktgKOaAc10R+Jt31GhrhFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=snXFlMww/hBgrchDtvxBNlAAkmwbiw5B
        g0MviUcE0yUfDkYhzHx5VcmLiqeMTNXZZ8JlZNnZHejceyHgM58EW5Pv8Jor9mjw
        soS1GERK+w7+rEHpMv7VCoON6fiJ6n5I0O8Xlq/QbnrUDBFD3nJ+ryqncLCw8eLA
        zhCkrgkqoO4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C1E612C7EC;
        Tue, 30 Mar 2021 13:46:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6186312C7EB;
        Tue, 30 Mar 2021 13:46:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v8] builtin/clone.c: add --reject-shallow option
References: <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com>
        <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2103301110040.52@tvgsbejvaqbjf.bet>
Date:   Tue, 30 Mar 2021 10:46:07 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2103301110040.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 30 Mar 2021 11:54:30 +0200 (CEST)")
Message-ID: <xmqqk0poedr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF90A8A8-917F-11EB-B671-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +static int option_shallow = -1;    /* unspecified */
>> +static int config_shallow = -1;    /* unspecified */
>
> I would much prefer those variable names to include an indicator that this
> is about _rejecting_ shallow clones. I.e. `option_reject_shallow`.

Good.

> ... repository has been initialized. Note that my suggestion still works with
> that: if either the original config, or the new config set
> `clone.rejectShallow`, it is picked up correctly, with the latter
> overriding the former if both configs want to set it.

All four combinations ("set it to true" vs "set it to false" makes
two, and before and after doubles that to four)?

>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index fb04a76ca263..34d0c2896e2e 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -1129,9 +1129,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>>  	if (args->deepen)
>>  		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
>>  					NULL);
>> -	else if (si->nr_ours || si->nr_theirs)
>> +	else if (si->nr_ours || si->nr_theirs) {
>> +		if (args->remote_shallow)
>
> Even as a non-casual reader, this name `remote_shallow` leads me to assume
> incorrect things. This option is not about wanting a remote shallow
> repository, it is about rejecting a remote shallow repository.

Yeah, I've seen this code too long that my eyes were contaminated
;-)  Thanks for an extra set of eyeballs to spot this.  What this
option means is to "reject-shallow-remote", and I agree 'reject'
is the most important part (args->reject_shallow_remote is not
overly long, either).

>> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
>> index 428b0aac93fa..de1cd85983ed 100755
>> --- a/t/t5606-clone-options.sh
>> +++ b/t/t5606-clone-options.sh
>> @@ -5,6 +5,8 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>
>>  . ./test-lib.sh
>> +. "$TEST_DIRECTORY"/lib-httpd.sh
>> +start_httpd
>
> That's not good. What happens if there is no `httpd`? Then the rest of the
> tests are either skipped, or if `GIT_TEST_HTTPD` is set to `true`, we
> fail. The failure is intentional, but the skipping is not. There are many
> tests in t5606 that do not require a running HTTP daemon, and we should
> not skip them (for example, in our CI runs, there are quite a few jobs
> that run without any working `httpd`).
>
> A much better alternative, I think, would be to move those new test cases
> that require `httpd` to be running to t5601 (which _already_ calls
> `start_httpd`, near the end, so as to not skip any tests that do not
> require `httpd`).

Or move the tests that require httpd, and use of httpd library, to
the end of this script.

> Having read through these test cases, I think they can be simplified by
>
> - first setting up `shallow-repo`
>
> - then testing in the same test case whether `--reject-shallow` fails and
>   `--no-reject-shallow` succeeds, without `--no-local`
>
> - then testing the same _with_ `--no-local`
>
> These can go to t5606, no problem.
>
> Then, in t5601, after the `start_httpd` call, add a single test case that
>
> - sets up the shallow clone _directly_, i.e.
>
> 	git clone --bare --no-local --depth=1 parent \
> 		"$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
>
> - verifies that `--reject-shallow` fails as expected, and
>
> - verifies that `--no-reject-shallow` works as expected.
>
>>  test_expect_success 'uses "origin" for default remote name' '

That would work.

> ...
> As I said, the rest of the patch looks good to me. With the few
> suggestions I offered, I would be totally fine with this patch entering
> `next`.

Thanks for a review.  Looking good.
