Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD57C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3436E2068E
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzH5fYHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfKYQkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:40:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54790 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfKYQkv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 11:40:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so6757498wmj.4
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dFYV1FxbmyNdwVWyPO5vizs7o6DXWa7xkO8QWIbK9yA=;
        b=AzH5fYHZ8fxYC+zYe8Y34Q/99UQ4jOQ7UgaP4HiAgBR6eKuDLBjVMZFpZGI17BHM+W
         pNPKBowwmFqQIxYhHx9uvA21m8K3Epwwu+JjohlLF5RoU2EoSIcudBmfsJ78OKkHtlJo
         ic35CUKvV7Vqox4ScdYiKw3secfxgUWtcn48DFxMEX0NC9WPfbjWCX6bKOaKoDSBtV45
         4anZu1xe/Z0pwWebffkBDkiWVwrrXUz9M14D1cOcp0NqYAeq0UsOx75bfbAdH+RGhBYI
         8nu/yZQ26HEH9PaSJga7qhSPIvw9SvcTwGb9XL4UPGh8p4BUHVQpP9doaD2l57qglOpI
         Aofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dFYV1FxbmyNdwVWyPO5vizs7o6DXWa7xkO8QWIbK9yA=;
        b=NNBw1Ef4jTVYLVdpHWYwK6+oUHsKfLDTudXcP1ldPaX5mnRpHthAvjWZcNJ3N4C23N
         yeZfuahLPEA+fCxQGyQ/jhzPspcRAT8D/9V33HdsquiY1zHi5JfW+hn35WeNou/8j2XR
         vfV8rp2GfhojsPIUwbb/wjf2TtCmJzFRHrm1i78y3k+snBC3NUqd9iZRaqO3kfw1Dt6n
         xHebpWVnZqCpMaKmfZjfDSsTvmR4OaieIKSlpzOaJMTqHxPXl3gd0Rlvy3EkrKNbHJq0
         Id5ouBBK5LPqWdjecVHD4/B7VSgTO341PGCvQ5NczVeZ6plUi48MnKpMF0Cd5eVTzBHQ
         a8vg==
X-Gm-Message-State: APjAAAVgoGfYE5E5HAuwk17+J1h+mQJsOkCzEs7LXyVc5rLZO0FALwUn
        6CIY5qhb9vUrUAl/vxTxrKc=
X-Google-Smtp-Source: APXvYqx8ZJGd4o2hFWvpfWWMp1+mxGDdv41HR6/blHqyfV8NeWDmQL3vb6FBzEB9Ym2d5s9kv9/c3Q==
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr9829663wmj.2.1574700048241;
        Mon, 25 Nov 2019 08:40:48 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id w11sm11939292wra.83.2019.11.25.08.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 08:40:47 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t3429: try to protect against a potential racy todo file
 problem
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
 <20191123172046.16359-1-szeder.dev@gmail.com>
 <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
 <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
 <20191124211021.GB23183@szeder.dev> <20191125131833.GD23183@szeder.dev>
 <5a43a071-a3c2-770e-bca4-3e73aff96e48@gmail.com>
 <20191125151517.GE23183@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1d94202c-4ab9-8437-0d73-80820ecb6789@gmail.com>
Date:   Mon, 25 Nov 2019 16:40:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191125151517.GE23183@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/11/2019 15:15, SZEDER Gábor wrote:
> On Mon, Nov 25, 2019 at 02:43:07PM +0000, Phillip Wood wrote:
>> On 25/11/2019 13:18, SZEDER Gábor wrote:
>>> On Sun, Nov 24, 2019 at 10:10:21PM +0100, SZEDER Gábor wrote:
>>>> To notice a changed todo file the sequencer stores the file's stat
>>>> data in its 'struct todo_list' instance, and compares it with the
>>>> file's current stat data after 'reword', 'squash' and 'exec'
>>>> instructions.  If the two stat data doesn't match, it re-reads the
>>>> todo file.
>>>>
>>>> Sounds simple, but there are some subtleties going on here:
>>>>
>>>>    - The 'struct todo_list' holds the stat data from the time when the
>>>>      todo file was last read.
>>>>
>>>>    - This stat data in 'struct todo_list' is not updated when the
>>>>      sequencer itself writes the todo file.
>>>>
>>>>    - Before executing each instruction during an interactive rebase,
>>>>      the sequencer always updates the todo file by removing the
>>>>      just-about-to-be-executed instruction.  This changes the file's
>>>>      size and inode [1].
>>>>
>>>> Consequently, when the sequencer looks at the stat data after a
>>>> 'reword', 'squash' or 'exec' instruction, it most likely finds that
>>>> they differ, even when the user didn't modify the todo list at all!
>>>> This is not an issue in practice, it just wastes a few cycles on
>>>> re-reading the todo list that matches what the sequencer already has
>>>> in memory anyway.
>>>
>>> It can be much more than just a few cycles, because the total number
>>> of parsed instructions from all the todo file re-reads can go
>>> quadratic with the number of rebased commits.
>>>
>>> The simple test below runs 'git rebase -i -x' on 1000 commits, which
>>> takes over 14seconds to run.  If it doesn't re-read the todo file at
>>> all (I simply deleted the whole condition block checking the stat data
>>> and re-reading) it runs for only ~2.5secs.
>>>
>>> Just another angle to consider...
>>
>> I know dscho was keen to avoid re-parsing the list all the time [1]
>> presumably because of the quadratic behavior. (He also assumed most people
>> were using ns stat times [2] but that appears not to be the case)
> 
> Nanosecond file timestamp comparisons are only enabled by the USE_NSEC
> macro, which is only defined if the USE_NSEC Makefile knob is enabled,
> but that is not enabled by default.
> 
> Then there is the related NO_NSEC Makefile knob:
> 
>    # Define NO_NSEC if your "struct stat" does not have "st_ctim.tv_nsec"
>    # available.  This automatically turns USE_NSEC off.
> 
> As Dscho mentioned in [2], we do disable nanosecond file timestamp
> comparisons in 'config.mak.uname' on a handful of platforms by setting
> NO_NSEC.  This, however, does not mean that nanosec timestamps are
> enabled on other platforms by default.
> 
>> Could we
>> just compare the text of the todo list on disk to whats in todo->buf.buf
>> (with an appropriate offset)? That would avoid parsing the text and looking
>> up all the commits with get_oid()
> 
> Comparing the contents without parsing is still quadratic in the size
> of the todo list, though I suppose with a much lower constant factor
> than actually parsing it.

The patch below (assuming thunderbird doesn't mangle it) reduces the 
time to run your bulk commit test from 30s to 7s, if I delete the 
condition block which checks the stat data it takes 4.7s on my (somewhat 
ancient) laptop. So there is a cost to the string comparison approach 
but it's much less that the full todo list parsing.

Best Wishes

Phillip

--- >8 ---
diff --git a/sequencer.c b/sequencer.c
index 8952cfa89b..a3efdae0a5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3909,12 +3909,17 @@ static int pick_commits(struct repository *r,
                                                         arg, item->arg_len,
                                                         opts, res, 0);
                 } else if (check_todo && !res) {
-                       struct stat st;
-
-                       if (stat(get_todo_path(opts), &st)) {
-                               res = error_errno(_("could not stat '%s'"),
+                       int offset;
+                       struct strbuf buf = STRBUF_INIT;
+                       if (strbuf_read_file(&buf, get_todo_path(opts), 
8096) < 0)
+                               res = error_errno(_("could not read '%s'"),
                                                   get_todo_path(opts));
-                       } else if (match_stat_data(&todo_list->stat, &st)) {
+
+                       offset = get_item_line_offset(todo_list,
+                                                     todo_list->current 
+ 1);
+                       if (buf.len != todo_list->buf.len  - offset ||
+                           memcmp(buf.buf, todo_list->buf.buf + offset, 
buf.len)) {
+                               fputs("re-reading todo list\n", stderr);
                                 /* Reread the todo file if it has 
changed. */
                                 todo_list_release(todo_list);
                                 if (read_populate_todo(r, todo_list, opts))

