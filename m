Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185ABC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 14:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BC521835
	for <git@archiver.kernel.org>; Sat,  2 May 2020 14:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DINPdS1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgEBOVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgEBOVw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 10:21:52 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3DEC061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 07:21:52 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b18so7023393ilf.2
        for <git@vger.kernel.org>; Sat, 02 May 2020 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gWSho84HNO68t2V9QdrwKDJ+avEQrcTY4k7ard8Z/QM=;
        b=DINPdS1kKAZP6prSX3aeYyJ5dMrqy1sSSL6XSDNMbzO7gRZGhlbbUoS+vCoUOmqreZ
         q9SONCRPMsAroSkoUcTJtwLG20AjzN2u4OxVia3xg/Ofbg0RQTl1sPgy4SwUIig+/Lhh
         bLlGiAOXgdo4IDiu5/GXNWTL4NG/soy0ignyEOe+2ie4IiCQImqLRlVpsK9w/3QWD0qq
         nDNi3ImZ5urVJtLvOzFmqYhxa67BijW5rpHNHRJXImvQ8eoOjGKn6pWgJy0DGuT4JNln
         hHoyDeVZElPR/YDwzAArp20e5zOgvkAYNaLgd58dvOV+LLBaA70ZJoF8vANaS1JwV83C
         Dzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gWSho84HNO68t2V9QdrwKDJ+avEQrcTY4k7ard8Z/QM=;
        b=lwUzEKWtXdn9r+EqmlK+s0Pa0pnYVXQ/bmENRyyg27ja+0+dblO0z6jViC41T9ocPM
         AL3RMsi8kLZt8noxFBbkJUlG4uySpvo9MKvC9nhg1uHGwSrqAM93eSgBO/lJB1DbgEZh
         xvfzxVsZEmji8boaqYFRUJU1E0SPIw0oEeabu8ixOTyiCFt8p4lsgZ7V7PibgYQm/+6d
         CX2TKmVyNy7MKjaYF9KA9zyg2f1OhGx8bLXpfkXpqXEUepBOmLt3YaroLRo6hiwyaNks
         AwHO1yheQCNUvnp9Rk9fpI339SB53k7yXGitQhEEMTwX/fdtLenrnrDkuOCkpRNSyOCM
         uj4w==
X-Gm-Message-State: AGi0PuYbzz/OGElBPneuJRCNNDfkUbR8dRwdkNUadEvPidnNHMew7Rkk
        glv91+caT8WFh8hEjwZF3HDONPLHn/Q=
X-Google-Smtp-Source: APiQypIg7yjN5NlBEGEK2BTo/QvXIo1kUiIbN7prSMg1z7bswfV2vkWHXlwLp9LbNugy8wqK5CWzqg==
X-Received: by 2002:a92:5211:: with SMTP id g17mr8193313ilb.220.1588429311578;
        Sat, 02 May 2020 07:21:51 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:886f:d51d:fbf5:59b6? ([2601:8c0:37f:6012:886f:d51d:fbf5:59b6])
        by smtp.gmail.com with ESMTPSA id n4sm2490851ilh.83.2020.05.02.07.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 07:21:51 -0700 (PDT)
Subject: Re: [PATCH 2/3 v3] Teach git-rev-list --ignore-merge-bases
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
 <1716d20d-6f0d-3872-cf36-6fc8d7bdb457@gmail.com>
 <37b157a3-f2d6-f459-2f2c-2ab53ba2f7ac@kdbg.org>
From:   Antonio Russo <antonio.e.russo@gmail.com>
Message-ID: <e14bbff1-e77a-f346-aa33-5d4ea1bccdb8@gmail.com>
Date:   Sat, 2 May 2020 08:21:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <37b157a3-f2d6-f459-2f2c-2ab53ba2f7ac@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/2/20 7:25 AM, Johannes Sixt wrote:
> Am 01.05.20 um 16:22 schrieb Antonio Russo:
>> +--ignore-merge-bases::
>> +	Show commits that are introduced by each merge before showing
>> +	the first parent of the merge but remove edges from those commits
>> +	to commits reachable from the first parent. When used with
>> +	`--graph`, this can help visualize repositories with many merges
>> +	when you are not interested in the merge base used for each
>> +	merge. It also reduces the width of the graph visualization
>> +	when used with `--graph`.
> 
> I wonder whether there is some potential to prettify another aspect of
> --graph once this feature is in place: In particular, when I *am*
> interested in merge-bases, I use --boundary, and I get this chart:
> 
> $ git log --graph --boundary --oneline --no-decorate 7d28d69174~4..7d28d69174
> 
> *   7d28d69174 Merge branch 'jc/allow-strlen-substitution-in-shell-scripts'
> |\  
> | * 78725ebda9 CodingGuidelines: allow ${#posix} == strlen($posix)
> * |   dfdce31ce6 Merge branch 'en/pull-do-not-rebase-after-fast-forwarding'
> |\ \  
> | * | fbae70ddc6 pull: avoid running both merge and rebase
> | |/  
> * |   b660a76d0f Merge branch 'dl/wrapper-fix-indentation'
> |\ \  
> | * | 7cd54d37dc wrapper: indent with tabs
> * | |   3d6c56dd66 Merge branch 'ag/sequencer-i18n-messages'
> |\ \ \  
> | * | | 4d55d63bde sequencer: mark messages for translation
> | o | | 3bab5d5625 The second batch post 2.26 cycle
> |  / /  
> o / / 9f471e4b95 Merge branch 'rs/pull-options-sync-code-and-doc'
>  / /  
> o / 0b6806b9e4 xread, xwrite: limit size of IO to 8MB
>  /  
> o b6d4d82bd5 msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x
> 
> but I would prefer to see something like this:
> 
> *   7d28d69174 Merge branch 'jc/allow-strlen-substitution-in-shell-scripts'
> |\  
> | * 78725ebda9 CodingGuidelines: allow ${#posix} == strlen($posix)
> * |   dfdce31ce6 Merge branch 'en/pull-do-not-rebase-after-fast-forwarding'
> |\ \  
> | * | fbae70ddc6 pull: avoid running both merge and rebase
> | |/
> | o b6d4d82bd5 msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x  
> *   b660a76d0f Merge branch 'dl/wrapper-fix-indentation'
> |\  
> | * 7cd54d37dc wrapper: indent with tabs
> | o 0b6806b9e4 xread, xwrite: limit size of IO to 8MB
> *   3d6c56dd66 Merge branch 'ag/sequencer-i18n-messages'
> |\  
> | * 4d55d63bde sequencer: mark messages for translation
> | o 3bab5d5625 The second batch post 2.26 cycle
> o 9f471e4b95 Merge branch 'rs/pull-options-sync-code-and-doc'
> 
> Maybe that is just an easy fall-out?

Yeah, I noticed this too.  What we want is to create a spanning tree by left-first
DFS (amputating edges connecting to already visited vertices), and then walk the
amputated tree in a right-first DFS (and then not sort the commits any further).

The tricky part is getting the results of the right-first DFS before the left-first
(amputation) DFS finishes.  I'm working on it.

>> diff --git a/object.h b/object.h
>> index b22328b838..0bf6fb0d55 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -59,7 +59,7 @@ struct object_array {
>>
>>  /*
>>   * object flag allocation:
>> - * revision.h:               0---------10         15                   25----28
>> + * revision.h:               0---------10         15                   23----28
> 
> I think the intent is that the line is like a ruler with marks: you
> should move "23" sufficiently far to the left, because the "23" mark
> cannot be at the same spot where the "25" mark was.

I though this was only a schematic ruler, but, counting it now, it is exact.
I'll fix it.

> (I'm not reviewing this patch as I am illiterate when it comes to the
> revision walker, I just happened to notice this when I skimmed the
> patch.)

Thank you,
Antonio
