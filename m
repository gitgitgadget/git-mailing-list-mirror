Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11FEF20437
	for <e@80x24.org>; Tue, 24 Oct 2017 10:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbdJXKCO (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 06:02:14 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:13561 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdJXKCM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 06:02:12 -0400
Received: from [192.168.2.201] ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id 6w1peEHN8lmqO6w1weCkm8; Tue, 24 Oct 2017 11:02:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1508839330; bh=jzwxY/6sE/MozPHg38rUJ4UkpwXDRiRD6Rd8TACA7Ts=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Cmm8SrNPZmKDuiMT/0GbsWM1jJuxk4fzKLrpfgFc+7B+LC7/2xCZqkYSmYVcYn0rT
         ZTTjAGh2H8rm7VVHCjKKLIVQafWUdf20jHgDi6XCvArhjKczkpaW6OSVlXmwPKd8Wa
         +zLCv5JckkMoM4eSFui5+OySSvRPwBzy/62NXoNA=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=H+Sr+6Qi c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=WCphT0a9x1ASOX0xwoIA:9 a=YiibyFmH85CshXC8:21
 a=pDWqcwFGsno9L7SK:21 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/8] commit: move code to update HEAD to libgit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20170925101041.18344-3-phillip.wood@talktalk.net>
 <xmqqo9pjth92.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <7e9318b4-1281-11ce-8144-5f7e4449e2e1@talktalk.net>
Date:   Tue, 24 Oct 2017 11:01:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9pjth92.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOyACIC7a0pUZYCWBgHDVuAMde+LzaqfIRHUl7jBYr/GvGto7wr4dXJIV1o5olQeps1EGcBBdIFcuCABlAZgLaEKS78Nh+inwT8D+hww3T2ps1AUEg/0
 t3s8nV1D9qK8bIDPuqzl/4TVT2EOblcFwYptnGH3a0YQCSD1odsGAN3lvmGNAvPi3A3AiEUCBgMU/btDHESSWXYsPx3cFqZBHqJNgsNXGCQ5/LtmX95pc0g2
 QZIrmXhu5/eqk+bWpvcBbXQlbtE/6XP97xxr3wh4W5dqxzV3dwBPi/DdhKtHcwSR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/17 10:54, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
> 
> This seems to do a lot more than just moving code, most notably, it
> uses setenv() to affect what happens in any subprocesses we may
> spawn, and it is unclear if it was verified that this patch is free
> of unwanted consequences due to that change (and any others I may
> have missed while reading this patch, if any).
>
> I suspect that it would be sufficient to make update_head() helper
> function take the reflog action message as another parameter
> instead to fix the above, but there may be other reasons why you
> chose to do it this way---I cannot read it in your empty log
> message, though.

Good point, sorry I should have added some explanation about that. I
went with using setenv() rather than passing a reflog message to
update_head() as it meant there were no changes needed on the sequencer
side as it already sets GIT_REFLOG_ACTION. As the sequencer already sets
GIT_REFLOG_ACTION, and git-commit does not fork any subprocesses I don't
think this change has any unwanted consequences (I pushed a branch to
github before submitting the patches and the test suite passes on
travis). It would however be clearer to add a parameter to update_head()
for the reflog message as you suggested.

> 
> I will not give line-by-line style nitpick but in general we do not
> leave a SP between function name and the open parenthesis that
> starts its argument list.  New code in this patch seems to use
> mixture of styles.

Sorry I should have spotted those before I posted this series, I go
though all the patches and fix them (this would be a good opportunity
for me to try using git-clang-format from next)

Thanks for looking at this, did you have time to look at the other
changes in this series or did this patch put you off looking further?
I'll update and repost probably towards the end of next week. If I
continue to base these patches on master then I think the patch that
moves the code to print the commit summary will have (trivial) conflicts
with the changes in ao/check-resolve-ref-unsafe-result in pu do you want
the new patches based pu or are you happy with them based on master?

Best Wishes

Phillip

>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 0b8c1ef6f57cfed328d12255e6834adb4bda4137..497778ba2c02afdd4a337969a27ca781e8389040 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1578,13 +1578,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  	struct strbuf sb = STRBUF_INIT;
>>  	struct strbuf author_ident = STRBUF_INIT;
>>  	const char *index_file, *reflog_msg;
>> -	char *nl;
>>  	struct object_id oid;
>>  	struct commit_list *parents = NULL;
>>  	struct stat statbuf;
>>  	struct commit *current_head = NULL;
>>  	struct commit_extra_header *extra = NULL;
>> -	struct ref_transaction *transaction;
>>  	struct strbuf err = STRBUF_INIT;
>>  
>>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>> @@ -1625,10 +1623,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  	reflog_msg = getenv("GIT_REFLOG_ACTION");
>>  	if (!current_head) {
>>  		if (!reflog_msg)
>> -			reflog_msg = "commit (initial)";
>> +			setenv ("GIT_REFLOG_ACTION", "commit (initial)", 1);
>>  	} else if (amend) {
>>  		if (!reflog_msg)
>> -			reflog_msg = "commit (amend)";
>> +			setenv("GIT_REFLOG_ACTION", "commit (amend)", 1);
>>  		parents = copy_commit_list(current_head->parents);
>>  	} else if (whence == FROM_MERGE) {
>>  		struct strbuf m = STRBUF_INIT;
>> @@ -1637,7 +1635,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  		struct commit_list **pptr = &parents;
>>  
>>  		if (!reflog_msg)
>> -			reflog_msg = "commit (merge)";
>> +			setenv("GIT_REFLOG_ACTION", "commit (merge)", 1);
>>  		pptr = commit_list_append(current_head, pptr);
>>  		fp = xfopen(git_path_merge_head(), "r");
>>  		while (strbuf_getline_lf(&m, fp) != EOF) {
>> @@ -1660,9 +1658,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  			parents = reduce_heads(parents);
>>  	} else {
>>  		if (!reflog_msg)
>> -			reflog_msg = (whence == FROM_CHERRY_PICK)
>> -					? "commit (cherry-pick)"
>> -					: "commit";
>> +			setenv("GIT_REFLOG_ACTION", (whence == FROM_CHERRY_PICK)
>> +						? "commit (cherry-pick)"
>> +						: "commit", 1);
>>  		commit_list_insert(current_head, &parents);
>>  	}
>>  
>> @@ -1707,25 +1705,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  	strbuf_release(&author_ident);
>>  	free_commit_extra_headers(extra);
>>  
>> -	nl = strchr(sb.buf, '\n');
>> -	if (nl)
>> -		strbuf_setlen(&sb, nl + 1 - sb.buf);
>> -	else
>> -		strbuf_addch(&sb, '\n');
>> -	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
>> -	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
>> -
>> -	transaction = ref_transaction_begin(&err);
>> -	if (!transaction ||
>> -	    ref_transaction_update(transaction, "HEAD", oid.hash,
>> -				   current_head
>> -				   ? current_head->object.oid.hash : null_sha1,
>> -				   0, sb.buf, &err) ||
>> -	    ref_transaction_commit(transaction, &err)) {
>> +	if (update_head (current_head, &oid, &sb, &err)) {
>>  		rollback_index_files();
>>  		die("%s", err.buf);
>>  	}
>> -	ref_transaction_free(transaction);
>>  
>>  	unlink(git_path_cherry_pick_head());
>>  	unlink(git_path_revert_head());
>> diff --git a/sequencer.c b/sequencer.c
>> index 319208afb3de36c97b6c62d4ecf6e641245e7a54..917ad4a16216b30adb2c2c9650217926d8db8ba7 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1,10 +1,10 @@
>>  #include "cache.h"
>>  #include "config.h"
>>  #include "lockfile.h"
>> -#include "sequencer.h"
>>  #include "dir.h"
>>  #include "object.h"
>>  #include "commit.h"
>> +#include "sequencer.h"
>>  #include "tag.h"
>>  #include "run-command.h"
>>  #include "exec_cmd.h"
>> @@ -750,6 +750,43 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
>>  	return rest_is_empty(sb, start - sb->buf);
>>  }
>>  
>> +int update_head(const struct commit *old_head, const struct object_id *new_head,
>> +		const struct strbuf *msg, struct strbuf *err)
>> +{
>> +	struct ref_transaction *transaction;
>> +	struct strbuf sb = STRBUF_INIT;
>> +	const char *nl, *reflog_msg;
>> +	int ret = 0;
>> +
>> +	reflog_msg = getenv("GIT_REFLOG_ACTION");
>> +	if (!reflog_msg)
>> +		reflog_msg="";
>> +
>> +	nl = strchr(msg->buf, '\n');
>> +	if (nl) {
>> +		strbuf_add(&sb, msg->buf, nl + 1 - msg->buf);
>> +	} else {
>> +		strbuf_addbuf(&sb, msg);
>> +		strbuf_addch(&sb, '\n');
>> +	}
>> +	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
>> +	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
>> +
>> +	transaction = ref_transaction_begin(err);
>> +	if (!transaction ||
>> +	    ref_transaction_update(transaction, "HEAD", new_head->hash,
>> +				   old_head
>> +				   ? old_head->object.oid.hash : null_sha1,
>> +				   0, sb.buf, err) ||
>> +	    ref_transaction_commit(transaction, err)) {
>> +		ret = -1;
>> +	}
>> +	ref_transaction_free(transaction);
>> +	strbuf_release(&sb);
>> +
>> +	return ret;
>> +}
>> +
>>  static int is_original_commit_empty(struct commit *commit)
>>  {
>>  	const struct object_id *ptree_oid;
>> diff --git a/sequencer.h b/sequencer.h
>> index dd071cfcd82d165bd23726814b74cbf3384e1a17..87edf40e5274d59f48d5af57678100ea220d2c8a 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -60,4 +60,6 @@ enum cleanup_mode {
>>  int message_is_empty(const struct strbuf *sb, enum cleanup_mode cleanup_mode);
>>  int template_untouched(const struct strbuf *sb, const char *template_file,
>>  		       enum cleanup_mode cleanup_mode);
>> +int update_head(const struct commit *old_head, const struct object_id *new_head,
>> +		const struct strbuf *msg, struct strbuf *err);
>>  #endif

