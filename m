Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB23AC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBE724B0A
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgLPRoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 12:44:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55991 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgLPRoH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 12:44:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 674EEFD862;
        Wed, 16 Dec 2020 12:43:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mak1o2SiXJdXQyXH+L4haSLgzhE=; b=rmPiFY
        bOXUX1nnsuc+ZyZQgH5SU1RCFfcIMOEffW5+8zBeIdFay3geYzubtWC+9cblbBSX
        7Q0OHcJTITJu3jZW45w69NW6/zX1qgAJgkx6BoQHa0sKxR4mHEfzFskKWZchETno
        p11NEoyveMMhhL0WuZok+rXP3YOyZhVIh8/0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UGT8I8aYUCIgEAq2B0T1LKrn7fevWIAP
        hiVroUCHG/DkSUhY49rGEjrupVByUUmh/8EBo+Y+JyxSZh7DpGzKpYcjyVBOx9w8
        hEhlV4IHCYRZBrsxE5u5qlGZ11kkQ0eP11I2QHfPhTYMKQoEaRyAvGyKQrb1NCXq
        oIvoqM4+mOA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EC63FD861;
        Wed, 16 Dec 2020 12:43:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 977DCFD860;
        Wed, 16 Dec 2020 12:43:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] merge-ort: copy a few small helper functions from
 merge-recursive.c
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
        <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
        <4a4d9d29-ccba-8d39-a7cd-34b1ba785e22@gmail.com>
Date:   Wed, 16 Dec 2020 09:43:19 -0800
In-Reply-To: <4a4d9d29-ccba-8d39-a7cd-34b1ba785e22@gmail.com> (Derrick
        Stolee's message of "Wed, 16 Dec 2020 08:30:23 -0500")
Message-ID: <xmqqim914pfs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30004F4C-3FC6-11EB-8867-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/15/2020 12:53 PM, Elijah Newren via GitGitGadget wrote:
>> From: Elijah Newren <newren@gmail.com>
>> 
>> In a subsequent commit, we will implement the traditional recursiveness
>> that gave merge-recursive its name, namely merging non-unique
>> merge-bases to come up with a single virtual merge base.  Copy a few
>> helper functions from merge-recursive.c that we will use in the
>> implementation.
>
> I'm sure these are copies, but...
>
>> +static struct commit_list *reverse_commit_list(struct commit_list *list)
>> +{
>> +	struct commit_list *next = NULL, *current, *backup;
>> +	for (current = list; current; current = backup) {
>> +		backup = current->next;
>> +		current->next = next;
>> +		next = current;
>> +	}
>
> The naming of 'next' seems backwards to me, since it is really
> the "previous" node. Using something like 'previous' makes it
> clear that you are reversing when you say
>
> 	current->next = previous;

Hmph.  I took "next" commit_list as "list is the original one, and
next is the reversed list, the next generation of what we received".

Calling it "previous" feels even more backwards when you view among
three "struct commit_list *" pointers, one (the one that holds the
eventual return value) is primarily used to denote the resulting
list itself, and the other two are used to point individual elements
on the original list.

I wonder if a slightly different codeflow may be easier to follow

	struct commit_list *result = NULL;
	while (list) {
        	struct commit_list *next = list->next;
		list->next = result;
		result = list;
		list = next;
	}
	return result;

if we were to try improving this for readability?  

I dunno if it matters too much, though.

