Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18822C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 17:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF832168B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 17:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YOOUkj5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgJGRsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 13:48:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54686 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgJGRsr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 13:48:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAF76F0B51;
        Wed,  7 Oct 2020 13:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Jsb5NppxVnmJGk4ZttD3dnfYEI=; b=YOOUkj
        5syDH6IHffEWNeBlpQ/ijH+uUgPpmwBsaw0LCdfUGd1doXOwHUV6yndl+aEwA8Js
        ddaAU6PgdqMutxYwAru21q/jzKrvREoRouNcejYvosqlI8SG2PoVd8D3kRA4T+XR
        V6dbQtZOXUz5Nemk3IeZUds4JEkoMwD0yd0Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H4tPTO/DvAQH5133NQ+41JDi7aBgxc7n
        j/woQoGPpzpbqF+G5nlbA3YCZvilycx+TxTvV1ixmXMfOvYy3N4A6tmeAYmp/xs0
        0I5ZK/PD/1TzLBc1ErGpG2kERbfJJddrTaj8U0eytIVh0MyFWSmUoO0+YzD+Kqom
        eIy5f0nE3rE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3DE8F0B50;
        Wed,  7 Oct 2020 13:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F401BF0B4F;
        Wed,  7 Oct 2020 13:48:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] help: do not expect built-in commands to be hardlinked
References: <pull.745.git.1602074589460.gitgitgadget@gmail.com>
        <xmqqpn5u2bps.fsf@gitster.c.googlers.com>
Date:   Wed, 07 Oct 2020 10:48:41 -0700
In-Reply-To: <xmqqpn5u2bps.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 07 Oct 2020 10:21:51 -0700")
Message-ID: <xmqqh7r62ah2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 573CD5A4-08C5-11EB-92F9-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ... in the new world order, what we see on disk plus what
> we have in the built-in table are the set of subcommands available
> to us, and the rule that was valid in the old world order can no
> longer be relied upon, and nobody noticed  the breakage while
> developing or reviewing.

>> diff --git a/help.c b/help.c
>> index 4e2468a44d..919cbb9206 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -263,6 +263,8 @@ void load_command_list(const char *prefix,
>>  	const char *env_path = getenv("PATH");
>>  	const char *exec_path = git_exec_path();
>>  
>> +	load_builtin_commands(prefix, main_cmds);
>> +
>>  	if (exec_path) {
>>  		list_commands_in_dir(main_cmds, exec_path, prefix);
>>  		QSORT(main_cmds->names, main_cmds->cnt, cmdname_compare);

I wondered if we need, after this change, to worry about duplicates,
because some Git subcommands, even after they made into a built-in
and callable internally, must have on-disk footprint.

It turns out that after the post-context in this hunk we do make a
call to uniq(main_cmds) so it is fine.

This was unexpected to me, as we read only from a single directory
"exec_path" and the need to call uniq() in the old world order would
have meant that readdir in exec_path gave us duplicate entries.

In fact, the very original version of load_command_list() did not
have this unnecessary call to uniq().  It was introduced in 1f08e5ce
(Allow git help work without PATH set, 2008-08-28); perhaps Alex saw
12 years into the future and predicted that we would start needing
it ;-)

In any case, the patch is good thanks to that existing uniq() call.

>> diff --git a/help.h b/help.h
>> index dc02458855..5871e93ba2 100644
>> --- a/help.h
>> +++ b/help.h
>> @@ -32,6 +32,7 @@ const char *help_unknown_cmd(const char *cmd);
>>  void load_command_list(const char *prefix,
>>  		       struct cmdnames *main_cmds,
>>  		       struct cmdnames *other_cmds);
>> +void load_builtin_commands(const char *prefix, struct cmdnames *cmds);
>>  void add_cmdname(struct cmdnames *cmds, const char *name, int len);
>>  /* Here we require that excludes is a sorted list. */
>>  void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
>>
>> base-commit: 8f7759d2c8c13716bfdb9ae602414fd987787e8d
