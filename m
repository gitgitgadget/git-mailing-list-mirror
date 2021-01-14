Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07E8C433E9
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F6E23A3B
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 10:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbhANKrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 05:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbhANKrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 05:47:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2175C0613C1
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 02:46:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c124so4099487wma.5
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 02:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uyVb32yT7T4El1CRI8BD6+UNWxRrJoEovokFi+wdM30=;
        b=ZMcL+TXOBRr+K/3hFErPLVBUzySnIfvRspKltEgSOrKwAQj8/GERhFDhh1F5nETA6t
         Dfmq0OTs3KzMmipabX6gI6ckVZKdvXX1YwAlFoMiwPM9CEtLAsZU93PzZ1BomNQhLicf
         a7we1QQ07C2auikw3WnVC9rXOcnWQO30IkEz/bayEuxW/Y+EgHJK5lIPKOuX+hwP+yF6
         Ksu4G8IxH48Zq5jW1nnqvSPZCx4WXJ/5WFcO24InV8S6ktEmGrookUrDM1US8Jvmi90e
         AYh5xDQ8JbXH1TmUqXIHZT3TLabml4+k0MxHpl7T9KAn7TteQWaGxxTGehMh9xdtYEzN
         ijww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uyVb32yT7T4El1CRI8BD6+UNWxRrJoEovokFi+wdM30=;
        b=Ncfe9khX6yOjbUtlzkau1BgtEE5WwzaGueGF5hx7mWxwnDMoD4qIjz6fKAv+3J6E6n
         WIhf0kEDCum+ortofjf0XP2jRtgisQE5/JA+jfgN3g2E9geFlegU9nhRB7Ry5hLIDiy4
         ENyqrYrXC93OlqAycOW66ynbQglMsBpEZPfterXAtsLcD6lK5KYvIXxedETZJ/7CfFl1
         lG7AWLrc7x9IiebtnvUdg7KuiH6ioTMmOS9Xw02XeLuwTA7rtiC+PcJofQFRJbeqjrXr
         qjtriwXyWUpJnhx+xnKQYM1O/jMPwI9kzb27BWmIKWQyTxUkXp7cKpkbXuHYVnqzHSjh
         8gmg==
X-Gm-Message-State: AOAM53194dKBjymrS9sezync998FRYoBFFTI7FX440YLFRQZSQJB1vGv
        s1RzgZDZvr39+RwgXAK5FIs=
X-Google-Smtp-Source: ABdhPJypZngkPzd+zWU1OcCB3TCnMJJyjOuuJDHqfynHIWMmFaWGCqbtfd98ihfsM5PjUoYBqqVg3g==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr3293187wme.101.1610621184548;
        Thu, 14 Jan 2021 02:46:24 -0800 (PST)
Received: from [192.168.1.201] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.googlemail.com with ESMTPSA id s19sm6807363wrf.72.2021.01.14.02.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 02:46:23 -0800 (PST)
Subject: Re: [RFC PATCH 1/9] rebase -i: only write fixup-message when it's
 needed
To:     Charvi Mendiratta <charvi077@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes.Schindelin@gmx.de
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210108092345.2178-2-charvi077@gmail.com> <X/8/WassxF7ujqjX@nand.local>
 <CAPSFM5ew583ZPZO9XUWxskQPsdSv520gKCM30GH2huhdTDxb2A@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ac1691d6-e13e-2c04-b105-73a0645f4883@gmail.com>
Date:   Thu, 14 Jan 2021 10:46:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAPSFM5ew583ZPZO9XUWxskQPsdSv520gKCM30GH2huhdTDxb2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor and Charvi

On 14/01/2021 08:12, Charvi Mendiratta wrote:
> On Thu, 14 Jan 2021 at 00:13, Taylor Blau <me@ttaylorr.com> wrote:
>>
>> On Fri, Jan 08, 2021 at 02:53:39PM +0530, Charvi Mendiratta wrote:
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> The file "$GIT_DIR/rebase-merge/fixup-message" is only used for fixup
>>> commands, there's no point in writing it for squash commands as it is
>>> immediately deleted.
>>>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
>>> ---
>>>   sequencer.c | 12 +++++++-----
>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 8909a46770..f888a7ed3b 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -1757,11 +1757,13 @@ static int update_squash_messages(struct repository *r,
>>>                        return error(_("could not read HEAD's commit message"));
>>>
>>>                find_commit_subject(head_message, &body);
>>> -             if (write_message(body, strlen(body),
>>> -                               rebase_path_fixup_msg(), 0)) {
>>> -                     unuse_commit_buffer(head_commit, head_message);
>>> -                     return error(_("cannot write '%s'"),
>>> -                                  rebase_path_fixup_msg());
>>> +             if (command == TODO_FIXUP) {
>>> +                     if (write_message(body, strlen(body),
>>> +                                       rebase_path_fixup_msg(), 0)) {
>>> +                             unuse_commit_buffer(head_commit, head_message);
>>> +                             return error(_("cannot write '%s'"),
>>> +                                          rebase_path_fixup_msg());
>>> +                     }
>>
>> I'm nit-picking here, but would this be clearer instead as:
>>
>>      if (command == TODO_FIXUP && write_message(...) < 0) {
>>        unuse_commit_buffer(...);
>>        // ...
>>      }
>>
>> There are two changes there. One is two squash the two if-statements
>> together, and the latter is to add a check that 'write_message()'
>> returns an error. This explicit '< 0' checking was discussed recently in
>> another thread[1], and I think makes the conditional here read more
>> clearly.

I don't feel that strongly but the addition of '< 0' feels like it is 
adding an unrelated change to this commit. It also leaves a code base 
where most callers of `write_message()` do not check the sign of the 
return value but a couple do (there appears to be one that checks the 
sign already and a couple that completely ignore the return value). If 
we want to standardize on always checking the sign of the return value 
of functions when checking for errors even when they never return a 
positive value then I think someone in favor of that change should 
propose a patch to the coding guidelines so it is clear what our policy 
is. When I see a '< 0`' check I tend to think the positive value has a 
non-error meaning.

Best Wishes

Phillip

> Okay, I got this and will change it.
> 
> Thanks and Regards,
> Charvi
> 
>> Thanks,
>> Taylor
>>
>> [1]: https://lore.kernel.org/git/xmqqlfcz8ggj.fsf@gitster.c.googlers.com/

