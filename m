Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159E1C433E3
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9DD204FD
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOnGItHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgHQNhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgHQNhA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 09:37:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22239C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 06:37:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r15so5117121wrp.13
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i3EdBZKMdcKB2UDMuRwv6xniNF9ZDWl5in6qELoQaIA=;
        b=DOnGItHgiENYMBrFPmCqZQ9TLQmYtwNF9zmLVfNRmcM9xZe+tG/LA4bsMCHMcjzwQs
         5U2DxjdUkwR7WP1J0Fcn2SOPyh34sm4JyYx/qJPve2ZRfshd3/unsYlp7OAx3PWAaUiS
         AHTI1CrhI5xr6XHjOA8dMI3ey75geXIqt22CGNyS9Grb/+38mk1cbOhj2RdivMNBYJxx
         JDftESV1X7VNN2PSXcSzH7q4RMcz8Hu8VJ+dxcBdqs/FFP9l681mmtJka467oZo7oMRp
         fIkyFOx1hQhDDsuWgJoTudeGvsTk31IOyAskQi8aywvOll+qXngz+FYdBM9Qw+ufg6bs
         jhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i3EdBZKMdcKB2UDMuRwv6xniNF9ZDWl5in6qELoQaIA=;
        b=ths9wD5o7ribCGqgIRQ6vQdxM0GoDt8jzMwout4bazMf/KL7sLzH+ifEcqc1kt388Z
         L4gyFovSIyRL1NXeCyvIGxaN7g63ovcopRf5mlZFn7d5yUFlnRwuaQZXU8i35xR11OYE
         slQ8vFDsgbvn0U4YSOj8ocz16GrvltEnv1DVfrNhds2+KXq/k/M/gKEdn1UeE1wMgemh
         snIo7R+Ovkvkd2jLIv1DGXfeMTxWPYoZ3ex03EDXa5p7P489Q/cTc6/icDbPhuF6SgpB
         eZHLL9BSe9mj2wTb6rCelWeQGLSlhVyTcdDhTEVpyem+6baL/CmO1EFlvZMnquo2mSob
         nzLQ==
X-Gm-Message-State: AOAM531HgvIf+urIMjEMguVM40qNOQp7dox+MKd9udNPOUXjQCt7d+nE
        jUbIBRG2m5iixcp51cArcGL8c3eF15M=
X-Google-Smtp-Source: ABdhPJwHfLfyMkLAMNp+HHgi3fiPS/nyJnNUaFJox6itoFkHIAV64H6LSQOiYAujycANZnhxjwJ9wg==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr16509295wrq.175.1597671418507;
        Mon, 17 Aug 2020 06:36:58 -0700 (PDT)
Received: from [192.168.1.240] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id v7sm12624919wmj.28.2020.08.17.06.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 06:36:58 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] hook: add list command
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
References: <20200521185414.43760-1-emilyshaffer@google.com>
 <20200521185414.43760-4-emilyshaffer@google.com>
 <41e4fcf3-5d39-71a2-35b2-ee143cd59033@gmail.com>
 <20200609214926.GD148632@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3fda8c55-1373-03a8-9cc1-484345e7fa3e@gmail.com>
Date:   Mon, 17 Aug 2020 14:36:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200609214926.GD148632@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

sorry it has taken me so long to reply

On 09/06/2020 22:49, Emily Shaffer wrote:
> On Fri, May 22, 2020 at 11:27:44AM +0100, Phillip Wood wrote:
>>
>> Hi Emily
>>
>> On 21/05/2020 19:54, Emily Shaffer wrote:
>>> [...]
>>> +static int hook_config_lookup(const char *key, const char *value, void *hook_key_cb)
>>> +{
>>> +	const char *hook_key = hook_key_cb;
>>> +
>>> +	if (!strcmp(key, hook_key)) {
>>> +		const char *command = value;
>>> +		struct strbuf hookcmd_name = STRBUF_INIT;
>>> +		struct list_head *pos = NULL, *tmp = NULL;
>>> +
>>> +		/* Check if a hookcmd with that name exists. */
>>> +		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
>>> +		git_config_get_value(hookcmd_name.buf, &command);
>>
>> This looks dodgy to me. This code is called by git_config() as it parses
>> the config files, so it has not had a chance to fully populate the
>> config cache used by git_config_get_value(). I think the test below
>> passes because the hookcmd setting is set in the global file and the
>> hook setting is set in the local file so when we have already parsed the
>> hookcmd setting when we come to look it up. The same comment applies to
>> the hypothetical ordering config mentioned below. I think it would be
>> better to collect the list of hook.<event>.command settings in this
>> callback and then look up any hookcmd settings for those hook commands
>> after we've finished reading all of the config files.
> 
> git_config_get_value() calls repo_read_config(the_repository) if the
> config hasn't been fully parsed yet, so I think what you're worrying
> about is not an issue. It's ugly, I agree, but since the new hotness
> (git_config_get_value() and friends) doesn't offer the same
> functionality as the old solution (config origin) this seemed like an
> okay approach. As I understand it, moving this hookcmd lookup section
> outside of the config callback will save us up to one additional pass
> through the configs, at the expense of a more convoluted code path.

Oh I didn't realize that, thanks for explaining it. Below you mention 
showing the origin for hookcmds as well as the origin of the command 
which would mean having to change this code anyway I think.

>>
>>> +
>>> +		if (!command)
>>> +			BUG("git_config_get_value overwrote a string it shouldn't have");
>>> +
>>> +		/*
>>> +		 * TODO: implement an option-getting callback, e.g.
>>> +		 *   get configs by pattern hookcmd.$value.*
>>> +		 *   for each key+value, do_callback(key, value, cb_data)
>>> +		 */
>>> +
>>> +		list_for_each_safe(pos, tmp, &hook_head) {
>>> +			struct hook *hook = list_entry(pos, struct hook, list);
>>> +			/*
>>> +			 * The list of hooks to run can be reordered by being redeclared
>>> +			 * in the config. Options about hook ordering should be checked
>>> +			 * here.
>>> +			 */
>>> +			if (0 == strcmp(hook->command.buf, command))
>>> +				remove_hook(pos);
>>> +		}
>>> +		emplace_hook(pos, command);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +struct list_head* hook_list(const struct strbuf* hookname)
>>> +{
>>> +	struct strbuf hook_key = STRBUF_INIT;
>>> +
>>> +	if (!hookname)
>>> +		return NULL;
>>> +
>>> +	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
>>> +
>>> +	git_config(hook_config_lookup, (void*)hook_key.buf);
>>> +
>>> +	return &hook_head;
>>> +}
>>> diff --git a/hook.h b/hook.h
>>> new file mode 100644
>>> index 0000000000..aaf6511cff
>>> --- /dev/null
>>> +++ b/hook.h
>>> @@ -0,0 +1,15 @@
>>> +#include "config.h"
>>> +#include "list.h"
>>> +#include "strbuf.h"
>>> +
>>> +struct hook
>>> +{
>>> +	struct list_head list;
>>> +	enum config_scope origin;
>>> +	struct strbuf command;
>>> +};
>>> +
>>> +struct list_head* hook_list(const struct strbuf *hookname);
>>> +
>>> +void free_hook(struct hook *ptr);
>>> +void clear_hook_list(void);
>>> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
>>> index 34b0df5216..4e46d7dd4e 100755
>>> --- a/t/t1360-config-based-hooks.sh
>>> +++ b/t/t1360-config-based-hooks.sh
>>> @@ -4,8 +4,55 @@ test_description='config-managed multihooks, including git-hook command'
>>>   
>>>   . ./test-lib.sh
>>>   
>>> -test_expect_success 'git hook command does not crash' '
>>> -	git hook
>>> +test_expect_success 'git hook rejects commands without a mode' '
>>> +	test_must_fail git hook pre-commit
>>> +'
>>> +
>>> +
>>> +test_expect_success 'git hook rejects commands without a hookname' '
>>> +	test_must_fail git hook list
>>> +'
>>> +
>>> +test_expect_success 'setup hooks in global, and local' '
>>> +	git config --add --local hook.pre-commit.command "/path/ghi" &&
>>
>> Can I make a plea for the use of test_config please. Writing tests which
>> rely on previous tests for their set-up creates a chain of hidden
>> dependencies that make it hard to add/alter tests later or run a subset
>> of the tests when developing a new patch. t3404-rebase-interactive.sh is
>> a prime example of this and I dread touching it.
> 
> Sure. I'll redo them.

That's great, thanks

Best Wishes

Phillip

>>
>>> +	git config --add --global hook.pre-commit.command "/path/def"
>>> +'
>>> +
>>> +test_expect_success 'git hook list orders by config order' '
>>> +	cat >expected <<-\EOF &&
>>> +	global:	/path/def
>>> +	local:	/path/ghi
>>> +	EOF
>>> +
>>> +	git hook list pre-commit >actual &&
>>> +	test_cmp expected actual
>>> +'
>>> +
>>> +test_expect_success 'git hook list dereferences a hookcmd' '
>>> +	git config --add --local hook.pre-commit.command "abc" &&
>>> +	git config --add --global hookcmd.abc.command "/path/abc" &&
>>> +
>>> +	cat >expected <<-\EOF &&
>>> +	global:	/path/def
>>> +	local:	/path/ghi
>>> +	local:	/path/abc
>>
>> We should make it clear in the documentation that the config origin
>> applies to the hook setting, even though we display the hookcmd command
>> which is set globally here for the last hook.
> 
> One of the suggestions from our UX team last week was to make this list
> output clearer to indicate the origin of the command plus the origin of
> the hookcmd object; I'll try to straighten this out and make sure the
> doc agrees.
> 
>   - Emily
> 
