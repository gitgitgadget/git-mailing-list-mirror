Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8048BCD37B0
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 02:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjIPCTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 22:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjIPCS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 22:18:57 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033E4173C
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 19:18:52 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1694830729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wRYL6TIU3Q3ivFKSRfUtAGxVfMPod4jybFLdP/N1enQ=;
        b=GdxfGB9tzq1qp7lGXhqXs3247smMT0eFHRbbe5DnHBHRqwKqc2icf36JtvFr3bAiNtG5xw
        YppNdoRJLXNYgnX2a1jHv0UpX+gQQOFYhZ0vPyRDdgGJW6swiyWFrVIZyBCjv9gP7dL6D9
        x0oXF68Xh4na8KWbx31LQBTnGnPKQno0bXZN53y6OlbAL1r18oh7z02tJymGji62LKpCc5
        Z8U+dilDw7aWyzChmIK/y3UONtFXdcNkTjA/H48noYSEUAwApRFckz5rhwQqhW+GMFOpQP
        W9DlVncPTRblxs0ZmIrHnPgR7fI7A7ZFkqLzZTBgV2CDby0vVE4EfPy/pUrtew==
Date:   Sat, 16 Sep 2023 04:18:49 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Linus Arver <linusa@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: pull: improve rebase=false documentation
In-Reply-To: <owlya5tnjg4f.fsf@fine.c.googlers.com>
References: <226cc3ed753ee809a77ac7bfe958add7a4363390.1694661788.git.dsimic@manjaro.org>
 <xmqqzg1oinq1.fsf@gitster.g> <owlyedj0jok7.fsf@fine.c.googlers.com>
 <xmqqh6nvfi2p.fsf@gitster.g> <owlya5tnjg4f.fsf@fine.c.googlers.com>
Message-ID: <56952a81148ab44f44d020071655f667@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-15 23:12, Linus Arver wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Linus Arver <linusa@google.com> writes:
>> 
>>> Aside: interestingly, there appears to be a "--no-rebase" option that
>>> means "--rebase=false" (see cd67e4d46b (Teach 'git pull' about 
>>> --rebase,
>>> 2007-11-28)):
>>> 
>>>        --no-rebase
>>>            This is shorthand for --rebase=false.
>>> ...
>>> How about adding something like this instead as the very first 
>>> paragraph
>>> for this flag?
>>> 
>>>     Supplying "--rebase" defaults to "--rebase=true". Running 
>>> git-pull
>>>     without arguments implies "--rebase=false", unless relevant
>>>     configuration variables have been set otherwise.
>> 
>> Phrase nit.
>> 
>> 	$ git pull origin
>> 
>> does run the command with arguments.
> 
> Ah, good catch.
> 
>> What you mean is "running
>> git-pull without any --rebase arguments implies --no-rebase",
> 
> Right (modulo your "--rebase arguments" -> "--rebase option" correction
> in your follow-up email).
> 
>> but
>> that is saying "not giving --rebase=<any> and not giving --rebase
>> means not rebasing", which makes my head spin.
> 
> Me too.
> 
>> "--no-rebase" as a command line option does have use to defeat
>> configured pull.rebase that is not set to "false"
> 
> Yes, I noticed this too after digging around a bit more after I sent my
> message. Thanks for clarifying for the record.
> 
>> and allowing
>> "pull.rebase" to be set to "false" does have use to defeat settings
>> for the same variable made by lower-precedence configuration file.
> 
> Indeed! I did not think of this. IOW, Git can be configured in
> multiple places (the "pull.rebase" setting in ~/.gitconfig can be
> overridden by the same config in ~/myrepo/.git/config).
> 
>> "--rebase=false" does not have any reason to exist, except for
>> making the repertoire of "--rebase=<kind>" to be complete.
> 
> Agreed. In a sense, the docs for "--rebase=false" should say that it is
> a synonym for "--no-rebase" (because "--no-rebase" came first,
> historically), and not the other way around (that "--no-rebase" is
> shorthand for "--rebase=false").
> 
>> So, I am still not sure if saying "'git pull' (no other arguments
>> and no configuration) is equivalent to 'git pull --rebase=false'"
>> adds much value.
> 
> Fair point. That is, there are so many gotchas and "edge case"-like
> behaviors to consider here, so the statement "'git pull' (no other 
> arguments
> and no configuration) is equivalent to 'git pull --rebase=false'" is an
> oversimplification that can be misleading. I agree.
> 
>> If --no-rebase and --rebase=false are explained in terms of why
>> these options that specify such an unnatural action (after all, you
>> say "do this" or "do it this way", but do not usually have to say
>> "do not do it that way") need to exist.
>> 
>> If I were writing this patch, I would rearrange the existing text
>> like so:
>> 
>>  * Update the description of "--no-rebase" *NOT* to depend on
>>    --rebase=false.  Instead move it higher and say
>> 
>>    - The default for "git pull" is to "merge" the other history into
>>      your history, but optionally you can "rebase" your history on
>>      top of the other history.
>> 
>>    - There are configuration variables (pull.rebase and
>>      branch.<name>.rebase) that trigger the optional behaviour, and
>>      when you set it, your "git pull" would "rebase".
>> 
>>    - The "--no-rebase" option is to defeat such configuration to
>>      tell the command to "merge" for this particular invocation.
>> 
>>  * Update the description of "--rebase=<kind>" and move the
>>    paragraph that begins with "When false" to the end, something
>>    like:
>> 
>>    - `--rebase` alone is equivalent to `--rebase=true`.
>>    - When set to 'merges'...
>>    - When set to 'interactive'...
>>    - See `pull.rebase`, ..., if you want to make `git pull` always
>>      rebase your history on top of theirs, instead of merging their
>>      history to yours.
>>    - `--rebase=false` is synonym to `--no-rebase`.
> 
> I think this captures the finer details while still preserving the
> spirit of Dragan's original patch, so SGTM.
> 
> @Dragan if you are OK with doing the (much more substantial) change as
> suggested, please do. Thanks!

Sure, thanks.  I'll put together v2 of the patch in the next couple of 
days, taking into account all the fine details of the awesome feedback 
provided by both of you, so we can have it discussed and refined 
further.
