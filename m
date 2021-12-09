Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574B8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 21:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhLIWB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhLIWBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:01:25 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC753C0617A2
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 13:57:51 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id jo4-20020a056214500400b003a5cb094fb8so11431572qvb.22
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 13:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NBh+/tuN0tOVDxSNHUCuZ5BvaWub57WlX8HEpvAB3v0=;
        b=a1IpQtibQTBGtLj5KbZRV1QmF9EZUCRgnVYDL0AVqZkwpg6oOnEbdtm2U/C8W67AeB
         etzubvhNF0cuFPgY7rBQ55dDcHonrmMoWbNzWwDGcRQv8u4ZlbEaI2JdD6k266CIUU+j
         R/o8zEXedUZHiUQoxITAcybnDuSJgraONW+ireMIU37hAlOTyHkRP90dz4Op1KiKijS5
         FLJ3WKe2xusLJbh2rEI//N6wiqHP6aR+1HglPHZgZCzrFLxcMq73LcaDn6OVeKOVsPyt
         NzGzs+M+eG4dDf0/GfDMJQYBQ6IrSapfOuHzNEuIX/ih2y5A6old5enNBJR/448zg9vF
         4OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NBh+/tuN0tOVDxSNHUCuZ5BvaWub57WlX8HEpvAB3v0=;
        b=k7F99TLGFSQXj/HOX01oFUbY9EeVwhvQR0JLOBPuqOTyPe9JRyuEojcQyFLOCf+c9G
         fF1YW/+tecj3gsVLha83Qt8CG0stBsZGiUzQFifvQHI/a+84irsgy5huE1huF38xitY7
         yuC25FsAELHN5fWs2RQvpY2h3eBTRJ4BGbwTrVysH9Q2uTPHEhLrKGwE0oc4AQuUWwbD
         95XlD2ygSETa9+ANshbUMgDhRsbW7XBktVNJ7Uy6y3OydAW27fxzYmn3Iw72Ni5eaWLX
         CQ2lMgMYTEKbNkGwKfmdR3v8aT5gokHQoWGe34EtQ/JMRc1r6QX8dW2TYRbspm4ded3t
         l5eA==
X-Gm-Message-State: AOAM533nBWG4RZgpkLe6VGj7w19/Y7RRzxKN+Bgzde8kTN+3OZryG3l+
        lAruibSuVEj5Af0NAjvqG1KruDqE//Ea2g==
X-Google-Smtp-Source: ABdhPJxxA6vZ+br5gpxlgpExz/+y3lRqj3QBifWw9BEFMlM0qH+bYqvl0jA0OXth+ZNT0Zw+EcNsy1ju3oyy0w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:ac8:5841:: with SMTP id
 h1mr21470705qth.517.1639087071026; Thu, 09 Dec 2021 13:57:51 -0800 (PST)
Date:   Thu, 09 Dec 2021 13:57:49 -0800
In-Reply-To: <20211209212322.499217-1-jonathantanmy@google.com>
Message-Id: <kl6lk0gda1b6.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211209184928.71413-4-chooglen@google.com> <20211209212322.499217-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/5] builtin/branch: clean up action-picking logic in cmd_branch()
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Incidentally, fix an incorrect usage string that combined the 'list'
>> usage of git branch (-l) with the 'create' usage; this string has been
>> incorrect since its inception, a8dfd5eac4 (Make builtin-branch.c use
>> parse_options., 2007-10-07).
>
> I think that we implement such incidental fixes only when we're touching
> the relevant lines, but this change looks correct.

That's fair. This fix is such low-hanging fruit that I don't think it
deserves its patch, but if others agree, I'll separate it.

>
>> -	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
>> -	int show_current = 0;
>> -	int reflog = 0, edit_description = 0;
>> -	int quiet = 0, unset_upstream = 0;
>> +	/* possible actions */
>> +	int delete = 0, rename = 0, copy = 0, force = 0, list = 0,
>> +	    unset_upstream = 0, show_current = 0, edit_description = 0;
>> +	int noncreate_actions = 0;
>> +	/* possible options */
>> +	int reflog = 0, quiet = 0, icase = 0;
>
> [snip]
>
>> -	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
>> -	    list + edit_description + unset_upstream > 1)
>> +	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
>> +			    !!show_current + !!list + !!edit_description +
>> +			    !!unset_upstream;
>> +	if (noncreate_actions > 1)
>>  		usage_with_options(builtin_branch_usage, options);
>
> Overall this change looks good, although if you're going to rearrange
> the variable declarations (e.g. the positions of show_current,
> edit_description, and unset_upstream have moved), you might as well make
> them consistent with the noncreate_actions statement, I guess. Also
> maybe move new_upstream closer.

Yeah this is obviously inconsistent, thanks for the catch.

* force isn't an action
* new_upstream is an action
* for QoL, all of the actions should be listed in the same order at both
  sites
