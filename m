Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E16C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 21:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245705AbiCJVaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244630AbiCJVai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 16:30:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B61D17FD06
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 13:29:36 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id lt6-20020a17090b354600b001bf5a121802so3990659pjb.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 13:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hGKo3WZzozpbOW35fFSSOLa3cf2vsp9NbGHxJXVXT/0=;
        b=mq9c201/sufT4eCs+z0CQpblIqBC7HjCj3nltLF4cUzmrSMzDHC1CRy/XcEbzO3dlI
         m0H9V3FjeCbXFJLvkqjKw0z4YXoL2sz1ObHPGI4JnSU/iMnH7sM90vtBpxBLZ7F6vzvK
         7dBX+psk0xsK0ka01qeaV+QF00xfFFSS0VOmDpkgKvQ/3MEWsp+DU3ExiO0ILtMQp3CB
         wNAiEO+OIeoO0HfEzqz316Vt4FVOGNsQOehQgxj/kHJtwklgI7y99pES7dbOJF+u2vPN
         yBLGzKNpMc8zBT1DiFgJRi103VeQ4xF6kDq3wsJVq/lssHXrjS6MkgV2lV+LBE6rRwIv
         +1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hGKo3WZzozpbOW35fFSSOLa3cf2vsp9NbGHxJXVXT/0=;
        b=dWYLXL5XlCAxx+AjcrpZIkgm/2P1h+jzu4cr9aDUKzneqD38mjhEetCS3DscoFjcH8
         oYQdfoGl3mr18DpKMydO7yYiW1qIxlS6SnIxyZgUsHx4/d3MCgj4fPzsXhhRNMQGg/sJ
         6Q4XiyQEhirHWZyTaMqQUebPhJlzFWkxZK7F9beA9lq7HK3/eakllJfZSzNrm4zveUgK
         zahCldChAz5UNnQV0iSJYXoWccgHy/Rk0p98UjrJecCR9O4hqKcgUmgi29hvASKCCK8/
         VpR00PzIvfm2FN2Y24AGw1KCQBaA2KKx35pLyFwjuytqkD0b2qW0wi9Jd72l1jitdPJV
         0eUg==
X-Gm-Message-State: AOAM532MTwQF2s5DmdCn5StbEWOi+WFJOO4uR4XLHoIUyXLjpSPZuHyZ
        Fa2ITJ/GIK9aprmfoc39lqaJ02SA6jYTRA==
X-Google-Smtp-Source: ABdhPJxZNDJf2ERUzg3xbwXEEjAnYFZqRYLviGny3DZQvn4BlvIu3RhR5i1Aj41gWQDDLnz2FEQtlCcLKEN7Zg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:cccc:b0:14e:e89c:c669 with SMTP
 id z12-20020a170902cccc00b0014ee89cc669mr7133903ple.58.1646947776077; Thu, 10
 Mar 2022 13:29:36 -0800 (PST)
Date:   Thu, 10 Mar 2022 13:29:25 -0800
In-Reply-To: <xmqqtuc6h83m.fsf@gitster.g>
Message-Id: <kl6lczitsdhm.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220310004423.2627181-1-emilyshaffer@google.com>
 <20220310004423.2627181-3-emilyshaffer@google.com> <xmqqtuc6h83m.fsf@gitster.g>
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>> @@ -2617,6 +2622,12 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
>>  
>>  	free(prefixed_path);
>>  
>> +	/*
>> +	 * This entry point is always called from a submodule, so this is a
>> +	 * good place to set a hint that this repo is a submodule.
>> +	 */
>> +	git_config_set("submodule.hasSuperproject", "true");
>> +
>>  	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
>>  		return do_run_update_procedure(&update_data);
>
> In Glen's update to rewrite "submodule update" in C, this part is
> replaced with a call to update_submodule2().  I am not sure what the
> current repository is at this point of the code with and without
> Glen's topic, but are we sure we are in a submodule we discovered?

With my topic, this call would be moved into update_submodule2(). The
repository at that point is the superproject.

> builtin/submodule--helper.c::run_update_procedure() takes sm_path to
> the path to the submodule, presumably from superproject's point of
> view, and the callchain leads to a call to run_update_command()
> eventually, which uses run_command_v_opt_cd_env() to go in to the
> submodule repository and run an external git command (like
> "checkout"), so it looks like what git_config_set() updates is the
> superprojects' configuration, not the configuration of a particular
> submodule being updated.
>
> The other one, where cmd_clone() sets the variable in submodule's
> configuration file, looks good, but I am not sure about this one.

But in this series, the current repository is the submodule because this
part happens in a "run-update-procedure" child process.

So there is a slight conflict here, but the conflict existed even before
this change (we used to do this twice in git-submodule.sh and
module_clone()).

Because of that conflict, I was planning to base "part2" on this series
anyway, and if anything, this change makes the conflict better because
we now set "submodule.hasSuperproject" in only one place
(run_update_procedure()) instead of two.

So I think this change improves this series and improves the interaction
with mine.
