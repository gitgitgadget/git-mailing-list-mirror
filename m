Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB830C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 14:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiBOOvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:51:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiBOOun (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 09:50:43 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86812CC29
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 06:48:47 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso23485358oop.0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 06:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lm5KlCR+mtpCUfL+R6RkuokxTeZHpfplAznG06ZNNH0=;
        b=a/MgEVhQLGC0uraq/wfIZeys3IdWBv0JRqievte/4VadhrKBByLWxUhafcCV2/GGVc
         iaASTFvetb7Mn4dqMSwhpqE+xRaTlnFaeA/9jXGT4BCzdCebT9TBlWqroh90SxCtEnmI
         LKfbfgppRVTYojDN0vTTuNItkKjasqAOWEQXBaihVO9rm7dFBpBGxi1aJmyS3k6PuLx4
         37184A7AE1Z4W+aBUE+XbTkW6O2dqvaOel18DTtemIkrGhgB0hEQQyPbnc/igTZR/P0w
         zFSetd0aSkBGpLczOpyLzXelnm3S7FwrtpzGtRKo4kszCEWD8A47vqe+U4Q4Mta057qQ
         1gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lm5KlCR+mtpCUfL+R6RkuokxTeZHpfplAznG06ZNNH0=;
        b=G3HHzS8+7tEkWUNTOIJLQi/mX39rGSqtLb7pG1Ahn0uvIRTKZd0x0zAryo7QMo95vW
         0aIM/leomblubdxigry3hTtgkxN5AG/b+9LvA38FH1e9OCqBpZxliFzlhUkn6kScE+mW
         lIPt87cJPwNPEuwCMDgCblNLpWo910iCouirYPietAKjwBWx+5+9/TUoqzWrypP+kAYf
         pHaxzzBEi9eY68/e3JqHFYDDcdaMLk+yAJQI7TpMg7sjEbIvu/npCPtb+3I+idhvWIrZ
         zLfw6x/vkrwD9Qh2WfbtNcvV/9b2+vh3Lt2k3JPOcS1mxKjceVut0y5/1FRNLGvyRQNI
         +6/Q==
X-Gm-Message-State: AOAM5300D+q0cudAJQmDDc9BDextTwJPsTsa7+iywnY4jk+ZxM0D8x5j
        ZFn84mGWpyCgF4KLgDRAHwN9
X-Google-Smtp-Source: ABdhPJz1MxK++JyhLBfqaPFaPm5YrnobOadP7EAAIBCBNTeq0jxBWXAVJLEnL8li14oyGPG6oYFG1g==
X-Received: by 2002:a05:6870:a603:: with SMTP id e3mr1532435oam.87.1644936520348;
        Tue, 15 Feb 2022 06:48:40 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a8sm14003296otj.47.2022.02.15.06.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:48:40 -0800 (PST)
Message-ID: <42d2a9fe-a3f2-f841-dcd1-27a0440521b6@github.com>
Date:   Tue, 15 Feb 2022 09:48:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] name-rev: test showing failure with non-monotonic commit
 dates
Content-Language: en-US
To:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
References: <20220214210136.1532574-1-jacob.e.keller@intel.com>
 <xmqqr18515jr.fsf@gitster.g>
 <CA+P7+xrN0zPWfxO1roWzR+MBHntTv8jr9OGdNcN9RPA=ebK24A@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CA+P7+xrN0zPWfxO1roWzR+MBHntTv8jr9OGdNcN9RPA=ebK24A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/2022 5:07 PM, Jacob Keller wrote:
> On Mon, Feb 14, 2022 at 1:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>>> From: Jacob Keller <jacob.keller@gmail.com>
>>>
>>> If a commit in a sequence of linear history has a non-monotonically
>>> increasing commit timestamp, git name-rev will not properly name the
>>> commit.
>>>
>>> However, if you use --annotate-stdin then the commit does actually get
>>> picked up and named properly.
>>
>> IIRC, this is to be expected.
>>
> 
> Right. I figured this is somehow expected behavior...
> 
>> When preparing to answer --annotate-stdin request, the command has
>> to dig down to the root of the history, which would be too expensive
>> in some repositories and wants to stop traversal early when it knows
>> particular commits it needs to describe.
>>
> 
> And this method of cutting the search relies on monotonic commit times right?
> 
> Is there any other method we could use (commit graph?) or perhaps to
> add an option so that you could go "git name-rev --no-cutoff <commid
> id>"? That would potentially allow working around this particular
> problem on repositories where its known to be problematic.

I initially thought that generation numbers could help. The usual way
is to use a priority queue that explores by generation, not commit
date. This approach was immediately stifled by these lines:

	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
	prio_queue_put(&queue, start_commit);

So the queue is really a stack.
 
> Alternatively is there some other way to apply the cutoff heuristic
> only in some cases? I get the sense this is intended to allow cutting
> off merged branches? i.e. not applying it when history is linear? I'd
> have to study it further but the existing algorithm seems to break
> because as it goes up the history it has found an "older" commit, so
> it stops trying to blame that line...?

It is still possible that the cutoff could be altered to use generation
numbers instead of commit dates, but I haven't looked closely enough to
be sure.

Here is a very basic attempt. With GIT_TEST_COMMIT_GRAPH=1, your
test_expect_failure turns into a success.

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 138e3c30a2b..f7ad1dd8b4d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -9,6 +9,7 @@
 #include "prio-queue.h"
 #include "hash-lookup.h"
 #include "commit-slab.h"
+#include "commit-graph.h"
 
 /*
  * One day.  See the 'name a rev shortly after epoch' test in t6120 when
@@ -27,6 +28,7 @@ struct rev_name {
 define_commit_slab(commit_rev_name, struct rev_name);
 
 static timestamp_t cutoff = TIME_MAX;
+static timestamp_t generation_cutoff = 0;
 static struct commit_rev_name rev_names;
 
 /* How many generations are maximally preferred over _one_ merge traversal? */
@@ -151,7 +153,10 @@ static void name_rev(struct commit *start_commit,
 	struct rev_name *start_name;
 
 	parse_commit(start_commit);
-	if (start_commit->date < cutoff)
+	if (generation_cutoff && generation_cutoff < GENERATION_NUMBER_INFINITY) {
+		if (commit_graph_generation(start_commit) < generation_cutoff)
+			return;
+	} else if (start_commit->date < cutoff)
 		return;
 
 	start_name = create_or_update_name(start_commit, taggerdate, 0, 0,
@@ -599,6 +604,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		if (commit) {
 			if (cutoff > commit->date)
 				cutoff = commit->date;
+			if (generation_cutoff > commit_graph_generation(commit))
+				generation_cutoff = commit_graph_generation(commit);
 		}
 
 		if (peel_tag) {

Thanks,
-Stolee
