Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9BDC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 14:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12BB218AC
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 14:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9BbdWKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLRO1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:27:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33480 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLRO1A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 09:27:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so4773095wmd.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BmO9/qV/RLc6UCPQTkhCSHRLWyCzqs8uB15KDkTTDVY=;
        b=m9BbdWKhj1+YtBePjB7qgyQcGHCXTHQ1Gjt1Y7Db5GDE0dBwtNGnwBi6oqe7/PSVAk
         zrIWrcuSbP9PO29WKHB3qutmHf2xY/gcfOWQVicKQjseGYPTKjQUkB9sPCAAToID4AXc
         hr2836UqOAjMjbNqR4qZ8R5/JXANdIATwgwr1VsV+gXQ6+WUQ7GxyqKm4HbwyIWbtUNW
         o3HolnXsQEguKYl+U9idD1PRZzGvBvFmsoLKfY04FunB//Lyz21s+gmV8AlEVXnroLOM
         UR4WkKQp8G2FUwIoPZnK+o9zP4qEKSrCjNI8xHRWkqTlF8FR09MG69Y9vQQJfbt7v0lf
         y1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BmO9/qV/RLc6UCPQTkhCSHRLWyCzqs8uB15KDkTTDVY=;
        b=P9UprXcqPNZFjgy1EsUXlg9m+Uu9/a0MAmEowS/0FeNHHi0lCbQQXJDZ5rewhcvQPp
         wner9KVnJ0QB0/Pr/K04CTdOd37HwsSnKbguiEM3BAVA5MKHJdRWr8SeBrQLD5WMiSEE
         qMHiiw/+WiHwPPSSSi0UkEDOyAbDjF6/As9Yq0u5tnlbamfnU12ZhR5iojK2reZ5YNm/
         9v594nmvjFosPLVNc0LW+2M09hoTWc8kLFpzVL1fKKNL1wveU2wid7gfoVKqyrjCqWt9
         7nZ1LVAT57d9+QjlX1FaYjOqIYsIi3nBs3x9qPlfnueU911NDfAC4OEQYHzm5UR3hJL6
         QBMA==
X-Gm-Message-State: APjAAAWWpTICAyP2P4y73sJnKVJma+9VNyLsGSI52sQl1PrX2p/v6kq+
        IHPfrQB8m70wQP6pVEfbHW0=
X-Google-Smtp-Source: APXvYqzAwq7IQsgGEE2zNA62d2mOpWkekY7MuDCrDRHHT1jzJFFfeCdftKHW4A6dfom85M7nk+W0EQ==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr3708156wmj.33.1576679217981;
        Wed, 18 Dec 2019 06:26:57 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id r15sm2561819wmh.21.2019.12.18.06.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 06:26:57 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 6/9] commit: encapsulate determine_whence() for
 sequencer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com>
 <20191206160614.631724-7-phillip.wood123@gmail.com>
 <xmqqwob9wbwe.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <141f95b0-cae0-06f6-2c29-618dc22ae000@gmail.com>
Date:   Wed, 18 Dec 2019 14:26:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqwob9wbwe.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12/2019 18:24, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Working out which command wants to create a commit requires detailed
>> knowledge of the sequencer internals and that knowledge is going to
>> increase in subsequent commits. With that in mind lets encapsulate that
>> knowledge in sequencer.c rather than spreading it into builtin/commit.c.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   builtin/commit.c |  5 +----
>>   sequencer.c      | 13 ++++++++++++-
>>   sequencer.h      |  3 ++-
>>   3 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 3b463522be..d8d4c8e419 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -178,10 +178,7 @@ static void determine_whence(struct wt_status *s)
>>   {
>>   	if (file_exists(git_path_merge_head(the_repository)))
>>   		whence = FROM_MERGE;
>> -	else if (file_exists(git_path_cherry_pick_head(the_repository)))
>> -		whence = file_exists(git_path_seq_dir()) ?
>> -			FROM_CHERRY_PICK_MULTI : FROM_CHERRY_PICK_SINGLE;
>> -	else
>> +	else if (!sequencer_determine_whence(the_repository, &whence))
>>   		whence = FROM_COMMIT;
>>   	if (s)
>>   		s->whence = whence;
>> diff --git a/sequencer.c b/sequencer.c
>> index 4e0370277b..98e007556c 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -40,7 +40,7 @@ static const char cherry_picked_prefix[] = "(cherry picked from commit ";
>>   
>>   GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
>>   
>> -GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
>> +static GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
>>   
>>   static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
>>   static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
>> @@ -5256,3 +5256,14 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>>   
>>   	return 0;
>>   }
>> +
>> +int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
>> +{
>> +	if (file_exists(git_path_cherry_pick_head(r))) {
>> +		*whence = file_exists(git_path_seq_dir()) ?
>> +			FROM_CHERRY_PICK_MULTI : FROM_CHERRY_PICK_SINGLE;
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> I am not sure if this is a good move---determine_whence() that can
> tell not just we are in the middle of cherry-pick (either a single
> or multi) but also during a merge may be at the right abstraction
> level.  Why would we want to invent a separate function that says "I
> dunno" during a merge, instead of moving the logic for merge to the
> new helper as well?  The original determine_whence that takes
> wt_status and populates it still has to call the new helper either
> way.  Also for the matter FROM_COMMIT may also want to be part of
> the helper.  This all depends on the new callers you plan to invent,
> of course.

The idea was for determine_whence() to be able to delegate to the 
sequencer to ask if it is doing something without having to expose all 
the implementation details of that check in builtin/commit.c. It is 
simple enough at this stage but the next patches add more complexity 
which would mean exposing various sequencer state files to 
builtin/commit.c. This function is only meant to be called from 
determine_whence() - callers that want to know if any operations (merge, 
cherry-pick etc.) are in progress should be calling that not the 
function added here.

> Not part of this topic, but the call to file_exists() may want to
> become a call to dir_exists() as git-path-seq-dir is clearly a
> directory and cannot be a file, right?

Yes

Best Wishes

Phillip
