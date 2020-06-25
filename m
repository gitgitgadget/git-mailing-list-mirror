Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E36CC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 11:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D3620706
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 11:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcKydmCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404330AbgFYLq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404321AbgFYLq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 07:46:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6C0C061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 04:46:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y18so3020008lfh.11
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oiU/1HQCm4HtQd2fp0coFUpFRbzJMtFUKHydC243DQ8=;
        b=HcKydmCMqNFXoUbbDDcBxE1NtWWdCACmG2YUUMr6qpp9ILXDQcbka82Igoj5hl0XJZ
         /yq/4dLLrEOL+XTw8zZ07SLCEm3pPpcuS+HtnW1D+1PCH0ImUzxjRd9qMlYYLQewHC+M
         C0W7telkZa7sX1zxJXBCf2uGvY0kUZscw1sOlfqTjJ3EUq3k4FC9ukXaGbk8H9mLFFnR
         0LDLH3DwPjOEYPJYj5H2NsBdI3y7OaieLGjDszLD7oG1cPh0kDhNrvsdpodajHtVoNrz
         +R158t0h+gj6VMKvOPC+nTZbnVHhqkR3mbGUX5vhUOFLgTt+ZNTgAcEx8+uWzsjY/D0J
         Pi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=oiU/1HQCm4HtQd2fp0coFUpFRbzJMtFUKHydC243DQ8=;
        b=caUa0LfjD+18g/8Zl9q37usBpXpt3ENnvxfKfeewBiUHPZfDj2XaJvCaSE5ehRiII0
         T/zCZeSBb1CxtGhNCB1mccyiBaEe2UevTL32otbGITUE6owGH819faSd2J2h+ltTKxP5
         5JygYXXcfsjMi2UGuu1Gyov6X/fmzyS8nAQ3+e7lTZTT1wVStGPUxFNedZJfzPBA/BSs
         PU07gM4Wq9P38Ebz4SJiamzhVQ8tVFKUSVJS9BLAmN9sjQYSESfzPybqXsrKn9wOMVOZ
         PPY0tWCbMli5BRLlk/Hjct0qpqcXkocwKilc8gABiq1Wtdpxy9yTL1a4i3zI4Zu/ywpJ
         HICA==
X-Gm-Message-State: AOAM530MPpVdDbPHd7oS2u7lzv00z97hUp2Ux/EHt/Ub5tljqrhsZnbs
        KO9gpOWqSjPvowTK5QnWIJI=
X-Google-Smtp-Source: ABdhPJziqd9GLNrxjObbjFgtlFXmKhPQDrnsbbi3W5Sv8fnRB3J4Uhy+r4BY1KO2xXVfcitoR+y7/A==
X-Received: by 2002:a19:c64e:: with SMTP id w75mr18299667lff.64.1593085616781;
        Thu, 25 Jun 2020 04:46:56 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u30sm4733848ljd.94.2020.06.25.04.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 04:46:55 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
        <20200622194122.GN6531@camp.crustytoothpaste.net>
        <871rm6x86y.fsf@osv.gnss.ru>
        <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com>
        <xmqqk0zxbe6f.fsf@gitster.c.googlers.com> <87k0zw1gu9.fsf@osv.gnss.ru>
        <xmqqk0zw5bt5.fsf@gitster.c.googlers.com>
Date:   Thu, 25 Jun 2020 14:46:54 +0300
In-Reply-To: <xmqqk0zw5bt5.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 24 Jun 2020 15:38:46 -0700")
Message-ID: <87h7uzweoh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> To clarify, could you please tell if plain
>>
>>    git merge -s ours
>>
>> is a "partial merge" from your point of view?
>
> It is not even "partial".

OK, get it, thanks!

I asked for clarification because it /is/ possible to interpret such
merge as "partial" in the sense that it gets only /part/ of changes,
discarding those that were introduced on the side branch.

>
> The merge strategy "-s ours" is a way to cauterize a side branch as
> dead-end, declaring that everything that has ever been done on that
> side branch up to the point of the merge is not interesting and we'd
> never want to look at anything that builds on it.
>
> It has its uses, though.  After doing so, "git log --all ^mainline"
> or "git branch --not-merged release" would not show such a
> cauterized branch; it is a good way to "hide" the branch that you
> deem a dead-end when you cannot remove it.  But of course you do not
> want to ever build on such a side branch after doing so.
>

I think the usefulness of the feature might happen to be somewhat wider,
yet I'm to avoid arguing, to scatter no attention.

>> If you think it is not, then what about:
>>
>>   git merge -X ours
>
> It is not even a sensible merge.

I don't believe one could tell out of context, see below.

Anyway, the question was not if it's good, bad, or sensible. Suppose I
do such a "non-sensible" merge, is it a "partial merge" or not?

> It takes their changes where we didn't touch, but it takes our change
> without even looking at what they did when the changes overlap.

Sure, and that happens to be exactly what I need from Git when I do such
merge, because I did look at all the 137 conflicts and found none where
I need different resolution; and yes, I'm too lazy to resolve all 137 by
hand. Makes sense? Is my merge "partial" /now/?

Getting back to technical discussion, can we come up with a useful
definition of "partial merge" at all? Honestly, I can't, and unless
somebody else does, I'm inclined to consider it to be an arbitrary label
being put on selected merge examples for the sake of argument.

Thanks,
-- Sergey
