Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C38C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF78E20897
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc+eyF1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKRSaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgKRSaS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:30:18 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DAC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:30:18 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id ek7so1521091qvb.6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zWrkt3D1HXCFRRHBQasirjXrXIUYzPqwWPhJpHwI+TE=;
        b=Wc+eyF1G28tqqsz7aFWo4+W2CSRgLujHX6/wo7k73456RM+/IeroN8RZ8GWt0Ce4vl
         5wqDkTJkH2VPtxCWq83135BXRgu1Oi0CaLmHo7WOyk8n6XK/VdMgqhHh0v6SJ2fjbucs
         10mghQZCvjFzoyqkFSC8QC4+WcRfr0rNlVCDfyp+D0Ua7lyAXEl5QjIFRYe5ZExfZe44
         BfEYIHZsloaXviYUMGnDkjd81nuf9he6c1ZZVDSPs2NZiJn7mHk0S511ehTQZ/KWTwZd
         mmP0BXRgQ5FDaz9W9Rbr3OYzd5+3CEMXN43H5wficKzFiS0iLVscwYNc2iUR+UcPNoW4
         OkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zWrkt3D1HXCFRRHBQasirjXrXIUYzPqwWPhJpHwI+TE=;
        b=PjIFTRLH10gLspmcjzENPSnNH03jH0WAX7UefaOb2g9DBlIG2gzTdffFY1v7lmkuGw
         e/NLQKO4TdJ1rcR4aSrk0D5/c7RKvDtrgKVW9hbl3C06YlUloRNIrKXXArcmsOMvsL7M
         FMn3g6cVne5uuQmYtusbeYoHSFP4T5JgXiRuUXr8zykq0518DGkmFoHMLKlKjvBBYugC
         mF+Awx2KCFnLOipORLLe0gcThtqoakVXvkU8lUdB4oy8MaVt2NS8n0ZPQdkRxBduH0je
         vkO8yDzfIjndraLE30bvKbmRJjLpuaR2cF4At0YnDy295dwXIZUXKivQ9RJTHot6OE8l
         lIHA==
X-Gm-Message-State: AOAM531B/09E56XMoPUOPZ0DVN7R+3Xzk7c+heddLlWsAGZTC2HIhLC4
        jcQI1C4w+1MKi27wwBMhU1o=
X-Google-Smtp-Source: ABdhPJw7NQusH0Y8fVoQYycF0yjo0wGnCPrPjqTmyl60ovKBJoVd0BGVZ5Yv0YXTDZTVye0pK5BDzw==
X-Received: by 2002:a0c:e18f:: with SMTP id p15mr6432254qvl.12.1605724217447;
        Wed, 18 Nov 2020 10:30:17 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:805f:b8ae:cbb3:6b01? ([2600:1700:e72:80a0:805f:b8ae:cbb3:6b01])
        by smtp.gmail.com with UTF8SMTPSA id a23sm17033472qtk.82.2020.11.18.10.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 10:30:16 -0800 (PST)
Subject: Re: [PATCH v4 4/4] maintenance: use Windows scheduled tasks
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
 <b8d86fb9832b59884d3d38791de252dcb71e3629.1605647598.git.gitgitgadget@gmail.com>
 <CAPig+cRFQfg-NLx5dO+BjQpYduhOYs-_+ZRd=DhO8ebWjGB0iA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e8922076-1ed4-b540-f1c9-9b4a8fa7a085@gmail.com>
Date:   Wed, 18 Nov 2020 13:30:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRFQfg-NLx5dO+BjQpYduhOYs-_+ZRd=DhO8ebWjGB0iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2020 2:15 AM, Eric Sunshine wrote:
> On Tue, Nov 17, 2020 at 4:13 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> [...]
>> Since the GIT_TEST_MAINT_SCHEDULER environment variable allows us to
>> specify 'schtasks' as the scheduler, we can test the Windows-specific
>> logic on a macOS platform. Thus, add a check that the XML file written
>> by Git is valid when xmllint exists on the system.
> 
> Nit: xmllint can be installed on Linux (and likely other platforms),
> as well, so it's not clear why this calls out macOS specially. More
> generally, it may not be important to call out xmllint at all in the
> commit message; it's just _one_ thing being checked by a test which is
> checking several other things not called out individually by the
> commit message. Anyhow, this is minor; not worth a re-roll.

Sorry, it should just say "other platforms"

>> diff --git a/builtin/gc.c b/builtin/gc.c
>> @@ -1671,6 +1671,167 @@ static int launchctl_update_schedule(int run_maintenance, int fd, const char *cm
>> +static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule, const char *cmd)
>> +{
>> +       xmlpath =  xstrfmt("%s/schedule-%s.xml",
>> +                          the_repository->objects->odb->path,
>> +                          frequency);
> 
> I missed this in the earlier rounds since I wasn't paying close enough
> attention, but placing this XML file within the object database
> directory (.git/objects/) feels rather odd, even if it is just a
> temporary file. Using the .git/ directory itself might be better,
> perhaps like this:
> 
>     struct strbuf xmlpath = STRBUF_INIT;
>     strbuf_git_common_path(&xmlpath, the_repository,
>         "schtasks-%s.xml", frequency);
>     ...
>     strbuf_release(&xmlpath);

It does look odd, and in this case we could use the .git directory
instead. I specifically use the objects directory for the maintenance
lock in 'git maintenance run' to allow maintenance to run when
GIT_OBJECT_DIRECTORY points to an alternate, allowing us to maintain
object databases that don't have a full .git directory around them.

Thanks,
-Stolee
