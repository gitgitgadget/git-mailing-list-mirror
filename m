Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B17AC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbhLUSZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241288AbhLUSZh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:25:37 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46472C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:25:37 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r4-20020a654984000000b0033ae6493472so9376616pgs.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mT+VrUtUWt22cjHEdMUwp3rZ9ZoMFMLYMIdRuPfIjto=;
        b=N/is718oTb1RmjhB9PyCgOeMsLKF9sTSTFHZu4BkO+VQsPTyHxxCQfwAak+hVMkCF7
         Wc/vQ6CUdSR+iLyubNysYYKDWdUphzoOVaF9SQO/mlK8g4kIqvs0RUHYidXnEaGpE9km
         s3szKMkuSx+6vcmtkXF03Ii6QgQPz+DdlSmRZSJDrm4JSPdOHt6ricn/4ph1YmlQ/23E
         bE94dm6zKpW8ztg/2wVVrAdQ8TeRjsK2WibDdcIummP3Ijkh4wAvq7qgX5iPwZKK3K6Y
         tHwAU+oTGXcaFGsXl3zSgGizKjNVWvwPidojmdFXtD08PfvQnIc+47fG7/6e0iq9JjZS
         rKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mT+VrUtUWt22cjHEdMUwp3rZ9ZoMFMLYMIdRuPfIjto=;
        b=VqCTRT9yfr+TDqX49JAzCTMS4zIOJEegaSXrHcq+N7UH/xjhAUyu9JmA2z7yPuqmwn
         OdAtwJB2Uao3bdrrcoWfl9JkmlO9fGPwrx5qxu0CZS2hG75k6xoBM8Y3ohoCLMR75I0w
         czjbe8Vf8jo1vhDvRPfUen5AgexRUCpWPxJAAxDO8z/2z7OHCsXLrYRYKKAU6wkw3x6s
         gNmF9Pl67tHSvUwmaXUgEZVgNlGNM9uKqrdfoHe29uKTC9f8W08xars1ajwAZcjM2BNo
         fZKBePwzmiMrfKYmXmLJosrKAvuN3oidiCUP5QPWJKWmlUt/SFNdnTuOqph0e+xthDgq
         gj+w==
X-Gm-Message-State: AOAM533lQIL1DCr81LqUoO5ky+TJdqhH0QlXprcPsDfKQgdD25qjPjry
        4lR7j9ZtxALxa6UtgIUrGXcUwQ0GAFHhYg==
X-Google-Smtp-Source: ABdhPJxQ0knWx7kTYkmJnJu1daPGc6TIXMZ3nrYMQZm80pXB/PD9j/aGx7F9BT9zL7U/XH+1hJ8h1Q32IIUzdw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:c394:: with SMTP id
 h20mr5396455pjt.103.1640111136643; Tue, 21 Dec 2021 10:25:36 -0800 (PST)
Date:   Tue, 21 Dec 2021 10:25:34 -0800
In-Reply-To: <xmqq1r26sazc.fsf@gitster.g>
Message-Id: <kl6l35mlzug1.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com> <a5265e1c7f4dc1a69e85511d2cc3f659cc46788f.1640039978.git.steadmon@google.com>
 <xmqq1r26sazc.fsf@gitster.g>
Subject: Re: [PATCH v8 1/3] branch: accept multiple upstream branches for tracking
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +/**
>> + * Install upstream tracking configuration for a branch; specifically, add
>> + * `branch.<name>.remote` and `branch.<name>.merge` entries.
>> + *
>> + * `flag` contains integer flags for options; currently only
>> + * BRANCH_CONFIG_VERBOSE is checked.
>> + *
>> + * `local` is the name of the branch whose configuration we're installing.
>> + *
>> + * `origin` is the name of the remote owning the upstream branches. NULL means
>> + * the upstream branches are local to this repo.
>> + *
>> + * `remotes` is a list of refs that are upstream of local
>> + */
>> +static int install_branch_config_multiple_remotes(int flag, const char *local,
>> +		const char *origin, struct string_list *remotes)
>>  {
>>  	const char *shortname = NULL;
>>  	struct strbuf key = STRBUF_INIT;
>> +	struct string_list_item *item;
>>  	int rebasing = should_setup_rebase(origin);
>>  
>> +	if (!remotes->nr)
>> +		BUG("must provide at least one remote for branch config");
>> +	if (rebasing && remotes->nr > 1)
>> +		die(_("cannot inherit upstream tracking configuration of "
>> +		      "multiple refs when rebasing is requested"));
>> +
>> +	/*
>> +	 * If the new branch is trying to track itself, something has gone
>> +	 * wrong. Warn the user and don't proceed any further.
>> +	 */
>> +	if (!origin)
>> +		for_each_string_list_item(item, remotes)
>> +			if (skip_prefix(item->string, "refs/heads/", &shortname)
>> +			    && !strcmp(local, shortname)) {
>> +				warning(_("not setting branch '%s' as its own upstream."),
>> +					local);
>> +				return 0;
>> +			}
>
> Added comments make it easier to follow what is going on and more
> importantly why.  I very much like it ;-)

Agreed! We made a lot of 'why' decisions and I think the comments do a
great job of capturing that.

>> @@ -87,29 +117,40 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>>  	strbuf_release(&key);
>>  
>>  	if (flag & BRANCH_CONFIG_VERBOSE) {
>> +		struct strbuf tmp_ref_name = STRBUF_INIT;
>> +		struct string_list friendly_ref_names = STRING_LIST_INIT_DUP;
>> +
>> +		for_each_string_list_item(item, remotes) {
>> +			shortname = item->string;
>> +			skip_prefix(shortname, "refs/heads/", &shortname);
>> +			if (origin) {
>> +				strbuf_addf(&tmp_ref_name, "%s/%s",
>> +					    origin, shortname);
>> +				string_list_append_nodup(
>> +					&friendly_ref_names,
>> +					strbuf_detach(&tmp_ref_name, NULL));
>> +			} else {
>> +				string_list_append(
>> +					&friendly_ref_names, shortname);
>> +			}
>> +		}
>> +
>> +		if (remotes->nr == 1) {
>> +			/*
>> +			 * Rebasing is only allowed in the case of a single
>> +			 * upstream branch.
>> +			 */
>
> There does not seem to be any code to forbid "rebasing" when
> remotes->nr != 1, though.  Did I miss a call to die() earlier?

The die() call happens in install_branch_config_multiple_remotes(),
where it belongs.

I think someone who reads this comment will eventually track down the
die() call, but it does look a little out of place. Purely as a matter
of personal taste, I would have expected this comment to be in the
'else' clause, and it might read something like:

  install_branch_config_multiple_remotes() does not allow rebasing with
  multiple upstream branches.

but that's just a suggestion :) This patch looks fine to me.

>
>> +			printf_ln(rebasing ?
>> +				_("branch '%s' set up to track '%s' by rebasing.") :
>> +				_("branch '%s' set up to track '%s'."),
>> +				local, friendly_ref_names.items[0].string);
>>  		} else {
>> +			printf_ln(_("branch '%s' set up to track:"), local);
>> +			for_each_string_list_item(item, &friendly_ref_names)
>> +				printf_ln("  %s", item->string);
>
> In other words, I would have expected something in this else clause.
>
>>  		}
>
> Thanks.
