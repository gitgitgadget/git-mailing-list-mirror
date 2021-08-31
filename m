Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC8C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBCF6103D
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhHaOXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHaOXv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 10:23:51 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2473C061760
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:22:56 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c79so24529225oib.11
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7vPW+cmTMboN5Li2JJNrkWuC5oEmsV+ebThGx7N+1Fw=;
        b=j1ZGbqQg98DiGbOdpDt4FQZh4D7tzw6OBLnrFNkvoGbfxlh/2gj0c97JVyfjhl6z3G
         2kOyHx5dBfQ10d+ZjLzMSB1gLJsq0A11ohP2tpOpqkKJ32P1myNW2MOo8Z5+pip+93yo
         o9qbEUG1MK6ucqie0wIwuWpaxJdVAjvLVvFcKgCXIhlluImqXvy5sDgfImQ2AtiIqozS
         4W93/x7eNDbXQ1B5yxyktRGJfg8ComnXeF2UAnBYR6JdjM24WUb1Xgfox/Jz6f+ngXD/
         uh/7ZgVmdpu+7N4nqH7EL8pbDjE5IJXfQwGSflHjL8954yvaqR4B+rJyc0/77WmXm6/5
         cJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7vPW+cmTMboN5Li2JJNrkWuC5oEmsV+ebThGx7N+1Fw=;
        b=cuHap0bOJqENaANiy8/e3ETv2a8O+yBImT+9xlDBRDbBUuxWQvXZ8LMG/xjss2iKvE
         qSYlyxtH52HlkfxJwXeVbij+eBsWYaulbpbOASzOW6f5RA1XCIk3/Tjo9n5e9Rbp9gva
         nfzovZ2VfmgdrZ2yJ0qGY0n8iObxFqvNWGUXGuJhcnzeRgWxxHQHOSG6SrG4mREMMYyt
         d4yXhF2Z9DvqLCDNcFXAzz1+6OFZWXo3p4zyI5Fd/Fahv7C6VgPDB+cHhXRCnhKK7P0R
         fU87qbGAZN7XQVSh7wUOZZk9oCJ1c+f/+TJfyYCxr6CpDyBJRYrSXFr7cNeE3UhROPq/
         MTiw==
X-Gm-Message-State: AOAM532AzDoTyHIXtroiiyRqyxFDueJvRVAeyu6+ySp9oY2I9J1F42xx
        vFaqjM3Mqs4nrqN63sExxdQ=
X-Google-Smtp-Source: ABdhPJz/rri0J8OW7i6PKotl7lfyrp9m3FypXF0UdgU/TtZ9raDePDwrgJk8laGsNQeB5CEosj8HWg==
X-Received: by 2002:aca:be56:: with SMTP id o83mr3274620oif.51.1630419775710;
        Tue, 31 Aug 2021 07:22:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7821:7d0e:d840:aa7e? ([2600:1700:e72:80a0:7821:7d0e:d840:aa7e])
        by smtp.gmail.com with ESMTPSA id v16sm3573084oou.45.2021.08.31.07.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:22:55 -0700 (PDT)
Subject: Re: [PATCH 04/15] scalar: 'register' sets recommended config and
 starts maintenance
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <3786f4c597fffc13f638efd26875dcb257d54ab4.1630359290.git.gitgitgadget@gmail.com>
 <87fsuqxc6l.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3e443075-2d69-9ab9-3d22-915f4f19d22b@gmail.com>
Date:   Tue, 31 Aug 2021 10:22:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87fsuqxc6l.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/31/2021 4:11 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Aug 30 2021, Derrick Stolee via GitGitGadget wrote:
> 
>> [...]
>> +#ifndef WIN32
>> +		{ "core.untrackedCache", "true" },
>> +#else
>> +		/*
>> +		 * Unfortunately, Scalar's Functional Tests demonstrated
>> +		 * that the untracked cache feature is unreliable on Windows
>> +		 * (which is a bummer because that platform would benefit the
>> +		 * most from it). For some reason, freshly created files seem
>> +		 * not to update the directory's `lastModified` time
>> +		 * immediately, but the untracked cache would need to rely on
>> +		 * that.
>> +		 *
>> +		 * Therefore, with a sad heart, we disable this very useful
>> +		 * feature on Windows.
>> +		 */
>> +		{ "core.untrackedCache", "false" },
>> +#endif
>> [...]
> 
> Ok, but why the need to set it to "false" explicitly? Does it need to be
> so opinionated as to overwrite existing user-set config in these cases?

Users can overwrite this local config value, but this is placed to avoid
a global config value from applying specifically within Scalar-created
repos.
 
>> +		{ "core.bare", "false" },
> 
> Shouldn't this be set by "git init" already?

This one is probably a bit _too_ defensive. It can be removed.

>> [...]
>> +		{ "core.logAllRefUpdates", "true" },
> 
> An opinionated thing unrelated to performance?

It's an opinionated thing related to supporting monorepo users. It helps
us diagnose issues they have by recreating a sequence of events.

>> [...]
>> +		{ "feature.manyFiles", "false" },
>> +		{ "feature.experimental", "false" },
> 
> Ditto the question about the need to set this, these are false by
> default, right?

But if a user has them on globally, then we don't want them to apply
locally (in favor of the settings that we set explicitly).

>> [...]
>> +		if (git_config_get_string(config[i].key, &value)) {
>> +			trace2_data_string("scalar", the_repository, config[i].key, "created");
>> +			if (git_config_set_gently(config[i].key,
>> +						  config[i].value) < 0)
>> +				return error(_("could not configure %s=%s"),
>> +					     config[i].key, config[i].value);
>> +		} else {
>> +			trace2_data_string("scalar", the_repository, config[i].key, "exists");
>> +			free(value);
>> +		}
> 
> The commit message doesn't discuss these trace2 additions, these in
> particular seem like they might be useful, but better done as as some
> more general trace2 intergration in config.c, i.e. if the functions
> being called here did the same logging on config set/get.

If we want to do such a tracing change within git_config_set*(), then
that would be an appropriate replacement. The biggest reason to include
them here is to trace that an existing value already exists, for the
case of running 'scalar reconfigure' during an upgrade. That part
doesn't make much sense to put into config.c.

Thanks,
-Stolee
