Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3CAC43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 06:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB67206B8
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 06:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f1AE69Qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgIGGys (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:54:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59496 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGGyr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 02:54:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3409DFF35;
        Mon,  7 Sep 2020 02:54:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FYzOG40e6ftYmWewW9BaCAqXSIY=; b=f1AE69
        Qa2VrWKU+FJjJ2dF8ME6DRVazwjzh9mXV1TLN6O9+yW5//avAFKonJOmz8QxSFuJ
        O1NW458dlj1m65SS3jGtoQBdWuJF6eGOXhix5fEpDjaaPKduGswDZEZ/XRVWUkTe
        LLqEAOH3Km5GsPpKdfin7j8MGUvKZy03PzEMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wyTp2zFEXoAaMQvzfFVlvVAJmK+XOYLd
        Z8RZAHrIMubZCk62IsSjwwFzWvF29uozFZqT73LWOu7rRknlm0QUX7BLf2HCfZBb
        YacQCiz64GSffeZ+vSqIM15gr8YXz/gmO567Rdh+bRbMMT1KB2Q8ZNMYnAXc4jr/
        HYmzTM9pCPU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DBB83DFF34;
        Mon,  7 Sep 2020 02:54:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E730DFF33;
        Mon,  7 Sep 2020 02:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] pretty: allow to override the built-in formats
References: <20200905192406.74411-1-dev+git@drbeat.li>
        <20200905195218.GA892287@generichostname>
        <xmqqeene36t7.fsf@gitster.c.googlers.com>
        <8bb68268-8e4c-749e-b2e0-21b38b70c8bf@drbeat.li>
Date:   Sun, 06 Sep 2020 23:54:42 -0700
In-Reply-To: <8bb68268-8e4c-749e-b2e0-21b38b70c8bf@drbeat.li> (Beat Bolli's
        message of "Mon, 7 Sep 2020 07:36:47 +0200")
Message-ID: <xmqqtuwa13gt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02B18A62-F0D7-11EA-B247-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> On 06.09.20 23:59, Junio C Hamano wrote:
>> Denton Liu <liu.denton@gmail.com> writes:
>> 
>>> Hmm, I'm not sure how I feel about being able to override formats other
>>> than "reference".
>> 
>> Is the idea to introduce a parallel namespace to pretty.<name>?  I
>> am not sure why that is a good idea than, say a single variable that
>> says "to me, pretty.<name> would override even the built-in names".
>> 
>> I am not sure how I feel about being able to override built-in
>> formats in the first place, though.
>> 
>> After all, pretty.<name> were introduced so that user-defined ones
>> can be invoked with an equal ease as the built-in ones, but
>> overriding common understanding among the users of the tool is a
>> different story.
>
> I gave a reason for the reference format, at least.
>
> Would you be fine with a patch that just allows to override the
> reference format (for the stated reasons)?

Your "reason" read pretty much the same as "I want reference to do
something else", but that leads to "depending on the configuration,
even built-in names that are well known to all Git users behave
differently---the users lose common reference (no pun intended)".

Also I am not sure how your reason applies specifically to the
reference format.  It would be widely applicable to other formats
like 'short' and 'oneline' in that depending on projects' and
personal preference, people may want "something like X but not
exactly X" for all the built-in formats.

IOW I still do not see why your "stated reasons" justify overriding
any built-in format, and/or overriding only the reference format.  I
can understand (but not necessarily agree with) the position "We'll
let any built-in format to be overridden", but I do not see what
makes "reference" so special.  Even though I think it would confuse
the users to make any built-in format overridable and therefore I do
not think it is such a good idea, if we were to allow it, I do not
see any point in limiting the damage only to the reference format.

Finally, a non-built-in name to express the format specific to a
project can already be defined and used pretty easily; e.g. the
"pretty.kernel" format may say %h ("%s") and can be used like

    $ git show -s --pretty=kernel HEAD

with the same ease as the 'reference' format.

    $ git show -s --pretty=reference HEAD

So, I dunno.

