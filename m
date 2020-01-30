Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8E8C35240
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 14:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECDF2051A
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 14:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbaQDxvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgA3OUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:20:45 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46962 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3OUp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 09:20:45 -0500
Received: by mail-qv1-f67.google.com with SMTP id y2so1517155qvu.13
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 06:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VmSOOoMupETaUpxJ2Hq9Fi+RFVOv2Cr8yV5s4qEis50=;
        b=sbaQDxvpgFIPZemReUc7QLt3KviKOtki9FVN+9rbvXii74BxuUi22RSJDAy/vtLp41
         e9m+N2yiyCDa9FFvDZvTZMdpyBkzUpOLI+vUgq36//FdmfledOmxn11sRDqiRYipxvnr
         PLkoOEfo+HW8OFjoKPK0QDxUmkrWW0Ms9Q5bsRqvEul1inVcszXQ9lIzznnwNYND4rHG
         LxnuGw60PgGmIRwBYANG1tF2QUtiGormtx8MT4KT7VxqZg+OK5mHSq5uLzRg/OF2YgZC
         Fh5UCOTa5y/aWd2ZZgIqZOWOTerTNzjYnxpM89xhC517kzBBrLKml7lI0hhrIkNgZHYJ
         S0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VmSOOoMupETaUpxJ2Hq9Fi+RFVOv2Cr8yV5s4qEis50=;
        b=t98rnGt6NjI+ZUGdDHM+gHULY9qgwFfuQO4Ak73pJC/eGfVn5kGCs/eWye4IVp9ZFI
         oftf9pQFg9+IUjS8H6NoB1TTcYwtfggFvC/jojBR87d9nBcyNxfxZh7am/MDXXtkf9Vg
         N+A6eBRWYFOaCJ3mMLt4MvLs0fdMV6ypAux9v34mbG3CMo6qPAs99qxE35H+9pIyk4AP
         BZS++EkIAGi71SJxfEIy5rLj4htpUn/pwYwdl9ilRAOIJDETLjrytQ2220UEoLwyfkkv
         SyMzqoGoZrI0PFWReiTjsKXYcctDhfmpCS25joVqonFNkFUMQG/0h1hR2QG/d2/HeuSK
         igVQ==
X-Gm-Message-State: APjAAAXBdJ1XNv0EUGjcfPu3ZsKHsEfF/pTLUcJvyqAKAa4Cl/1JQWFs
        kpTMfIPdofUA2hxBbdpQXq3wWZC8HZ/GRA==
X-Google-Smtp-Source: APXvYqyPpYZNY8xcQ9BfduozLouKho3KL0Kp9MUowOsln8VFx71S7BNz8L19Soo1kQktAQ7A8L2SEQ==
X-Received: by 2002:ad4:4204:: with SMTP id k4mr4771786qvp.203.1580394043969;
        Thu, 30 Jan 2020 06:20:43 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id z26sm3081294qtj.12.2020.01.30.06.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 06:20:43 -0800 (PST)
Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
To:     Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
Cc:     Andrey Mazo <ahippo@yandex.com>, Git Users <git@vger.kernel.org>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
 <xmqqzheg76m3.fsf@gitster-ct.c.googlers.com>
 <CAE5ih79a4SeiAnC_c+XHXAiibeNBg-h1ZjMsv2pHMNtHGmqX1w@mail.gmail.com>
 <xmqqtv4edqx9.fsf@gitster-ct.c.googlers.com>
 <xmqqeevhenbh.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <1dfe9fba-ec25-cd44-981a-25f7bcba31cc@gmail.com>
Date:   Thu, 30 Jan 2020 09:20:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqqeevhenbh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 1/29/2020 8:37 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thanks, but it wasn't very helpful to see an Ack (i.e. "an expert
>> says this is good") without seeing any of my "why is this good?"
>> answered by either the original author or the expert X-<.
> More specifically, to summarize the issues I raised:
Thanks for summarizing your questions, below are my thoughts.
>
>   * Is the proposed name of the hook a reasonable one?  If so, the
>     log message should explain why it is a reasonable one.  If not,
>     it should be given a more reasonable name and the log message
>     should justify the new name.

Having re-read your original comments, no, I think that I should change
the name of the hook from "p4-pre-edit-changelist" to follow the
git standard hooks:

* "p4-prepare-changelist" - This will replace the proposed hook but still
   take only the filename. This hook will be called, even if the
   prepare-p4-only option is selected.

* "p4-changelist" - this is a new hook that will be added after the
   user edit of the changelist text, but prior to the actual submission.
   This hook will also take the temporary file as it's only parameter
   and a failed response will fail the submission.

>   * Given that "git commit" has a pair of hooks for log message, is
>     adding one new hook a reasonable thing?  If so, the log mesasge
>     should explain why (e.g. perhaps the other one already is there,
>     or perhaps the other one is not applicable in the context of
>     interacting with P4 with such and such reasons).)

I agree with your suggestion.

>   * Is it reasonable not to have a mechanism to disable/skip the
>     hook, like "git commit" does?  If not, the log message should
>     explain why such an escape hatch, which is needed for "git
>     commit", is not needed.
The existing hook, p4-pre-submit, does not have an escape hatch,
so I did not add one to this method, but I can certainly add one.

I am amenable to adding an escape hatch, I'll add --no-verify.

>
>   * githooks(5) manual page is supposed to list all hooks, so a patch
>     that adds a new one should add a description for it in there.

I'll add text for these files (githooks and the git-p4 pages).

I'll make a new submission soon.


>
> Thanks.
>
>>>> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>
>>>>> From: Ben Keene <seraphire@gmail.com>
>>>>> Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
>>>> "git shortlog --no-merges" would show that the convention is to
>>>> downcase "Add".
>>>>
>>>> With two consecutive non-words (i.e. 'pre' and "pedit'), it really
>>>> feels an unpronounceable mouthful to a non-perforce person like me.
>>>>
>>>> On the core Git side, "git commit", which is the primary command
>>>> that is used to create a new commit, has two hooks that helps to
>>>> enforce consistency to the commit log messages:
>>>>
>>>>   - The "prepare-commit-msg" hook prepares the message to be further
>>>>     edited by the end-user in the editor
>>>>
>>>>   - The "commit-msg" hook takes what the end-user edited in the
>>>>     editor, and can audit and/or tweaks it.
>>>>
>>>> Having a matching pair of hooks and making sure the new hooks have
>>>> similar names to these existing ones may help experienced Git users
>>>> adopt the new hooks "git p4" learns here.
>>>>
>>>> What makes "p4-pre-pedit-changelist" a good name for this hook?  "In
>>>> pure Perforce without Git, there is 'pre-pedit-changelist' hook that
>>>> Perforce users are already familiar with" would be a good answer but
>>>> not being P4 user myself, I do not know if that is true.
>>>>
>>>> Also, "git commit" has a mechanism (i.e. "--no-verify") to suppress
>>>> the "auditing" hook, and it serves as an escape hatch.  The new hook
>>>> "git p4" learns may want to have a similar mechanism, to keep its
>>>> users productive even when they have broken/stale/bogus hook rejects
>>>> their legitimate log message, by allowing them to bypass the
>>>> offending hook(s).
>>>>
>>>>
>>>>> Add an additional hook to the git-p4 command to allow a hook to modify
>>>>> the text of the changelist prior to displaying the p4editor command.
>>>>>
>>>>> This hook will be called prior to checking for the flag
>>>>> "--prepare-p4-only".
>>>>>
>>>>> The hook is optional, if it does not exist, it will be skipped.
>>>>>
>>>>> The hook takes a single parameter, the filename of the temporary file
>>>>> that contains the P4 submit text.
>>>>>
>>>>> The hook should return a zero exit code on success or a non-zero exit
>>>>> code on failure.  If the hook returns a non-zero exit code, git-p4
>>>>> will revert the P4 edits by calling p4_revert(f) on each file that was
>>>>> flagged as edited and then it will return False so the calling method
>>>>> may continue as it does in existing failure cases.
>>>> The githooks(5) page should talk about some of these, I would think.
>>>>
>>>>>   git-p4.py | 11 +++++++++++
>>>>>   1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/git-p4.py b/git-p4.py
>>>>> index 40d9e7c594..1f8c7383df 100755
>>>>> --- a/git-p4.py
>>>>> +++ b/git-p4.py
>>>>> @@ -2026,6 +2026,17 @@ def applyCommit(self, id):
>>>>>           tmpFile.write(submitTemplate)
>>>>>           tmpFile.close()
>>>>>
>>>>> +        # Run the pre-edit hook to allow programmatic update to the changelist
>>>>> +        hooks_path = gitConfig("core.hooksPath")
>>>>> +        if len(hooks_path) <= 0:
>>>>> +            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
>>>>> +
>>>>> +        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
>>>>> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
>>>>> +            for f in editedFiles:
>>>>> +                p4_revert(f)
>>>>> +            return False
>>>>> +
>>>>>           if self.prepare_p4_only:
>>>>>               #
>>>>>               # Leave the p4 tree prepared, and the submit template around
>>>>>
>>>>> base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
